<table align=center width="70%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
<tr>
	<td bgcolor=#FFFFFF>
		<table border=0 cellspacing=2 cellpadding=5 align=center width="100%">
			<form name="frmAdvSearch" method="POST">	
				<input type="hidden" name="action" value="">
				<input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
				
				<tr>
					<td class=tableheader align="left" colspan="3">
						<table cellpadding="0" cellspacing="0" width="100%">
						<TR>
							<td><b>Advanced search</b></td>
							<td style="text-align:right">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="save('frmAdvSearch', 'reset');" value="Reset">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="save('frmAdvSearch', 'save');" value="Search">&nbsp;&nbsp;
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
				
				<!-- GENERAL INFORMATION -->
				<tr>
					<td class="tabledata6" align="left" colspan="3">Search parameters can be full or partial words</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left" width="25%"><b>Text</b> (search into short name or description)</td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="50" name="descriptionTxt" value="{$smarty.session.SEARCH.descriptionTxt|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Location</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<select name="ITM_LocationId" class="text" onchange="clearText();">
							<option value=""></option>
							{foreach from=$smarty.session.LOCATIONS item="loc"}
								<option value="{$loc.LOC_ID}" {if $loc.LOC_ID == $smarty.session.SEARCH.ITM_LocationId}selected{/if}>{$loc.LOC_Description1} - {$loc.LOC_Description2|truncate:60:"..."}</option>
							{/foreach}
						</select>
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Brand</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_Brand" value="{$smarty.session.SEARCH.ITM_Brand|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Model</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_Model" value="{$smarty.session.SEARCH.ITM_Model|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Serial num.</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_SerialNum" value="{$smarty.session.SEARCH.ITM_SerialNum|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Condition</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="radio" value="1" name="ITM_State" {if $smarty.session.SEARCH.ITM_State == 1}checked{/if}>New</radio>
						<input type="radio" value="2" name="ITM_State" {if $smarty.session.SEARCH.ITM_State == 2}checked{/if}>Used</radio>&nbsp;&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Purchase location</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_PurchaseLocation" value="{$smarty.session.SEARCH.ITM_PurchaseLocation|escape}">
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Purchase price</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<select name="priceOp" class="text">
							<option value="<" {if $smarty.session.SEARCH.priceOp == '<'}selected{/if}>&lt;</option>
							<option value="<=" {if $smarty.session.SEARCH.priceOp == '<='}selected{/if}>&lt;=</option>
							<option value="=" {if $smarty.session.SEARCH.priceOp == '='}selected{/if}>=</option>
							<option value=">" {if $smarty.session.SEARCH.priceOp == '>'}selected{/if}>&gt;</option>
							<option value=">=" {if $smarty.session.SEARCH.priceOp == '>='}selected{/if}>&gt;=</option>
						</select>&nbsp;
						<input type="text" class="text" size="30" name="ITM_PurchasePrice" value="{$smarty.session.SEARCH.ITM_PurchasePrice|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Current value</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<select name="cValueOp" class="text">
							<option value="<" {if $smarty.session.SEARCH.cValueOp == '<'}selected{/if}>&lt;</option>
							<option value="<=" {if $smarty.session.SEARCH.cValueOp == '<='}selected{/if}>&lt;=</option>
							<option value="=" {if $smarty.session.SEARCH.cValueOp == '='}selected{/if}>=</option>
							<option value=">" {if $smarty.session.SEARCH.cValueOp == '>'}selected{/if}>&gt;</option>
							<option value=">=" {if $smarty.session.SEARCH.cValueOp == '>='}selected{/if}>&gt;=</option>
						</select>&nbsp;
						<input type="text" class="text" size="30" name="ITM_CurrentValue" value="{$smarty.session.SEARCH.ITM_CurrentValue|escape}">
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Warranty Information</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_WarrantyInfo" value="{$smarty.session.SEARCH.ITM_WarrantyInfo|escape}">
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Maintenance History</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="30" name="ITM_History" value="{$smarty.session.SEARCH.ITM_History|escape}">
					</td>
				</tr>
			</form>
		</table>
	<//td>
</tr>
</table>