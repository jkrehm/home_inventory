{literal}
        <script language="javascript" type="text/javascript">
        // <!--
                function lookInto(id)
                {
                    frmObj = document.forms["frm"];
                    frmObj.searchByLocation.value = id;
                    frmObj.searchByText.value = "";
                    frmObj.action = "list.php";
                    frmObj.submit();
                }
        // -->
        </script>
{/literal}

<center><a href="#" style="font-family: verdana; font-size: 11px; color: #000000;" onclick="toggleDiv('locInsertDiv', 'locInsertVisibility');"><b>Toggle insert frame</b></a></center>

<div id="locInsertDiv">
        {literal}
        <script language="javascript" type="text/javascript">
        // <!--
                vis = getCookie('locInsertVisibility'); //alert(vis);
                if (vis == null)
                        setCookie('locInsertVisibility', 1);
                        
                if (vis == 1)
                        document.getElementById('locInsertDiv').style.display = "block";
                else if (vis == 0) 
                        document.getElementById('locInsertDiv').style.display = "none";
        // -->
        </script>
        {/literal}

        <table align=center width="70%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
        <tr>
                <td bgcolor=#FFFFFF>
                        <table border=0 cellspacing=2 cellpadding=5 align=center width="100%">
                                <form name="frmLocation" method="POST" enctype = "multipart/form-data">
                                        <input type="hidden" name="act" value="">
                                        <input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
                                        
                                        <tr>
                                                <td class=tableheader align="left" colspan="3">
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                        <TR>
                                                                <TD width="55%" style="font-family:Arial; font-size: 11px; color: #FFFFFF;"><b>Insert new location</b><br/>
                                                                        Fields marked with a * are required.
                                                                </TD>
                                                                <td align="right">
                                                                        <input type="button" class="smallbutton" onclick="save('frmLocation', 'save', 1);" value="Save">&nbsp;&nbsp;
                                                                </td>
                                                        </TR>
                                                        </table>
                                                </td>
                                        </tr>

                                        {* <!-- OUTPUT MESSAGE --> *}
                                        {if !empty($MSG_QUEUE)}
                                                <tr>
                                                        <td class="tabledata5" align="left" colspan="3">
                                                                {foreach from=$MSG_QUEUE item="msg"}
                                                                        <span style="FONT-FAMILY : Verdana; font-size: 11px;"><b><font color="{if $msg.1 == true}#CC0000{else}#00AA00{/if}">&nbsp;{$msg.0}</font></b></span><br/>
                                                                {/foreach}
                                                        </td>
                                                </tr>
                                        {/if}
                                        
                                        <tr>
                                                <td class="tabledata3" align="left" width="15%" nowrap><b><span style="color: #FF0000">*</span> Description 1</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="text" class="text" size="80" maxlength="80" name="LOC_Description1" value="{$LOCATION.LOC_Description1}">
                                                </td>   
                                        </tr>
                                        <tr>
                                                <td class="tabledata3" align="left" width="15%" nowrap><b><span style="color: #FF0000"></span> Description 2</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="text" class="text" size="80" maxlength="200" name="LOC_Description2" value="{$LOCATION.LOC_Description2}">
                                                </td>   
                                        </tr>
                                        <tr>
                                                <td class="tabledata3" align="left"><b><span style="color: #FF0000"></span>Image upload</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="file" class="text" size="50" name="LOC_Picture">
                                                </td>
                                        </tr>
                                </form>
                        </table>
                <//td>
        </tr>
        </table>
</div>

<div style="height: 15px"></div>
<table width="100%">
<tr>
        <td>
                <table border="0" cellspacing="0" cellpadding="3" align="center" width="100%">
                <tr>
                        <td class="tableheader" align="left" colspan="3"><img src="images/icons/locationTable.png" border="0" hspace="8" align="absmiddle">
                                <b class="tableTitle">Locations</b>
                        </td>
                </tr>
                </table>
                
                <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
                        <tr>
                                <td class="tableheader" width="20%" align="center" nowrap>Picture</td>
                                <td class="tableheader" width="30%" align="center" nowrap>Description 1</td>
                                <td class="tableheader" width="25%" align="center">Description 2</td>
                                <td class="tableheader" width="15%" align="center">Items in this location</td>
                                <td class="tableheader" width="20%" align="center">Action</td>
                        </tr>
                
                        <form name="frm" id="frm"  method="POST" action="locations.php">
                                <input type="hidden" name="act" value="">
                                <input type="hidden" name="id" value="">
                                <input type="hidden" name="searchByText" value="">
                                <input type="hidden" name="searchByLocation" value="">
                                <input type="hidden" name="returnTo" value="locations.php">
                                {foreach from=$OBJ_LIST item="item"}
                                        <tr>
                                                <td class="tabledata3" width="20%" align="center" valign="middle" nowrap>
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                        <td>
                                                                <TD align="center">
                                                                        {if !empty($item.LOC_Picture)}
                                                                                <img src="images/locations/{$item.LOC_Picture}" width="130px" border="1">
                                                                        {else}
                                                                                no picture
                                                                        {/if}
                                                                </TD>
                                                        </TR>
                                                        </table>
                                                </td>
                                                <td class="tabledata3" width="30%" valign="middle" title="{$item.LOC_Description1}">
                                                        {$item.LOC_Description1|truncate:45:"..."}
                                                </td>
                                                <td class="tabledata4" width="25%" valign="middle" title="{$item.LOC_Description2}">
                                                        {$item.LOC_Description2}
                                                </td>
                                                <td class="tabledata4" width="15%" valign="middle" align="center">
                                                        {$item.num}
                                                </td>
                                                <td class="tabledata4" width="20%" valign="middle" nowrap align="center">
                                                        &nbsp;
                                                        <a href="#" onclick="document.frm.id.value={$item.LOC_ID}; save('frm', 'addItemHere', 1);" title="Add an item here"><img src="images/icons/addInto.png" style="border-style:none;"></a>
                                                        &nbsp;
                                                        <a href="#" onclick="lookInto({$item.LOC_ID});" title="Look into this location"><img src="images/icons/lookInto.png" style="border-style:none;"></a>
                                                        &nbsp;
                                                        <a href="#" onclick="{if $item.num > 0}alert('Can\'t remove location with items inside.'); {else} deleteObject('frm', 'Location', {$item.LOC_ID}, 'deleteOne', 1); {/if}" title="Delete this location"><img src="images/icons/delete.png" style="border-style:none;"></a>
                                                </td>
                                        </tr>
                                {foreachelse}
                                        <tr><td class="tabledata3" colspan="5" align="center" >Empty list</td></tr>
                                {/foreach}
                        </form>
                </table>
        </td>
</tr>
</table>


