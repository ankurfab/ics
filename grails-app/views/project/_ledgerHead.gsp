<%@ page import="ics.Expense" %>


<g:hiddenField name="id" value="${expenseInstance?.id}" />
<g:hiddenField name="version" value="${expenseInstance?.version}" />

<div class="allbody"> 

   
<fieldset class="form">

<div>
	<label for="type">Type</label>
	${expenseInstance?.type}
</div>

<div>
	<label for="ledgerHead">Ledger Head</label>
	<g:select id="ledgerHead" name='ledgerHead.id' value="${expenseInstance?.ledgerHead?.id}"
	    noSelection="${['':'Select Ledger Head']}"
	    from='${ics.LedgerHead.list()}'
	    optionKey="id" optionValue="name"></g:select>
</div>

</fieldset>

</div>