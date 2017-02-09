Implementación de una aplicación WebGis

Se desarrolló un clon de la aplicación cualbondi.com.ar utilizando el framework web Grails.
La cartografía es provista por la API de GoogleMaps para javascript. También se utilzo el servicio web Google Maps Geolocation API.
Los recorridos se almacenan en una base de datos PostgreSQL con la extensión Postgis. 
Cada recorrido se representa con un nombre y un objeto MULTIPOINT.

La aplicación esta configurada para utilizar una base de datos con nombre 'daw_user' y password '1234'.

