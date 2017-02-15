<%@ page import="recorridos.Recorrido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recorrido.label', default: 'Recorrido')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
	<body>
		<a href="#edit-recorrido" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</div>
		<span style="display: none" id="puntos"><g:each in="${array}">${it};</g:each></span>
		
		<g:form url="[resource:recorridoInstance, action:'update']" method="PUT" onsubmit="loadCoordinates()">
			<g:hiddenField id="points" name="points" />
			<g:hiddenField id="id" name="id" value="${recorridoInstance.id}" />
			<span>Nombre de Recorrido:</span> <g:textField type="text" id="nombre" name="nombre" value="${recorridoInstance.nombre}"/>
			<g:submitButton name="update" class="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
		</g:form>
		<g:render template="editForm"/>
	</body>
</html>
