<?php
	
	require_once('environment.php');
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
	
	
	$sSql = 'SELECT * ' .
			'  FROM Item LEFT OUTER JOIN Person on ITM_LendToId = PPL_ID ' .
			'			 LEFT OUTER JOIN Location on ITM_LocationId = LOC_ID ' .
			' WHERE ITM_ID = ' . $_REQUEST['id'];
	$aItem = fetchFromDb($sSql, true);
	
	$sHtml = makePictureGallery($_REQUEST['id'], false, true);		
		
	$GLOBALS["hSmarty"]->assign('SHOW_VIEW_ITEM', true);
	$GLOBALS["hSmarty"]->assign('ITEM', $aItem);
	$GLOBALS["hSmarty"]->assign('HTML_PICTURES', $sHtml);
	$GLOBALS["hSmarty"]->assign('CONDITIONS', array(1 => 'poor', 2 => 'good', 3 => 'Fair', 4 => 'excellent'));
	$GLOBALS['hSmarty']->display('_main.tpl');

?>