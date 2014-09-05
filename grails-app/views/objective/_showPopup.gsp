<div class="eventPopup">

<h2>${"Objective: "+objectiveInstance.name}</h2>
<p class="date">
    <g:formatDate date="${occurrenceStart}" format="E, MMM d, hh:mma"/>  –
    <g:formatDate date="${occurrenceEnd}" format="E, MMM d, hh:mma"/>
</p>
<p>
    <g:link action="show" id="${objectiveInstance.id}" params="[occurrenceStart: occurrenceStart, occurrenceEnd: occurrenceEnd]">More details</g:link>
</p>
</div>