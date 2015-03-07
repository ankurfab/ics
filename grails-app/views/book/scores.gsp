
<%@ page import="ics.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title>Scores as on ${new Date()}</title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
<div>
	<table border="1">
		<tr>
			<th>Date</th>
			<th>Distributor</th>			
			<th>Small</th>
			<th>Medium</th>
			<th>Big</th>
			<th>MahaBig</th>
			<th>BookPoints</th>			
		</tr>
		<g:each var="score" in="${scores}">
		<!-- find the team -->
		<g:set var="team" value=""/>
		<g:set var="bo" value="${ics.BookOrder.createCriteria().get{challan{eq('id',score.challan_id)}}}" /> 
		<g:if test="${bo}">
			<g:set var="team" value="${bo.team?.comments}"/>
		</g:if>
		<g:if test="${!bo}">
			<g:set var="rgs" value="${ics.RelationshipGroup.createCriteria().list(max:1){
					eq('category','JIVADAYA')
					eq('refid',score.dist_id.toInteger())
					order('id','desc')
					}}"/>
			<g:if test="${rgs.size()>0}">
				<g:set var="team" value="${rgs[0].comments}"/>
			</g:if>
		</g:if>
		<tr>
			<td>${score.date}</td>
			<td>${score.distributor+" "}
				<g:if test="${team}">
				(${team})
				</g:if>
			</td>
			<td>${score.Small}</td>
			<td>${score.Medium}</td>
			<td>${score.Big}</td>
			<td>${score.MahaBig}</td>
			<td>${score.BookPoints}</td>
		</tr>
		</g:each>		
	</table>
</div>
	</body>
</html>
