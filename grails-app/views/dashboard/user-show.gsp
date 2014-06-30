<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="administrator-dashboard"/>
		<title>${grailsApplication.metadata['app.name']}.${label}</title>
	</head>
	<body>
		<script type="text/javascript">
		  	$(document).ready(function() {
		  		var dataToSend = { id: '${user.id}' };
		  		$.ajax({
			  	  	url: "${appBaseUrl}/dashboardAjax/userGroups",
			  	  	context: $("#groupsContent"),
			  	  	data: dataToSend
		  		})
		  	   .done(function(data){
		  			$("#groupsSpinner").css("display","none");
		  			var label = data.length == 1 ? data.length + ' Group' : data.length + ' Groups';
		  			$("#groupsTitle").html("");
		  			$("#groupsNumber").html(" " + label);
		  			$.each(data, function(i,item){
			  			var roles ="";
						for(var i=0; i<item.roles.length; i++) {
							roles+=item.roles[i].label
						}
		  				$('#groupsTable').append('<tr><td><a href="../showGroup/' + 
			  				item.group.id + '">' + item.group.name + '</a></td><td>' + 
			  				item.dateCreated + '</td><td>'+ roles +
			  				'</td><td> '+ item.status.label + '</td></tr>');
		  		    });
		  					  			
			  	})
			  	.fail(function( jqXHR, textStatus ) {
			  		$("#groupsSpinner").css("display","none");
			  		$("#groupsTitle").html("<b>! Failed to load the list of groups</b>");
			  		$("#userGroupsComponent").css("display","none");
				});
				
		  		$.ajax({
			  	  	url: "${appBaseUrl}/dashboardAjax/userSystems",
			  	  	context: $("#systemsContent"),
			  	  	data: dataToSend,
			  	  	statusCode: {
			          	404: function() {
			          		$("#systemsSpinner").css("display","none");
					  		$("#systemsTitle").html("<b>! Failed to load the list of systems (404)</b>");
					  		$("#userSystemsComponent").css("display","none");
			          	}
			        }
		  		})
		  	   .done(function(data){
		  			$("#systemsSpinner").css("display","none");
		  			var label = data.length == 1 ? data.length + ' System' : data.length + ' Systems';
		  			$("#systemsTitle").html("");
		  			$("#systemsNumber").html(" " + label);
		  			$.each(data, function(i,item){
		  				$('#systemsTable').append('<tr><td><a href="../showSystem/' + 
			  				item.system.id + '">' + item.system.name + '</a></td><td>' + 
			  				item.dateCreated + '</td><td>'+ (item.system.enabled==true?'Enabled':'Disabled') + '</td></tr>');
		  		    });
		  					  			
			  	})
			  	.fail(function( jqXHR, textStatus ) {
			  		$("#systemsSpinner").css("display","none");
			  		$("#systemsTitle").html("<b>! Failed to load the list of systems</b>");
			  		$("#userSystemsComponent").css("display","none");
				});
		  	});
		</script>
	
		<table>
			<tr>
				<td valign="top" width="400px">
					<div class="title">
						<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'user.png')}"/> User - id: ${user.id}
					</div>
					<g:form method="post" >
						<div class="csc-lens-container">
							<br/>
							<g:hiddenField name="id" value="${user.id}" /> 
							<g:render plugin="cs-users" template="/users/userShow" />
							<br/>
						</div>
						<div class="buttons">
							<g:if test="${grailsApplication.config.org.commonsemantics.grails.users.dashboard.user.editing!='disabled'}">
								<span class="button">
									<g:link class="edit" controller="dashboard" action="editUser"  id="${user.id}" style="text-decoration: none;">Edit User</g:link>
								</span>
							</g:if>
							<g:if test="${grailsApplication.config.org.commonsemantics.grails.users.dashboard.user.password!='disabled'}">
								<span class="button">
									<g:link class="password" controller="dashboard" action="changeUserPassword"  id="${user.id}" style="text-decoration: none;">${message(code: 'default.button.edit.account.label', default: 'Change password')}</g:link>
								</span>
							</g:if>
							<span class="button">
								<g:link class="list" controller="dashboard" action="listUsers"  id="${user.id}" style="text-decoration: none;">${message(code: 'default.button.edit.account.label', default: 'List Users')}</g:link>
							</span>
						</div>
					</g:form>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<div class="title">
						<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'groups.png')}"/><span id="groupsNumber"/> Groups
					</div>
					<g:render plugin="cs-groups" template="/groups/ajaxShowUserGroups" />
				</td>
			</tr>
			<tr>
				<td valign="top">
					<div class="title">
						<img style="display: inline; vertical-align: middle;" src="${resource(dir:'images/dashboard',file:'computer.png')}"/><span id="systemsNumber"/> Systems
					</div>
					<g:render plugin="cs-systems" template="/systems/ajaxShowUserSystems" />
				</td>
			</tr>
		</table>
		<br/><br/><br/><br/>
	</body>
</html>