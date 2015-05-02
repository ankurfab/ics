<g:form name="formAssignProfile" controller="Mb" action="assignProfile" method="post" >

<g:hiddenField name="profileid" value="${profile.id}" />

<g:select name='assignedToId'
    noSelection="${['':'Assign to...']}"
    from='${members}'
    optionKey="id" optionValue="legalName"></g:select>
    
</g:form>