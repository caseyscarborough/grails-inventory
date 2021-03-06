
<%@ page import="harbor.Type" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'type.label', default: 'Type')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="main-content">
			<div id="show-type" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
		
			<ol class="property-list type">
			
				<g:if test="${typeInstance?.make}">
				<li class="fieldcontain">
					<span id="make-label" class="property-label"><g:message code="type.make.label" default="Make" /></span>
						<span class="property-value" aria-labelledby="make-label"><g:fieldValue bean="${typeInstance}" field="make"/></span>
				</li>
				</g:if>
				
				<g:if test="${typeInstance?.model}">
				<li class="fieldcontain">
					<span id="model-label" class="property-label"><g:message code="type.model.label" default="Model" /></span>
						<span class="property-value" aria-labelledby="model-label"><g:fieldValue bean="${typeInstance}" field="model"/></span>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${typeInstance?.id}" />
					<g:link class="edit" action="edit" id="${typeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
		</div>
	</body>
</html>
