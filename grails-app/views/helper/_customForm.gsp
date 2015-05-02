<g:form name="formCustom" controller="Helper" action="saveCustomForm" method="post" >

<g:hiddenField name="customEntityId" value="${customEntityId}" />
<g:hiddenField name="customEntityName" value="${customEntityName}" />
<g:hiddenField name="domainClassId" value="${domainClassId}" />
<g:hiddenField name="domainClassName" value="${domainClassName}" />
<g:hiddenField name="redirectController" value="${redirectController}" />
<g:hiddenField name="redirectAction" value="${redirectAction}" />

<div class="dialog">

<g:set var="domainClassName" value="${domainClassName}" />
<g:set var="domainClassId" value="${domainClassId}" />
<g:set var="title" value="${ics.Attribute.findWhere('domainClassName':domainClassName,'domainClassAttributeName':domainClassId,name:'title')}" />
<g:set var="items" value="${ics.Attribute.findAllWhere('domainClassName':domainClassName,'domainClassAttributeName':domainClassId,category:'ITEM',[sort:'position'])}" />


<h1>${title?.displayName}</h1>
<table>
	<g:each var="item" in="${items}">
	  <tr>
	  	<td>${"("+item.position+") "+item.displayName}</td>
	  </tr>
	  <tr>
	  	<td>
			<g:if test="${item.type=='MULTI'}">
				<g:set var="choices" value="${ics.Attribute.findAllWhere('domainClassName':domainClassName,'domainClassAttributeName':domainClassId,category:item.name,[sort:'position'])}" />
				<g:each var="choice" in="${choices}">
					<label>
						<input type="radio" name="${item.name}" value="${choice.position}" required="required">${choice.displayName}
					</label>					
				</g:each>
			</g:if>
			<g:else>
				<g:textArea name="${item.name}" value="" required="required" maxlength="200"/>
			</g:else>
			<p/>
	  	</td>
	  </tr>
	</g:each>
</table>

</div>
</g:form>

