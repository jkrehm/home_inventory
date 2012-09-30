<table width="100%">
<tr>
        <td>
                <table border="0" cellspacing="0" cellpadding="3" align="center" width="100%">
                <tr>
                        <td class="tableheader" align="left" colspan="1" width="30%"><img src="images/icons/itemTable.png" border="0" hspace="8" align="absmiddle">
                                <b class="tableTitle">Items</b>
                        </td>
                        <td class="tableheader" align="left" width="45%" rowspan="2" nowrap="nowrap" valign="top" height="70px">
                                <form method="POST" name="frmSearch">
                                        <input type="hidden" name="searchRequest" value="">
                                        <b>Text:</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="font-size:10px; font-family:Arial;" size="30" maxlength="30" name="searchByText" value="{$smarty.session.searchByText}">
                                        &nbsp;&nbsp;
                                        <a href="#" class="whiteLink" onclick="document.frmSearch.searchByText.value=''; document.frmSearch.searchByLocation.selectedIndex=0;" title="Reset parameters"><img src="images/icons/cancel.png" style="border-style: none;"></a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="#" class="whiteLink" onclick="document.frmSearch.searchRequest.value=1; document.frmSearch.submit();">Search &gt;&gt;</a>
                                        <br/><div style="height: 5px"></div>
                                        <b>Location: </b>

                                        <select name="searchByLocation" style="font-size:9pt; font-family:Arial; valign: top;">
                                                <option value="">-- all --</option>
                                                {foreach from=$smarty.session.LOCATIONS item="loc"}
                                                        <option value="{$loc.LOC_ID}" {if $loc.LOC_ID == $smarty.session.searchByLocation}selected{/if}>{$loc.LOC_Description1} - {$loc.LOC_Description2|truncate:50:"..."}</option>
                                                {/foreach}
                                        </select>

                                </form>
                        </td>
                        <td class="tableheader" align="right" width="25%" style="text-align:right">{$PAGE_LINKS}</td>
                        
                </tr>
                <tr>
                        <td class="tableheader" align="left" colspan="3">
                                <input type="button" value="New item" class="smallbutton" onclick="document.location.href='editItem.php';">&nbsp;&nbsp;
                                <input type="button" value="Delete selected" class="smallbutton" onclick="deleteObject('frm', 'selected items', '', 'deleteSelected');">
                        </td>
                </tr>
                </table>
                
                <table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
                <tr>
                        <td class="tableheader" width="10%" align="center" nowrap>Picture</td>
                        <td class="tableheader" width="14%" align="center">Short name</td>
                        <td class="tableheader" width="17%" align="center">Description</td>
                        <td class="tableheader" width="10%" align="center">Location</td>
                        <td class="tableheader" width="7%" align="center">Purchase Price</td>
                        <td class="tableheader" width="10%" align="center">Lend to</td>
                        <td class="tableheader" width="6%" align="center">Date</td>
                        <td class="tableheader" width="6%" align="center">Action</td>
                </tr>

        
                <form name="frm" action="list.php?pageID={$smarty.request.pageID}" method="POST">
                        <input type="hidden" name="action" value="">
                        <input type="hidden" name="id" value="">
                        {foreach from=$OBJ_LIST item="item"}
                                <tr>
                                        <td class="tabledata3" width="10%" align="center" valign="middle" nowrap>
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                <TR>
                                                        <TD align="center" width="15px"><input type="checkbox" name="chkItem[]" value="{$item.ITM_ID}"></TD>
                                                        <TD title="{$item.ITM_Picture}">&nbsp;
                                                                {if !empty($item.ITM_Picture)}
                                                                        <a href="viewItem.php?id={$item.ITM_ID}&returnTo=list.php" title="View this item"><img src="images/items/{$item.ITM_Picture}" width="90px" border="1" style="border-color: #888888;"></a>
                                                                {else}
                                                                        no picture
                                                                {/if}
                                                        </TD>
                                                </TR>
                                                </table>
                                        </td>
                                        <td class="tabledata4" width="14%" valign="top"><b>{$item.ITM_ShortName}</b></td>
                                        <td class="tabledata4" valign="top" title="{$item.ITM_Description}">{$item.ITM_Description|nl2br}</td>
                                        <td class="tabledata4" valign="top">
                                                <b>{$item.LOC_Description1|nl2br}</b>
                                                {if strlen($item.LOC_Description2) > 0}
                                                        <br/>{$item.LOC_Description2|nl2br}
                                                {/if}
                                        </td>
                                        <td class="tabledata4" valign="top" align="center">{if !empty($item.ITM_PurchasePrice)}${$item.ITM_PurchasePrice}{/if}</td>
                                        <td class="tabledata4" valign="top" align="center">
                                                {if strlen($item.PPL_Name) > 0}
                                                        {$item.PPL_Name}<br/>{$item.ITM_LendDate}
                                                {/if}
                                        </td>
                                        <td class="tabledata4" width="6%" valign="top">{$item.ITM_InsertDate}</td>
                                        <td class="tabledata4" width="6%" valign="top" nowrap align="center">
                                                &nbsp;
                                                <a href="viewItem.php?id={$item.ITM_ID}&returnTo=list.php" title="View this item"><img src="images/icons/view.png" style="border-style:none;"></a>
                                                <a href="editItem.php?id={$item.ITM_ID}&returnTo=list.php" title="Modify this item"><img src="images/icons/edit.png" style="border-style:none;"></a>
                                                <a href="#" onclick="deleteObject('frm', 'Item', {$item.ITM_ID}, 'deleteOne');" title="Delete this item"><img src="images/icons/delete.png" style="border-style:none;"></a>
                                        </td>
                                </tr>
                        {foreachelse}
                                <tr><td class="tabledata3" colspan="8" width="6%" align="center" >Empty list</td></tr>
                        {/foreach}
                </form>
                <tr>
                        <td class="tableheader" align="left" colspan="8">
                                <input type="button" value="New item" onclick="document.location.href='editItem.php';" class="smallbutton">&nbsp;&nbsp;
                                <input type="button" value="Delete selected" onclick="deleteObject('frm', 'selected items', '', 'deleteSelected');" class="smallbutton">
                        </td>
                </tr>
                </table>
        </td>
</tr>
</table>

        
