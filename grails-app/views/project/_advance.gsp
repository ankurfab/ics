<%@ page import="ics.Project" %>


<g:hiddenField name="id" value="${projectInstance?.id}" />
<g:hiddenField name="version" value="${projectInstance?.version}" />

<div class="allbody"> 

   
  <h1>Issue advance for ${projectInstance?.ref}</h1>
			
			
<fieldset class="form">

<div>
	<label for="advanceAmount">Advance Amount Requested</label>
	<g:field name="advanceAmountReq"  id="advanceAmountReq" value="${fieldValue(bean: projectInstance, field: 'advanceAmount')}" readonly="readonly"/>
</div>

<div>
	<label for="advanceAmountIssued">Advance Amount Issued</label>
	<g:field name="advanceAmountIssued"  type="number"/>
</div>

<div>
	<label for="comments">Comments</label>
</div>
<div>
	<g:field name="comments" type="text"/>
</div>

</fieldset>

</div>