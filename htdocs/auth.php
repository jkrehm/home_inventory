<?php

	require_once('environment.php');


	if (isset($_SESSION['userInfo'])) 
		header('Location: ' . (isset($_REQUEST['returnTo']) ? $_REQUEST['returnTo'] : 'list.php'));
		
	if (isset($_POST['username']) && isset($_POST['password']) &&
		$_POST['username'] == HOMEINV_USERNAME && $_POST['password'] == HOMEINV_PASSWD)
	{
		$_SESSION['userInfo'] = $_POST['username'];		
		header('Location: ' . (isset($_REQUEST['returnTo']) ? $_REQUEST['returnTo'] : 'list.php'));
	}
	else
	{
		unset($_SESSION['userInfo']);
		$GLOBALS['hSmarty']->assign('WRONG_USER', true);
	}
	
	
	$GLOBALS['hSmarty']->display('auth.tpl');

?>