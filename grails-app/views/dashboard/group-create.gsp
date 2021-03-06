<!DOCTYPE html>
<%-- by Paolo Ciccarese --%>

<html>
    <head>
		<meta name="layout" content="administrator-dashboard" /> 
		<title>Create Group :: ${grailsApplication.config.af.shared.title}</title>
    </head>
	<body>
		<div class="title">Group Creation </div>
		<g:form method="post" >
			<sec:access expression="hasRole('ROLE_ADMIN')">
				<g:render template="/groups/groupCreate" plugin="cs-groups"/>
				<%-- <g:render template="/administrator/createGroup" /> --%>
			</sec:access>
			<sec:ifNotGranted roles="ROLE_ADMIN">
				<sec:access expression="hasRole('ROLE_MANAGER')">
					<g:render template="/groups/groupCreate" />
				</sec:access>
			</sec:ifNotGranted>
			<sec:ifNotGranted roles="ROLE_ADMIN, ROLE_MANAGER">
				---
			</sec:ifNotGranted>
			<br/>
			<div class="buttons">
				<span class="button">
					<g:actionSubmit class="save" action="saveGroup" value="${message(code: 'org.commonsemantics.grails.users.profile.create', default: 'Create Group')}" />
				</span>
				<span class="button">
					<g:actionSubmit class="disable" action="listGroups" value="${message(code: 'org.commonsemantics.grails.general.cancel', default: 'Cancel')}" />
				</span>
			</div>
		</g:form>
	</body>
</html>