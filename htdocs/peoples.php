<?php
	
	require_once('environment.php');
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
	

	if ($_REQUEST['action'] == 'deleteOne' && isset($_REQUEST['id']))
	{
		// reset loan on item
		$sSql = 'UPDATE Item SET ITM_LendDate = NULL, ITM_LendToId = NULL' .
				" WHERE ITM_LendToId = {$_REQUEST['id']}";
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		
		$sSql = "DELETE FROM Person WHERE PPL_ID = {$_REQUEST['id']}";
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
	}
		
	// save a person
	elseif ($_REQUEST['action'] == 'save')
	{
		$aLoc = saveFormData();
		
		// check for required fields
		if (strlen(trim($_REQUEST['PPL_Name'])) == 0)
			pushMessage('Name is required');
			
		if (errorOnPage() == false)
		{
			$sName = safeAddSlashes($_REQUEST['PPL_Name']);
			$sTelefone = safeAddSlashes($_REQUEST['PPL_Telefone']);
			$sSql = 'INSERT INTO Person(PPL_Name, PPL_Telefone, PPL_EMail) ' .
					"VALUES('$sName', '$sTelefone', '{$_REQUEST['PPL_EMail']}')";
			$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		}
	}
	
	
	// Performing SQL query
	$sSql = 'SELECT * ' .
			 ' FROM Person ' .
			 'ORDER BY PPL_ID DESC ';
	$aPeople = fetchFromDb($sSql);
	
	foreach ($aPeople as $k => $person)
	{
		$sSql = "SELECT ITM_ShortName, ITM_LendDate, ITM_ID FROM Item WHERE ITM_LendToId = {$person['PPL_ID']} ";
		$aOnLoan = fetchFromDb($sSql);
		$aPeople[$k]['ON_LOAN'] = $aOnLoan;
	}
	//print_r($aPeople);
	
	$GLOBALS["hSmarty"]->assign('OBJ_LIST', $aPeople);
	$GLOBALS["hSmarty"]->assign('SHOW_PEOPLE_LIST', true);
	$GLOBALS['hSmarty']->display('_main.tpl');

?>