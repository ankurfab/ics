<%@ page import="ics.EventRegistration" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'Registration')}" />
		<title>Accommodation and other details</title>
		<r:require module="jqui" />
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
                                <span class="menuButton"><g:link class="create" action="registrationDetailsResources">Resources</g:link></span>
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
				<span class="menuButton"><g:link class="create" action="registrationDetails" params="[id: er?.id,printRCS:true]">RCS</g:link></span>
	    </sec:ifAnyGranted>
			    <g:if test="${er.accommodationAllotmentStatus==ics.AccommodationAllotmentStatus.ALLOTEMENT_COMPLETE}">
				<span class="menuButton"><g:link class="create" action="registrationDetails" params="[id: er?.id,printACS:true]">ACS</g:link></span>
			    </g:if>

			</ul>
		</div>
		<div id="create-eventRegistration" class="content scaffold-create" role="main-jqm">
			<h1>Accommodation and other details</h1>
		
		
		<g:javascript>
		 $(function() {
		     
		     calCharges();

		     $('#btnSave').button().click(function(){
		     
			     /*if($('.required').val() == "") {
				     alert("Please provide all names and date of births!!");
				     $('.required').addClass('error');
				     return false;
				 }*/
		         
		         	$('#registrationDetailsForm').submit();
		         	return true;
		         
                               });
                               
		     $('.datepicker').each(function(){
                        $(this).datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
			dateFormat: 'dd/mm/yy'});		     		
                            });

		  $('#btnPay').button()
		  .click(function( event ) 
		  		{
		  		$('#pay').val("true");
		  		$("#registrationDetailsForm").submit();
		  		return true;
		  		});

		     
		  $('#btnChargeCalculation').button()
		  .click(function( event ) 
		  		{
		  		calCharges();
		           });

		function calCharges() {
		  	 for (i = 0; i < ${numPersons}; i++) 
		  	 {
		  	         
		  	         //set age..
		  	         $('#age_'+i).val(getAge($('#birthdate_'+i).val()));
		  	         /* $('#age_'+i).val(function() 
				   {
				  var today = new Date();
				  givenDate = new Date(today);
				  var dt1 = $('#birthdate_'+i).val();			    
				  var birthDate = new Date(dt1);
				   var value = (givenDate.getFullYear() - birthDate.getFullYear());			   
				   return value ;			  	 		                   
				    });	*/
				  
				  //set age categories
				  setPersonCategory(i);
				  
				  //modify cost per day as per person cat
				  updateCosts(i);
				  
				  
				  //alert(${er.event.maxAttendees}+":"+parseFloat($('#personcat_'+i))+":"+);
				  $('#regcharge_'+i).val($('#personcat_'+i).val()*${er.event.maxAttendees});

				  $('#totalprasadcharge_'+i).val($('#prasadcostperday_'+i).val()*$('#prasadnumberofdays_'+i).val());
				  				    
				   $('#totaltravelcharges_'+i).val($('#costperdayfortravel_'+i).val()*$('#numberofdaysfortravel_'+i).val());
				    		
				 
                             <g:each var="acc" in="${ accomodations }" status="j">
				  $('#place_'+${j}+'personnameaccom_'+i).val($('#personname_'+i).val());
				</g:each>
				
				 $('#personnameforprasad_'+i).val($('#personname_'+i).val());
				 
				  $('#personnamefortravel_'+i).val($('#personname_'+i).val());
				  
				   $('#summarypersonname_'+i).val($('#personname_'+i).val());                    
				  				    					    
					       
		  		}

				//find out num rooms and num extra beds required
		  		calculateRooms();

                             <g:each var="acc" in="${ accomodations }" status="j">
					 for (i = 0; i < ${numPersons}; i++) 
					 {
				  		$('#place_'+${j}+'totalroomcharge_'+i).val($('#place_'+${j}+'rentperday_'+i).val()*$('#place_'+${j}+'noofdaysaccom_'+i).val());				  
				  	}
				</g:each>

		  		calculateSectionTotals();
		  		calculateOverallTotal();
		  		
		  		//set balance due
		  		$('#paymentDue').val(parseFloat($('#overalltotalcharge').val())-parseFloat($('#onlinePayment').val())-parseFloat($('#offlinePayment').val()))
		  	

		}
		
		function calculateSectionTotals() {
				//for total registration charge  
				
				var totalreg =0;
				 for (j=0; j < ${numPersons}; j++) 
				 {
				  totalreg  =  totalreg + parseFloat($('#regcharge_'+j).val());
					
					}
				$('#sumofregcharge').val(totalreg);
					

				  
				//for total travel charge  
				
				var totaltravel = 0;
				 for (j=0; j < ${numPersons}; j++) 
				 {
				  totaltravel  =  totaltravel + parseFloat($('#totaltravelcharges_'+j).val());
					
					}
				$('#sumoftravelcharge').val(totaltravel);
					
				////for total Prasad charge  
				            var totalprasad = 0;
					 for (j=0; j < ${numPersons}; j++) 
					{
					totalprasad  =  totalprasad + parseFloat($('#totalprasadcharge_'+j).val());
				            }
					$('#sumofprasadcharge').val(totalprasad); 
					
					
			        //for total Accom charge 
                             var sumofaccomcharge = 0;
                             <g:each var="acc" in="${ accomodations }" status="k">
					var totalaccom = 0;
														
					 for (j=0; j < ${numPersons}; j++) 
					{
			                     totalaccom  =  totalaccom + parseFloat($('#place_'+${k}+'totalroomcharge_'+j).val());
				            }
				          $('#place_'+${k}+'sumofaccomcharge').val(totalaccom); 
				          sumofaccomcharge += totalaccom;
				</g:each>
					$('#sumofaccomcharge').val(sumofaccomcharge); 
		
		}


		function calculateOverallTotal() {
			var overallTotal = 0;

			//acco charges from room and bed count
			var totalAccoByRoom=0;
			var ad='';
			<g:if test="${er.isAccommodationRequired}"> 
		       <g:each var="acc" in="${ accomodations }" status="k">
		       		var st=0;
		       		var atype=$('#place_'+${k}+'roomtype:checked').val();
				//alert("Room type:"+${k}+":"+atype);
				if(atype=="nonac") {
					st = parseFloat($('#place_'+${k}+'numRoomsRequired').val())*${new Integer(acc.numDays)*new Integer(acc.nonacRoomRentPerDay)} + parseFloat($('#place_'+${k}+'numExtraBedsRequired').val())*${new Integer(acc.numDays)*new Integer(acc.nonacRoomExtraBedRentPerDay)};
					totalAccoByRoom  += st;
				}
				else {
					st = parseFloat($('#place_'+${k}+'numRoomsRequired').val())*${new Integer(acc.numDays)*new Integer(acc.acRoomRentPerDay)} + parseFloat($('#place_'+${k}+'numExtraBedsRequired').val())*${new Integer(acc.numDays)*new Integer(acc.acRoomExtraBedRentPerDay)};
					totalAccoByRoom  += st;
				}
				ad +='${acc.place}'+'_'+atype+'_NumRooms:'+$('#place_'+${k}+'numRoomsRequired').val()+'_NumExtraBeds:'+$('#place_'+${k}+'numExtraBedsRequired').val()+" ";
				$('#place_'+${k}+'sumofaccomcharge').val(st);
			</g:each>
				$('#accodetails').val(ad);
			</g:if>
			

			 for (j=0; j < ${numPersons}; j++) 
			{				
				//for total Accom charge 
				var totalaccom = 0;
				<g:if test="${er.isAccommodationRequired}"> 
			       <g:each var="acc" in="${ accomodations }" status="k">
					totalaccom  =  totalaccom + parseFloat($('#place_'+${k}+'totalroomcharge_'+j).val());
				</g:each>
				</g:if>
				//alert('charge by person and by room'+totalaccom+':'+totalAccoByRoom/${numPersons});
				//$('#summarytotalcharge_'+j).val(parseFloat($('#regcharge_'+j).val())+parseFloat($('#totalprasadcharge_'+j).val())+parseFloat($('#totaltravelcharges_'+j).val())+totalaccom); 
				$('#summarytotalcharge_'+j).val(parseFloat($('#regcharge_'+j).val())+parseFloat($('#totalprasadcharge_'+j).val())+parseFloat($('#totaltravelcharges_'+j).val())+totalAccoByRoom/${numPersons}); 
				overallTotal+=parseFloat($('#summarytotalcharge_'+j).val());
			}
				$('#overalltotalcharge').val(Math.round(overallTotal * 100) / 100);
		}
		
			function getAge(dateString) 
			{
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

	function setPersonCategory(j) {
			var cat=''
			var age = parseFloat($('#age_'+j).val())
			if(age>10)
				cat=1 
			else if(age>5)
				cat=0.5
			else
				cat=0
			//alert(j+":"+age+":"+cat);
			$('#personcat_'+j).val(cat);			
	}
	
	function updateCosts(j) {
		$('#prasadcostperday_'+j).val(${prasadCostPerDay});
		$('#prasadcostperday_'+j).val($('#personcat_'+j).val()*$('#prasadcostperday_'+j).val());
		$('#costperdayfortravel_'+j).val(${travelCostPerDay});
		$('#costperdayfortravel_'+j).val($('#personcat_'+j).val()*$('#costperdayfortravel_'+j).val());
	}
	
	function calculateRoomsFromPersons() {
		//first find num by age cat
		var infant=0,child=0,adult=0;
		for (j=0; j < ${numPersons}; j++) 
		{
			
			switch(parseFloat($('#personcat_'+j).val())) {
				case 1:
					adult++
					break;
				case 0.5:
					child++
					break;
				case 0:
					infant++
					break;
				default:
					break;
				
			}
		}
		//alert(adult+":"+child+":"+infant);
		var numBedsRequired = Math.ceil(adult+(child/2));	//2 child per bed
		//alert("numBedsRequired:"+numBedsRequired);

		var maxBeds = 2;	//@TODO: hardcoded as it is general config
		//alert("maxBeds:"+maxBeds);
		var numRoomsRequired = Math.ceil(numBedsRequired/maxBeds)
		//alert("numRoomsRequired:"+numRoomsRequired);
		var numExtraBeds = numBedsRequired - (numRoomsRequired*maxBeds);
		if(numExtraBeds<=0)
			numExtraBeds=0;
		
		return [numRoomsRequired,numExtraBeds];
	}
	
	function setRooms() {
		var roomsRequired,numRooms,extraBeds;
		if($()) {
		}
		else {
			roomsRequired = calculateRoomsFromPersons();
			numRooms=roomsRequired[0];
			extraBeds=roomsRequired[1];
		}
		var rooms = [[]];	//2d room booking array to store rooms and allocations with extra bed
		for(roomNo=0;rommNo<numRooms;roomNo++) {
			for(bed=0;bed<3;bed++) {	//@TODO hardcoded max beds in room along with extra bed
				rooms[roomNo][bed]=0;	//initialoze to all blanks
			}
		}
	}


	function calculateRooms() {
		//place_1accname_0
		//first find num by age cat
		var infant=0,child=0,adult=0;
		for (j=0; j < ${numPersons}; j++) 
		{
			
			switch(parseFloat($('#personcat_'+j).val())) {
				case 1:
					adult++
					break;
				case 0.5:
					child++
					break;
				case 0:
					infant++
					break;
				default:
					break;
				
			}
		}
		//alert(adult+":"+child+":"+infant);
		var numBedsRequired = Math.ceil(adult+(child/2));	//2 child per bed
		//alert("numBedsRequired:"+numBedsRequired);

	     <g:each var="acc" in="${ accomodations }" status="k">
	     	
	     	var atype=$('#place_'+${k}+'roomtype:checked').val();
	     	
	     	//check for manual mode
	     	if($('#place_'+${k}+'manualMode').is(':checked')) {
	     		//alert("Manual mode");
	     		//update rent per day and total room charges
			for (j=0; j < ${numPersons}; j++) 
			{
				$('#place_'+${k}+'accname_'+j).val('MANUAL');
				$('#place_'+${k}+'rentperday_'+j).val('0');
				$('#place_'+${k}+'totalroomcharge_'+j).val('0');
			}
	     	}
	     	else {
			var maxBeds = ${new Integer(acc.nonacRoomNumBeds)+new Integer(acc.nonacRoomNumExtraBeds)};
			//alert("maxBeds:"+maxBeds);
			var numRoomsRequired = Math.ceil(numBedsRequired/maxBeds)
			//alert("numRoomsRequired:"+numRoomsRequired);
			var numExtraBeds = numBedsRequired - (numRoomsRequired*${new Integer(acc.nonacRoomNumBeds)});
			if(numExtraBeds<=0)
				numExtraBeds=0;
			var extraBedCharges = 0;
			if(atype=='nonac')
				extraBedCharges = numExtraBeds*${new Integer(acc.nonacRoomExtraBedRentPerDay)};
			else
				extraBedCharges = numExtraBeds*${new Integer(acc.acRoomExtraBedRentPerDay)};
			
			var roomCharges = 0;
			if(atype=='nonac')
				roomCharges = numRoomsRequired*${new Integer(acc.nonacRoomRentPerDay)};
			else
				roomCharges = numRoomsRequired*${new Integer(acc.acRoomRentPerDay)};
				
			var totalRoomCharges = roomCharges+extraBedCharges;

			for (j=0; j < ${numPersons}; j++) 
			{
				$('#place_'+${k}+'accname_'+j).val('#R:'+numRoomsRequired+' #EB:'+numExtraBeds);
				//'place_'+j+'rentperday_'+i
				$('#place_'+${k}+'rentperday_'+j).val(Math.round((totalRoomCharges/${numPersons})*100/100));
			}

			//place_0sumofaccomcharge
			$('#place_'+${k}+'sumofaccomcharge').val(totalRoomCharges*${acc.numDays});
			
			//also set the values in the room/eb selector
			$('#place_'+${k}+'numRoomsRequired').val(numRoomsRequired);
			$('#place_'+${k}+'numExtraBedsRequired').val(numExtraBeds);
		}
		</g:each>
		
	}
		                    
                  });
                                         
		</g:javascript>
		
           <g:form   name="registrationDetailsForm" id="registrationDetailsForm" action="registrationDetailsSave" >

			<g:hiddenField name="numPersons" value="${numPersons}" />
			<g:hiddenField name="erid" value="${er.id}" />
			<g:hiddenField name="firstTime" value="${firstTime}" />
			<g:hiddenField name="pay" value="" />
			<g:hiddenField name="accodetails" value="" />
			
			<g:set var="formHeader" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Form',type:'Header')}" />
			<g:set var="formFooter" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Form',type:'Footer')}" />

			<g:set var="regHeader" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Reg',type:'Header')}" />
			<g:set var="regFooter" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Reg',type:'Footer')}" />

			<g:set var="accoHeader" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Acco',type:'Header')}" />
			<g:set var="accoFooter" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Acco',type:'Footer')}" />

			<g:set var="prasadHeader" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Prasad',type:'Header')}" />
			<g:set var="prasadFooter" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Prasad',type:'Footer')}" />

			<g:set var="travelHeader" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Travel',type:'Header')}" />
			<g:set var="travelFooter" value="${ics.EventDetail.findWhere('event.id':er.event.id,category:'Travel',type:'Footer')}" />
			
			<div>
				${formHeader?.details}
			</div>

                                <fieldset>
			       		
				 <h2>Person Details: </h2>
				 <table class="details1" border="0">
					
					                     <thead>
								<th>Name</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Gender</th>
								<th>Date Of Birth</th>
								<th>Age</th>
								<th>RegistrationCharge</th>
								</thead>
							<tbody>	
	                                              <g:each var="i" in="${ (0..<numPersons) }">
	                                              <g:hiddenField name="${'personcat_'+i}" value="" />
                                                      <g:hiddenField name="${'personid_'+i}" value="${persons[i]?.id}" />
                                       
                                      
								
						  <tr>
							<td><input type="text" pattern="^[a-zA-Z_ ]*$"  name="${'personname_'+i}" id="${'personname_'+i}" value="${persons[i]?.name}" size="20" placeholder="Please enter name of Person" required="true" />  </td>
							
							<td> <input type="email" name="${'email_'+i}" id="${'email_'+i}"  value="${persons[i]?.email}" size="20" placeholder="EMail Id"  /> </td>
							
							<td> <input type="text" name="${'phone_'+i}"  placeholder="contact number"  value="${persons[i]?.phone}"  size="10" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" pattern="^[1-9][0-9]{0,9}$" maxlength="10"  id="${'phone_'+i}"   /></td>
		                                         
		                                         
		                                         
		                                         <td>M:<input type="radio" name="${'gender_'+i}" id="${'gender_'+i}" value="male" <g:if test="${persons[i]?.isDonor}">checked="true"</g:if> >
                                                         F:<input type="radio" name="${'gender_'+i}" id="${'gender_'+i}" value="female"   <g:if test="${!persons[i]?.isDonor}">checked="true"</g:if> ></td>
		                                         
		                                      
		                                          
		                                         <td> <input type="text" name="${'birthdate_'+i}"  id="${'birthdate_'+i}" value="${persons[i]?.dob?.format('dd/MM/yyyy')}" size="10" class="datepicker" required  ></td>
		                                             
		                                         <td> <input type="text" name="${'age_'+i}"  placeholder="" size="4" id="${'age_'+i}" readOnly ="true" /></td>                 

		                                         <td> <input type="text" name="${'regcharge_'+i}"  placeholder="" size="4" id="${'regcharge_'+i}" readOnly ="true" /></td>                 
		                                                          
		                                                          </tr>
								
						         </g:each>
						         
						         <tr>
						         	<td/>
						         	<td/>
						         	<td/>
						         	<td/>
						         	<td/>
								  <td>  <input type="text"  value="Total" readOnly ="true"  size="5"/></td>
								  <td> <input type="text" name="sumofregcharge"  id="sumofregcharge" value="0" readOnly ="true" size="4" /></td> 						         	
						         </tr>
							
							</tbody>		
						</table>
						
						
		                         </fieldset>

            <g:if test="${!er.status || er.status != 'PAID'}">
            <input type="button"  id="btnChargeCalculation"  value="Calculate Charges"  />
            <input type="button"  id="btnSave" value="Save"/>
            </g:if>            
		                         
	<!-- for the  Accomodation Details: -->	
		<fieldset>
		<h2>Accomodation Details: </h2>
		<g:if test="${er.isAccommodationRequired}"> 

	<div>
		${accoHeader?.details}
	</div>


			                             <g:each var="acc" in="${ accomodations }" status="j">

						            <p>Accommodation Preference: ${er.accomodationPreference?:''}<br></p>
						            <div style="display:<sec:ifAnyGranted roles='ROLE_NVCC_ADMIN'>block</sec:ifAnyGranted><sec:ifNotGranted roles='ROLE_NVCC_ADMIN'>none</sec:ifNotGranted>">						            
								 NonAC Room:<input type="radio" name="${'place_'+j+'roomtype'}" id="${'place_'+j+'roomtype'}" value="nonac" <g:if test="${!er.accomodationPreference || er.accomodationPreference!='AC'}">checked="true"</g:if> >
								 AC Room:<input type="radio" name="${'place_'+j+'roomtype'}" id="${'place_'+j+'roomtype'}" value="ac"   <g:if test="${er.accomodationPreference=='AC'}">checked="true"</g:if> >
						            </div>
								 <p><g:checkBox name="${'place_'+j+'manualMode'}" value="${false}"/>Manual Room Selection for ${acc.place}=>
								 Total No. of Rooms Required:<input type="number" name="${'place_'+j+'numRoomsRequired'}" id="${'place_'+j+'numRoomsRequired'}"  size="2" min="0" max="${numPersons}"/>
								 Total No. of Extra Beds Required:<input type="number" name="${'place_'+j+'numExtraBedsRequired'}" id="${'place_'+j+'numExtraBedsRequired'}"  size="2" min="0" max="${numPersons}"/></p>

							 <table class="details2" border="0">
							
							                     <thead>
										
										
										<th>Person Name</th>
										<th>Place</th>
										<th>AccomName</th>
										<th>NumberofDays</th>
										<th>RentPerDay</th>
										<th>Total Room Charges</th>
										
										
										</thead>
									<tbody>	
			                                              <g:each var="i" in="${ (0..<numPersons) }">
		                                       
										             <tr>
									<td><input type="text" name="${'place_'+j+'personnameaccom_'+i}" id="${'place_'+j+'personnameaccom_'+i}"  size="20"  readOnly ="true"/>  </td>
									
									<td> <input type="text" name="${'place_'+j+'place_'+i}" id="${'place_'+j+'place_'+i}"   size="10" placeholder="Place" value="${acc.place}" readOnly ="true"/> </td>
									
									<td><input type="text" name="${'place_'+j+'accname_'+i}" id="${'place_'+j+'accname_'+i}"  size="10" placeholder="RoomID" readOnly ="true"/>  </td>
									
									<td><input type="text" name="${'place_'+j+'noofdaysaccom_'+i}" id="${'place_'+j+'noofdaysaccom_'+i}"  size="10"  value="${acc.numDays}" readOnly ="true"/>  </td> 
				                                       
				                                        <td>  <input type="text" name="${'place_'+j+'rentperday_'+i}"  id="${'place_'+j+'rentperday_'+i}" size="4"  placeholder="Rent Per Day" value="${0}" readOnly ="true"/></td>
				                                             
				                                         <td> <input type="text" name="${'place_'+j+'totalroomcharge_'+i}"  placeholder="Total Room Charges " size="5" id="${'place_'+j+'totalroomcharge_'+i}" /></td>
				                                             
				                                                           </tr>
				                                                          
						                        </g:each>
										
									</tbody>		
                        
                         <tr>
                         <td> </td>
			<td> </td>
			<td> </td>
			<td> </td>
			<td>  <input type="text"  value="Total" readOnly ="true"  size="5"/></td>
			<td> <input type="text" name="${'place_'+j+'sumofaccomcharge'}"  id="${'place_'+j+'sumofaccomcharge'}" value="0" readOnly ="true" size="5" /></td> 
			</tr>
                        
			</table>
			
			</g:each>
			<table>
				<tr>
				 <td> </td>
				<td> </td>
				<td> </td>
				<td> </td>
				<td>  <input type="text"  value="Total" readOnly ="true"  size="5"/></td>
				<td> <input type="text" name="${'sumofaccomcharge'}"  id="${'sumofaccomcharge'}" value="0" readOnly ="true" size="5" /></td> 					
				</tr>
			</table>

	<div>
		${accoFooter?.details}
	</div>
	</g:if>
	<g:else>
		<div>
		During registration, you had specified that accommodation is not to be arranged by the management. So , if accommodation is required, kindly make self arrangements. Thank you.
		</div>
	</g:else>
		       </fieldset>
						
                
              <!-- for the  Prasad Details: -->	
              <fieldset>
	      		<h2> Prasad Details:</h2>                       
	      		                                     	<div>
							     		${prasadHeader?.details}
							     	</div>

	      		                                     
	      							 <table class="details3" border="0">
	      							
	      							                     <thead>
	      										
	      										
	      										<th> Person Name</th>
	      										<th>Cost Per Day</th>
	      										<th>Number of days </th>
	      										
	      										<th>Total Prasad Charges</th>
	      										
	      										
	      										</thead>
	      									<tbody>	
	      			                         <g:each var="i" in="${ (0..<numPersons) }">
	      		                                                    
	      						<tr>           
	      					  <td><input type="text" name="${'personnameforprasad_'+i}" id="${'personnameforprasad_'+i}" readOnly ="true"/>  </td>	             
	      										             
	      					 <td> <input type="text" name="${'c'+i}" id="${'prasadcostperday_'+i}"   placeholder="" value="${prasadCostPerDay}" readOnly ="true"/> </td>				             
	      										             
	      										             
	      					<td> <input type="text" name="${'prasadnumberofdays_'+i}"   placeholder="Enter number of Days"  id="${'prasadnumberofdays_'+i}" value="${numDays}" readOnly ="true"/></td>					             
	      										             
	      					 <td>  <input type="text" name="${'totalprasadcharge_'+i}" id="${'totalprasadcharge_'+i}"    placeholder="Prasad Charge" value="0" readOnly ="true"/></td>
	      					                               </tr>
	      								
	                             </g:each>
	      								</tbody>
	      				                  
	                             
	                          <tr>
				  <td> </td>
				  <td> </td>
			          <td>  <input type="text"  value="Total" readOnly ="true"  /></td>
			          <td> <input type="text" name="sumofprasadcharge"  id="sumofprasadcharge" value="0" readOnly ="true" /></td> 
			          </tr>
			          
	      			</table>
	      			
	<div>
		${prasadFooter?.details}
	</div>
	      			
	      			
	      			
		       </fieldset>
              
	
	
	<!-- for the  Travel Details:: -->	
	             
	              <fieldset>
		      		<h2> Travel Charges Details::</h2>

	<div>
		${travelHeader?.details}
	</div>
		      	
		                <table class="details4" border="0">
		      							
		      							                     <thead>
		      										
		      										
		      										<th>Person Name</th>
		      										<th>Cost Per Day</th>
		      										<th>Number of days </th>
		      										<th>Total Travel Charges</th>
		      										
		      										</thead>
		      									<tbody>	
		      			                         <g:each var="i" in="${ (0..<numPersons) }">
		      		                                                    
		      					 <tr> 
		      					 
		      					  <td><input type="text" name="${'personnamefortravel_'+i}" id="${'personnamefortravel_'+i}" maxlength="20" readOnly ="true"/>  </td>	             
		      										             
		      					 <td> <input type="text" name="${'costperdayfortravel_'+i}" id="${'costperdayfortravel_'+i}"  placeholder="Cost" value="${travelCostPerDay}" readOnly ="true"/> </td>
		      										             
		      										             
		      					 <td> <input type="text" name="${'numberofdaysfortravel_'+i}"   placeholder="Enter number of Days to Travel "   id="${'numberofdaysfortravel_'+i}" value ="${numDays}" readOnly ="true"/></td>
		      										             
		      					  <td>  <input type="text" name=${'totaltravelcharges_'+i}"  id="${'totaltravelcharges_'+i}" value="0"  readOnly ="true"/> </td>
		      					                               </tr>
		      								
		                              </g:each>	
		      								</tbody>
		      				                  
		                             
		                              
		                             <tr>
					    <td> </td>
					    <td> </td>
					    <td>  <input type="text"  value="Total" readOnly ="true"  /></td>
					    <td> <input type="text" name="sumoftravelcharge"  id="sumoftravelcharge" value="0" readOnly ="true" /></td> 
					    </tr>
		      			</table>
	<div>
		${travelFooter?.details}
	</div>
		      			
		      			
		       </fieldset>

	                           <fieldset>
		             <h2> Summary Table:</h2>
				   				      		
				<table class="details5" border="0">
			   				      										
	<thead>			   				      										
 <th>Person Name</th>
 <th>Total Charges</th>				   				      									
 <th>Date</th>				   				      									
 <th>Reference</th>				   				      									
 </thead>
		
 <tbody>	
   <g:each var="i" in="${ (0..<numPersons) }">	   				      		                                                    
 <tr>           
 <td><input type="text" name="${'summarypersonname_'+i}" id="${'summarypersonname_'+i}" size="20" value="" readOnly ="true" />  </td>
 <td> <input type="text" name="${'summarytotalcharge_'+i}"  id="${'summarytotalcharge_'+i}"   value=""  readOnly ="true" /> </td>
<td/>
<td/>
 </tr>
 </tbody>				   				      								
 </g:each> 
 
 <tr>
 	<td/>
 	<td/>
 	<td/>
 	<td/>
</tr>

 <tr>
 	<td>Total:</td>
	<td> <input type="text" name="${'overalltotalcharge'}"  id="${'overalltotalcharge'}"   value=""  readOnly ="true" /> </td>
	<td/>
	<td/>
 </tr>
 
 <tr>
	 <td>Online Payment:</td>
	 <td> <input type="text" name="${'onlinePayment'}"  id="${'onlinePayment'}"   value="${er.paymentReference?.amount?:0}"  readOnly ="true" /> </td>
	 <td>${er.paymentReference?.paymentDate?.format('dd-MM-yyyy HH:mm:ss')}</td>
	 <td>${er.paymentReference?.details}</td>
 </tr>

 <tr>
	 <g:set var="offlinepymt" value="${ics.PaymentReference.findWhere('ref':'EventRegistration_'+er.id,'paymentBy.id':er.individual.id)}" />
	 <td>Offline Payment:</td>
	 <td> <input type="text" name="${'offlinePayment'}"  id="${'offlinePayment'}"   value="${offlinepymt?.amount?:0}"  readOnly ="true"/> </td>
	 <td>${offlinepymt?.paymentDate?.format('dd-MM-yyyy HH:mm:ss')}</td>
	 <td>${offlinepymt?.details}</td>
 </tr>

 <tr>
	 <td>Balance Due:</td>
	 <td> <input type="text" name="${'paymentDue'}"  id="${'paymentDue'}"   value=""  <sec:ifNotGranted roles="ROLE_NVCC_ADMIN">readOnly ="true"</sec:ifNotGranted> /> </td>
	 <td></td>
	 <td></td>
 </tr>
 
 </table>				   				      				                  
 </fieldset>				   				      										             
				   				      										             
	<div>
		${formFooter?.details}
	</div>

            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
            	<input type="button"  id="btnPay"  value="Accept Payment"  />
            	<g:checkBox name="markComplete" value="${er.status?true:false}" />Full payment received?
	    </sec:ifAnyGranted>
 
 			</g:form>
 		</div>
 	</body>
 </html>
