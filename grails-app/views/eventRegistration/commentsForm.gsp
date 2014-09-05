
<%@ page import="ics.EventRegistration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Enter registration verification comments</title>
    </head>
    <body>
       <div class="body">
            <h1>Plese provide verification comments</h1>
            <g:form method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
					<td valign="top" class="name">
						<label for="verificationComments">
							<g:message code="eventRegistration.verificationComments" default="Verification Comments" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'verificationComments', 'error')} ">
						<g:textArea name="verificationComments" value="${eventRegistrationInstance?.verificationComments}"/>
					</td>
				</tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:actionSubmit class="delete" action="rejected" value="${message(code: 'default.button.rejected.label', default: 'Rejected')}" />
		    <a href="javascript:self.close();">Close</a>
                </div>
            </g:form>
        </div>
    </body>
</html>
