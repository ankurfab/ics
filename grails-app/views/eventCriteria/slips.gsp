<%@ page import="ics.EventCriteria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventCriteria.label', default: 'EventCriteria')}" />
        <title>Generate Slips for Events</title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	<span class="menuButton"><g:link class="create" action="slips">Slips</g:link></span>
	</div>
        <div class="body">
            <h1>Generate Slips</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form action="generate" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        <tr class="prop">
                        <td valign="top" class="name">
				<g:radio name="slipFor" value="Individual"/> Individual<br>                 
				<g:radio name="slipFor" value="Collector" /> Collector<br>
				<g:radio name="slipFor" value="Cultivator" checked="true"/> Cultivator<br>
                        </td>
                        </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label >Event</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acEvent"
				    width="200px"
				    controller="event"
				    action="findEventsAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                   
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label >Event Criteria</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acEventCriteria"
				    width="200px"
				    controller="eventCriteria"
				    action="findEventCriteriaAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                   
                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label >Person</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
			       <div style="width: 200px">
				<gui:autoComplete
				    id="acIndividual"
				    width="200px"
				    controller="individual"
				    action="allIndividualsAsJSON"
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
                    <span class="button"><g:submitButton name="generate" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>



        </div>
    </body>
</html>