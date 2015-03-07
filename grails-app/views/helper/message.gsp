<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Send message</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
        </div>
        <div class="body">
            <h1>Send Message via ${via}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form controller="helper" action="sendmessage" method="post" >
                <g:hiddenField name="via" value="${via}" />
                <g:hiddenField name="entityName" value="${entityName}" />
                <g:hiddenField name="depid" value="${depid}" />
                <g:hiddenField name="ids" value="${ids}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <b>Names</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
					<g:each in="${individuals}" status="i" var="ind">
						${ind.toString()+" ; "} 
					</g:each>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <b>To</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
				    <g:if test="${via=='EMAIL'}">
				    	<g:textArea name="to" rows="5" cols="100" value="${emailAddrs}"/>
				    </g:if>
				    <g:else>
				    	<g:textArea name="to" rows="5" cols="100" value="${phoneNos}"/>
				    </g:else>
                                    
                                </td>
                            </tr>

			    <g:if test="${via=='EMAIL'}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <b>Subject</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textArea name="sub" cols="100" rows="1"/>
                                </td>
                            </tr>
			    </g:if>
			    
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <b>Message</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: roleInstance, field: 'name', 'errors')}">
                                    <g:textArea name="msg" rows="5" cols="100" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="sendmessage" value="Send" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
