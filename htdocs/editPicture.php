<?php
	
	require_once('environment.php');
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
		
	//print_r($_REQUEST);
	$bModify = isset($_REQUEST['id']) && is_numeric($_REQUEST['id']);

	
	// save pictures
	if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'save')
	{
		for ($i = 1; $i <= 4; $i++)
		{
			if ($_FILES["file$i"]['size'] <= 0)
				continue;
				
			$sPict = uploadImage("file$i", $sError);
			if (!$sPict && !empty($sError)) 
				die($sError);
			elseif (!$sPict)
				$sPict = '';
				
			$sSql = 'INSERT INTO Picture(PCT_ItemId, PCT_FileName) ' .
						"VALUES({$_REQUEST['id']}, '$sPict')";
			$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		}
	}
	elseif (isset($_REQUEST['action']) && $_REQUEST['action'] == 'deletePicture' && is_numeric($_REQUEST['pictId']))
	{
		$sSql = "DELETE FROM Picture WHERE PCT_ID = {$_REQUEST['pictId']}";
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
		// delete file on disk
		@unlink(SITE_PATH . 'htdocs/images/items/' .$_REQUEST['pictFileName']);
	}
	
	
	$sSql = 'SELECT ITM_ShortName ' .
			'  FROM Item ' .
			' WHERE ITM_ID = ' . $_REQUEST['id'];
	$aItem = fetchFromDb($sSql, true);

	$sHtml = makePictureGallery($_REQUEST['id']);
	
	//print_r($aPicture);
	$GLOBALS["hSmarty"]->assign('SHOW_EDIT_PICTURE', true);
	$GLOBALS["hSmarty"]->assign('HTML_PICTURES', $sHtml);
	$GLOBALS["hSmarty"]->assign('ITEM_INFO', $aItem);
	$GLOBALS['hSmarty']->display('_main.tpl');



	
?>
