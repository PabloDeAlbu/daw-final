<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recorrido.label', default: 'Recorrido')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-recorrido" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<g:form url="[resource:recorridoInstance, action:'save']" onsubmit="loadCoordinates()">
			<g:hiddenField type="text" id="points" name="points"/>
			<span>Nombre de Recorrido:</span> <g:textField type="text" id="nombre" name="nombre"/>
			<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />			
		</g:form>
		<g:render template="form"/>

	</body>
</html>
