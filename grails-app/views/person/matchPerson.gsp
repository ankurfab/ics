
<%@ page import="ics.Person" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title>Matching results</title>
		<r:require module="qtip" />
	</head>
	<body>

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

	<script>
	function qTip(node) {
	    var url = node.attr("href");
	    node.qtip({
		content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
		show: {
		            ready: true // Show it immediately
        }
	    });
	}
	$(document).ready(function() {
	    $('.lex').on('mouseover', function() {
		var _self = $(this);
		qTip(_self);
	    });
	})
	</script>
			

        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create">New Contact</g:link></span>
        </div>

        <div class="body">
		<div id="list-person" class="list">
			<h1>Match Results</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
				<tr>
				<th>
					MatchCondition
				</th>
				<th>
					Individual(s)
				</th>
				</tr>
				</thead>
				<tr>
					<td>
					Name (${personInstance?.name})
					</td>
					<td>
					    <table>
						<g:each in="${mnameInds}">
						    <tr>
						    	<td>

						    		<g:link class="lex" title="test" controller="person" action="show" id="${it.id}">${it.name}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>

				<tr>
					<td>
					Phone (${personInstance?.phone})
					</td>
					<td>
					    <table>
						<g:each in="${mphoneInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="person" action="show" id="${it.id}">${it.name}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<!--<tr>
					<td>
					Address (${personInstance?.address?:(personInstance?.officeAddress?:'')})
					</td>
					<td>
					    <table>
						<g:each in="${maddrInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>-->
				<tr>
					<td>
					Email (${personInstance?.email})
					</td>
					<td>
					    <table>
						<g:each in="${memailInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="person" action="show" id="${it.id}">${it.name}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					PANNO (${personInstance?.panno})
					</td>
					<td>
					    <table>
						<g:each in="${mpanInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="person" action="show" id="${it.id}">${it.name}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					LMNO (${personInstance?.lmno})
					</td>
					<td>
					    <table>
						<g:each in="${mlmnoInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="person" action="show" id="${it.id}">${it.name}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
			</table>
		</div>
	<g:form method="post" >
		<!--<g:hiddenField name="id" value="${personInstance?.id}" />-->
		<g:hiddenField name="version" value="${personInstance?.version}" />
		<g:hiddenField name="name" value="${personInstance?.name}" />
		<g:hiddenField name="address" value="${personInstance?.address}" />
		<g:hiddenField name="phone" value="${personInstance?.phone}" />
		<g:hiddenField name="email" value="${personInstance?.email}" />
		<g:hiddenField name="panno" value="${personInstance?.panno}" />
		<g:hiddenField name="lmno" value="${personInstance?.lmno}" />

		<g:hiddenField name="category" value="${category}" />
		<fieldset class="buttons">
			<g:actionSubmit class="list" action="list" value="Do Not Save" formnovalidate="" />
			<g:actionSubmit class="save" action="savePerson" value="Save" />
		</fieldset>
	</g:form>
	</div>
	</body>
</html>
