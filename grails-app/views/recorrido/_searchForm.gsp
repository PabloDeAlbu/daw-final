		<g:form url="[resource:recorridoInstance, action:'search', controller:'recorrido']" onsubmit="loadCoordinates()">
			<g:hiddenField type="text" id="points" name="points"/>
			<span>Origen:</span> <g:field type="text" required="" id="origenX" name="origenX"/><g:field  required=""  type="text" id="origenY" name="origenY"/>
			<span>Destino:</span> <g:field type="text" required="" id="destinoX" name="destinoX"/><g:field required="" type="text" id="destinoY" name="destinoY"/>
			<span>Distancia:</span> <g:field onchange="setCircle()" type="number" id="distancia" name="distancia" value ="0" min="0" />
			
			<g:submitButton name="search" class="search" value="Buscar" />			
		</g:form>
			
	    <div id="floating-panel">
	      <input id="address" type="textbox" value="La Plata">
	      <input id="buscar" type="button" value="Geocode">
	    </div>
	    
	    
	    