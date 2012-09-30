<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<title>Home Inventory</title>
	<link rel="stylesheet" href="css/main.css" type="text/css">
	<script language="javascript" type="text/javascript" src="js/common.js">
	// <!--
  	// -->
	</script>
</head>


<body style="margin: 0 0 0 0; {if $SHOW_ITEM_LIST}background-color: #EEEEEE;{else}background-color: #FFFFFF;{/if}">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align="left" valign="top" width="100%">
				<table align="center" width="100%">
				<tr>
					<td bgcolor="#555599">
						<table border="0" cellspacing="1" cellpadding="3" align="center" width="100%">
						<tr>
							<td class="tableheader" align="left" nowrap>
								<a href="list.php"><IMG src="images/icons/logo.png" width="48" height="48" hspace="8" vspace="0" align="left" border="0"></a>
								<H2>Home Inventory</H2>
							</td>
						</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="3" align="center" width="100%">
						<tr>
							<td class="partialBorder" align="center">
								<a href="editItem.php" class="whiteLink">New item</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/icons/itemLittle.png" vspace="-4">&nbsp;<a href="list.php" class="whiteLink">List item</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/icons/locationLittle.png" vspace="-4">&nbsp;<a href="locations.php" class="whiteLink">Locations</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/icons/peopleLittle.png" vspace="-4">&nbsp;<a href="peoples.php" class="whiteLink">Peoples</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/icons/find.png" vspace="-4">&nbsp;<a href="advSearch.php" class="whiteLink">Advanced Search...</a>
							</td>
							<td class="partialBorder" align="right" width="1%" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://sourceforge.net/projects/homeinv/" target="_homeinv" class="whiteLink">Home inventory on sf.net</a>&nbsp;&nbsp;&nbsp;</td>
						</tr>
						</tr>
					</td>
				</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align="left" valign="top" width="100%">

				<div style="height: 15px"></div>
				
				<!-- MAIN PAGE CONTENT -->
				<table style="width: 100%;"  border="0" cellpadding="0" cellspacing="0">
					{if $ERRORE_OP|count_characters > 0}
						<tr><td height="30px" style="background-color: #FFFFFF;"><span class="normalfont"><b><font color="#FF0000">&nbsp;{$ERROR_MSG}</font></b></span></td></tr>
					{/if}
					
					<!--  Contenuto della pagina  -->	
					{if $SHOW_ITEM_LIST}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="itemsList.tpl"}</td></tr>
					{elseif $SHOW_EDIT_ITEM}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="editItem.tpl"}</td></tr>
					{elseif $SHOW_VIEW_ITEM}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="viewItem.tpl"}</td></tr>
					{elseif $SHOW_EDIT_PICTURE}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="editPicture.tpl"}</td></tr>
					{elseif $SHOW_LOCATION_LIST}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="locations.tpl"}</td></tr>
					{elseif $SHOW_PEOPLE_LIST}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="peoples.tpl"}</td></tr>
					{elseif $SHOW_ADVANCED_SEARCH}
						<tr><td style="text-align: justify; " align="left" valign="top">{include file="advSearch.tpl"}</td></tr>
					{/if}
				</table>
				<br>
			</td>
		</tr>
	</table>
</body>
</html>