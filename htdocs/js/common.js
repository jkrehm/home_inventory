/**
* Sets a Cookie with the given name and value.
*
* name       Name of the cookie
* value      Value of the cookie
* [expires]  Expiration date of the cookie (default: end of current session)
* [path]     Path where the cookie is valid (default: path of calling document)
* [domain]   Domain where the cookie is valid
*              (default: domain of calling document)
* [secure]   Boolean value indicating if the cookie transmission requires a
*              secure transmission
*/
function setCookie(name, value, expires, path, domain, secure) 
{
        var ExpireDate = new Date ();
        ExpireDate.setTime(ExpireDate.getTime() + (365 * 24 * 3600 * 1000));
        expires = ExpireDate;
        document.cookie= name + "=" + escape(value) +
                ((expires) ? "; expires=" + ExpireDate.toGMTString() : "") +
                ((path) ? "; path=" + path : "") +
                ((domain) ? "; domain=" + domain : "") +
                ((secure) ? "; secure" : "");
}


/**
* Gets the value of the specified cookie.
*
* name  Name of the desired cookie.
*
* Returns a string containing value of specified cookie,
*   or null if cookie does not exist.
*/
function getCookie(name)
{
        var dc = document.cookie;
        var prefix = name + "=";
        var begin = dc.indexOf("; " + prefix);
        if (begin == -1) {
                begin = dc.indexOf(prefix);
                if (begin != 0) return null;
        } else {
                begin += 2;
        }
        var end = document.cookie.indexOf(";", begin);
        if (end == -1) {
                end = dc.length;
        }
        return unescape(dc.substring(begin + prefix.length, end));
}
        
        
/**
* Deletes the specified cookie.
*
* name      name of the cookie
* [path]    path of the cookie (must be same as path used to create cookie)
* [domain]  domain of the cookie (must be same as domain used to create cookie)
*/
function deleteCookie(name, path, domain) 
{
        if (getCookie(name)) {
                document.cookie = name + "=" +
                        ((path) ? "; path=" + path : "") +
                        ((domain) ? "; domain=" + domain : "") +
                        "; expires=Thu, 01-Jan-70 00:00:01 GMT";
        }
}

// act fields is used in locations.tpl only to avoid conflict changing form action properties
function save(formName, type, altAction)
{
        frmObj = document.forms[formName];
        if (typeof(altAction) == 'undefined')
            frmObj.action.value = type;
        else
            frmObj.act.value = type;

        frmObj.submit();
}

// act fields is used in locations.tpl only to avoid conflict changing form action properties
function deleteObject(formName, description, id, action, altAction)
{
        if (confirm('Confirm deletion of ' + description + '?'))
        {
                frmObj = document.forms[formName];
                frmObj.id.value = id;
                if (typeof(altAction) == 'undefined')
                    frmObj.action.value = action;
                else
                    frmObj.act.value = action;

                frmObj.submit();
        }
}


function setBackground()
{
        backgr = getCookie('manager_background');
        if (backgr != null)
                //document.bgColor = '#FF0000';
                document.body.background = 'images/' + backgr;
}


function toggleDiv(divName, cookieName) 
{
        if (document.getElementById(divName).style.display == 'none')
        {
                document.getElementById(divName).style.display = 'block';
                setCookie(cookieName, 1);
        }
        else
        {
                document.getElementById(divName).style.display = 'none';
                setCookie(cookieName, 0);
        }
}



