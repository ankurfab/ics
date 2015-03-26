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

h1,h2,h4,h5,h5
{
 text-align: center;
}
p
{
text-align: center;
}
.voucherbody
{
font-family:10pt, "HelveticaNeue-Light";
}
</style>

 <style type='text/css' media='print'>
            body {
                margin: 0;
                padding: 0;
                background-color: #FAFAFA;
                font: 9pt "Tahoma";
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
            .subpageTop{
               // padding: 0.5cm;
                #border: 5px red solid;
                #height: 148mm;
                #outline: 1cm #FFEAEA solid;
            }
            .subpageBottom {
                //padding-top: 0.5cm;
                #border: 5px red solid;
                #height: 130mm;
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
        </style>


 <div class="page">
 
 <div class="subpageTop">
 
  <fieldset>

  <h4>International Society For Krishna Consciousness(ISKCON)</h4>
  <h5>(Regd.Office,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
  <h5>(Branch:4,Katraj-Kondhava Bypass Rd,Opp Shatranjay Temple ,Kondhava Bk,Pune-48,Ph020141033247/222.)</h5> 
  
  <table>
  
        <tr>
         <td><span style="float: left;"> <h6> Expense Ref No: ${projectInstance?.ref} </h6></span></td>
         <td><span style="float: right;padding-right:20px;"><h6> Date:${new Date()?.format('dd-MM-yyyy')}   <h6></span></td>
        </tr>
     
     
        <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
   
       <tr> 
        <td><span style="float: left;"><h4>Department:${projectInstance?.costCenter?.name} <h4></span></td>
        <td><span style="float: right;padding-right:20px;"></span></td>
       </tr>
       
      
       <tr>  
          <td><div class="voucherbody">To<br>
            The President,<br>
            ISKCON,Pune.<br>
            Dear Prabhu,<br>
            
            
            Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmountIssued} /-</b> Rs. in Words <b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.advanceAmountIssued?.toString()?:'0'))} Only </b><br>
            for the following expenses:<br>
           <b>Name of the expense:</b> ${projectInstance?.name}<br>  
           <b>Description:</b> ${projectInstance?.description}<br>            
       
           
            I will settle the above amount by producing the necesarry documents in  <b>  30  </b>  days <br>
            
          Thanking You,</div> </td> </tr>
           <div class="voucherbody">
                <tr>  
	             <td><span style="float: left;">Your Servant,  </span></td>
	             <td><p>Sanctioned</p></td>
                </tr>
                
                  <tr>  
  	             <td><span style="float: left;"><b>${projectInstance?.submitter}</b></span></td>
  	             <td><p><b>${projectInstance?.reviewer1}</b></p></td>
                  </tr>
               
                
                <tr>
		      <td><span style="float: left;">(Signature)</span></td>
		      <td><span style="float: right;padding-right:20px;"></span></td>
	        </tr>  
          
                
                
                 <tr>
		       <td>Name:${projectInstance?.reviewer3}</td>
		      <td style="padding-right:30px;">(AutorisedSign)</td>
		 </tr> </div> 
          </table>
 
  </fieldset>
  </div> 
  
  <div class="subpageBottom">  <!-- bottom Copy -->
  
  
  <fieldset>
  
    <h4>International Society For Krishna Consciousness(ISKCON)</h4>
    <h5>(Regd.Office,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
    <h5>(Branch:4,Katraj-Kondhava Bypass Rd,Opp Shatranjay Temple ,Kondhava Bk,Pune-48,Ph020141033247/222.)</h5> 
    
    <table>
    
          <tr>
           <td><span style="float: left;"> <h6> Expense Ref No: ${projectInstance?.ref} </h6></span></td>
           <td><span style="float: right;padding-right:20px;"><h6> Date:${new Date()?.format('dd-MM-yyyy')}   <h6></span></td>
          </tr>
       
       
          <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
     
         <tr> 
          <td><span style="float: left;"><h5>Department:${projectInstance?.costCenter?.name} <h5></span></td>
          <td><span style="float: right;padding-right:20px;"></span></td>
         </tr>
         
        
         <tr>  
            <td><div class="voucherbody">To<br>
              The President,<br>
              ISKCON,Pune.<br>
              Dear Prabhu,<br>
              
              
              Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmountIssued} /-</b> Rs. in Words <b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.advanceAmountIssued?.toString()?:'0'))} Only </b><br>
              for the following expenses:<br>
             <b>Name of the expense:</b> ${projectInstance?.name}<br>  
             <b>Description:</b> ${projectInstance?.description}<br>            
         
             
              I will settle the above amount by producing the necesarry documents in  <b>  30  </b>  days <br>
              
            Thanking You,</div> </td> </tr>



                  <tr>  
  	             <td><span style="float: left;">Your Servant,  </span></td>
  	             <td><p>Sanctioned</p></td>
                  </tr>
                  
                  <tr>  
  	             <td><span style="float: left;"><b>${projectInstance?.submitter}</b></span></td>
  	             <td><p><b>${projectInstance?.reviewer1}</b></p></td>
                  </tr>
                 
                  
                  <tr>
  		      <td><span style="float: left;">(Signature)</span></td>
  		      <td><span style="float: right;padding-right:20px;"></span></td>
  	        </tr>  
            
                  
                  
                   <tr>
  		       <td>Name:${projectInstance?.reviewer3}</td>
  		      <td style="padding-right:30px;">(AutorisedSign)</td>
  		 </tr>  
            </table>
   
  </fieldset>
    </div> 
  
                    </div>   <!-- End of subpageBottom Div -->  
                </div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 