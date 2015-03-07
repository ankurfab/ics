<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#26ADE4;}
.tg .tg-vn4c{background-color:#D2E4FC}
</style>

<h3><p><b>Upcoming Events Summary</b></p></h3>
<table class="tg">
  <tr>
    <th class="tg-031e">Date</th>
    <th class="tg-031e">Name</th>
    <th class="tg-031e">Type</th>
    <th class="tg-031e">Phone</th>
    <th class="tg-031e">Email</th>
  </tr>
  <g:each in="${eventSummary}"> 
	  <tr>
	    <td class="tg-vn4c">${it[2]}</td>
	    <td class="tg-vn4c">${it[1]}</td>
	    <td class="tg-vn4c">${it[3]}</td>
	    <td class="tg-vn4c">${it[4]}</td>
	    <td class="tg-vn4c">${it[5]}</td>
	  </tr>
  </g:each>
</table>
