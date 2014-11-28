
<%@ page import="ics.Mb" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Initiate Profile Creation</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>Initiate Profile Creation</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${mbInstance}">
            <div class="errors">
                <g:renderErrors bean="${mbInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <fieldset>
                        <legend><b>Candidate Info</b></legend>
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donorName">Legal Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'donorName', 'errors')}">
                                    <g:textField name="donorName" size="50" maxlength="127" pattern=".{10,}" validationMessage="Please enter min 10 letters!" required="required" value="" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="initiatedName">Initiated Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'initiatedName', 'errors')}">
                                    <g:textField name="initiatedName" size="50" maxlength="127" pattern=".{10,}" value="" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donorContact">Contact Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'donorContact', 'errors')}">
                                    <g:textField name="donorContact" type="tel" size="50" value="" required="required"/>

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donorEmail">Email Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'donorEmail', 'errors')}">
                                    <g:textField name="donorEmail" type="email" size="50" value="" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refClor">Counsellor:</label>
                                </td>
                            </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'donorContact', 'errors')}">
                                    <g:textField name="refClor" type="tel" size="50" value="" required="required"/>
                            </tr>
                        </tbody>
                    </table>
                    </fieldset>
                </div>
                <br><br>
                <div class="dialog">
                    <fieldset>
                        <legend><b>Referrer Info</b></legend>
                    <table>
                        <tbody>
                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refName">Referred By:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'donorName', 'errors')}">
                                    <g:textField name="refName" size="50" maxlength="127" pattern=".{10,}" validationMessage="Please enter min 10 letters!" required="required" value="" />

                                </td>
                            </tr>
                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refCentre">Centre:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'initiatedName', 'errors')}">
                                    <g:textField name="refCentre" size="50" maxlength="127" pattern=".{3,}" value="" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refContact">Contact Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'refContact', 'errors')}">
                                    <g:textField name="refContact" type="tel" size="50" value="" required="required"/>

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refEmail">Email Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'refEmail', 'errors')}">
                                    <g:textField name="refEmail" type="email" size="50" value="" />

                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="refReln">Relation to the referred candidate:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfileInstance, field: 'refEmail', 'errors')}">
                                    <g:textField name="refReln" size="50" value="" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </fieldset>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Initiate" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
