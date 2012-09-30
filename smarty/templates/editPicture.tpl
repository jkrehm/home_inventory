{literal}
	<script type="text/javascript">		
		function deletePicture(id, fName)
		{
			if (confirm('Delete this picture? Are you sure?'))
			{
				frmObj = document.forms['frmPicture'];
                frmObj.pictId.value = id;
                frmObj.pictFileName.value = fName;
                frmObj.action.value = 'deletePicture';
                frmObj.submit();
            }
            else
            	return false;
		}
	</script>
{/literal}

<table align=center width="70%" style="border: 1px solid #DDDDDD" cellspacing=0 cellpadding=0>
<tr>
	<td bgcolor=#FFFFFF>
		<table border=0 cellspacing=2 cellpadding=5 align=center width="100%">
			<form name="frmPicture" method="POST" enctype="multipart/form-data">	
				<input type="hidden" name="action" value="">
				<input type="hidden" name="pictId" value="">
				<input type="hidden" name="pictFileName" value="">
				<input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
				
				<tr>
					<td class=tableheader align="left" colspan="3">
						<table cellpadding="0" cellspacing="0" width="100%">
						<TR>
							<TD width="55%">
								<b>Edit Picture&nbsp;&nbsp; (step <a href="#" onclick="document.location.href='editItem.php?id={$smarty.request.id}';" class="whiteLink">1</a>/2)</b>
							<br/>
							</TD>
							<td align="right">
								<input type="button" class="smallbutton" onclick="document.location.href='{if !empty($smarty.request.returnTo)}{$smarty.request.returnTo}{else}editItem.php?id={$smarty.request.id}{/if}';" value="&lt; Back">&nbsp;&nbsp;&nbsp;
								<input type="button" class="smallbutton" onclick="save('frmPicture', 'save');" value="Save">&nbsp;&nbsp;
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
					<td class="tabledata3" align="left" colspan="3">Item name: <i>{$ITEM_INFO.ITM_ShortName}</i></td>
				</tr>
				
				<!-- MULTIPLE UPLOAD -->
				<tr>
					<td class="tabledata6" align="center" colspan="3"><b>Upload new pictures</b></td>
				</tr>
				<tr>
					<td class="tabledata3" align="left" colspan="3">
						There is not a maximum limit to the number of uploadable picture.<br/>
						&nbsp;<input type="file" class="text" size="50" name="file1"><br/>
						&nbsp;<input type="file" class="text" size="50" name="file2"><br/>
						&nbsp;<input type="file" class="text" size="50" name="file3"><br/>
						&nbsp;<input type="file" class="text" size="50" name="file4"><br/>
					</td>
				</tr>
				
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
	</td>
</tr>
</table>