<%@ page import="ics.IndividualCourse" %>



<div class="fieldcontain ${hasErrors(bean: individualCourseInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualCourse.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="individual" name="individual.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${individualCourseInstance?.individual?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCourseInstance, field: 'course', 'error')} required">
	<label for="course">
		<g:message code="individualCourse.course.label" default="Course" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="course" name="course.id" from="${ics.Course.list()}" optionKey="id" required="" value="${individualCourseInstance?.course?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCourseInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="individualCourse.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${individualCourseInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCourseInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="individualCourse.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${individualCourseInstance?.updator}"/>
</div>

