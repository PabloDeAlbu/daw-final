<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><a class="list" href="${createLink(uri: '/recorrido')}">Listar recorridos</a></li>
				<li><a class="create" href="${createLink(uri: '/recorrido/create')}">Crear recorridos</a></li>
			</ul>
		</div>
		<div id="status" role="complementary">
			<g:render template="recorrido/searchForm"/>
		</div>
		<div id="page-body" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<h1>Recorridos</h1>
			<p>Para agregar un destino o un origen, cliquear con el botón derecho en el mapa o buscar ubicación</p>
		<g:render template="map"/>
			
		</div>
		
	</body>
</html>
