{literal}
        <script language="javascript" type="text/javascript">           
        // <!--
        // -->
        </script>
{/literal}

<center><a href="#" style="font-family: verdana; font-size: 11px; color: #000000;" onclick="toggleDiv('peopleInsertDiv', 'peopleInsertVisibility');"><b>Toggle insert frame</b></a></center>

<div id="peopleInsertDiv">
        {literal}
        <script language="javascript" type="text/javascript">
        // <!--
                vis = getCookie('peopleInsertVisibility'); 
                if (vis == null)
                        setCookie('peopleInsertVisibility', 1);
                        
                if (vis == 1)
                        document.getElementById('peopleInsertDiv').style.display = "block";
                else if (vis == 0) 
                        document.getElementById('peopleInsertDiv').style.display = "none";
        // -->
        </script>
        {/literal}

        <table align=center width="55%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
        <tr>
                <td bgcolor=#FFFFFF>
                        <table border=0 cellspacing=2 cellpadding=5 align=center width="100%">
                                <form name="frmPeople" method="POST" enctype = "multipart/form-data">   
                                        <input type="hidden" name="action" value="">
                                        <input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
                                        
                                        <tr>
                                                <td class=tableheader align="left" colspan="3">
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                        <TR>
                                                                <td style="font-family:Arial; font-size: 11px; color: #FFFFFF;"><b>Insert new person</b><br/>
                                                                        Fields marked with a * are required.
                                                                </td>
                                                                <td style="text-align:right">
                                                                        <input type="button" class="smallbutton" onclick="save('frmPeople', 'save');" value="Save">&nbsp;&nbsp;
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
                                                <td class="tabledata3" align="left" width="15%" nowrap><b><span style="color: #FF0000">*</span> Name</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="text" class="text" size="60" maxlength="60" name="PPL_Name" value="{$PERSON.PPL_Name}">
                                                </td>   
                                        </tr>
                                        <tr>
                                                <td class="tabledata3" align="left" width="15%" nowrap><b><span style="color: #FF0000"></span> E-Mail 2</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="text" class="text" size="60" maxlength="60" name="PPL_EMail" value="{$PERSON.PPL_EMail}">
                                                </td>   
                                        </tr>
                                        <tr>
                                                <td class="tabledata3" align="left" width="15%" nowrap><b><span style="color: #FF0000"></span> Telefone</b></td>
                                                <td valign="top" colspan="2" class="tabledata3">
                                                        <input type="text" class="text" size="30" maxlength="30" name="PPL_Telefone" value="{$PERSON.PPL_Telefone}">
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
                <table border="0" cellspacing="0" cellpadding="3" align="center" width="85%">
                <tr>
                        <td class="tableheader" align="left" colspan="3"><img src="images/icons/peopleTable.png" border="0" hspace="8" align="absmiddle">
                                <b class="tableTitle">Peoples</b>
                        </td>
                </tr>
                </table>
                
                <table border="0" cellspacing="1" cellpadding="3" align="center" width="85%">
                        <tr>
                                <td class="tableheader" width="30%" align="center" nowrap>Name</td>
                                <td class="tableheader" width="20%" align="center">E-Mail</td>
                                <td class="tableheader" width="15%" align="center">Telefone</td>
                                <td class="tableheader" width="25%" align="center">Items on loan</td>
                                <td class="tableheader" width="10%" align="center">Action</td>
                        </tr>
                
                        <form name="frm" id="frm" method="POST">
                                <input type="hidden" name="action" value="">
                                <input type="hidden" name="id" value="">
                                {foreach from=$OBJ_LIST item="item"}
                                        <tr>
                                                <td class="tabledata3" width="30%" valign="top" title="{$item.PPL_Name}">
                                                        {$item.PPL_Name}
                                                </td>
                                                <td class="tabledata4" width="20%" valign="top" title="{$item.PPL_EMail}">
                                                        {if !empty($item.PPL_EMail)}<a href="mailto: {$item.PPL_EMail}" title="Contact {$item.PPL_Name}!">{$item.PPL_EMail}</a>{/if}
                                                </td>
                                                <td class="tabledata4" width="15%" valign="top" align="center">
                                                        {$item.PPL_Telefone}
                                                </td>
                                                <td class="tabledata4" width="25%" valign="top" align="center">
                                                        {foreach from=$item.ON_LOAN item="it"}
                                                                <a href="editItem.php?id={$it.ITM_ID}&returnTo=peoples.php" title="View item {$it.ITM_ShortName}">{$it.ITM_ShortName|truncate:40:"..."}</a>{if !empty($it.ITM_LendDate)} - {$it.ITM_LendDate}{/if}<br/>
                                                        {/foreach}
                                                </td>
                                                <td class="tabledata4" width="10%" valign="top" nowrap align="center">
                                                        &nbsp;
                                                        <a href="#" onclick="deleteObject('frm', 'Person', {$item.PPL_ID}, 'deleteOne');" title="Delete this person"><img src="images/icons/delete.png" style="border-style:none;"></a>
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

        
