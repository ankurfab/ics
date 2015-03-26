<div>

<table id="feedbacks" > 
	<thead>
		<th>S.No.</th>
		<th>Name</th>
		<th>RegCode</th>
		<th>Date</th>
		<th>TimeTaken</th>
		<th>Score</th>
		<th>Result</th>
		<th>Feedback</th>
	</thead>
  
        <g:each status="i" var="ia" in="${ias}">
             <tr>
                          	
             	<td>${i+1}</td>
             	<td>${ia.individual}</td>
             	<td>
             		${ia.eventRegistration.regCode}
             	</td>
             	<td>
             		${ia.assessmentDate.format('dd-MM-yyyy HH:mm:ss')}
             	</td>
             	<td>
             		${ia.timeTaken}
             	</td>
             	<td>
             		${ia.score}
             	</td>
             	<td>
             		${ia.assessmentCode}
             	</td>
             	<td>
			<g:set var="feedback" value="" />
			<g:each in="${ics.AttributeValue.findAllByObjectClassNameAndObjectId('IndividualAssessment',ia.id.toString())}" var="fb">
			    <g:if test="${fb.attribute.type=='MULTI'}">
			        <g:set var="attr" value="${null}"/>
			        <g:set var="attr" value="${ics.Attribute.findWhere(domainClassName:'EVENT_FEEDBACK',type:'RADIO',category:fb.attribute.name,position:new Integer(fb.value))?.displayName}" />
			    </g:if>
			    <g:else>
			    	<g:set var="attr" value="${null}"/>
			    </g:else>
			    <g:if test="${attr}">
			    	<g:set var="feedback" value="${feedback +" "+ attr}" />
			    </g:if>
			    <g:else>
			    	<g:set var="feedback" value="${feedback +" "+fb.value}" />
			    </g:else>			    
			</g:each>             		
			${feedback}
             	</td>
             	
             </tr> 
          </g:each>
</table>
</div>