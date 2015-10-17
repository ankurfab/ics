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
                      <td><span style="float: right;">No:<b>${voucherInstance?.voucherNo}</b></span></td>
                     
                     </tr>
                 
                  
                    <tr> 
                     
                     <td> <span style="float: left;">Department:${voucherInstance?.departmentCode}</span></td>
                     <td>
                     		<g:if test="${voucherInstance?.type?.toUpperCase()=='JOURNAL'}">
                     		ToDepartment:${voucherInstance?.anotherDepartmentCode?:voucherInstance?.anotherLedger}
                     		</g:if>
                     </td>
                      <td><span style="float: right;">Date:<b>${voucherInstance?.voucherDate?.format('dd-MM-yyyy')}</b></span></td>
                    </tr>
                 
      
           </table>
             
           <table class="advancebottomtable">
		   <tr>
			<td>
				Received with thanks, a sum of Rupees <b>${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(voucherInstance?.amount?.toString()?:'0'))}</b> Only
				as donation by ${voucherInstance?.mode?.name?:''}
			</td>
		   </tr>
		   <tr>
			<td>
				Cheque No: ${voucherInstance?.instrumentNo?:''} Cheque Date: ${voucherInstance?.instrumentDate?.format('dd-MM-yyyy')?:''} Bank: ${(voucherInstance?.bankName?:'') +' '+ (voucherInstance?.bankBranch?:'')}
			</td>
		   </tr>
		   <tr>
			<td>
				From: <b>${voucherInstance?.refNo?:''}</b>
			</td>
		   </tr>
		   <tr>
			<td>
				Address: ${voucherInstance?.description?:''}
			</td>
		   </tr>
		   <tr>
			<td>
				On Account of: <b>${voucherInstance?.departmentCode?.name?:''}</b>
			</td>
		   </tr>
                                         
            </table>
            
       <table class="signtable">
       	<tr>
       		<td>
       		</td>
       		<td>
       			Yours in Service of Lord Krishna
       		</td>
       	</tr>
       	<tr>
       		<td>
       		</td>
       		<td>
      		</td>
       	</tr>
       	<tr>
       		<td>
       			Rs. <b>${voucherInstance?.amount?:''}</b>
       		</td>
       		<td>
       		</td>
       	</tr>
       	<tr>
       		<td>
       			(Draft/Cheque subject to realization)
       		</td>
       		<td>
       			For ISKCON
       		</td>
       	</tr>
       </table>           
       </fieldset>             
         