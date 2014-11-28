
<%@ page import="ics.Sadhana" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="sadhana.create" default="Create Sadhana" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="sadhana.list" default="Sadhana List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="sadhana.create" default="Create Sadhana" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${sadhanaInstance}">
            <div class="errors">
                <g:renderErrors bean="${sadhanaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="devotee"><g:message code="sadhana.devotee" default="Devotee" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'devotee', 'errors')}">
                                    <g:select name="devotee.id" from="${ics.Individual.list()}" optionKey="id" value="${sadhanaInstance?.devotee?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="day"><g:message code="sadhana.day" default="Day" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'day', 'errors')}">
                                    <g:datePicker name="day" value="${sadhanaInstance?.day}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attendedMangalAratik"><g:message code="sadhana.attendedMangalAratik" default="Attended Mangal Aratik" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'attendedMangalAratik', 'errors')}">
                                    <g:checkBox name="attendedMangalAratik" value="${sadhanaInstance?.attendedMangalAratik}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numRoundsBefore9"><g:message code="sadhana.numRoundsBefore9" default="Num Rounds Before9" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBefore9', 'errors')}">
                                    <g:textField name="numRoundsBefore9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBefore9')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numRoundsBetween9And12"><g:message code="sadhana.numRoundsBetween9And12" default="Num Rounds Between9 And12" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween9And12', 'errors')}">
                                    <g:textField name="numRoundsBetween9And12" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween9And12')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numRoundsBetween12And6"><g:message code="sadhana.numRoundsBetween12And6" default="Num Rounds Between12 And6" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween12And6', 'errors')}">
                                    <g:textField name="numRoundsBetween12And6" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween12And6')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numRoundsBetween6And9"><g:message code="sadhana.numRoundsBetween6And9" default="Num Rounds Between6 And9" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween6And9', 'errors')}">
                                    <g:textField name="numRoundsBetween6And9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween6And9')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numRoundsAfter9"><g:message code="sadhana.numRoundsAfter9" default="Num Rounds After9" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'numRoundsAfter9', 'errors')}">
                                    <g:textField name="numRoundsAfter9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsAfter9')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="minutesRead"><g:message code="sadhana.minutesRead" default="Minutes Read" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'minutesRead', 'errors')}">
                                    <g:textField name="minutesRead" value="${fieldValue(bean: sadhanaInstance, field: 'minutesRead')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="minutesHeard"><g:message code="sadhana.minutesHeard" default="Minutes Heard" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'minutesHeard', 'errors')}">
                                    <g:textField name="minutesHeard" value="${fieldValue(bean: sadhanaInstance, field: 'minutesHeard')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="minutesAssociated"><g:message code="sadhana.minutesAssociated" default="Minutes Associated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'minutesAssociated', 'errors')}">
                                    <g:textField name="minutesAssociated" value="${fieldValue(bean: sadhanaInstance, field: 'minutesAssociated')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attendedSandhyaAratik"><g:message code="sadhana.attendedSandhyaAratik" default="Attended Sandhya Aratik" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'attendedSandhyaAratik', 'errors')}">
                                    <g:checkBox name="attendedSandhyaAratik" value="${sadhanaInstance?.attendedSandhyaAratik}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="sadhana.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: sadhanaInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: sadhanaInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
