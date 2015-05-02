
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserLayout" />
    </head>
    <body>
    <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
    </g:if>    
    <div>
    	<g:if test="${!success && (!trycount || trycount<=3)}">
            <g:form action="verify" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"></label>
                                </td>
                                <td valign="top" class="value">
                                    Please verify your registration by entering the code mentioned on the cover of the DVD in the GPL packet: 
                                    <g:textField name="packetcode" value="" maxlength="9"  required placeholder="Enter Registration Confirmation Code from GPL Packet" pattern = "[0-9]{9}"  title='Registration Confirmation Code must contain digits only'/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="verify" class="save" value="Verify" /></span>
                </div>
            </g:form>
         </g:if>
    </div>
	
    </body>
</html>
