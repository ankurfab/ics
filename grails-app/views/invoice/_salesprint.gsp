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

<div class="page">
    <div class="subpageTop">
        <div>
            <table>
                <tr>
                    <td> Issued To </td>
                    <td>
                        ${invoiceInstance.personTo}	
                    </td>
                        

                   
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>

                        Invoice   Number
                    </td>
                    <td>
                        ${invoiceInstance.invoiceNumber}

                    </td>
                </tr>                    
                
                    
                  <tr>
                    <td></td>
                    <td></td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>

                    <td>Invoice   Date </td>
                    <td> ${invoiceInstance.invoiceDate?.format('dd-MM-yy')} </td>
                  </tr>  
                       

                   
                


                <tr>
              <td></td>
        
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>
                    <td>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</td>

                    <td>
                        Prepared By
                    </td>
                    <td>${invoiceInstance.preparedBy} </td> 
                </tr>
             </table>
           </div>
          <div>

	<g:set var="items" value="${invoiceInstance?.lineItems?.sort{it.item.name}}" />
            <table border="1">
                <tr>
                    <th>Item Name</th>

                    <th >Quantity</th>
                    <th style="width:15%;">UnitSize</th>
                    <th style="width:15%;">Unit</th>
                    <th style="width:15%;">Rate</th>
                    <th style="width:15%;">TaxRate</th>
                    <th style="width:15%;">TotalWithTax</th>


                </tr>
                <g:set var="invoiceTotalWitoutTax" value="${new BigDecimal(0)}" />
                <g:set var="invoiceTotalWithTax" value="${new BigDecimal(0)}" />
                <g:each var="lineItem" in="${items}">
                    <tr>
                        <td>${lineItem?.item?.name}</td>
                        <td>${lineItem?.qty}</td>
                        <td style="width:15%;">${lineItem?.unitSize}</td>
                        <td style="width:15%;">${lineItem?.unit}</td>
                        <td style="width:15%;">${lineItem?.rate}</td>
                        <td style="width:15%;">${lineItem?.taxRate}</td>
                        <td  style="width:15%;">${lineItem?.totalWithTax}</td>


                    </tr>
                    <g:set var="invoiceTotalWitoutTax" value="${(invoiceTotalWitoutTax?:0)+(lineItem?.totalWithoutTax?:0)}" />
                    <g:set var="invoiceTotalWithTax" value="${(invoiceTotalWithTax?:0)+(lineItem?.totalWithTax?:0)}" />
                </g:each>
                    <tr>
                        <td></td>
                        <td></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"><b>Total:</b></td>
                        <td  style="width:15%;">${invoiceTotalWithTax}</td>
                    </tr>
              </table>

         <!--<table id="summary">
                <tr>
                    <th>Total Items</th>
                    <td>100</td>

                </tr>

                <tr>
                    <th>Total Quantity</th>
                    <td>100</td>
                </tr>


                <tr>
                    <th>Total With Tax</th>
                    <td>100</td>
                </tr>

            </table>-->
 </div>                
    </div>

    <div class="subpageBottom">
    </div>

</div>

