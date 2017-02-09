<div id="map"></div>
<script>
	var poly;
	var map;

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 16,
			center : {
				lat : -34.91957824,
				lng : -57.95464039
			}
		});

		
		poly = new google.maps.Polyline({
			strokeColor : '#000000',
			strokeOpacity : 1.0,
			strokeWeight : 3,
			editable : true,
			draggable : true
		});
		poly.setMap(map);

		map.addListener('rightclick', addLatLng);
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
