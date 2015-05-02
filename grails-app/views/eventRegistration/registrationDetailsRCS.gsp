<%@ page import="ics.EventRegistration" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="plain">
    <g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'Registration')}" />
    <title>RCS</title>
    <r:require module="jqui" />
    <r:require module="jqbarcode" />

</head>
<body>
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
                #padding-left: 1.6cm;
                #margin: 1cm;
                #border: 1px #D3D3D3 solid;
                #border-radius: 5px;
                background: white;
                #box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }
            .subpageDonor {
                padding: 1cm;
                #border: 5px red solid;
                #height: 148mm;
                #outline: 2cm #FFEAEA solid;
            }
            .subpageOffice {
                padding-top: 2cm;
                #border: 5px red solid;
                #height: 130mm;
                #outline: 2cm #FFEAEA solid;
            }

            @page {
                size: A4;
                margin: 10px;
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
        </style>

            <!--Include Upper Barcode  -->
            <div class="page">
                <div class="subpageDonor"> 
                    <div>

                                <h3>Registration Confirmation Slip (RCS) - ${er.event?.title} - ${er.event?.startDate?.format('dd/MM/yyyy')} - ${er.event?.endDate?.format('dd/MM/yyyy')}</h3>
                                
                                <table class="details2" border="1" >

                                    <tr>
                                    <td> Registration Id</td>
                                    <td> <b>${90000+er.id}</b> </td>
                                    <td rowspan="7">
                                    	<img class="avatar" src="${createLink(controller:'individual', action:'avatar_image', id:er.individual?.id)}" />
                                    </td>                                    
                                    </tr>


                                    <tr>
                                        <td>Initiated Name </td>
                                        <td><b>${er.individual?.initiatedName}</b> </td>
                                    </tr>


                                    <tr>
                                        <td>Legal Name </td>
                                        <td><b>${er.individual?.legalName}</b></td>
                                    </tr>


                                    <tr>
                                        <td>Yatra Charges </td>
                                        <td><b>${er.status?:'UNPAID'}</b></td>
                                    </tr>

                                    <tr>
                                        <td>ONLINE Payment </td>
                                        <td><b>Amount: ${er.paymentReference?.amount?:0} Date: ${er.paymentReference?.paymentDate?.format('dd-MM-yyyy HH:mm:ss')}</b></td>
                                    </tr>
                                <g:set var="offlinepymt" value="${ics.PaymentReference.findWhere('ref':'EventRegistration_'+er.id,'paymentBy.id':er.individual.id)}" />

                                    <tr>
                                        <td>OFFLINE Payment </td>
                                        <td><b>Amount: ${offlinepymt?.amount?:0} Date: ${offlinepymt?.paymentDate?.format('dd-MM-yyyy HH:mm:ss')}</b></td>
                                    </tr>

                                    <tr>
                                        <td>Accommodation Details </td>
                                        <td><b>${offlinepymt?.details}</b></td>
                                    </tr>

                                </table>
                            <!--<div id="barcodeTarget" ></div>-->

                        </div>  <!-- End of barcode,reg details,Photo details outer div -->
	        </div>
                <div class="subpageOffice">  <!-- Office Copy -->
                </div>   <!-- End of Subpage Div -->  
                </div>    <!-- End of Page Div -->  

           <g:each var="person" in="${ persons }" status="p"> 

            <div class="page">
                <div class="subpageDonor"> 
                    <div>
                            <fieldset>
                                <div id="prasad">
                                    <h3>Prasad Coupons for  ${person}</h3>
                                    <g:each var="i" in="${ (0..<new Integer(numDays)) }"> 
                                        <table class ="coupans" style="border:2px dashed black;">

                                            <tr>

						<td>
							<table>
								<tr><td><b>${person.name}</b></td></tr>
								<tr><td><b>Breakfast</b></td></tr>
								<tr><td><b>${(er.event.startDate+i).format('E d-M-y')}</b></td></tr>
								<tr><td><div id="${'barcodeprasad_'+i+'_B_'+person.id}"></div></td></tr>
                                                	</table>
                                                </td>


						<td>
							<table>
								<tr><td><b>${person.name}</b></td></tr>
								<tr><td><b>Lunch</b></td></tr>
								<tr><td><b>${(er.event.startDate+i).format('E d-M-y')}</b></td></tr>
								<tr><td><div id="${'barcodeprasad_'+i+'_L_'+person.id}"></div></td></tr>
                                                	</table>
                                                </td>

						<td>
							<table>
								<tr><td><b>${person.name}</b></td></tr>
								<tr><td><b>Dinner</b></td></tr>
								<tr><td><b>${(er.event.startDate+i).format('E d-M-y')}</b></td></tr>
								<tr><td><div id="${'barcodeprasad_'+i+'_D_'+person.id}"></div></td></tr>
                                                	</table>
                                                </td>

                                            </tr>
                                        </table>    
                                    </g:each> 
                                </div>    <!-- End of Prasad Div -->    
                            </fieldset>
                            </div>
	        </div>
                <div class="subpageOffice">  <!-- Office Copy -->
                </div>   <!-- End of Subpage Div -->  
                </div>    <!-- End of Page Div -->  
             </g:each>

        <g:javascript>
            $(document).ready(function()
            {
           
            	generateAllBarcodes();
            	
            	function generateAllBarcodes() {
            		//generate main barcode
            		$('#barcodeTarget').barcode("${90000+er.id}","code39");
            		
            		//generate barcodes for prasad coupons
		        <g:each var="person" in="${ persons }" status="p">
		        	var cat = getPersonCategory("${person.dob?.format('dd/MM/yyyy')}");
		        	var catCode;
		        	if(cat==1)
		        		catCode='';
		        	else
		        		catCode='CHILD';
		        	if(cat>0) {
		        	<g:each var="i" in="${ (0..<new Integer(numDays)) }">
		        		$("${'#barcodeprasad_'+i+'_B_'+person.id}").barcode(catCode+"${i+'10000'+person.id}","code39");
		        		$("${'#barcodeprasad_'+i+'_L_'+person.id}").barcode(catCode+"${i+'20000'+person.id}","code39");
		        		$("${'#barcodeprasad_'+i+'_D_'+person.id}").barcode(catCode+"${i+'30000'+person.id}","code39");
		        	</g:each>
		        	}
		        </g:each>
            		
            		
            	}
			function getAge(dateString) 
			{
			    //alert("in getAge:"+dateString);
			    //var today = new Date();
			    var today = new Date(${er.event?.startDate?.format('yyyy')},${er.event?.startDate?.format('MM')},${er.event?.startDate?.format('dd')});
			    //alert("${er.event?.startDate?.format('dd/MM/yyyy')}"+"=======>"+today);
			    var birthDate = new Date(dateString.split("/")[2],dateString.split("/")[1],dateString.split("/")[0]);
			    var age = today.getFullYear() - birthDate.getFullYear();
			    var m = today.getMonth() - birthDate.getMonth();
			    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) 
			    {
				age--;
			    }
			    return age;
			}

	function getPersonCategory(dobStr) {
			//alert("in getPersonCategory:"+dobStr);
			var cat=''
			var age = getAge(dobStr)
			if(age>10)
				cat=1 
			else if(age>5)
				cat=0.5
			else
				cat=0
			//alert(j+":"+age+":"+cat);
			return cat;			
	}
            	

            });

        </g:javascript>

</body>
</html>
