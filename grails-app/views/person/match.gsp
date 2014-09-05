
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
	    $('a.lex').click(function(e) {
	        e.preventDefault();
	        //do other stuff when a click happens
		});
	})
	</script>
			

        <!--<div class="nav">
            <span class="menuButton"><g:link class="create" action="create">New Contact</g:link></span>
        </div>-->

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
						    		<g:link class="lex" title="test" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					Spouse (${personInstance?.spouse})
					</td>
					<td>
					    <table>
						<g:each in="${mspouseInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					Father (${personInstance?.father})
					</td>
					<td>
					    <table>
						<g:each in="${mfatherInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
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
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					Address (${personInstance?.address?:(personInstance?.officeAddress?:'')})
					</td>
					<td>
					    <table>
						<g:each in="${maddrInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="individual" action="show" id="${it?.id}">${it?.legalName+" ( "+(it?.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					Email (${personInstance?.email})
					</td>
					<td>
					    <table>
						<g:each in="${memailInds}">
						    <tr>
						    	<td>
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
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
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
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
						    		<g:link class="lex" controller="individual" action="show" id="${it.id}">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<b>Match Result</b>
					</td>
					<td>
						<g:if test="${personInstance?.status == 'AUTOMATCHED'}">
							<g:link controller="individual" action="show" id="${personInstance?.matchedIndividual?.id}">${personInstance?.matchedIndividual?.legalName+" ( "+(personInstance?.matchedIndividual?.initiatedName?:'')+" )"}</g:link>
						</g:if>
					</td>
				
				</tr>
				<tr>
					<td>
					Repeating Matches
					</td>
					<td>
					    <table>
						<g:each in="${dupInds}">
						    <tr>
						    	<td>
						    		<g:link action="map" id="${personInstance.id}" params="[mid: it.id, category: category]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">${it.legalName+" ( "+(it.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
				<tr>
					<td>
					Unique Matches
					</td>
					<td>
					    <table>
						<g:each in="${uniqInds}">
						    <tr>
						    	<td>
						    		<g:link action="map" id="${personInstance.id}" params="[mid: it?.id, category: category]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">${it?.legalName+" ( "+(it?.initiatedName?:'')+" )"}</g:link>
						    	</td>
						    </tr>
						</g:each>
						</table>
					</td>
				</tr>
			</table>			
		</div>
		<!--<div>
		<h2>
			<g:if test="${uniqInds?.size() > 0}">List of Matching Individual(s) (Please click on the relevant one for linking)
			</g:if>
			<g:else>No matching individual found!!
			</g:else>
		</h2>
		    <table>
			<g:each in="${uniqInds}">
			    <tr>
				<td>
					${it?.legalName+" ( "+(it?.initiatedName?:'')+" )"}
				</td>
			    </tr>
			</g:each>
			</table>
		</div>-->
	<g:form method="post" >
		<g:hiddenField name="id" value="${personInstance?.id}" />
		<g:hiddenField name="version" value="${personInstance?.version}" />
		<g:hiddenField name="category" value="${category}" />
		<fieldset class="buttons">
			<!--<g:actionSubmit class="delete" action="skip" value="Skip" formnovalidate="" />-->
			<!--<g:actionSubmit class="save" action="next" value="Next" formnovalidate=""  />-->
		      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
			<g:if test="${!keyFlag}">
			<g:actionSubmit class="create" action="cultivate" value="Create in Central DB" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			</g:if>
			<g:else>
			<g:if test="${keyFlag}">
			<g:actionSubmit class="create" action="cultivate" value="Create in Central DB" formnovalidate="" onclick="return confirm('The local contact possibly exists in Central Contact!! Are you sure?');" />
			</g:if>
			</g:else>
		      </sec:ifAnyGranted>
		</fieldset>
	</g:form>
	</div>
	</body>
</html>
