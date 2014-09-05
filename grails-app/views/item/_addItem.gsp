<g:form name="formAddItem" controller="Item" action="addItem" method="post" >

<div class="dialog">
    <table>
	<tbody>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="category">Category</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="category"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="subcategory">SubCategory</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="subcategory"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="name">Name</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="name"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="otherNames">Other Names</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="otherNames"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="variety">Variety</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="variety"/>
		</td>
	    </tr>

	    <tr class="prop">
		<td valign="top" class="name">
		    <label for="brand">Brand</label>
		</td>
		<td valign="top" class="value">
			<g:textField name="brand"/>
		</td>
	    </tr>


	</tbody>
    </table>
</div>
</g:form>
