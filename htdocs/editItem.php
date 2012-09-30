<?php
	
	require_once('environment.php');
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
	
	
//	print_r($_REQUEST);
	$bModify = isset($_REQUEST['id']) && is_numeric($_REQUEST['id']);
	$bLendIncompleteDate = false;
	$bPurIncompleteDate = false;
	
	// save an item
	if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'save' || $_REQUEST['action'] == 'saveAndNew'))
	{
		$aItem = saveFormData();
		
		// check for required fields
		if (strlen(trim($_REQUEST['ITM_ShortName'])) == 0)
			pushMessage('ShortName is required');
		if (empty($_REQUEST['ITM_LocationId']) && strlen(trim($_REQUEST['LOC_Description1'])) == 0)
			pushMessage('Location is required');

		if (!is_numeric($_REQUEST['ITM_Quantity']))
			pushMessage('Wrong quantity');
		
		
		checkCorrectDate('lendingDate', $bLendDateAll, $bLendAtLeastOne, $bLendIncompleteDate);
		checkCorrectDate('purchaseDate', $bPurDateAll, $bPurAtLeastOne, $bPurIncompleteDate);
		
		if ($bLendIncompleteDate) 
			pushMessage('Lending date incomplete');
		if ($bPurIncompleteDate)
			pushMessage('Purchase date incomplete');
		if ($bLendDateAll && empty($_REQUEST['ITM_LendToId']))
			pushMessage('Person is missing');
			
		if (errorOnPage() == false)
		{
			// a new location has been inserted. Save it
			$newLocId = -1;
			if (strlen(trim($_REQUEST['LOC_Description1'])) > 0)
			{
				$sDesc1 = safeAddSlashes($_REQUEST['LOC_Description1']);
				$sDesc2 = safeAddSlashes($_REQUEST['LOC_Description2']);
				$sSql = 'INSERT INTO Location(LOC_Description1, LOC_Description2) ' .
						"VALUES('$sDesc1', '$sDesc2')";
				$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
				$newLocId = fetchFromDb('SELECT LAST_INSERT_ID() AS last FROM Location', true) 
					or die('Query failed: ' . mysql_error());
				$newLocId = $newLocId['last'];
			}
			
			// upload img file
			$sPict = uploadImage('ITM_Picture', $sError);
			if (!$sPict && !empty($sError)) 
				die($sError);
			else
				if (!$sPict)
					$sPict = '';
				
			
			$sShortName = safeAddSlashes($_REQUEST['ITM_ShortName']);
			$sDescr = safeAddSlashes($_REQUEST['ITM_Description']);
			$nInsertDate = date('Y-m-d H:i:s');
			if ($bLendDateAll)
				$nDate = $_REQUEST['lendingDateYear'] . '-' . 
						(strlen($_REQUEST['lendingDateMonth'])==1 ? '0' : '')  . $_REQUEST['lendingDateMonth'] . '-' .
						(strlen($_REQUEST['lendingDateDay'])==1 ? '0' : '')  . $_REQUEST['lendingDateDay']; 
			else
				$nDate = 'NULL';
				
			if ($bPurDateAll)
				$nPurDate = $_REQUEST['purchaseDateYear'] . '-' . 
						(strlen($_REQUEST['purchaseDateMonth'])==1 ? '0' : '')  . $_REQUEST['purchaseDateMonth'] . '-' .
						(strlen($_REQUEST['purchaseDateDay'])==1 ? '0' : '')  . $_REQUEST['purchaseDateDay']; 
			else
				$nPurDate = 'NULL';
			$nLendTo = (!empty($_REQUEST['ITM_LendToId']) ? $_REQUEST['ITM_LendToId'] : 'NULL');
			$nLocId = ($newLocId != -1 ? $newLocId : $_REQUEST['ITM_LocationId']);
			$bDeleteLastPicture = false;
			$sSqlPicture = '';
			
			// detail's data
			$sBrand = safeAddSlashes($_REQUEST['ITM_Brand']);
			$sModel = safeAddSlashes($_REQUEST['ITM_Model']);
			$sSerialNum = safeAddSlashes($_REQUEST['ITM_SerialNum']);
			$sState = (empty($_REQUEST['ITM_State']) ? 'NULL' : $_REQUEST['ITM_State']);
			$sCond = (empty($_REQUEST['ITM_Condition']) ? 'NULL' : $_REQUEST['ITM_Condition']);
			$sCondDescr = safeAddSlashes($_REQUEST['ITM_ConditionDescr']);
			$sPurLoc = safeAddSlashes($_REQUEST['ITM_PurchaseLocation']);
			$sPurPrice = safeAddSlashes($_REQUEST['ITM_PurchasePrice']);
			$sCurValue = safeAddSlashes($_REQUEST['ITM_CurrentValue']);
			$sReplCost = safeAddSlashes($_REQUEST['ITM_ReplacementCost']);
			$sWarrant = safeAddSlashes($_REQUEST['ITM_WarrantyInfo']);
			$sHistory = safeAddSlashes($_REQUEST['ITM_History']);
			
			if ($bModify)
			{
				// check if there was a previous picture
				$aPrevImg = fetchFromDb("SELECT ITM_Picture FROM Item WHERE ITM_ID = {$_REQUEST['id']}", true);
				if (!empty($aPrevImg) && $sPict != '')
					$bDeleteLastPicture = true;
				if ($sPict != '')
					$sSqlPicture = ", ITM_Picture = '$sPict' ";

				$sSql = 'UPDATE Item ' .
						"   SET ITM_ShortName = '$sShortName', " .
						"		ITM_Description = '$sDescr', " .
						"		ITM_LocationId = $nLocId, " .
						"		ITM_LendToId = $nLendTo, " .
						"		ITM_LendDate = " . ($nDate!='NULL' ? "'$nDate'" : $nDate) . ", " .
						"		ITM_Quantity = {$_REQUEST['ITM_Quantity']}, " .
						"		ITM_Brand = '$sBrand', " .
						"		ITM_Model = '$sModel', " .
						"		ITM_SerialNum = '$sSerialNum', " .
						"		ITM_State = $sState, " .
						"		ITM_Condition = $sCond, " .
						"		ITM_ConditionDescr = '$sCondDescr', " .
						"		ITM_PurchaseDate = " . ($nPurDate!='NULL' ? "'$nPurDate'" : $nPurDate) . ", " .
						"		ITM_PurchaseLocation = '$sPurLoc', " .
						"		ITM_PurchasePrice = '$sPurPrice', " .
						"		ITM_CurrentValue = '$sCurValue', " .
						"		ITM_ReplacementCost = '$sReplCost', " .
						"		ITM_WarrantyInfo = '$sWarrant', " .
						"		ITM_History = '$sHistory' " .
						"		$sSqlPicture " .
						" WHERE ITM_ID = {$_REQUEST['id']}";
			}
			else
				$sSql = 'INSERT INTO Item(ITM_ShortName, ITM_Description, ITM_LocationId, ITM_LendToId, ' .
						'	ITM_LendDate, ITM_InsertDate, ITM_Quantity, ITM_Picture, ' .
						'	ITM_Brand, ITM_Model, ITM_SerialNum, ITM_State, ITM_Condition, ' .
						' 	ITM_ConditionDescr, ITM_PurchaseDate, ITM_PurchaseLocation, ' .
						'	ITM_PurchasePrice, ITM_CurrentValue, ITM_ReplacementCost, ' .
						'	ITM_WarrantyInfo, ITM_History) ' .
						"VALUES('$sShortName', '$sDescr', $nLocId, $nLendTo, " .
						($nDate!='NULL' ? "'$nDate'" : $nDate) . ", '$nInsertDate', " .
						" {$_REQUEST['ITM_Quantity']}, '$sPict', '$sBrand', '$sModel', " .
						" '$sSerialNum', $sState, $sCond, '$sCondDescr', " .
						($nPurDate!='NULL' ? "'$nPurDate'" : $nPurDate) . ", '$sPurLoc', " .
						" '$sPurPrice', '$sCurValue', '$sReplCost', '$sWarrant', '$sHistory')";
			//print_R($sSql);
			$result = mysql_query($sSql) or die('Query failed: ' . mysql_error());
			
			// if picture has changed, delete previous
			if ($bDeleteLastPicture)
				@unlink(SITE_PATH . 'htdocs/images/items/' . $aPrevImg['ITM_Picture']);
			
			// save last choice, only location at moment
			$_SESSION['ITM_LocationId'] = $nLocId;
			
			if ($_REQUEST['action'] == 'saveAndNew')
				header('Location: ./editItem.php?new');
			elseif (strlen($_REQUEST['returnTo']) > 0)
				header('Location: ./' . $_REQUEST['returnTo']);
			else
				header("Location: ./list.php?pageID={$_SESSION['pageID']}");
		}
	}
	
	
	// modify an item
	if ($bModify && errorOnPage() == false)
	{
		$sSql = 'SELECT * ' .
				'  FROM Item ' .
				' WHERE ITM_ID = ' . $_REQUEST['id'];
		$aItem = fetchFromDb($sSql, true);

		if (empty($aItem['ITM_LendDate']))
			$aItem['ITM_LendDate'] = '--';
		else
			$aItem['ITM_LendDate'] = substr($aItem['ITM_LendDate'], 0, 4) . 
									 substr($aItem['ITM_LendDate'], 5, 2) .
									 substr($aItem['ITM_LendDate'], 8, 2) . '000000';
									 
		if (empty($aItem['ITM_PurchaseDate'])) 
			$aItem['ITM_PurchaseDate'] = '--';
		else
			$aItem['ITM_PurchaseDate'] = substr($aItem['ITM_PurchaseDate'], 0, 4) . 
									 	 substr($aItem['ITM_PurchaseDate'], 5, 2) .
									 	 substr($aItem['ITM_PurchaseDate'], 8, 2) . '000000';
	}
	else
	{
		if ($bModify)
		{
			$sSql = 'SELECT ITM_Picture ' .
					'  FROM Item ' .
					' WHERE ITM_ID = ' . $_REQUEST['id'];
			$aPictName = fetchFromDb($sSql, true);
			$aItem['ITM_Picture'] = $aPictName['ITM_Picture'];
		}
		
		// restore last saved choice
		if (!empty($_SESSION['ITM_LocationId']))
			$aItem['ITM_LocationId'] = $_SESSION['ITM_LocationId'];
			
		if ($bLendIncompleteDate || empty($_REQUEST['action']) || (!empty($_REQUEST['action']) && !$bLendAtLeastOne))
		{
			$aItem['ITM_LendDate'] = '--';
		}
		else
		{
			$aItem['ITM_LendDate'] = (strlen($_REQUEST['lendingDateYear'])==1 ? '0' : '').$_REQUEST['lendingDateYear'] . 
									 (strlen($_REQUEST['lendingDateMonth'])==1 ? '0' : '').$_REQUEST['lendingDateMonth'] .
									 (strlen($_REQUEST['lendingDateDay'])==1 ? '0' : '').$_REQUEST['lendingDateDay'] . '000000';
		}
		
		if ($bPurIncompleteDate || empty($_REQUEST['action']) || (!empty($_REQUEST['action']) && !$bLendAtLeastOne))
		{
			$aItem['ITM_PurchaseDate'] = '--';
		}
		else
		{
			$aItem['ITM_PurchaseDate'] = (strlen($_REQUEST['purchaseDateYear'])==1 ? '0' : '').$_REQUEST['purchaseDateYear'] . 
										 (strlen($_REQUEST['purchaseDateMonth'])==1 ? '0' : '').$_REQUEST['purchaseDateMonth'] .
										 (strlen($_REQUEST['purchaseDateDay'])==1 ? '0' : '').$_REQUEST['purchaseDateDay'] . '000000';
		}
	}
	
	
	if (isset($_REQUEST['new']))
		pushMessage('Last item has been saved', false);

	// Define the returnTo to point back to the viewItem page, along with its returnTo value
	if (isset($_REQUEST['returnToView']))
		$_REQUEST['returnTo'] = 'viewItem.php?id=' . $_REQUEST['id'] . '&returnTo=' . $_REQUEST['returnToView'];
		
	// read locations
	$sSql = 'SELECT * FROM Location ';
	$aLocations = fetchFromDb($sSql);
	$GLOBALS["hSmarty"]->assign('LOCATIONS', $aLocations);
	
	// read peoples
	$sSql = 'SELECT * FROM Person ';
	$aPeoples = fetchFromDb($sSql);
	$GLOBALS["hSmarty"]->assign('PEOPLES', $aPeoples);
		
		
	//print_r($aItem);
	$GLOBALS["hSmarty"]->assign('SHOW_EDIT_ITEM', true);
	$GLOBALS["hSmarty"]->assign('ITEM', $aItem);
	$GLOBALS["hSmarty"]->assign('CONDITIONS', array(1 => 'poor', 2 => 'fair', 3 => 'good', 4 => 'excellent'));
	$GLOBALS['hSmarty']->display('_main.tpl');



	function checkCorrectDate($sDatePrefix, &$bAll, &$bAtLeastOne, &$bIncompleteDate)
	{
		$bAll = (!empty($_REQUEST[$sDatePrefix.'Year']) && !empty($_REQUEST[$sDatePrefix.'Month']) && 
				 !empty($_REQUEST[$sDatePrefix.'Day']));
		$bAtLeastOne = (!empty($_REQUEST[$sDatePrefix.'Year']) || !empty($_REQUEST[$sDatePrefix.'Month']) || 
						!empty($_REQUEST[$sDatePrefix.'Day']));
		$bIncompleteDate = (!$bAll && $bAtLeastOne);
	}

	
?>
