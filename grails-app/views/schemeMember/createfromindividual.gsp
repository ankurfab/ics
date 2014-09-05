

<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'schemeMember.label', default: 'SchemeMember')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <r:require module="jqui" />
        <script type="text/javascript">
         $(document).ready(function()
            {
                $("#startDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                $("#stopDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                 $("#recentResumeDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
                 $("#futureStartDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
            })
        </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
        	
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${schemeMemberInstance}">
            <div class="errors">
                <g:renderErrors bean="${schemeMemberInstance}" as="list" />
            </div>
            </g:hasErrors>
            <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_DONATION_EXECUTIVE">
				<g:form action="savefromindividual" >
					<div class="dialog">
						<table>
							<tbody>

								<tr class="prop">
									<td valign="top" class="name">
										<label for="member"><g:message code="schemeMember.member.label" default="Member" /></label>
									</td>
									<td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'member', 'errors')}">
										${member}<g:hiddenField name="individualid" value="${individualid}" />
									</td>
								</tr>
                                 <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="externalName"><g:message code="schemeMember.externalName" default="External Name(From Bank/ECS Agency)" />:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'externalName', 'errors')}">
                                        <g:textField name="externalName" value="${fieldValue(bean: schemeMemberInstance, field: 'externalName')}" />

                                    </td>
                                 </tr>

                                  <tr class="prop">
                                    <td valign="top" class="name">
                                        <label for="counsumerNumber"><g:message code="schemeMember.counsumerNumber" default="Counsumer Number(From Bank/ECS Agency)" />:</label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'counsumerNumber', 'errors')}">
                                        <g:textField name="counsumerNumber" value="${fieldValue(bean: schemeMemberInstance, field: 'counsumerNumber')}" />

                                    </td>
                                 </tr>

								<tr class="prop">
									<td valign="top" class="name">
										<label for="scheme"><g:message code="schemeMember.scheme.label" default="Scheme" /></label>
									</td>
									<td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'scheme', 'errors')}">
										<g:select name="scheme.id" from="${schemes}" optionKey="id" value="${schemeMemberInstance?.scheme?.id}"  />
									</td>
								</tr>

								<tr class="prop">
									<td valign="top" class="name">
										<label for="centre"><g:message code="schemeMember.centre.label" default="Centre" /></label>
									</td>
									<td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'centre', 'errors')}">
										<g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${schemeMemberInstance?.centre?.id}"  />
									</td>
								</tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="schemeMember.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" keys="${['ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" value="${fieldValue(bean: schemeMemberInstance, field: 'status')}"  />
                                    
                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="recentCommunication"><g:message code="schemeMember.recentCommunication" default="Recent Communication" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'recentCommunication', 'errors')}">
                                    <g:textArea name="recentCommunication" class="smalltextarea" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'recentCommunication')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressTheConcern"><g:message code="schemeMember.addressTheConcern" default="Address any Concern" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'addressTheConcern', 'errors')}">
                                    <g:select name="addressTheConcern" from="${['NONE','LOW','MEDIUM','HIGH']}" keys="${['NONE','LOW','MEDIUM','HIGH']}" value="${fieldValue(bean: schemeMemberInstance, field: 'addressTheConcern')}"  />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="schemeMember.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startComments"><g:message code="schemeMember.startComments" default="Start Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'startComments', 'errors')}">
                                    <g:textArea  class="smalltextarea" name="startComments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'startComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="stopComments"><g:message code="schemeMember.stopComments" default="Stop Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'stopComments', 'errors')}">
                                    <g:textArea class="smalltextarea" name="stopComments" rows="2" cols="80" value="${fieldValue(bean: schemeMemberInstance, field: 'stopComments')}" />

                                </td>
                            </tr>
                        
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startDate"><g:message code="schemeMember.startDate" default="Start Date" />*:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'startDate', 'errors')}">
                                    <g:textField name="startDate" value="${schemeMemberInstance?.startDate?.format('dd-MM-yyyy')}"/>    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="stopDate"><g:message code="schemeMember.stopDate" default="Stop Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'stopDate', 'errors')}">
                                    <g:textField name="stopDate" value="${schemeMemberInstance?.stopDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="recentResumeDate"><g:message code="schemeMember.recentResumeDate" default="Recent Resume Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'recentResumeDate', 'errors')}">
                                    <g:textField name="recentResumeDate" value="${schemeMemberInstance?.recentResumeDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="futureStartDate"><g:message code="schemeMember.futureStartDate" default="Future Start Date " />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'futureStartDate', 'errors')}">
                                    <g:textField name="futureStartDate" value="${schemeMemberInstance?.futureStartDate?.format('dd-MM-yyyy')}"/>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedFrequency"><g:message code="schemeMember.committedFrequency" default="Committed Frequency" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedFrequency', 'errors')}">
                                    <g:select name="committedFrequency" from="${['MONTHLY','QUARTERLY','HALFYEARLY','YEARLY']}" keys="${['MONTHLY','QUARTERLY','HALFYEARLY','YEARLY']}" value="${fieldValue(bean: schemeMemberInstance, field: 'committedFrequency')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedAmount"><g:message code="schemeMember.committedAmount" default="Committed Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedAmount', 'errors')}">
                                    <g:textField name="committedAmount" value="${fieldValue(bean: schemeMemberInstance, field: 'committedAmount')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="actualCurrentAmount"><g:message code="schemeMember.actualCurrentAmount" default="Actual Current Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'actualCurrentAmount', 'errors')}">
                                    <g:textField name="actualCurrentAmount" value="${fieldValue(bean: schemeMemberInstance, field: 'actualCurrentAmount')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="membershipLevel"><g:message code="schemeMember.membershipLevel" default="MemberShip Level" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'membershipLevel', 'errors')}">
                                     <g:select name="membershipLevel" from="${['BRONZE1','BRONZE2','SILVER1','SILVER2','GOLD','PLATINUM','DIAMOND']}" keys="${['BRONZE1','BRONZE2','SILVER1','SILVER2','GOLD','PLATINUM','DIAMOND']}"  noSelection="['': '']" value="${fieldValue(bean: schemeMemberInstance, field: 'membershipLevel')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedMode"><g:message code="schemeMember.committedMode" default="Committed Mode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedMode', 'errors')}">
                                    <g:select name="committedMode" from="${['ECS','E-PAYMENT','CASH','PDC']}"  keys="${['ECS','E-PAYMENT','CASH','PDC']}"  noSelection="['': '']" value="${fieldValue(bean: schemeMemberInstance, field: 'committedMode')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="committedModeDetails"><g:message code="schemeMember.committedModeDetails" default="Committed Mode Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'committedModeDetails', 'errors')}">
                                    <g:textField name="committedModeDetails" value="${fieldValue(bean: schemeMemberInstance, field: 'committedModeDetails')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankName"><g:message code="schemeMember.bankName" default="Bank Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'bankName', 'errors')}">
                                    <g:textField name="bankName" value="${fieldValue(bean: schemeMemberInstance, field: 'bankName')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountNumber"><g:message code="schemeMember.bankName" default="Account Number" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'accountNumber', 'errors')}">
                                    <g:textField name="accountNumber" value="${fieldValue(bean: schemeMemberInstance, field: 'accountNumber')}" />

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftchannel"><g:message code="schemeMember.giftchannel" default="Gift Channel" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: schemeMemberInstance, field: 'giftchannel', 'errors')}">
                                    <g:textField name="giftchannel" value="${fieldValue(bean: schemeMemberInstance, field: 'giftchannel')}" />

                                </td>
                            </tr>

			</tbody>
		</table>
					</div>
					<div class="buttons">
						<span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
					</div>
				</g:form>
			</sec:ifAnyGranted>
        </div>
    </body>
</html>
