<%@ page import="com.vmware.ie.englabs.state.StationState"%>
<%@ page import="com.vmware.ie.englabs.state.UCPType"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name='layout' content='admin_auth'/>
		<title><g:message code="default.page.title"/></title>
	</head>
	<body>
		<div class="row">
			<div class="well sitesheader">
				<h1><g:message code="admin.section.station"/></h1>
			</div>
		</div>
		<g:render template="/common/adminflash" />
		
		<script>


			$(document).ready(function() {

			 $('#search').typeahead({
			        source: function(typeahead, query) {
			            if(this.ajax_call)
			                this.ajax_call.abort();
			            this.ajax_call = $.ajax({
			                dataType : 'json',
			                cache: false,
			                data: {
			                    query: query
			                },
			                url: '${createLink(controller: "adminStation", action: "search")}',
			                success: function(data) {
			                    typeahead.process(data);
			                }
			            });
			        },
			        property: 'stationNumber',
			        onselect: function (obj) {
			           window.location.href='${createLink(controller: "adminStation", action:"edit")}/' + obj.id
			         }
			    });
			})
			</script>
				
		</div>		
		
		<div class="row">
			<div>
			
			<table class="table table-striped ">
					<admin:adminTableHeader selectAll="true" cols="${[message(code:'label.stationnumber'),message(code:'label.stationtype'),message(code:'label.stationreg'),'Locked?',message(code:'label.site'),message(code:'label.stationip'),message(code:'label.stationstate')
						,message(code:'label.actions')]}"/>
					<tbody>
			 			<g:each in="${stations}" status="status" var="station">
			 				<tr>
	 							<td class="td_background">
	 								<input type="checkbox" name="station[]" value="${station.id}"/> &nbsp;<strong>${station.stationNumber}</strong>
								</td>
								<td class="td_background">
									${station.type.toString()}
								</td>
								<td class="td_background">
								 	<g:if test="${!station.clientIP && station.state.toString()=="UNREGISTERED"}">
								 		<admin:enabledStatus enabled="${new Boolean(false)}"/>
								 	</g:if>
								 	<g:else>
									 	<admin:enabledStatus enabled="${new Boolean(true)}"/>
								 	</g:else>
								</td>
								<td class="td_background">
									${station.site?.siteName }
								</td>
								<td class="td_background">
									${station.clientIP}
								</td>
								<td class="td_background">
								 	${station.state.toString()}
								</td>
								<td class="td_background">
									<g:link controller="adminStation" action="edit" id="${station.id}" class="btn">
   										<i class="icon-pencil"></i><g:message code="admin.action.edit" args="[message(code: 'label.station')]"/>
   									</g:link>
   								</td>
							</tr>
	 					</g:each>
	 				</tbody>
			 	</table>
			</div>
		</div>
		
		<div id="flipStateEmptyModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Pick Stations!</h3>
				</div>
			<div class="modal-body">
				<p>You need to pick some stations before you can perform bulk options on them.</p>
            </div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.ok"/>
				</a>
			</div>
		</div>		
		
		
		<div id="confirmUnregisterModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Are you sure?</h3>
				</div>
			<div class="modal-body">
				<p>Once stations are un-registered, you can't re-register them in bulk.</p>
            </div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.cancel"/>
				</a>
				<a href="javascript:confirmUnregister()" class="btn btn-danger">
					<g:message code="label.ok"/> unregister stations
				</a>
			</div>
		</div>		
				
		<div id="flipStateModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Bulk change station state</h3>
				</div>
			<div class="modal-body">
				<p>You're about to switch the state of the labs you have selected. Pick the state you'd like them to be switched to.</p>
				<p><g:select name="bulk_state" id="bulk_state" from="${StationState.values()}"/>
            </div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.cancel"/>
				</a>
				<a href="javascript:flipStateConfirm()" class="btn btn-success">
					<g:message code="label.ok"/>
				</a>
			</div>
		</div>
				
		<div id="bulkDeleteModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Bulk delete stations</h3>
				</div>
			<div class="modal-body">
				<p>You're about to delete the stations you have selected. This is a destructive action and cannot be undone.</p>
			</div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.cancel"/>
				</a>
				<a href="javascript:deleteStationsConfirm()" class="btn btn-danger">
					<g:message code="label.ok"/> Delete
				</a>
			</div>
		</div>
		
		<div id="bulkAddModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Bulk add stations</h3>
				</div>
			<div class="modal-body">
				<p>Define the station number range you wish to add (ie. 100-150)</p>
				
				<form class="form-inline">
  					<input type="text" class="input-small" placeholder="Start" id="add_min">
  					<input type="text" class="input-small" placeholder="End" id="add_max">
  				</form>
				<p>
					Station Type: <br/>
					<g:select name="bulk_type" id="add_type" from="${UCPType.values()}" value="BYOD"/>
            	</p>
				<p>
					Site: <br/>
					<g:select noSelection="['null':'-None Bound-']"  name="site" id="add_site" from="${sites}" optionKey="id" optionValue="siteName"  />
            	</p>
		    </div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.cancel"/>
				</a>
				<a href="javascript:addStationConfirm()" class="btn btn-success">
					<g:message code="label.ok"/> - Add Stations
				</a>
			</div>
		</div>
		
		<div id="changeSiteModal" class="modal hide fade" style="display: none; ">
			<div class="modal-header">
				<a class="close" data-dismiss="modal">×</a>
					<h3>Bulk change station site</h3>
				</div>
			<div class="modal-body">
				<p>You're about to change the bound data center/site of the selected stations</p>
				<p><g:select name="bulk_site" id="bulk_site" from="${sites}" optionKey="id" optionValue="siteName"/>
            </div>
            <div class="modal-footer">
				<a href="#" data-dismiss="modal" class="btn">
					<g:message code="label.cancel"/>
				</a>
				<a href="javascript:changeSiteConfirm()" class="btn btn-success">
					<g:message code="label.ok"/>
				</a>
			</div>
		</div>				
		
	
		<script>
				 $(document).ready(function() {
					$('#collapseStations').collapse('show')
					$('#station_nav_list').addClass('active')
				
				
					$('#selectAllBox').bind('click', function() {
						 selectAllStations()
					});
				 });
					var flipped=false;	
					 function selectAllStations() {
						var boxes = $(':checkbox');
						boxes.each( function() {
							if(!flipped) {
								$(this).attr('checked',true)
							} else {
								$(this).attr('checked',false)
							}
						});
						if(!flipped) {
							flipped=true
						} else {
							flipped=false
						}
						
					}

					function filterStations(filter) {
						
						var minVal = $('#min_val').val()
						var maxVal = $('#max_val').val()
						
						if(filter==null) {
							window.location.href = 'list?min=' + minVal + '&max=' + maxVal + '&filter=${params.filter}'
						} else {
							window.location.href = 'list?min=' + minVal + '&max=' + maxVal + '&filter=' + filter
						}					

					}
						
					 function bulkChangeStationState() {
						var boxes = $('input[type=station[]]:checked');
						selectedStations = new Array()
						boxes.each( function() {
							if($(this).val()!="on")
								selectedStations[selectedStations.length] = $(this).val()
						});
						if(selectedStations.length<=0) {
							$('#flipStateEmptyModal').modal('show')
						} else {
							$('#flipStateModal').modal('show')
						}
					}

					 function bulkDeleteStations() {
							var boxes = $('input[type=station[]]:checked');
							selectedStations = new Array()
							boxes.each( function() {
								if($(this).val()!="on")
									selectedStations[selectedStations.length] = $(this).val()
							});
							if(selectedStations.length<=0) {
								$('#flipStateEmptyModal').modal('show')
							} else {
								$('#bulkDeleteModal').modal('show')
							}
						}
						

					 function bulkAddStations() {
						$('#bulkAddModal').modal('show')
					 }

					 function bulkSwitchSite() {
							var boxes = $('input[type=station[]]:checked');
							selectedStations = new Array()
							boxes.each( function() {
								if($(this).val()!="on")
									selectedStations[selectedStations.length] = $(this).val()
							});
							if(selectedStations.length<=0) {
								$('#flipStateEmptyModal').modal('show')
							} else {
								$('#changeSiteModal').modal('show')
							}
						}	

					function bulkUnregister() {
						var boxes = $('input[type=station[]]:checked');
						selectedStations = new Array()
						boxes.each( function() {
							if($(this).val()!="on")
								selectedStations[selectedStations.length] = $(this).val()
						});
						if(selectedStations.length<=0) {
							$('#flipStateEmptyModal').modal('show')
						} else {
							$('#confirmUnregisterModal').modal('show')
						}

					}
					
					function confirmUnregister() {
						selectedStations = new Array()
						var boxes = $('input[type=station[]]:checked');
						boxes.each( function() {
							if($(this).val()!="on")
								selectedStations[selectedStations.length] = $(this).val()
						});

						var state = $('#bulk_state').val();
						var dataObj = { 'state': state, 'stations' : selectedStations }

						$.ajax({
							url: "${createLink(controller:'adminStation',action:'bulkUnregisterStations')}",
							type: "POST",
							data: JSON.stringify({ data: dataObj }),
							contentType: "application/json; charset=utf-8",
							success:  function(feedback){
								   if(feedback.success) {
									   $('#flipStateModal').modal('hide')
									   var bounce = function() {
										   window.location.href='${createLink(controller:'adminStation',action:'list')}'
										 }
										setTimeout(bounce(),1200);
									}
								 }
						});
					 }

					function addStationConfirm() {
						
						var min = $('#add_min').val();
						var max = $('#add_max').val();
						var type = $('#add_type').val();
						var site = $('#add_site').val();
						
						if(min=="" || max=="") {
							alert("min/max values are empty")
							return;
						}

						if((min!="" && max!="") && (parseInt(min) > parseInt(max))) {
							alert("min value is greater than the max!")
							return;
						}
						
						var dataObj = { 'min': min, 'max' : max, 'type': type, 'site': site }

						$.ajax({
							url: "${createLink(controller:'adminStation',action:'bulkAddStations')}",
							type: "POST",
							data: JSON.stringify({ data: dataObj }),
							contentType: "application/json; charset=utf-8",
							success:  function(feedback){
								   if(feedback.success) {
									   $('#bulkAddModal').modal('hide')
									   var bounce = function() {
										   window.location.href='${createLink(controller:'adminStation',action:'list')}'
										 }
										setTimeout(bounce(),1200);
									}
								 }
						});
					 }

					

					
					
					 function flipStateConfirm() {
						selectedStations = new Array()
						var boxes = $('input[type=station[]]:checked');
						boxes.each( function() {
							if($(this).val()!="on")
								selectedStations[selectedStations.length] = $(this).val()
						});

						var state = $('#bulk_state').val();
						var dataObj = { 'state': state, 'stations' : selectedStations }

						$.ajax({
							url: "${createLink(controller:'adminStation',action:'bulkUpdateStationState')}",
							type: "POST",
							data: JSON.stringify({ data: dataObj }),
							contentType: "application/json; charset=utf-8",
							success:  function(feedback){
								   if(feedback.success) {
									   $('#flipStateModal').modal('hide')
									   var bounce = function() {
										   window.location.href='${createLink(controller:'adminStation',action:'list')}'
										 }
										setTimeout(bounce(),1200);
									}
								 }
						});
					 }


					 function deleteStationsConfirm() {
							selectedStations = new Array()
							var boxes = $('input[type=station[]]:checked');
							boxes.each( function() {
								if($(this).val()!="on")
									selectedStations[selectedStations.length] = $(this).val()
							});

							var dataObj = { 'stations' : selectedStations }

							$.ajax({
								url: "${createLink(controller:'adminStation',action:'bulkDeleteStations')}",
								type: "POST",
								data: JSON.stringify({ data: dataObj }),
								contentType: "application/json; charset=utf-8",
								success:  function(feedback){
									   if(feedback.success) {
										   $('#flipStateModal').modal('hide')
										   var bounce = function() {
											   window.location.href='${createLink(controller:'adminStation',action:'list')}'
											 }
											setTimeout(bounce(),1200);
										}
									 }
							});
						 }	

					 function changeSiteConfirm() {
							selectedStations = new Array()
							var boxes = $('input[type=station[]]:checked');
							boxes.each( function() {
								if($(this).val()!="on")
									selectedStations[selectedStations.length] = $(this).val()
							});

							var site = $('#bulk_site').val();
							var dataObj = { 'site': site, 'stations' : selectedStations }

							$.ajax({
								url: "${createLink(controller:'adminStation',action:'bulkUpdateStationSite')}",
								type: "POST",
								data: JSON.stringify({ data: dataObj }),
								contentType: "application/json; charset=utf-8",
								success:  function(feedback){
									   if(feedback.success) {
										   $('#changeSiteModal').modal('hide')
										   var bounce = function() {
											   window.location.href='${createLink(controller:'adminStation',action:'list')}'
											 }
											setTimeout(bounce(),1200);
										}
									 }
							});
						 }
					 
			</script>
				
	</body>
</html>