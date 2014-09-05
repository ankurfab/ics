<%@ page contentType="text/html"%>

<g:if test="${eventRegistrationInstance?.isVipDevotee==false}">
	Dear Sir/Madam,
	<br>
	Hare Krishna!
	<br><br>
	You have successfully registered on NVCC website for the opening ceremony of ISKCON Pune's  New Vedic Cultural Centre.
	<br>
	We will be sending you your login id and password soon using which you can update the details about your participation anytime if required.
	<br><br>
	For cancellation of registration, please e-mail us at register@iskconpune.in with details of 'Name', 'Temple connected to', 'Contact Number','Registration Code(if any)' which you entered while registration.
</g:if>
<g:if test="${eventRegistrationInstance?.isVipDevotee==true}">
	<br>
	Hare Krishna<br>
	Please accept our humble obeisances,<br>
	All glories to Srila Prabhupada,<br>
	All glories to Sri Guru and Sri Gauranga,<br>
	<br>
	You have been successfully registered on NVCC website for the opening ceremony of ISKCON Pune's  New Vedic Cultural Centre.
	<br>
	Please feel free to contact Sripad Mahaprabhu das on +91-8605413471 or email smd@voicepune.com for any further queries or changes in your itinerary.
</g:if>
<br><br>
Thank you!
<br><br> 
Yours in the service of Lord Krishna,
<br>
NVCC Web Services Team.
 