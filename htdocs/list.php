<?php
	
	require_once('environment.php');
	require_once 'Pager/Pager.php';
	// vedi /usr/share/php/tests/Pager/tests/
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
	

	define('REC_4_PAGE', 10);
	
	//print_r($_SESSION['SEARCH']);
	//print_R($_REQUEST);
	if ($_REQUEST['action'] == 'deleteOne' && isset($_REQUEST['id']))
	{
		// delete first picture if exist
		$sSql = 'SELECT ITM_Picture FROM Item WHERE ITM_ID = ' . $_REQUEST['id'];
		$pictName = fetchFromDb($sSql, true);
		if (!empty($pictName['ITM_Picture']))
			@unlink(SITE_PATH . 'htdocs/images/items/' . $pictName['ITM_Picture']);
			
		// delete all picture gallery
		$sSql = 'SELECT PCT_FileName FROM Picture WHERE PCT_ItemId = ' . $_REQUEST['id'];
		$aGallery = fetchFromDb($sSql);
		foreach ($aGallery as $pict)
			@unlink(SITE_PATH . 'htdocs/images/items/' . $pict['PCT_FileName']);

		$sSql = 'DELETE FROM Picture WHERE PCT_ItemId = ' . $_REQUEST['id'];
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		
		if (!empty($pictName['ITM_Picture']))
			@unlink(SITE_PATH . 'htdocs/images/items/' . $pictName['ITM_Picture']);
			
		$sSql = "DELETE FROM Item WHERE ITM_ID = {$_REQUEST['id']}";
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
	}
	elseif ($_REQUEST['action'] == 'deleteSelected' && isset($_POST['chkItem']))
	{
		$sId = implode($_POST['chkItem'], ', ');
		// read all picture's filename
		$sSql = "SELECT ITM_Picture FROM Item WHERE ITM_ID IN ($sId)";
		$aPictures = fetchFromDb($sSql);

		$sSql = "DELETE FROM Item WHERE ITM_ID IN ($sId)";
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		
		foreach ($aPictures as $pict)
			if (!empty($pict['ITM_Picture']))
				@unlink(SITE_PATH . 'htdocs/images/items/' . $pict['ITM_Picture']);
	}

	
	// Read Location
	if (!isset($_SESSION['LOCATIONS']))
	{
		$sSql = 'SELECT * FROM Location loc ORDER BY LOC_ID DESC ';
		$aLocations = fetchFromDb($sSql);
		$_SESSION['LOCATIONS'] = $aLocations;
	}	
	
	
	// Set Search-by parameters
	$sSqlSearchBy = '';
	if (isset($_POST['searchByText']))
	{
		unset($_SESSION['SEARCH']);
		$_SESSION['searchByText'] = $_POST['searchByText'];
	}
	if (isset($_POST['searchByLocation']))
	{
		unset($_SESSION['SEARCH']);
		$_SESSION['searchByLocation'] = $_POST['searchByLocation'];
	}
		
	if (strlen(trim($_SESSION['searchByText'])) > 0)
		$sSqlSearchBy .= " (ITM_ShortName like '%{$_SESSION['searchByText']}%' OR " .
						 " ITM_Description like '%{$_SESSION['searchByText']}%') ";
	if (strlen(trim($_SESSION['searchByLocation'])) > 0)
		$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " LOC_ID = {$_SESSION['searchByLocation']} ";
	
	if ($_REQUEST['searchRequest'] == 1) 
		$_GET['pageID'] = 1;
		
		
	// set page for pagination
	if (isset($_GET['pageID']) && ($_GET['pageID'] != ''))
	{
		$nCurrentPage = $_GET['pageID'];
		$_SESSION['pageID'] = $_GET['pageID'];
	}
	else
		$nCurrentPage = 1;
	
	// Advanced search parameters
	if (isset($_SESSION['SEARCH']))
	{
		if (isset($_SESSION['SEARCH']['descriptionTxt']))
			$sSqlSearchBy .= " (ITM_ShortName like '%{$_SESSION['SEARCH']['descriptionTxt']}%' OR " .
							 " ITM_Description like '%{$_SESSION['SEARCH']['descriptionTxt']}%') ";
		if (isset($_SESSION['SEARCH']['ITM_LocationId']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " LOC_ID = {$_SESSION['SEARCH']['ITM_LocationId']} ";
		if (isset($_SESSION['SEARCH']['ITM_Brand']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_Brand like '%{$_SESSION['SEARCH']['ITM_Brand']}%' ";
		if (isset($_SESSION['SEARCH']['ITM_Model']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_Model like '%{$_SESSION['SEARCH']['ITM_Model']}%' ";
		if (isset($_SESSION['SEARCH']['ITM_SerialNum']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_SerialNum like '%{$_SESSION['SEARCH']['ITM_SerialNum']}%' ";
		if (isset($_SESSION['SEARCH']['ITM_State']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_State = {$_SESSION['SEARCH']['ITM_State']} ";
		if (isset($_SESSION['SEARCH']['ITM_PurchaseLocation']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_PurchaseLocation like '%{$_SESSION['SEARCH']['ITM_PurchaseLocation']}%' ";
		if (isset($_SESSION['SEARCH']['ITM_PurchasePrice']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_PurchasePrice {$_SESSION['SEARCH']['priceOp']} {$_SESSION['SEARCH']['ITM_PurchasePrice']} ";
		if (isset($_SESSION['SEARCH']['ITM_CurrentValue']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_CurrentValue {$_SESSION['SEARCH']['cValueOp']} {$_SESSION['SEARCH']['ITM_CurrentValue']} ";
		if (isset($_SESSION['SEARCH']['ITM_WarrantyInfo']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_WarrantyInfo like '%{$_SESSION['SEARCH']['ITM_WarrantyInfo']}%' ";
		if (isset($_SESSION['SEARCH']['ITM_History']))
			$sSqlSearchBy .= (!empty($sSqlSearchBy) ? ' AND ' : '') . " ITM_History like '%{$_SESSION['SEARCH']['ITM_History']}%' ";
	}
	
	if (!empty($sSqlSearchBy))
		$sSqlSearchBy = ' WHERE ' . $sSqlSearchBy;
		
	// Read filtered items for the current page
	$sSql = 'SELECT * ' .
			 '  FROM Item LEFT OUTER JOIN Location ON ITM_LocationId = LOC_ID ' .
			 '  		  LEFT OUTER JOIN Person ON ITM_LendToId = PPL_ID ' .
			 " $sSqlSearchBy " .
			 'ORDER BY ITM_InsertDate DESC ' .
			 'LIMIT ' . (REC_4_PAGE * ($nCurrentPage - 1)) . ", " . REC_4_PAGE;
	$aItems = fetchFromDb($sSql);

	$nItem = fetchFromDb("SELECT COUNT(*) as num  FROM Item LEFT OUTER JOIN Location ON " .
						 "	ITM_LocationId = LOC_ID $sSqlSearchBy", true);
	$pager_options = array(
		'mode'       => 'Jumping',
		'perPage'    => REC_4_PAGE,
		'delta'      => 6,
		'totalItems' => $nItem['num'],
		'spacesBeforeSeparator' => 2,
		'linkClass' => 'whiteLink'
	);
	$pager = &Pager::factory($pager_options);
	$links = $pager->getLinks();
	
	//print_r($aItems);
	$GLOBALS["hSmarty"]->assign('OBJ_LIST', $aItems);
	$GLOBALS["hSmarty"]->assign('PAGE_LINKS', $links['all']);
	$GLOBALS["hSmarty"]->assign('SHOW_ITEM_LIST', true);
	$GLOBALS['hSmarty']->display('_main.tpl');

?>