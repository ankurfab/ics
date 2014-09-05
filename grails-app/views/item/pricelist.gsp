
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>PriceList</title>
	<r:require module="dataTable" />
    </head>
    <body>
	<script type="text/javascript" charset="utf-8">
		$(document).ready( function () {
		    var table = $('#pricelistTable').DataTable( {
			"dom": 'T<"clear">lfrtip',
			"tableTools": {
			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"	
			}
		    } );
		    $("#pricelistTable tfoot th").each( function ( i ) {
			if(i<2) {
			var select = $('<select><option value=""></option></select>')
			    .appendTo( $(this).empty() )
			    .on( 'change', function () {
				table.column( i )
				    .search( '^'+$(this).val()+'$', true, false )
				    .draw();
			    } );

			table.column( i ).data().unique().sort().each( function ( d, j ) {
			    select.append( '<option value="'+d+'">'+d+'</option>' )
			} );
			}
		    } );		    
		} );
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
            	<h1>Item Price List</h1>            	

			<div id="pricelist">          
			<table id="pricelistTable" border="1">
			    <thead>
				<tr>
					<th>Category</th>
					<th>SubCategory</th>
					<th>Item</th>
					<th>Variety</th>
					<th>Brand</th>
					<th>UnitSize</th>
					<th>Unit</th>
					<th>Rate(with tax)</th>
					<th>NormalizedUnitSize</th>
					<th>NormalizedUnit</th>
					<th>NormalizedRate(with tax)</th>
				</tr>
			    </thead>
				<tfoot>
				    <tr>
					<th>Category</th>
					<th>SubCategory</th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
					<th></th>
				    </tr>
				</tfoot>
			    <tbody>
		            	<g:set var="is" bean="itemService"/>
		            	<g:each in="${itemList}" status="i" var="item">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				    <td>${item.category}</td>
				    <td>${item.subcategory}</td>
				    <td>${item.name}</td>
				    <td>${item.variety}</td>
				    <td>${item.brand}</td>
				    <g:set var="ili" value="${ics.InvoiceLineItem.findAllByItem(item, [max:1,sort:'id',order:'desc'])}" />
				    <td>${ili[0]?.unitSize}</td>
				    <td>${ili[0]?.unit}</td>
				    <td>${(ili[0]?.rate?:0)*(1+(ili[0]?.taxRate?:0)/100)}</td>
				    <g:set var="normalized" value="${is.normalize(item,ili[0]?.qty,ili[0]?.unitSize,ili[0]?.unit)}" />
				    <td>${item?.nunitSize}</td>
				    <td>${item?.nunit}</td>
				    <td>${(ili[0]?.rate?:0)*(1+(ili[0]?.taxRate?:0)/100)}</td>
				</tr>
			    </g:each>
			    </tbody>
			</table>
			</div>
            </div>
        </div>
    </body>
</html>
