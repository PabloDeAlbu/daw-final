<div id="map" style="width:750px; height:500px"></div>


<script>
	var poly;
	var map;
	var origen = null;
	var origenCircle = null;
	var destino = null;
	var destinoCircle = null;

	function initMap() {
		var geocoder = new google.maps.Geocoder();
		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 15,
			center : {
				lat : -34.91957824,
				lng : -57.95464039
			}
		});

		
		map.addListener('rightclick', addOrigin);
		document.getElementById('buscar').addEventListener('click', function() {
			geocodeAddress(geocoder, map);
		});
	}


	function geocodeAddress(geocoder, resultsMap) {
	  var address = document.getElementById('address').value;
	  geocoder.geocode({'address': address}, function(results, status) {
	    if (status === google.maps.GeocoderStatus.OK) {
	      resultsMap.setCenter(results[0].geometry.location);

			if (origen == null){
				origen = new google.maps.Marker({
			        position: results[0].geometry.location,
			        map: resultsMap,
					label: 'origen',
					draggable:true
				})
				origen.addListener('position_changed', updateMarkers);
				origen.setMap(map);
				document.getElementById('origenX').value = origen.getPosition().lat();
				document.getElementById('origenY').value = origen.getPosition().lng();
				origenCircle = new google.maps.Circle({
				      strokeColor: '#FF0000',
				      strokeOpacity: 0.8,
				      strokeWeight: 2,
				      fillColor: '#FF0000',
				      fillOpacity: 0.35,
				      map: map,
				      center: origen.getPosition(),
				      radius: Number(document.getElementById('distancia').value)
				});
				setCircle();
			}else if (destino == null){
				destino = new google.maps.Marker({
					position: results[0].geometry.location,
			        map: resultsMap,
					label: 'destino',
					draggable:true
				});
				destino.addListener('position_changed', updateMarkers);
				document.getElementById('destinoX').value = destino.getPosition().lat();
				document.getElementById('destinoY').value = destino.getPosition().lng();
				destino.setMap(map)
							destinoCircle = new google.maps.Circle({
			      strokeColor: '#FF0000',
			      strokeOpacity: 0.8,
			      strokeWeight: 2,
			      fillColor: '#FF0000',
			      fillOpacity: 0.35,
			      map: map,
			      center: destino.getPosition(),
			      radius: Number(document.getElementById('distancia').value)
				});
				setCircle();
			}
	    } else {
	      alert('Geocode was not successful for the following reason: ' + status);
	    }
	  });
	}
	
	function geocode(sel) {
		alert(sel.id);
	}
	
	function setCircle() {
		if (origenCircle != null){
			origenCircle.setCenter(origen.getPosition());
			origenCircle.setRadius(Number(document.getElementById('distancia').value))
		}
		if (destinoCircle != null){
			destinoCircle.setCenter(destino.getPosition());
			destinoCircle.setRadius(Number(document.getElementById('distancia').value))
		}
	}

	function addOrigin(event) {
		if (origen == null){
			origen = new google.maps.Marker({
				position: event.latLng,
				label: 'origen',
				draggable:true
			})
			origen.addListener('position_changed', updateMarkers);
			origen.setMap(map);
			document.getElementById('origenX').value = origen.getPosition().lat();
			document.getElementById('origenY').value = origen.getPosition().lng();
			origenCircle = new google.maps.Circle({
			      strokeColor: '#FF0000',
			      strokeOpacity: 0.8,
			      strokeWeight: 2,
			      fillColor: '#FF0000',
			      fillOpacity: 0.35,
			      map: map,
			      center: origen.getPosition(),
			      radius: Number(document.getElementById('distancia').value)
			});
		}else if (destino == null){
			destino = new google.maps.Marker({
				position: event.latLng,
				label: 'destino',
				draggable:true
			});
			destino.addListener('position_changed', updateMarkers);
			document.getElementById('destinoX').value = destino.getPosition().lat();
			document.getElementById('destinoY').value = destino.getPosition().lng();
			destino.setMap(map)
			destinoCircle = new google.maps.Circle({
			      strokeColor: '#FF0000',
			      strokeOpacity: 0.8,
			      strokeWeight: 2,
			      fillColor: '#FF0000',
			      fillOpacity: 0.35,
			      map: map,
			      center: destino.getPosition(),
			      radius: Number(document.getElementById('distancia').value)
			});
		}
	}

	function updateMarkers(event) {
		document.getElementById('origenX').value = origen.getPosition().lat();
		document.getElementById('origenY').value = origen.getPosition().lng();

		if (destino != null){
			document.getElementById('destinoX').value = destino.getPosition().lat();
			document.getElementById('destinoY').value = destino.getPosition().lng();
		}
		setCircle();
	}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9_mf2ukOd6NpNP21ePA-8K9x_8H8er2A&callback=initMap"></script>
