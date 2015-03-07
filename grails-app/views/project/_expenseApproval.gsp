 
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
</style>

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
                #outline: 2cm #FFEAEA solid;
            }
            .subpageBottom {
                //padding-top: 0.5cm;
                #border: 5px red solid;
                #height: 130mm;
                #outline: 0.5cm #FFEAEA solid;
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
        </style>


 <div class="page">
 
 <div class="subpageTop">
 
  <fieldset>

  <h4>International Society For Krishna Consciousness(ISKCON)</h4>
  <h5>(Regd.Office,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
  <h5>(Branch:4,Katraj-Kondhava Bypass Rd,Opp Shatranjay Temple ,Kondhava Bk,Pune-48,Ph020141033247/222.)</h5> 
  
  <table>
  
        <tr>
         <td><span style="float: left;"> <h5> Slip No: ${projectInstance?.ref} </h5></span></td>
         <td><span style="float: right; padding-right:50px;"><h5> Date:${projectInstance?.submitDate?.format('dd-MM-yyyy')}   <h5></span></td>
        </tr>
     
     
        <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
   
        <tr>  
          <td><span style="float: left;"><h5> Vr No:   <h5></span></td>
          <td><span style="float: right;"><h5> Department:${projectInstance?.costCenter?.name} <h5></span></td>
       </tr>
       
       
       <ghcgghgbvb>
       <tr>  
          <td> To<br>
            The President,<br>
            ISKCON,Pune.<br>
            Dear Prabhu,<br>
            
            
            Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmount} /-</b> for the following expenses:<br>
            Rs. in Words <b> Nine Thousand Only </b>                                     <br>
            <br>
            ${projectInstance?.description}
            
            1. Some expenses name <br>
           
            I will settle the above amount by producing the necesarry documents in  <b>  30  </b>  days <br>
            
          Thanking You, </td> </tr>
           
                <tr>  
	             <td><span style="float: left;">${projectInstance?.submitter}Your Servant,  </span></td>
	             <td><p>(Sanctioned)</p></td>
                </tr>
                
               
                
                <tr>
		      <td><span style="float: left;">(Signature)</span></td>
		      <td><span style="float: right;padding-right:20px;"></span></td>
	        </tr>  
          
                
                
                 <tr>
		       <td>Name:${projectInstance?.reviewer3}</td>
		       <td><p>(Autorised Signatory)</p></td>
		 </tr>  
          </table>
 
  </fieldset>
  </div> 
  
  <div class="subpageBottom">  <!-- bottom Copy -->
  
  
    <fieldset>
  
    <h4>International Society For Krishna Consciousness(ISKCON)</h4>
    <h5>(Regd.bottom,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
    <h5>(Branch:4,Katraj-Kondhava Bypass Rd,Opp Shatranjay Temple ,Kondhava Bk,Pune-48,Ph020141033247/222.)</h5> 
    
    <table style="width:100%">
    
          <tr>
           <td><span style="float: left;"> <h5> Slip No: ${projectInstance?.ref} </h5></span></td>
           <td><span style="float: right; padding-right:50px;"><h5> Date:${projectInstance?.submitDate?.format('dd-MM-yyyy')}   <h5></span></td>
          </tr>
       
       
          <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
     
          <tr>  
            <td><span style="float: left;"><h5> Vr No:   <h5></span></td>
            <td><span style="float: right;"><h5> Department:${projectInstance?.costCenter?.name} <h5></span></td>
         </tr>
         
         
       
         <tr>  
            <td> To<br>
              The President,<br>
              ISKCON,Pune.<br>
              Dear Prabhu,<br>
              
              
              Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmount} /-</b> for the following expenses:<br>
              Rs. in Words <b> Nine Thousand Only </b>                                     <br>
              
              ${projectInstance?.description}
              
              1. Some expenses name <br>
             
              I will settle the above amount by producing the necesarry documents in  <b>  30  </b>  days <br>
              
            Thanking You, </td> </tr>
             
                  <tr>  
  	             <td><span style="float: left;">Your Servant,${projectInstance?.submitter}<br><p> (Signature)</p>Name:${projectInstance?.reviewer3} </span></td>
  	             <td><p>(Sanctioned)</p>(Autorised Signatory)></td>
                  </tr>
                  
                 
                 
            </table>
   
    </fieldset>
    </div> 
  
                    </div>   <!-- End of subpageBottom Div -->  
                </div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 