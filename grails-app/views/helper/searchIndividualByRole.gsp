
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search Individual by Role</title>
    </head>
    <body>
        <div class="body">
            <h1>Search Individual by Role</h1>
            <g:form controller='individualRole' action="searchByRole" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
			                                <td valign="top" class="name">
			                                    <label for="role"><g:message code="individualRole.role.label" default="Role" /></label>
			                                </td>
			                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'role', 'errors')}">
			                                    <g:select name="roleid" from="${ics.Role.list(sort:'name')}"  optionKey="id" value="${individualRoleInstance?.role?.id}"  />
			                                </td>
                            </tr>
                        
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Individual:</label>
                                </td>
                                
                                <td valign="top" class="value">
                                    <g:textField name="individualname" value="" />
                                </td>
                            </tr>-->
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="save" value="Search" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
