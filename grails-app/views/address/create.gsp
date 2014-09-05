
<%@ page import="ics.Address" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'address.label', default: 'Address')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${addressInstance}">
            <div class="errors">
                <g:renderErrors bean="${addressInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="address.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'individual', 'errors')}">
                                    <g:hiddenField name="individual.id" value="${addressInstance?.individual?.id}" />
                                    ${addressInstance?.individual}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="address.category.label" default="Category" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'category', 'errors')}">
					<g:select name="category" from="${['Correspondence','Permanent','Company','Location','Other']}" value="${addressInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1"><g:message code="address.addressLine1.label" default="Address Line1" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine1', 'errors')}">
                                    <g:textField name="addressLine1" maxlength="255" value="${addressInstance?.addressLine1}" size="100"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine2"><g:message code="address.addressLine2.label" default="Address Line2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine2', 'errors')}">
                                    <g:textField name="addressLine2" maxlength="100" value="${addressInstance?.addressLine2}" size="100"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine3"><g:message code="address.addressLine3.label" default="Address Line3" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'addressLine3', 'errors')}">
                                    <g:textField name="addressLine3" maxlength="100" value="${addressInstance?.addressLine3}" size="100" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="address.city.label" default="City" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}">
                                    <g:select name="city.id" from="${ics.City.list(sort:'name')}" optionKey="id" value="${addressInstance?.city?.id}" value="${ics.City.findByName('Pune')?.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="address.state.label" default="State" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'state', 'errors')}">
                                    <g:select name="state.id" from="${ics.State.list(sort:'name')}" optionKey="id" value="${addressInstance?.state?.id}"  value="${ics.State.findByName('Maharashtra')?.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><g:message code="address.country.label" default="Country" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'country', 'errors')}">
                                    <g:select name="country.id" from="${ics.Country.list(sort:'name')}" optionKey="id" value="${addressInstance?.country?.id}" value="${ics.Country.findByName('India')?.id}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pincode"><g:message code="address.pincode.label" default="Pincode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'pincode', 'errors')}">
                                    <g:textField name="pincode" value="${addressInstance?.pincode}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
