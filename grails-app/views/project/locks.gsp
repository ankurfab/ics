
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Locks</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <g:form method="post" >
                <div class="dialog">
                    
                    <g:set var="lockAttr" value="${ics.Attribute.findByNameAndType('EMS_ACCUSER_LOCK','LOCK')}" />
                    
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Current Lock Status
                                </td>
                                <td valign="top" class="value">
                                    ${ics.AttributeValue.findByAttribute(lockAttr)?.value?:'NOTSET'}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  New Lock Status
                                </td>
                                <td valign="top" class="value}">
					ON<g:radio name="lockValue" value="ON"/>
					OFF<g:radio name="lockValue" value="OFF" checked="true"/>                                    
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updateLocks" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
