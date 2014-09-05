
<%@ page import="ics.Donation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
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
			<table border="1">
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
					Name (${donationInstance?.donorName})
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
					Phone (${donationInstance?.donorContact})
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
					Address (${donationInstance?.donorAddress})
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
				</tr>
				<tr>
					<td>
					Email (${donationInstance?.donorEmail})
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
					PANNO (${donationInstance?.donorPAN})
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
			</table>
		</div>
	<g:form method="post" >
		<g:hiddenField name="id" value="${donationInstance?.id}" />
		<div>
		<h2>
			<g:if test="${(uniqInds?.size()+dupInds?.size()) > 0}">List of Matching Individual(s)
			</g:if>
			<g:else>No matching individual found!!
			</g:else>
		</h2>
		<h3> Repeated matches!!</h3>
		    <table>
			<g:each in="${dupInds}">
			    <tr>
				<td>
					<g:radio name="uniqIndRadio" value="${it.id}"/>${it.legalName+" ( "+(it.initiatedName?:'')+" )"}				
				</td>
			    </tr>
			</g:each>
			</table>
		<h3> Single matches!!</h3>
		    <table>
			<g:each in="${uniqInds}">
			    <tr>
				<td>
					<g:radio name="uniqIndRadio" value="${it.id}"/>${it.legalName+" ( "+(it.initiatedName?:'')+" )"}				
				</td>
			    </tr>
			</g:each>
			</table>
		</div>

		<fieldset class="buttons">
			<g:actionSubmit class="save" action="link" value="Link to Selected Individual" formnovalidate="" />
			<g:actionSubmit class="save" action="createAndLink" value="Create And Link" formnovalidate=""  />
		     <!-- <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
			<g:if test="${!keyFlag}">
			<g:actionSubmit class="create" action="cultivate" value="Create in Central DB" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			</g:if>
		      </sec:ifAnyGranted> -->
		</fieldset>
	</g:form>
	</div>
	</body>
</html>
