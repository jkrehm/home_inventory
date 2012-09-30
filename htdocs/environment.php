<?php

	// edit the following constants with your home inventory root...
	define('SITE_PATH', '/var/www/localhost/home_inventory/');
	// smarty package installation path (depends on your linux distribution)...
	define('SMARTY_DIR', '/usr/share/php/smarty/');
	// MySQL info
	define('MYSQL_DATABASE_NAME', 'home_inventory');
	define('MYSQL_USER', 'homeinv');
	define('MYSQL_PASSWD', 'your_password');
	define('MYSQL_SERVER_HOSTNAME', 'your_hostname');
	// home inventory's login user...
	define('HOMEINV_USERNAME', 'username');
	define('HOMEINV_PASSWD', 'passwd');	

	// default accepted picture size 120KB
	define('PICTURE_MAXSIZE', 122880);
	
	require_once(SMARTY_DIR . 'Smarty.class.php');
	
	
	// initialize session
	session_start();
	
	// Connecting, selecting database
	$link = mysql_connect(MYSQL_SERVER_HOSTNAME, MYSQL_USER, MYSQL_PASSWD)
		or die('Could not connect: ' . mysql_error());
	mysql_select_db(MYSQL_DATABASE_NAME) 
		or die('Could not select database');

	$GLOBALS['MSG_QUEUE'] = array();
	
	$smarty = new Smarty();
	$smarty->template_dir = SITE_PATH . 'smarty/templates/';
	$smarty->compile_dir = SITE_PATH . 'smarty/templates_c/';
	$smarty->configs = SITE_PATH . 'smarty/configs/';
	$smarty->cache = SITE_PATH . 'smarty/cache/';
	$GLOBALS['hSmarty'] = $smarty;
	
	
	
	function checkAuth($sCallerScript)
	{
		if (!empty($sCallerScript))
			$sCallerScript = '?returnTo=' . urlencode($sCallerScript);
			
		if (!isset($_SESSION['userInfo']))
			header("Location: ./auth.php$sCallerScript");
	}
	
	
	function safeAddSlashes($string) 
	{ 
		if (get_magic_quotes_gpc()) { 
			return $string; 
		} else { 
			return addslashes($string); 
		} 
	} 

	
	function fetchFromDb($sSql, $bRow = false)
	{
		$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());

		if ($bRow == false)
		{
			$a = array();
			while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) 
				$a[] = $line;
			return $a;
		}
		else
			return mysql_fetch_array($result, MYSQL_ASSOC);
	}
	
	
	function pushMessage($sMsg, $bIsError = true)
	{
		array_push($GLOBALS['MSG_QUEUE'], array($sMsg, $bIsError));
		$GLOBALS['hSmarty']->assign('MSG_QUEUE', $GLOBALS['MSG_QUEUE']);
	}
	
	
	function errorOnPage()
	{
		if (count($GLOBALS['MSG_QUEUE']) > 0)
			return true;
		else
			return false;
	}
	
	
	function saveFormData()
	{
		$aForm = array();
		foreach ($_POST as $k => $data)
			$aForm[$k] = $data;
			
		return $aForm;
	}
	
	
	function uploadImage($file, &$sError, $sDest = 'items') 
	{
		$sError = '';
		
		if ($_FILES[$file]['size'] > 0) 
		{
			// change PICTURE_MAXSIZE constant to increase max size
			if ( ($_FILES[$file]['type'] != 'image/pjpeg' && $_FILES[$file]['type'] != 'image/jpeg' &&
				  $_FILES[$file]['type'] != 'image/gif') ||
				  $_FILES[$file]['size'] > PICTURE_MAXSIZE ) 
			{
				$sError = "Wrong file type or too big! Max size " . PICTURE_MAXSIZE . " KB. " .
						  "Please change 'PICTURE_MAXSIZE' constant to increase size.";
				return false;
			}
					
		    $data['type'] = $_FILES[$file]['type'];
		    $data['name'] = $_FILES[$file]['name'];
		    $data['size'] = $_FILES[$file]['size'];
		    $data['tmp_name'] = $_FILES[$file]['tmp_name'];
	
			$dir_name = SITE_PATH . "htdocs/images/$sDest/";
			$file_name = $data['name'];
			$i = 1;
			while (file_exists($dir_name.$file_name)) 
			{
				$file_name = ereg_replace('(.*)(\.[a-zA-Z]+)$', '\1_'.$i.'\2', $data['name']);
				$i++;
			}
			
			if (!move_uploaded_file($data['tmp_name'], $dir_name.$file_name)) 
			{
				$sError = "Cannot upload file!";
				return false;
			}			
	
			// change file permission to rwxr--r--
			chmod($dir_name.$file_name, 0744);
			
			return $file_name;
		}

		return false;
	}
	
	
	function makePictureGallery($id, $bDisplayDelete = true, $bDisplayEnlargePict = false)
	{
		$sDisplayDel = ($bDisplayDelete == false) ? ' style="display: none;" ' : '';
		//$sEnlarge1 = ($bDisplayEnlargePict) ? '<a href="#"' : '';
		$sSql = 'SELECT * ' .
				'  FROM Picture ' .
				' WHERE PCT_ItemId = ' . $id;
		$aPicture = fetchFromDb($sSql);
		
		// create html for the picture's gallery
		$sHtml = '';
		if (!empty($aPicture))
		{
			$sHtml = '<tr>';
			foreach ($aPicture as $k => $pict)
			{
				$sHtml .= '
				<td class="tabledata3" align="center">
					<table cellpadding="0" cellspacing="4" width="100%">
					<tr><td align="center">';
				if ($bDisplayEnlargePict)	
					$sHtml .= '<a href="images/items/' . $pict['PCT_FileName'] . '" target="_blank">';
					
				$sHtml .= '<img src="images/items/' . $pict['PCT_FileName'] . '" title="' . $pict['PCT_FileName'] . '" width="180" style="border-width: 1px; border-style: solid; border-color: #777777;">';
				if ($bDisplayEnlargePict)	
					$sHtml .= '</a>';
					
				$sHtml .= '</td></tr>
					<tr><td align="center" style="font-size: 9pt;">' . ($k+1) . ')&nbsp;&nbsp;' . $pict['PCT_FileName'] . '&nbsp;&nbsp;<a href="#"' . $sDisplayDel . ' onclick="deletePicture(' . $pict['PCT_ID'] . ', \'' . $pict['PCT_FileName'] . '\')" title="Delete me"><img src="images/icons/remove.png" style="border-style: none;"></a></td></tr>
					</table>
				</td>';
				
				if ( ($k+1) % 3 == 0 )
				{
					$sHtml .= '</tr>';
					if ( ($k+1) < count($aPicture) )
						$sHtml .= '<tr>';
				}
			}
			
			if ( ($k+1) % 3 != 0 )
			{
				$colspan = 3 - ($k+1)%3;
				$sHtml .= '<td colspan="' . $colspan . '">&nbsp;</td></tr>';
			}
		}
		
		return $sHtml;
	}
	
?>
