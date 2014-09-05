

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>Advance Donation</title>
        <gui:resources components="['tabView','autoComplete']"/>

	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

    	<g:javascript library="jquery" />
    	<jqui:resources theme="ui-lightness" />
    </head>
    <body>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            
        </div>
  
        <div class="body">
        
            <h1>Enter Advance Donation By</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="create1" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanedBy">Advance Donation By</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanedBy', 'errors')}">
									<div style="width: 300px">

										<gui:autoComplete
											id="acIndividual"
											width="300px"
											controller="individual"
											action="allIndividualsExceptDummyDonorAsJSON"
											useShadow="true"
											queryDelay="0.5" minQueryLength='3'

										/>
									</div>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="next0" class="save" value="Next Step (Witness(es))" /></span>
                </div>
            </g:form>
        
			
        </div>
    </body>
</html>
