
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'devotee.label', default: 'Devotee')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:javascript library="jquery" />

<link rel="stylesheet" href="${resource(dir: 'css/ui-lightness', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css">
<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">

	</head>
	<body>
<g:javascript src="jquery.tablesorter.min.js" />
<g:javascript src="jquery-ui-1.8.17.custom.min.js" />
<script>
$(document).ready(function(){
   $("a").click(function(event){
     alert("As you can see, the link no longer took you to jquery.com");
     event.preventDefault();
   });
   $( "#datepicker" ).datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
  $("#myTable").tablesorter(); 
 });
 </script>
		<a href="#list-devotee" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-devotee" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>


 <div class="demo">

 <p>Date: <input id="datepicker" type="text"></p>

</div><!-- End demo -->


<table id="myTable" class="tablesorter"> 
<thead> 
<tr> 
    <th>Last Name</th> 
    <th>First Name</th> 
    <th>Email</th> 
    <th>Due</th> 
    <th>Web Site</th> 
</tr> 
</thead> 
<tbody> 
<tr> 
    <td>Smith</td> 
    <td>John</td> 
    <td>jsmith@gmail.com</td> 
    <td>$50.00</td> 
    <td>http://www.jsmith.com</td> 
</tr> 
<tr> 
    <td>Bach</td> 
    <td>Frank</td> 
    <td>fbach@yahoo.com</td> 
    <td>$50.00</td> 
    <td>http://www.frank.com</td> 
</tr> 
<tr> 
    <td>Doe</td> 
    <td>Jason</td> 
    <td>jdoe@hotmail.com</td> 
    <td>$100.00</td> 
    <td>http://www.jdoe.com</td> 
</tr> 
<tr> 
    <td>Conway</td> 
    <td>Tim</td> 
    <td>tconway@earthlink.net</td> 
    <td>$50.00</td> 
    <td>http://www.timconway.com</td> 
</tr> 
</tbody> 
</table> 

			<table>
				<thead>
					<tr>
					
						<td>counsellorName</td>
						<td>dob</td>
						<td>initiatedName</td>
						<td>legalName</td>
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${devoteeInstanceList}" status="i" var="devoteeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${devoteeInstance.id}">${fieldValue(bean: devoteeInstance, field: "counsellorName")}</g:link></td>
					
						<td><g:formatDate date="${devoteeInstance.dob}" /></td>
					
						<td>${fieldValue(bean: devoteeInstance, field: "initiatedName")}</td>
					
						<td>${fieldValue(bean: devoteeInstance, field: "legalName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
