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
		<div id="status" role="complementary">
			<h1>Alta de recorrido</h1>
			<g:form url="[resource:recorridoInstance, action:'save']" onsubmit="loadCoordinates()">
				<g:hiddenField type="text" id="points" name="points"/>
				<span>Nombre:</span> <g:textField type="text" id="nombre" name="nombre"/>
				<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />			
			</g:form>
		</div>
		<div id="page-body" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<h1>Recorridos</h1>
			<p>Para agregar un destino o un origen, cliquear con el botón derecho en el mapa o buscar ubicación</p>			
		</div>

		<g:render template="createForm"/>

	</body>
</html>
