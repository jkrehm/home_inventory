{literal}
	<script type="text/javascript">		
		function deselectComboValue()
		{
			document.frmItem.ITM_LocationId.selectedIndex = 0;
		}
		
		function clearText()
		{
			document.frmItem.LOC_Description1.value = '';
			document.frmItem.LOC_Description2.value = '';
		}
	</script>
{/literal}

<table align=center width="70%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
<tr>
	<td bgcolor=#FFFFFF>
		<table border=0 cellspacing=2 cellpadding=5 align=center width="100%" id="pippo">
			<form name="frmItem" method="POST" enctype="multipart/form-data">	
				<input type="hidden" name="action" value="">
				<input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
				
				<tr>
					<td class=tableheader align="left" colspan="3">
						<table cellpadding="0" cellspacing="0" width="100%">
						<TR>
							<TD width="55%"><b>{if isset($smarty.request.id)}Edit Item{else}Insert new item{/if}</b>
								<b>&nbsp;&nbsp; (step 1/<a href="#" onclick="document.location.href='editPicture.php?id={$smarty.request.id}';" class="whiteLink">2</a>)</b>
							<br/>
								Fields marked with <span style="color: #FF0000">*</span> are required.
							</TD>
							<td align="right">
								<input type="button" class="smallbutton" onclick="document.location.href='{if !empty($smarty.request.returnTo)}{$smarty.request.returnTo}{else}list.php{/if}{if !empty($smarty.session.pageID)}?pageID={$smarty.session.pageID}{/if}';" value="&lt; Back">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="save('frmItem', 'saveAndNew');" value="Save and New">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="save('frmItem', 'save');" value="Save">&nbsp;&nbsp;
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
					<td class="tabledata6" align="center" colspan="3"><b>General information</b></td>
				</tr>
				<tr>
					<td class="tabledata3" align="left" width="20%"><b><span style="color: #FF0000">*</span> Short name</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="50" name="ITM_ShortName" value="{$ITEM.ITM_ShortName|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b><span style="color: #FF0000"></span>Description</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<textarea class="text" rows="5" cols="50" name="ITM_Description">{$ITEM.ITM_Description}</textarea>
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b><span style="color: #FF0000">*</span> Location</b><br/>
						Select or enter a new location
					</td>
					<td valign="top" colspan="2" class="tabledata3">
						<select name="ITM_LocationId" class="text" onchange="clearText();">
							<option value=""></option>
							{foreach from=$LOCATIONS item="loc"}
								<option value="{$loc.LOC_ID}" {if $loc.LOC_ID == $ITEM.ITM_LocationId}selected{/if}>{$loc.LOC_Description1} - {$loc.LOC_Description2|truncate:60:"..."}</option>
							{/foreach}
						</select>
						<br/>
						or <a href="#" onclick="document.getElementById('tblLocation').style.display='block';"><b style="color: #000000;">Enter new location:</b></a><br/>
						<table cellpadding="4" cellspacing="4" id="tblLocation" style="display: none;">
						<TR>
							<TD class="tabledata3">Description 1</TD>
							<td><input type="text" class="text" size="40" maxlength="80" name="LOC_Description1" value="{$ITEM.LOC_Description1}" onkeypress="deselectComboValue();"></td>
						</TR>
						<TR>
							<TD class="tabledata3">Description 2</TD>
							<td><input type="text" class="text" size="40" maxlength="80" name="LOC_Description2" value="{$ITEM.LOC_Description2}" onkeypress="deselectComboValue();"></td>
						</TR>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b><span style="color: #FF0000">*</span> Quantity</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="5" name="ITM_Quantity" value="{if empty($ITEM.ITM_Quantity)}1{else}{$ITEM.ITM_Quantity}{/if}">
					</td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b><span style="color: #FF0000"></span>Lend to</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<select name="ITM_LendToId" class="text">
							<option value=""></option>
							{foreach from=$PEOPLES item="pp"}
								<option value="{$pp.PPL_ID}" {if $pp.PPL_ID == $ITEM.ITM_LendToId}selected{/if} >{$pp.PPL_Name}</option>
							{/foreach}
						</select>
						&nbsp;&nbsp;&nbsp;
						date:
						{html_select_date prefix="lendingDate" time=$ITEM.ITM_LendDate field_order='dmY' month_format="%m" start_year="2005" reverse_years="true" year_empty="---" month_empty="---" day_empty="---"}
						<br/><br/>
					</td>
				</tr>
				
				
				<!-- DETAILS -->
				<tr>
					<td class="tabledata6" align="center" colspan="3"><b>Details</b></td>
				</tr>
				<tr>
					<td class="tabledata3" align="left"><b>Brand - Model - Serial num.</b></td>
					<td valign="top" colspan="2" class="tabledata3" nowrap>
						<input type="text" class="text" size="28" name="ITM_Brand" value="{$ITEM.ITM_Brand|escape}">&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="text" size="28" name="ITM_Model" value="{$ITEM.ITM_Model|escape}">&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="text" size="10" name="ITM_SerialNum" value="{$ITEM.ITM_SerialNum|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left" ><b>Condition</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="radio" value="1" name="ITM_State" {if $ITEM.ITM_State == 1}checked{/if}>New</radio>
						<input type="radio" value="2" name="ITM_State" {if $ITEM.ITM_State == 2}checked{/if}>Used</radio>&nbsp;&nbsp;
						<select name="ITM_Condition" class="text">
							<option value=""></option>
							{foreach from=$CONDITIONS key="kCond" item="cond"}
								<option value="{$kCond}" {if $kCond == $ITEM.ITM_Condition}selected{/if} >{$cond}</option>
							{/foreach}
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;Free description&nbsp;
						<input type="text" class="text" size="28" name="ITM_ConditionDescr" value="{$ITEM.ITM_ConditionDescr|escape}">&nbsp;&nbsp;&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left" ><b>Purchase date - Location - Price</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						{html_select_date prefix="purchaseDate" time=$ITEM.ITM_PurchaseDate field_order='dmY' month_format="%m" start_year="1910" reverse_years="true" year_empty="---" month_empty="---" day_empty="---"}
						&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="text" size="25" name="ITM_PurchaseLocation" value="{$ITEM.ITM_PurchaseLocation|escape}">&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="text" size="10" name="ITM_PurchasePrice" value="{$ITEM.ITM_PurchasePrice|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left" ><b>Current value - Replacement Cost</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="10" name="ITM_CurrentValue" value="{$ITEM.ITM_CurrentValue|escape}">&nbsp;&nbsp;-&nbsp;&nbsp;
						<input type="text" class="text" size="10" name="ITM_ReplacementCost" value="{$ITEM.ITM_ReplacementCost|escape}">
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left" ><b>Warranty Information</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<input type="text" class="text" size="60" name="ITM_WarrantyInfo" value="{$ITEM.ITM_WarrantyInfo|escape}">&nbsp;&nbsp;&nbsp;
					</td>	
				</tr>
				<tr>
					<td class="tabledata3" align="left" ><b>Maintenance History</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						<textarea class="text" rows="4" cols="50" name="ITM_History">{$ITEM.ITM_History}</textarea>
					</td>	
				</tr>
				
				
				<!-- UPLOAD -->
				<tr>
					<td class="tabledata6" align="center" colspan="3"><b>Pictures</b></td>
				</tr>
				<tr>
					<td class="tabledata3" align="left" valign="top"><br/><br/><br/><b><span style="color: #FF0000"></span>First Picture</b></td>
					<td valign="top" colspan="2" class="tabledata3">
						
						<input type="button" class="smallbutton" value="More picture &gt;" {if !isset($smarty.request.id)}disabled{/if} onclick="document.location.href='editPicture.php?id={$smarty.request.id}';"><br/>
						<br/>
						This picture will appear into item's list.&nbsp;&nbsp;&nbsp; If you need additional pictures click on '<b>More picture</b>'. Note: You should save this page before enter additional pictures.
						<br/><input type="file" class="text" size="50" name="ITM_Picture">
						{if !empty($ITEM.ITM_Picture)}
							<br/><br/>
							<div style="padding-left: 40px">
								<img src="images/items/{$ITEM.ITM_Picture}" title="{$ITEM.ITM_Picture}" width="500">
							</div>
							<br/>
						{/if}
					</td>
				</tr>
			</form>
		</table>
	<//td>
</tr>
</table>
