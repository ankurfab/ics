
<%@ page import="ics.Relationship" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationship.label', default: 'Relationship')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${relationshipInstance}">
            <div class="errors">
                <g:renderErrors bean="${relationshipInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post">
                <div class="dialog">
                    <table>
                        <tbody>
                        <!--
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="relationshipGroup"><g:message code="relationship.relationshipGroup.label" default="Relationship Group" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'relationshipGroup', 'errors')}">
			       <div style="width: 350px">
			       <g:hiddenField name="relationshipGroup.id" value="" />
				<gui:autoComplete
				    id="acRelationshipGroup"
				    width="100px"
				    controller="relationshipGroup"
				    action="findRelationshipGroupsAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
				    forceSelection="false"
				    
			    />
			    </div>
                                </td>
                            </tr>
                        -->
                        <g:hiddenField name="relationshipGroup.id" value="${relationshipInstance?.relationshipGroup?.id}" />
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual1"><g:message code="relationship.individual1.label" default="Individual1" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'individual1', 'errors')}">
					<g:if test="${!relationshipInstance?.relation}">
						    <g:hiddenField name="individual1.id" value="" />
					       <div style="width: 350px">
						<gui:autoComplete
						    id="acIndividual1"
						    width="100px"
						    controller="individual"
						    action="allIndividualsAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='3'
						    forceSelection="true"

					    />
					    </div>
					</g:if>
					<g:else>
						<g:hiddenField name="individual1.id" value="${relationshipInstance?.individual1?.id}" />
						${relationshipInstance?.individual1}
					</g:else>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="relation"><g:message code="relationship.relation.label" default="Relation" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'relation', 'errors')}">
					<g:if test="${!relationshipInstance?.relation}">
					       <div style="width: 350px">
					       <g:hiddenField name="relation.id" value="" />
						<gui:autoComplete
						    id="acRelation"
						    width="100px"
						    controller="relation"
						    action="findRelationsAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='3'
						    forceSelection="false"

					    />
					    </div>
					</g:if>
					<g:else>
						<g:hiddenField name="relation.id" value="${relationshipInstance?.relation?.id}" />
						${relationshipInstance?.relation}
					</g:else>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
					<g:if test="${relationshipInstance?.relation?.name == 'Disciple of'}">
						Guru*
					</g:if>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Councellee of'}">
						Councellor*
					</g:elseif>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Cultivated by'}">
						ISKCON Representative*
					</g:elseif>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Sevak of'}">
						Patron Care Lead*
					</g:elseif>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Managed By'}">
						Secretary*
					</g:elseif>
					<g:else>
						Individual*
					</g:else>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'individual2', 'errors')}">
					<g:if test="${relationshipInstance?.relation?.name == 'Disciple of'}">
						    <g:hiddenField name="individual2.id" value="" />
					       <div style="width: 350px">
						<gui:autoComplete
						    id="acIndividual2"
						    width="100px"
						    controller="individual"
						    action="allGurusAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='3'
						    forceSelection="true"

					    />
					    </div>
					</g:if>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Councellee of'}">
						    <g:hiddenField name="individual2.id" value="" />
					       <div style="width: 350px">
						<gui:autoComplete
						    id="acIndividual2"
						    width="100px"
						    controller="individual"
						    action="allCouncellorsAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='3'
						    forceSelection="true"

					    />
					    </div>
					</g:elseif>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Cultivated by'}">
						    <g:hiddenField name="individual2.id" value="" />
					       <div style="width: 350px">
						<gui:autoComplete
						    id="acIndividual2"
						    width="100px"
						    controller="individual"
						    action="allCultivatorsAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='0'
						    forceSelection="true"

					    />
					    </div>
					</g:elseif>
					<g:elseif test="${relationshipInstance?.relation?.name == 'Sevak of'}">
						    <g:hiddenField name="individual2.id" value="" />
					       <div style="width: 350px">
						<gui:autoComplete
						    id="acIndividual2"
						    width="100px"
						    controller="individual"
						    action="findPatronCareAsJSON"
						    useShadow="true"
						    queryDelay="0.5" minQueryLength='3'
						    forceSelection="true"

					    />
					    </div>
					</g:elseif>
					<g:else>
						<g:hiddenField name="individual2.id" value="${relationshipInstance?.individual2?.id}" />
						${relationshipInstance?.individual2}
					</g:else>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment"><g:message code="relationship.comment.label" default="Comment" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'comment', 'errors')}">
                                    <g:textField name="comment" value="${relationshipInstance?.comment}" />
                                </td>
                            </tr>

			       <g:hiddenField name="family" value="${family}" />
                        
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
