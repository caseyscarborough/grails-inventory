
<%@ page import="harbor.Asset" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'asset.label', default: 'Asset')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div id="main-content" class="content scaffold-show" role="main">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<div id="asset-top">
			<div id="asset-left">
				<ol class="property-list asset">
					<li class="fieldcontain">
						<span id="hubId-label" class="property-label"><g:message code="asset.hubId.label" /></span>
						<span class="property-value"><h3><g:fieldValue bean="${assetInstance}" field="hubId"/></h3></span>
					</li>
					<li class="fieldcontain">
						<span id="serviceTag-label" class="property-label"><g:message code="asset.serviceTag.label" /></span>
						<span class="property-value"><g:fieldValue bean="${assetInstance}" field="serviceTag"/></span>
					</li>
					<li class="fieldcontain">
						<span id="type-label" class="property-label"><g:message code="asset.type.label" /></span>
						<span class="property-value"><g:link controller="asset" action="listByType" id="${assetInstance?.type?.id}">${assetInstance?.type?.encodeAsHTML()}</g:link></span>
					</li>
				</ol>
			</div>
			<div id="asset-right">
				<% def location = assetInstance.getLocation() %>
				<% def state = assetInstance.getState() %>
				<ol class="property-list asset">
					<li class="fieldcontain">
						<span id="location-label" class="property-label"><g:message code="update.location.label" /></span>
						<span class="property-value"><g:link controller="location" action="show" id="${location.id}">${location.encodeAsHTML()}</g:link></span>
					</li>
					<li class="fieldcontain">
						<span id="state-label" class="property-label"><g:message code="update.state.label" /></span>
						<span class="property-value"><g:link controller="state" action="show" id="${state.id}">${state.encodeAsHTML()}</g:link></span>
					</li>
				</ol>
			</div>
			<br>
			
			<% def updateInstanceList = assetInstance.getUpdateHistory() %>
			<div id="list-update" class="content scaffold-list clearBoth" role="main">
				<h2>Update History</h2>
				<table>
					<thead>
						<tr>
							<th><g:message code="update.location.label" default="Location" /></th>
							<th><g:message code="update.state.label" default="State" /></th>
							<th><g:message code="update.occurredBy.label" default="Occurred By" /></th>
							<g:sortableColumn property="occurredAt" title="${message(code: 'update.occurredAt.label', default: 'Occurred At')}" />
							<g:sortableColumn property="note" title="${message(code: 'update.note.label', default: 'Note')}" />
						</tr>
					</thead>
					<tbody>
					<g:each in="${updateInstanceList}" status="i" var="updateInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td><g:link controller="location" action="show" id="${updateInstance.location.id}">${fieldValue(bean: updateInstance, field: "location")}</g:link></td>
							<td><g:link controller="state" action="show" id="${updateInstance.state.id}">${fieldValue(bean: updateInstance, field: "state")}</g:link></td>
							<td>${fieldValue(bean: updateInstance, field: "occurredBy")}</td>
							<td><g:formatDate date="${updateInstance.occurredAt}" format="MMM dd yyyy" /></td>
							<td>${fieldValue(bean: updateInstance, field: "note")}</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${updateInstanceList.size()}" />
				</div>
			</div>
		</div>
	</div>
	<div id="options">
		<g:render template="/asset/sidebar" />
	</div>
	</body>
</html>
