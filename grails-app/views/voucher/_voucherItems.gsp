<%@ page import="ics.EnglishNumberToWords" %>

<fieldset>
         
     <h4>INTERNATIONAL SOCIETY FOR KRISHNA CONSCIOUSNESS</h4>
     <p>(Regd.Office:Hare Krishna Land,Juhu, Mumbai-400 049),</p>
     <p>(Branch:4,Tarapore Road,Camp,Pune-411 001)</p> <br>
           
           
           <table class="advancetoptable">
            <tr><h4><u>${voucherInstance?.type?.toUpperCase()?:''} VOUCHER</u></tr>
           
                      <tr>
		      <td><span style="float: left;"></span></td>
                      <td></td>
                      <td><span style="float: right;">No:${voucherInstance?.voucherNo}</span></td>
                     
                     </tr>
                 
                  
                    <tr> 
                     
                     <td> <span style="float: left;">Department:${voucherInstance?.departmentCode}</span></td>
                     <td>
                     		<g:if test="${voucherInstance?.type?.toUpperCase()=='JOURNAL'}">
                     		ToDepartment:${voucherInstance?.anotherDepartmentCode?:voucherInstance?.anotherLedger}
                     		</g:if>
                     </td>
                      <td><span style="float: right;">Date:${voucherInstance?.voucherDate?.format('dd-MM-yyyy')}</span></td>
                    </tr>
                 
      
           </table>
             
           <table class="advancebottomtable">
           <thead><td><p><b>Particulars </b></td> <td></td> </thead>
            </tbody>         
                  <tr>
 			<td><b>Debit</b>  </td>
 			<td>${voucherInstance?.anotherLedger?:0}</td>
                    </tr>
                              
                     <tr>
 			<td><b>Credit</b>  </td>
 		        <td>${voucherInstance?.ledger?:0}</td>
                     </tr>
            
                     <tr>
 			 <td><b>Narration  </b>${voucherInstance?.description?:''} </td>
 			 <td></td>
                      </tr> 

			<g:if test="${voucherInstance?.refNo?.startsWith('expense/show/')}">
			<g:set var="ids" value="${voucherInstance?.refNo.substring(13)}" />
			<g:each var="eid"  in="${ids?.tokenize(',')}">
			    <g:set var="expense" value="${ics.Expense.get(eid)}" />
			     <tr>
				 <td><p>${expense?.description+" "+expense?.ledgerHead?.name+" "+expense?.amount}</p></td>
				 <td></td>
			      </tr> 			    
			</g:each>
			</g:if>

                     <tr>
 			 <td>TDS:</td>
 			 <td>${ics.Expense.findByPaymentVoucher(voucherInstance)?.deductionPercentage?:'NONE'}</td>
                     </tr>                  
                              
                     <tr>
 			 <td>Rs. : ${voucherInstance?.amount}</td>
 			 <td>Rs. in words: ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(voucherInstance?.amount?.toString()?:'0'))} Only</td>
                     </tr>                  
              </tbody>                 
            </table>
            
       <table class="signtable">
                    <br><br>
                    <tr>
                    <g:set var="sanctioned" value="${ics.Project.findByAdvancePaymentVoucher(voucherInstance)?.reviewer1}" />
 		    <!-- try if the voucher is associated with an expense -->
 		    <g:if test="${!sanctioned}">
 		    	<g:set var="sanctioned" value="${ics.Expense.findByPaymentVoucher(voucherInstance)?.project?.reviewer1}" />
 		    </g:if>
 		    <td><p>${sanctioned}</p></td>
 			 <td><p> </p> </td>
 			 <td><p></p></td>
                    </tr>
                    
 		    <tr> 
 		    <td><p>(${sanctioned?'Electronically Sactioned By':'Sactioned'})</p></td>
 			 <td><p> </p> </td>
 			 <td><p>(Accountant)</p></td>
 		    </tr> 
       </table>           
       </fieldset>             
         