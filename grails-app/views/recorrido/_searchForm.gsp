	<h1>Busqueda de recorrido</h1>
	<p>Para agregar un destino o un origen, cliquear con el botón derecho en el mapa o buscar ubicación</p>
	<g:form url="[resource:recorridoInstance, action:'search', controller:'recorrido']" onsubmit="loadCoordinates()">
		<g:hiddenField type="text" id="points" name="points"/>
		<g:hiddenField type="text" required="" id="origenX" name="origenX"/><g:hiddenField  required=""  type="text" id="origenY" name="origenY"/>
		<g:hiddenField type="text" required="" id="destinoX" name="destinoX"/><g:hiddenField required="" type="text" id="destinoY" name="destinoY"/>
		<span>Distancia:</span> <g:field onchange="setCircle()" type="number" id="distancia" name="distancia" value ="0" min="0" />
		
		<g:submitButton name="search" class="search" value="Buscar" />			
	</g:form>
	<br/>		
	<h1>Utilizar Geocodificación</h1>
		
    <div id="floating-panel">
      <input id="address" type="textbox" value="La Plata">
      <input id="buscar" type="button" value="Geocode">
    </div>
	    
	    
	    