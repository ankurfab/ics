<div>
<div id="headingsale" class="invoice">
    <h2>Answer sheet for ${ia.individual}</h2>
</div>


<table id="answersheet" > 
	<thead>
		<th>S.No.</th>
		<th>Question</th>
		<th>Choice1</th>
		<th>Choice2</th>
		<th>Choice3</th>
		<th>Choice4</th>
		<th>Score</th>
	</thead>
  
        <g:each status="i" var="iaqa" in="${iaqas}">
             <tr>
                          	
             	<td>${i+1}</td>
             	<td>${iaqa.question.questionText}</td>
             	<td>
             		<g:if test="${iaqa.question.isChoice1Correct}"><b></g:if>
             		<g:if test="${iaqa.selectedChoice1}"><u></g:if>
             		${iaqa.question.choice1}
             		<g:if test="${iaqa.selectedChoice1}"></u></g:if>
             		<g:if test="${iaqa.question.isChoice1Correct}"></b></g:if>
             	</td>
             	<td>
             		<g:if test="${iaqa.question.isChoice2Correct}"><b></g:if>
             		<g:if test="${iaqa.selectedChoice2}"><u></g:if>
             		${iaqa.question.choice2}
             		<g:if test="${iaqa.selectedChoice2}"></u></g:if>
             		<g:if test="${iaqa.question.isChoice2Correct}"></b></g:if>
             	</td>
             	<td>
             		<g:if test="${iaqa.question.isChoice3Correct}"><b></g:if>
             		<g:if test="${iaqa.selectedChoice3}"><u></g:if>
             		${iaqa.question.choice3}
             		<g:if test="${iaqa.selectedChoice3}"></u></g:if>
             		<g:if test="${iaqa.question.isChoice3Correct}"></b></g:if>
             	</td>
             	<td>
             		<g:if test="${iaqa.question.isChoice4Correct}"><b></g:if>
             		<g:if test="${iaqa.selectedChoice4}"><u></g:if>
             		${iaqa.question.choice4}
             		<g:if test="${iaqa.selectedChoice4}"></u></g:if>
             		<g:if test="${iaqa.question.isChoice4Correct}"></b></g:if>
             	</td>
             	<td>${iaqa.score}</td>
             	
             </tr> 
          </g:each>
</table>
</div>