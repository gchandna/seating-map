<%@ page import="com.vmware.ie.englabs.state.UCPType"%>
<%@ page import="com.vmware.ie.englabs.state.StationState"%>

<div class="row-fluid">
	<div class="span6">
		<div class="control-group ${hasErrors(bean: site, field: 'stationNumber', 'error')}">
			<label class="control-label" for="stationNumber"><g:message code="label.stationnumber"/>:</label>
				<div class="controls">
 				<input class="input-xlarge" id="stationNumber" type="text" value="${station.stationNumber}">
			</div>
		</div>
		<div class="control-group ${hasErrors(bean: site, field: 'locked', 'error')}">
			<label class="control-label" for="locked"><g:message code="label.locked"/>?:</label>
				<div class="controls">
 				<g:checkBox name="locked" value="${station.locked}" />
			</div>
		</div>
		<div class="control-group ${hasErrors(bean: site, field: 'site', 'error')}">
			<label class="control-label" for="site"><g:message code="label.site"/>:</label>
				<div class="controls">
				<g:select noSelection="['null':'-None Bound-']"  name="site" id="site" from="${sites}" optionKey="id" optionValue="siteName" value="${station.site?.id}" />
 			</div>
		</div>
		<div class="control-group ${hasErrors(bean: site, field: 'type', 'error')}">
			<label class="control-label" for="type"><g:message code="label.type"/>:</label>
				<div class="controls">
				<g:select noSelection="['null':'-None Set-']"  name="type" id="type" from="${UCPType.values()}" value="${station.type}" />
 			</div>
		</div>
		<div class="control-group ${hasErrors(bean: site, field: 'state', 'error')}">
			<label class="control-label" for="type"><g:message code="label.state"/>:</label>
				<div class="controls">
				<g:select name="state" id="state" from="${StationState.values()}" value="${station.state}" />
 			</div>
		</div>
	</div>
	
</div>
<div class="row-fluid">
	<div class="span12">
		<div class="page-header">
				<h3>Current Lab Session<small> <i>(Lab currently being taken at this station)</i></small></h3>
  		</div>
  		<g:if test="${!labSession}">
  			No session currently assigned
  		</g:if>
  		<g:else>
  			<table class="table table-striped ">
					<admin:adminTableHeader  cols="${[message(code:'label.lab'),message(code:'label.user'),message(code:'label.started'),,message(code:'label.expires'),message(code:'label.timeleft')]}"/>
					<tbody>
			 				<tr>
	 							<td class="td_background">
	 								<g:link action="edit" controller="adminLab" id="${labSession.lab.id}">
	 									<strong>${labSession.lab.name}</strong>
	 								</g:link>
								</td>
								<td class="td_background">
									<g:if test="${sessionUser}">
										<g:link action="view" controller="adminUser" id="${sessionUser.id}">
	 										<i class="icon-user icon-white"></i> <strong>${sessionUser.firstName} ${sessionUser.lastName} (${sessionUser.email})</strong>
	 									</g:link>
	 								</g:if>
	 								<g:else>
	 									No user attached to this session!
	 								</g:else>
								</td>
								<td class="td_background">
								 	<g:formatDate date="${labSession.labStarted}" format="MMM-dd-yyyy HH:mm"/>
								</td>
								<td class="td_background">
								  	<g:formatDate date="${labSession.labExpires}" format="MMM-dd-yyyy HH:mm"/>
								</td>
								<td class="td_background">
									<ucp:labExpires expires="${labSession.labExpires}"/>
								</td>
								
							</tr>
	 					
	 				</tbody>
			 	</table>
  			
  		</g:else>
	</div>
</div>
