<?php
        
        require_once('environment.php');
        checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
        
        // act is used to avoid conflict with form action properties in javascript
        if (isset($_REQUEST['act']) && $_REQUEST['act'] == 'deleteOne' && isset($_REQUEST['id']))
        {
                $sSql = 'SELECT LOC_Picture FROM Location WHERE LOC_ID = ' . $_REQUEST['id'];
                $pictName = fetchFromDb($sSql, true);
                if (!empty($pictName['LOC_Picture']))
                        @unlink(SITE_PATH . 'htdocs/images/locations/' . $pictName['LOC_Picture']);
                        
                $sSql = "DELETE FROM Location WHERE LOC_ID = {$_REQUEST['id']}";
                $result = mysql_query($sSql) or die('Query failed: ' . mysql_error());

                unset($_SESSION['LOCATIONS']);
        }
        
        // add item into a location
        elseif (isset($_REQUEST['act']) && $_REQUEST['act'] == 'addItemHere' && isset($_REQUEST['id']))
        {
                $_SESSION['ITM_LocationId'] = $_REQUEST['id'];
                header('Location: ./editItem.php?returnTo=locations.php');
        }
        
        // search here
        elseif (isset($_REQUEST['act']) && $_REQUEST['act'] == 'searchHere' && isset($_REQUEST['id']))
        {
                $_SESSION['ITM_LocationId'] = $_REQUEST['id'];
                header('Location: ./editItem.php');
        }
        
        // save a location
        elseif (isset($_REQUEST['act']) && $_REQUEST['act'] == 'save')
        {
                $aLoc = saveFormData();
//                                      die('jjjj');
                // check for required fields
                if (strlen(trim($_REQUEST['LOC_Description1'])) == 0)
                        pushMessage('Description1 is required');
                        
                if (errorOnPage() == false)
                {
                        // upload img file
                        $sPict = uploadImage('LOC_Picture', $sError, 'locations');
                        if (!$sPict && !empty($sError))
                                pushMessage($sError);
                        else
                                if (!$sPict)
                                        $sPict = '';
                                        
                        if (errorOnPage() == false)     
                        {
                                $sDesc1 = safeAddSlashes($_REQUEST['LOC_Description1']);
                                $sDesc2 = safeAddSlashes($_REQUEST['LOC_Description2']);
                                $sSql = 'INSERT INTO Location(LOC_Description1, LOC_Description2, LOC_Picture) ' .
                                                "VALUES('$sDesc1', '$sDesc2', '$sPict')";
                                $result = mysql_query($sSql);
                                if (!$result)
                                {
                                        // delete uploaded image on error
                                        if (strlen($sPict) > 0)
                                                @unlink(SITE_PATH . "htdocs/images/locations/$sPict");
                                        die('Query failed: ' . mysql_error());
                                }
                        }
                        
                        unset($_SESSION['LOCATIONS']);
                }
        }
        

        // Performing SQL query
        $sSql = 'SELECT loc.*, (SELECT COUNT(*) FROM Item WHERE ITM_LocationId = loc.LOC_ID) AS num ' .
                         ' FROM Location loc ' .
                         'ORDER BY LOC_ID DESC ';
        $aLocations = fetchFromDb($sSql);
        
        //print_R($aLocations);
        if (isset($aLoc)) $GLOBALS["hSmarty"]->assign('LOCATION', $aLoc);
        $GLOBALS["hSmarty"]->assign('OBJ_LIST', $aLocations);
        $GLOBALS["hSmarty"]->assign('SHOW_LOCATION_LIST', true);
        $GLOBALS['hSmarty']->display('_main.tpl');

?>
