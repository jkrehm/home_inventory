<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
	<title>Home Inventory</title>
	<link rel="stylesheet" href="css/main.css" type="text/css">
</head>

<body style="margin: 150 0 0 0;" onload="setBackground();">
	<center>
		<table align=center>
		<tr><td bgcolor=#555599>
			<table border=0 cellspacing=1 cellpadding=3 align=center width=300>
				<form name="frmLogin" action="auth.php" method="POST" ID="Form2">	
					<input type="hidden" name="returnTo" value="{$smarty.request.returnTo}">
					<tr>
						<td class=tableheader align="left" colspan="3"><img src="images/icons/icon-user.gif" border=0 hspace=20 align=absmiddle>
							<b>Home Inventory Login<br><br/>
							{if isset($WRONG_USER)}User not found{/if}</b>
						</td>
						
					</tr>
					<tr>
						<td class="tabledata3" align=right >Username:</td>
						<td valign=top colspan=2 class="tabledata3"><img onClick="document.frmLogin.email.focus();" src="images/icons/icon-email.gif" border=0 align=top>&nbsp;<input  onBlur="this.className='input_textbox'" onfocus="this.className='input_textboxfocus'"  class="input_textbox" size=20 style="background-color: #FFFFFF;" type=text name="username" value="{$smarty.post.username}"></td>	
					</tr>
					<tr>
						<td class="tabledata3" align=right >Password:</td>
						<td colspan=2 class="tabledata3"><img onClick="document.frmLogin.password.focus();" src="images/icons/icon-lock.gif" border=0 hspace=1 align=top>&nbsp;<input onBlur="this.className='input_textbox'" onfocus="this.className='input_textboxfocus'" class="input_textbox"  size=20 style="background-color: #FFFFFF;" type=password name="password"></td>
					</tr>

					<tr>
						<td class="tabledata3" colspan=3 align=center><input type=submit class="smallButton" value=Login>
						</td>
					</tr>
					
				</form>
			</table>
		</td></tr>
		</table>
	</center>
</body>

</html>