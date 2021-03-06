
<div id="map"></div>
<script>
	var poly;
	var map;

	function initMap() {

		var puntos = document.getElementById('puntos').innerHTML.replace(/,\sNaN|\(|\)|\s/g, '').slice(0, -1).split(';')
		
		var path = [];
		puntos.forEach(function(entry) {
			var nuevo = entry.split(',');
			path.push(new google.maps.LatLng(nuevo[0], nuevo[1]));
		});

		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 16,
			center : path[0]
		});
		poly = new google.maps.Polyline({
			path : path,
			strokeColor : '#000000',
			strokeOpacity : 1.0,
			strokeWeight : 3,
			editable : true,
			draggable : true
		});
		poly.setMap(map);

	}


	function addLatLng(event) {
		var path = poly.getPath();
		path.push(event.latLng);
	}
	function loadCoordinates() {
		var str = '';
		poly.getPath().getArray().forEach(function(entry) {
			e = entry.toString().slice(1, -1)
			str += e + ";";
		});
		document.getElementById('points').value = str.slice(0, -1);
	}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9_mf2ukOd6NpNP21ePA-8K9x_8H8er2A&callback=initMap"></script>
