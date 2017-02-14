<%@ page import="recorridos.Recorrido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recorrido.label', default: 'Recorrido')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-recorrido" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="status" role="complementary">
			<table>
			<thead>
					<tr>
						<g:sortableColumn property="nombre" title="${message(code: 'recorrido.nombre.label', default: 'Nombre')}" />
					</tr>
				</thead>
				<tbody>
				<g:each in="${recorridoInstanceList}" status="i" var="recorridoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><g:link action="show" id="${recorridoInstance.id}">${fieldValue(bean: recorridoInstance, field: "nombre")}</g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>	
				<div class="pagination">
					<g:paginate total="${recorridoInstanceCount ?: 0}" />
				</div>
		</div>
		<div id="page-body" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<h1>Recorridos</h1>
			<p>Para agregar un destino o un origen, cliquear con el botón derecho en el mapa o buscar ubicación</p>			
		</div>
			
		</div>
	</body>
</html>
