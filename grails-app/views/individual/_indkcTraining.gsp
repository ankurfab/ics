<div>
<div id="KCTraining">
		<table border="0" cellspacing="0" cellpadding="0">
			<tbody bgcolor="lavender">

				<tr>
					<td valign="top" class="name">
					  <b>Courses/Workshops</b>
					</td>
					<td valign="top">

						<ul>
						<g:each in="${courses}" var="c">
							<li>${c.course}</li>
						</g:each>
						</ul>
					</td>
					<td valign="top" class="name">
					  <b>Books</b>
					</td>
					<td valign="top">

						<ul>
						<g:each in="${booksRead}" var="b">
							<li>${b.book}</li>
						</g:each>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</div>