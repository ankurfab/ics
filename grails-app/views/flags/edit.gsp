

<%@ page import="ics.Flags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'flags.label', default: 'Flags')}" />
        <title>Contact Data Verification and Correction</title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${flagsInstance}">
            <div class="errors">
                <g:renderErrors bean="${flagsInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${flagsInstance?.id}" />
                <g:hiddenField name="version" value="${flagsInstance?.version}" />

            <g:set var="ind" value="${ics.Individual.get(flagsInstance?.individualid)}" />

		<div class="buttons">
		    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
		    <span class="button"><g:actionSubmit class="delete" action="cancel" value="Cancel" /></span>
		</div>
            
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><b>Individual</b></td>
                            <td valign="top" class="value"><g:link controller= "individual" action="show" id="${flagsInstance?.individualid}">${ind}</g:link></td>
                            <g:hiddenField name="ind_id" value="${ind?.id}" />

                        <tr class="prop">
                            <td valign="top" class="name"><b>Comments</b></td>
                            <td valign="top" class="value">
	                            <g:textField name="comments" value="${flagsInstance?.comments}" size="100" />
                            </td>
                        </tr>
                            
                            
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Telephone Verified?</b></td>
                            <td valign="top" class="value"><g:checkBox name="telephoneNo" value="${flagsInstance?.telephoneNo}" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>CellPhone</b></td>
                            <td valign="top" class="value">
                                <g:set var="cp" value="${ics.VoiceContact.findByIndividualAndCategory(ind,'CellPhone')}" />
                                <g:hiddenField name="cp_id" value="${cp?.id}" />
                                <g:textField size="100" name="cpno" value="${cp?.number}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>HomePhone</b></td>
                            <td valign="top" class="value">
                                <g:set var="hp" value="${ics.VoiceContact.findByIndividualAndCategory(ind,'HomePhone')}" />
                                <g:hiddenField name="hp_id" value="${hp?.id}" />
                                <g:textField size="100" name="hpno" value="${hp?.number}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>CompanyPhone</b></td>
                            <td valign="top" class="value">
                                <g:set var="cop" value="${ics.VoiceContact.findByIndividualAndCategory(ind,'CompanyPhone')}" />
                                <g:hiddenField name="cop_id" value="${cop?.id}" />
                                <g:textField size="100" name="copno" value="${cop?.number}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Comments</b></td>
                            <td valign="top" class="value">
	                            <g:textField name="telComments" value="${flagsInstance?.telComments}" size="100" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
                    


            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Email Verified?</b></td>
                            <td valign="top" class="value"><g:checkBox name="email" value="${flagsInstance?.email}" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Email</b></td>
                            <td valign="top" class="value">
                                <g:set var="em" value="${ics.EmailContact.findByIndividualAndCategory(ind,'Personal')}" />
                                <g:hiddenField name="em_id" value="${em?.id}" />
                                <g:textField size="100" name="emaddr" value="${em?.emailAddress}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Company Email</b></td>
                            <td valign="top" class="value">
                                <g:set var="emco" value="${ics.EmailContact.findByIndividualAndCategory(ind,'Official')}" />
                                <g:hiddenField name="emco_id" value="${emco?.id}" />
                                <g:textField size="100" name="emcoaddr" value="${emco?.emailAddress}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Comments</b></td>
                            <td valign="top" class="value">
	                            <g:textField name="emailComments" value="${flagsInstance?.emailComments}" size="100" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
                    

            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Address Verified?</b></td>
                            <td valign="top" class="value"><g:checkBox name="address" value="${flagsInstance?.address}" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><b>Correspondence Address</b></td>
                            <td valign="top" class="value">
                                <g:set var="ca" value="${ics.Address.findByIndividualAndCategory(ind,'Correspondence')}" />
                                <g:hiddenField name="ca_id" value="${ca?.id}" />
                                <g:textField size="100" name="ca_addressLine1" value="${ca?.addressLine1}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            <td valign="top" class="value">
                                Pin<g:textField name="ca_pin" value="${ca?.pincode}" />
                                City<g:select name="ca_city_id" from="${ics.City.list(sort:asc)}" optionKey="id"  value="${ca?.city?.id?:ics.City.findByName('Pune')}" />
                                State<g:select name="ca_state_id" from="${ics.State.list(sort:asc)}" optionKey="id"  value="${ca?.state?.id?:ics.State.findByName('Maharashtra')}" />
                                Ctry<g:select name="ca_country_id" from="${ics.Country.list(sort:asc)}" optionKey="id"  value="${ca?.country?.id?:ics.Country.findByName('India')}" />
                            </td>
                        </tr>
                            
                        <tr class="prop">
                            <td valign="top" class="name"><b>Company Address</b></td>
                            <td valign="top" class="value">
                                <g:set var="coa" value="${ics.Address.findByIndividualAndCategory(ind,'Company')}" />
                                <g:hiddenField name="coa_id" value="${coa?.id}" />
                                <g:textField size="100" name="co_name" value="${ind?.companyName}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            <td>
                            	<g:textField size="100" name="coa_addressLine1" value="${coa?.addressLine1}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            <td valign="top" class="value">
                                Pin<g:textField name="coa_pin" value="${coa?.pincode}" />
                                City<g:select name="coa_city_id" from="${ics.City.list(sort:asc)}" optionKey="id"  value="${coa?.city?.id?:ics.City.findByName('Pune')}" />
                                State<g:select name="coa_state_id" from="${ics.State.list(sort:asc)}" optionKey="id"  value="${coa?.state?.id?:ics.State.findByName('Maharashtra')}" />
                                Ctry<g:select name="coa_country_id" from="${ics.Country.list(sort:asc)}" optionKey="id"  value="${coa?.country?.id?:ics.Country.findByName('India')}" />
                            </td>
                        </tr>
                            
                        <tr class="prop">
                            <td valign="top" class="name"><b>Permanent Address</b></td>
                            <td valign="top" class="value">
                                <g:set var="pa" value="${ics.Address.findByIndividualAndCategory(ind,'Permanent')}" />
                                <g:hiddenField name="pa_id" value="${pa?.id}" />
                                <g:textField size="100" name="pa_addressLine1" value="${pa?.addressLine1}" />
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            <td valign="top" class="value">
                                Pin<g:textField name="pa_pin" value="${pa?.pincode}" />
                                City<g:select name="pa_city_id" from="${ics.City.list(sort:asc)}" optionKey="id"  value="${pa?.city?.id?:ics.City.findByName('Pune')}" />
                                State<g:select name="pa_state_id" from="${ics.State.list(sort:asc)}" optionKey="id"  value="${pa?.state?.id?:ics.State.findByName('Maharashtra')}" />
                                Ctry<g:select name="pa_country_id" from="${ics.Country.list(sort:asc)}" optionKey="id"  value="${pa?.country?.id?:ics.Country.findByName('India')}" />
                            </td>
                        </tr>
                            
                        <tr class="prop">
                            <td valign="top" class="name"><b>Comments</b></td>
                            <td valign="top" class="value">
	                            <g:textField name="addressComments" value="${flagsInstance?.addressComments}" size="100" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
                    
            <div class="dialog">
                <table>
                    <tbody>
                    
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formstatus"><b>Status</b></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'formstatus', 'errors')}">
					<g:select name="formstatus" from="${['VERIFIED','UNDER VERIFICATION','PHYSICAL VERIFICATION NEEDED']}" value="${flagsInstance?.formstatus?:'UNDER VERIFICATION'}" />                                    
                                </td>
                            </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><b><g:message code="flags.dateCreated.label" default="Date Created" /></b></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${flagsInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><b><g:message code="flags.creator.label" default="Creator" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: flagsInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><b><g:message code="flags.lastUpdated.label" default="Last Updated" /></b></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${flagsInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><b><g:message code="flags.updator.label" default="Updator" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: flagsInstance, field: "updator")}</td>
                            
                        </tr>
                    
                        
                    </tbody>
                </table>
            </div>
            
            <div>
                <table>
                    <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <b>Collectors</b>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'formstatus', 'errors')}">
					<ul>
					<g:each in="${collectors}" var="c">
					    <li><g:link controller="individual" action="show" id="${c}" target="_blank">${ics.Individual.get(c)}</g:link></li>
					</g:each>
					</ul>
                                </td>
                            </tr>
                    </tbody>
                </table>

            </div>

                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="cancel" value="Cancel" /></span>
                </div>
            </g:form>

        </div>
    </body>
</html>
