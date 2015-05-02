<%@ page import="ics.EventRegistration" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="plain">
    	<title>ACS - ${er.name}</title>

<style type='text/css' media='print'>
    body {
        margin: 0;
        padding: 0;
        background-color: #FAFAFA;
        font: 12pt "Tahoma";
    }
    * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
    .page {
        width: 21cm;
        height: 29.7cm;
        padding: 1cm;
        #margin: 1cm;
        #border: 1px #D3D3D3 solid;
        #border-radius: 5px;
        background: white;
        #box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
    .subpageTop {

        #border: 5px red solid;
        height:50%;
        #outline: 2cm #FFEAEA solid;
    }
    .subpageBottom {
        #padding-top: 2cm;
        #border: 5px red solid;
        height:50%;
        #outline: 2cm #FFEAEA solid;
    }

    @page {
        size: A4;
        margin: 5px;
    }
    @media print {
        html, body {
            width: 210mm;
            height: 297mm;
        }
        .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after:always;
        }
    }
    #summary
    {
        margin-top:10px;

    }


</style>

<style>
    #summary
    {
        margin-top:10px;
    }
</style>

</head>
<body>
<div>
	<div class="page">
	    <div class="subpageTop">
        	<h1>Accommodation Confirmation Slip (ACS) - ${er.event?.title} - ${er.event?.startDate?.format('dd/MM/yyyy')} - ${er.event?.endDate?.format('dd/MM/yyyy')}</h1>
        	
        	<table border="1">
        	<tr>
        		<th>Name</th>
        		<th>Dwarka Accommodation</th>
        		<th>Dwarka Room No</th>
        		<th>Somnath Accommodation</th>
        		<th>Somnath Room No</th>
        	</tr>
        	<g:each var="person" in="${persons}">
        		<tr>
        		<td>${person.name}</td>
        		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:person.id?.toString(),name:'place0'))?.value}</td>
        		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:person.id?.toString(),name:'place0_room'))?.value}</td>
        		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:person.id?.toString(),name:'place1'))?.value}</td>
        		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:person.id?.toString(),name:'place1_room'))?.value}</td>
        		</tr>
		</g:each>
		</table>
		<br>
        	<table border="1">
        	<tr>
        		<th>Address</th>
        		<th>Important Points</th>
        		<th>Message</th>
        	</tr>
		<tr>
		<td>${ics.EventDetail.findWhere('event.id':er.event.id,category:'Dwarka',type:'Address')?.details}</td>
		<td>${ics.EventDetail.findWhere('event.id':er.event.id,category:'Dwarka',type:'Instructions')?.details}</td>
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:er.id?.toString(),name:'place0_message'))?.value}</td>
		</tr>

		<tr>
		<td>${ics.EventDetail.findWhere('event.id':er.event.id,category:'Somnath',type:'Address')?.details}</td>
		<td>${ics.EventDetail.findWhere('event.id':er.event.id,category:'Somnath',type:'Instructions')?.details}</td>
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(category:'EVENTACCOMMODATION',type:er.id?.toString(),name:'place1_message'))?.value}</td>
		</tr>
		</table>
		
		</div>                
	    </div>

    <div class="subpageBottom">
    </div>


</div>
</body>
</html>



