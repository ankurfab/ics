<%@ page import="ics.EnglishNumberToWords" %>
<div class="allbody">
<style>
 .maintable th
 {
 border:1px solid black;
 }

fieldset 
{
border:1px solid black 
}

h1,h2,h4 
{
 text-align: center;
}

.header1
{
text-align: center;
font: 8pt "Tahoma";
}

h5
{
text-align: center;
font: 8pt "Tahoma";
}

p
{
text-align: center;
}
</style>

 <style type='text/css' media='print'>
             body {
                 margin: 0;
                 padding: 0;
                 background-color: #FAFAFA;
                 font: 8pt "Tahoma";
             }
             * {
                 box-sizing: border-box;
                 -moz-box-sizing: border-box;
             }
             .page {
                 width: 21cm;
                 height: 29.7cm;
                 #padding-left: 1.6cm;
                 margin: 1cm;
                 #border: 1px #D3D3D3 solid;
                 border-radius: 5px;
                 background: white;
                 box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
             }
             .subpageTop{
                 padding: 0.5cm;
                 #border: 5px red solid;
                 height: 148mm;
                 #outline: 2cm #FFEAEA solid;
             }
             .subpageBottom {
                  padding: 0.5cm;
                  #border: 5px red solid;
                  height: 130mm;
                  #outline: 0.5cm #FFEAEA solid;
             }
 
             @page {
                 size: A4;
               
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
        
         table.reimtoptable{width:100%;}
 	     .reimtoptable tr td {height:10px; font: 8pt "Tahoma"; } 
        
         table.reimbursetoptable{width:100%;}
 	     .reimbursetoptable tr td {height:10px; font: 8pt "Tahoma"; }         
             
             
          table.middletable{width:100%;  }
             .middletable tr td {height:5px; font: 8pt "Tahoma"; }  
             
             
          table.bottomtable{width:100%;  }
             .bottomtable tr td {height:5px; font: 8pt "Tahoma";  }  
             
          table.signtable{width:100%;  }
             .signtable tr td {height:5px; font: 8pt "Tahoma";  } 
             

             
             
        </style>


 <div class="page">
 
 <div class="subpageTop">
  <fieldset>
  
    <h4>International Society For Krishna Consciousness(ISKCON)</h4>
    <h5>(<b>Regd.Office:</b>Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
    <h5>(<b>Branch:4</b>,Tarapore Road,Camp,Pune-411 001.)</h4> <br>
    
 <table class="reimtoptable">
             <tr></tr>       
                     <tr>
                         <td><span style="float: left;"></span></td>
                         <td></td>
                         <td><span style="float: right;">No:${projectInstance.ref}</span></td>
                     </tr>  
                      
                     <tr>
                          <td><span style="float: left;"></span></td>
	                  <td><h4>DEBIT VOUCHER</h4></td>
                          <td></td>
                     </tr>
                     
                      
                       
                      <tr> 
                        <td><span style="float: left;">Department: ${projectInstance?.costCenter?.name}</span></td>
                        <td><p>     </p></td>
                        <td><p><span style="float: right;">Date:${new Date()?.format('dd-MM-yyyy')}</span></p> </td>
                      </tr>
                   
        
           </table>
      
  
  <g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses]" />     
   
    
    <table class="bottomtable">
            
              <tr>
                   <td>Name:</td>
                   <td>${projectInstance.submitter?:''}</td>
                   <td></td>
                   <td></td>
                   <td></td>
             </tr>
             
              <tr>
  	         <td>Rupees</td>
  	          <td colspan="3"><b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.amount?.toString()?:'0'))} Only </b></td>
  	         <td>${projectInstance.amount?:0}</td>
  	      </tr
  	      
          </table>
          
          <table class="signtable">
             <br><br>
             <tr></tr>
             <tr>
  	         <td><p>(Sactionary Autority)</p></td>
  	         <td><p>(Receiver)</p> </td>
  	         <td><p>(Accountant)</p></td>
  	     </tr> 
          </table>
         
  </fieldset>
  
    </div>    
       
    <div class="subpageBottom">  <!-- subpageBottom Copy -->
  <fieldset>

  <h4>International Society For Krishna Consciousness(ISKCON)</h4>
  <h5>(<b>Regd.Office</b>:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
  <h5>(<b>Branch </b>:4,Tarapore Road,Camp,Pune-411 001.)</h4> <br>
  
  <table class="reimbursetoptable">
                  <tr></tr>
                    
                    <tr>
                         <td><span style="float: left;"></span></td>
                         <td></td>
                         <td><span style="float: right;">No:${projectInstance.ref}</span></td>
                     </tr>  
                      
                     <tr>
                          <td><span style="float: left;"></span></td>
	                  <td><h4>DEBIT VOUCHER</h4></td>
                          <td></td>
                     </tr>  
                    
                       
                       <tr>
                           <td><span style="float: left;">Department: ${projectInstance?.costCenter?.name}</span></td>
                           <td><p>     </p></td>
                           <td><span style="float: right;">Date:${new Date()?.format('dd-MM-yyyy')} </span></td>
                      </tr>
                   
        
           </table>
  
 
<g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses]" />     
 
  
  <table class="bottomtable">
  
          
           <tbody>        
            <tr>
                 <td>Name:</td>
                 <td>${projectInstance.submitter?:''}</td>
                 <td></td>
                 <td></td>
                 <td></td>
           </tr>
           
            <tr>
	       
	         <td>Rupees</td>
	         <td colspan="3"><b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.amount?.toString()?:'0'))} Only </b></td>
	         <td>${projectInstance.amount?:0}</td>
	    </tr
	         	      
	 </table>
	 <table class="signtable">
	     <br><br>
             <tr></tr>
             <tr>
	        <td><p>(Sactionary Autority)</p></td>
	        <td><p>(Receiver)</p> </td>
	        <td><p>(Accountant)</p></td>
	    </tr> 
	    
         </table>
       
  </fieldset>

    </div>   <!-- End of subpageOffice Div -->  
</div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 