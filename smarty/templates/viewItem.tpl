{literal}
	<script type="text/javascript">		

	</script>
{/literal}

<table align=center width="55%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
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
							<TD width="55%"><b>View item</b></TD>
							<td align="right">
								<input type="button" class="smallbutton" onclick="document.location.href='{if !empty($smarty.request.returnTo)}{$smarty.request.returnTo}{else}list.php{/if}{if !empty($smarty.session.pageID)}?pageID={$smarty.session.pageID}{/if}';" value="&lt; Back">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="self.print();" value="Print">&nbsp;&nbsp;&nbsp;
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
					<td class="tabledata3" align="center" width="30%">
						 {if !empty($ITEM.ITM_Picture)}
							<a href="images/items/{$ITEM.ITM_Picture}" target="_newWin" title="Enlarge picture"><img src="images/items/{$ITEM.ITM_Picture}" width="160px" border="1" style="border-color: #888888;"></a>
						{else}
							&nbsp;
						{/if}
					</td>
					<td class="tabledata3" align="left" valign="top" colspan="2">
						<b style="font-size: 12pt;">{$ITEM.ITM_ShortName}</b>
						<br/>
						<span style="font-size: 11pt;">{$ITEM.ITM_Description}
						<br/><br/>
						<b style="font-size: 10pt;">Location:</b> &nbsp;{$ITEM.LOC_Description1} {if !empty($ITEM.LOC_Description2)}- {$ITEM.LOC_Description2}{/if}
						<br/>
						<b style="font-size: 10pt;">Quantity:</b> &nbsp;{$ITEM.ITM_Quantity}
						{if !empty($ITEM.ITM_LendToId)}
							<br/>
							<b style="font-size: 10pt;">Lend to:</b> &nbsp;{$ITEM.PPL_Name} {if !empty($ITEM.ITM_LendDate)}(from {$ITEM.ITM_LendDate|date_format:"%d/%m/%Y"}){/if}
							{if !empty($ITEM.PPL_Telefone)}Tel. {$ITEM.PPL_Telefone}{/if} {if !empty($ITEM.PPL_EMail)}EMail: {$ITEM.PPL_EMail}{/if}
						{/if}
						</span>
					</td>
				</tr>
				
				
				<!-- DETAILS -->
				<tr>
					<td class="tabledata6" align="center" colspan="3"><b>Details</b></td>
				</tr>
				
				{if !empty($ITEM.ITM_State) || !empty($ITEM.ITM_Condition) || !empty($ITEM.ITM_ConditionDescr)}
				<tr>
					<td class="tabledata3" align="right"><b>Condition</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>
						{if $ITEM.ITM_State == 0}USED{elseif $ITEM.ITM_State == 1}NEW{/if}
						{if $ITEM.ITM_Condition == 1}- Poor{elseif $ITEM.ITM_Condition == 2}- Good{elseif $ITEM.ITM_Condition == 3}- Fair{elseif $ITEM.ITM_Condition == 4}- Excellent{/if}
						{if !empty($ITEM.ITM_ConditionDescr)}<br/>{$ITEM.ITM_ConditionDescr}{/if}
					</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_Brand) || !empty($ITEM.ITM_Model)}
				<tr>
					<td class="tabledata3" align="right"><b>Brand - Model</b></td>
					<td valign="top" colspan="2" class="tabledata7">
						{$ITEM.ITM_Brand|escape}&nbsp;&nbsp;-&nbsp;&nbsp;
						{$ITEM.ITM_Model|escape}&nbsp;&nbsp;
					</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_SerialNum)}
				<tr>
					<td class="tabledata3" align="right"><b>Serial number</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>{$ITEM.ITM_SerialNum|escape}</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_PurchaseDate) || !empty($ITEM.ITM_PurchaseLocation) || !empty($ITEM.ITM_PurchasePrice)}
				<tr>
					<td class="tabledata3" align="right"><b>Purchase info</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>
						{if !empty($ITEM.ITM_PurchaseDate)}{$ITEM.ITM_PurchaseDate|date_format:"%d/%m/%Y"} &nbsp;{/if}
						{if !empty($ITEM.ITM_PurchaseLocation)}{$ITEM.ITM_PurchaseLocation} &nbsp;{/if}
						{if !empty($ITEM.ITM_PurchasePrice)}{$ITEM.ITM_PurchasePrice} &nbsp;{/if}
					</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_CurrentValue)}
				<tr>
					<td class="tabledata3" align="right"><b>Current value</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>{$ITEM.ITM_CurrentValue|escape}</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_ReplacementCost)}
				<tr>
					<td class="tabledata3" align="right"><b>Replacement cost</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>{$ITEM.ITM_ReplacementCost|escape}</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_WarrantyInfo)}
				<tr>
					<td class="tabledata3" align="right"><b>Warranty info</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>{$ITEM.ITM_WarrantyInfo|escape}</td>	
				</tr>
				{/if}
				
				{if !empty($ITEM.ITM_History)}
				<tr>
					<td class="tabledata3" align="right" valign="top"><b>Maintenance History</b></td>
					<td valign="top" colspan="2" class="tabledata7" nowrap>{$ITEM.ITM_History|escape|nl2br}</td>	
				</tr>
				{/if}
				
				{* <!-- PICTURE`S GALLERY --> *}
				{if !empty($HTML_PICTURES)}
					<tr>
						<td class="tabledata6" align="center" colspan="3"><b>Pictures</b></td>
					</tr>
					<tr>
						<td class="tabledata3" align="center" colspan="3">
							<table cellpadding="0" cellspacing="6" width="100%">
							{$HTML_PICTURES}
							</table>
						</td>
					</tr>
				{/if}
			</form>
		</table>
	<//td>
</tr>
</table>