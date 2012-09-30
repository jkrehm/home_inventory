<?php
	
	require_once('environment.php');
	require_once 'Pager/Pager.php';
	// vedi /usr/share/php/tests/Pager/tests/
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
	
	
	if ($_REQUEST['action'] == 'save')
	{
		if (strlen(trim($_REQUEST['descriptionTxt'])) > 0)
			$_SESSION['SEARCH']['descriptionTxt'] = $_REQUEST['descriptionTxt'];
			
		if (strlen(trim($_REQUEST['ITM_LocationId'])) > 0)
			$_SESSION['SEARCH']['ITM_LocationId'] = $_REQUEST['ITM_LocationId'];
			
		if (strlen(trim($_REQUEST['ITM_Brand'])) > 0)
			$_SESSION['SEARCH']['ITM_Brand'] = $_REQUEST['ITM_Brand'];
			
		if (strlen(trim($_REQUEST['ITM_Model'])) > 0)
			$_SESSION['SEARCH']['ITM_Model'] = $_REQUEST['ITM_Model'];
			
		if (strlen(trim($_REQUEST['ITM_SerialNum'])) > 0)
			$_SESSION['SEARCH']['ITM_SerialNum'] = $_REQUEST['ITM_SerialNum'];
			
		if (strlen(trim($_REQUEST['ITM_State'])) > 0)
			$_SESSION['SEARCH']['ITM_State'] = $_REQUEST['ITM_State'];
			
		if (strlen(trim($_REQUEST['ITM_PurchasePrice'])) > 0)
		{
			$_SESSION['SEARCH']['ITM_PurchasePrice'] = $_REQUEST['ITM_PurchasePrice'];
			$_SESSION['SEARCH']['priceOp'] = $_REQUEST['priceOp'];
		}
			
		if (strlen(trim($_REQUEST['ITM_CurrentValue'])) > 0)
		{
			$_SESSION['SEARCH']['ITM_CurrentValue'] = $_REQUEST['ITM_CurrentValue'];
			$_SESSION['SEARCH']['cValueOp'] = $_REQUEST['cValueOp'];
		}
			
		if (strlen(trim($_REQUEST['ITM_WarrantyInfo'])) > 0)
			$_SESSION['SEARCH']['ITM_WarrantyInfo'] = $_REQUEST['ITM_WarrantyInfo'];
			
		if (strlen(trim($_REQUEST['ITM_History'])) > 0)
			$_SESSION['SEARCH']['ITM_History'] = $_REQUEST['ITM_History'];
			
		unset($_SESSION['searchByLocation']);
		unset($_SESSION['searchByText']);
		header("Location: ./list.php?pageID={$_SESSION['pageID']}");
	}
	elseif ($_REQUEST['action'] == 'reset')
	{
		unset($_SESSION['SEARCH']);
	}
	
	// Read Location
	if (!isset($_SESSION['LOCATIONS']))
	{
		$sSql = 'SELECT * FROM Location loc ORDER BY LOC_ID DESC ';
		$aLocations = fetchFromDb($sSql);
		$_SESSION['LOCATIONS'] = $aLocations;
	}	
	
	//print_r($aItems);
	$GLOBALS["hSmarty"]->assign('OBJ_LIST', $aItems);
	$GLOBALS["hSmarty"]->assign('SHOW_ADVANCED_SEARCH', true);
	$GLOBALS['hSmarty']->display('_main.tpl');

?>