<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="plain" />
        <title>Attendance Sheet</title>
    </head>
    <body>
        <div class="nav">
        </div>
        <div class="body">
            <div class="dialog">

		<g:set var="attOn" value="${retMap.attOn}" />
		<g:set var="result" value="${retMap.pairs}" />

                <table border='1'>
                    <thead>
			<th>S.No.</th>
			<th>ICS Id</th>
			<th>Name</th>
			<th>Phone</th>
			<th>Email</th>
			<th>Attendance On ${attOn?attOn[2]?.eventDate?.format('dd-MM'):''}</th>
			<th>Attendance On ${attOn?attOn[1]?.eventDate?.format('dd-MM'):''}</th>
			<th>Attendance On ${attOn?attOn[0]?.eventDate?.format('dd-MM'):''}</th>
			<th>Today's Attendance</th>
                    </thead>
                    <tbody>
			<g:each in="${result}" var="pair" status="sno"> 
				<g:each in="${pair}" var="ind"> 				
					<tr class="${(sno % 2) == 0 ? 'odd' : 'even'}">
						<td>${sno+1}</td>
						<td><g:link target="_new" controller="individual" action="show" id="${ind.icsid}">${ind.icsid} (${ind.loginid})</g:link></td>
						<td>${ind.toString()}</td>
						<td>${ics.VoiceContact.findByIndividualAndCategory(ind,'CellPhone')?.number?:''}</td>
						<td>${ics.EmailContact.findByIndividualAndCategory(ind,'Personal')?.emailAddress?:''}</td>
						<td>${(attOn?attOn[2]?.get(ind.icsid):'')?'Y':''}</td>
						<td>${(attOn?attOn[1]?.get(ind.icsid):'')?'Y':''}</td>
						<td>${(attOn?attOn[0]?.get(ind.icsid):'')?'Y':''}</td>
						<td/>
					</tr>
				 </g:each>
		       </g:each>                    
                    </tbody>
                </table>
            </div>
    </body>
</html>
