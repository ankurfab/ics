<div class="dialog">
<table border='1'>
    <tbody>
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
<g:each in="${results}" var="ind" status="i"> 
	<tr>
		<td>${i+1}</td>
		<td><g:link target="_new" controller="individual" action="show" id="${ind.icsid}">${ind.icsid}</g:link></td>
		<td>${ind.toString()}</td>
		<td>${ics.VoiceContact.findByIndividualAndCategory(ind,'CellPhone')?.number?:''}</td>
		<td>${ics.EmailContact.findByIndividualAndCategory(ind,'Personal')?.emailAddress?:''}</td>
		<td>${(attOn?attOn[2]?.get(ind.icsid):'')?'Y':''}</td>
		<td>${(attOn?attOn[1]?.get(ind.icsid):'')?'Y':''}</td>
		<td>${(attOn?attOn[0]?.get(ind.icsid):'')?'Y':''}</td>
		<td/>
	 </tr>

</g:each>

    </tbody>
</table>
</div>
