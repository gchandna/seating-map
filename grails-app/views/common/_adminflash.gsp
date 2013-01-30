		<g:if test="${flash.error}">
			<div class="row">
					<div class="alert alert-error">
						<h3><g:message code="admin.flash.error"/></h3>
						<p>
							${flash.error}
						</p>	
					</div>
			</div>
		</g:if>
		<g:if test="${!register}">
		<g:if test="${flash.info}">
			<div class="row">
					<div class="alert alert-info">
						<h3><g:message code="admin.flash.info"/></h3>
						<p>
							${flash.info}
						</p>
					</div>
			</div>
		</g:if>
		<g:if test="${flash.success}">
			<div class="row">
					<div class="alert alert-success">
						<h3><g:message code="admin.flash.success"/></h3>
						<p>
							${flash.success}
						</p>
					</div>
				</div>
			
		</g:if>
		</g:if>