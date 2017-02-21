# Aplicación WebGis de recorridos.

Se desarrolló un clon de la aplicación cualbondi.com.ar utilizando el framework web Grails 2.4.4. La cartografía es provista por la API de GoogleMaps para javascript. También se utilzo el servicio web Google Maps Geolocation API. Los recorridos se almacenan en una base de datos PostgreSQL 9.3 con la extensión Postgis 9.2. Cada recorrido se representa con un nombre y un objeto Multipoint.

## Manual de Usuario


Índice


1. Desarrollo
  1. Postgresql/Postgis
  2. Groovy/Grails Tool Suite (GGTS)

2. Funcionalidad
  1. Búsqueda de recorridos
  2. Crear recorridos
  3. Ver recorrido
  4. Eliminar recorridos
  5. Editar recorridos

### 1.i. Postgresql/Postgis

La base de datos corre sobre Postgresql. 

#### Preparación de la BBDD

Se crea un usuario en Postgre que accederá a la base de datos de la aplicación. El usuario se llama "daw_user" y el password debe ser '1234'

	~$ sudo su -c "createuser -d -P -R -S daw_user" postgres
	#Enter password for new role:
	#Enter it again:

#### Crear la BBDD

Se crea la base de datos en Postgre que usará DSpace. El dueño de la misma es "daw_user".


	~$ sudo su -c "createdb -U daw_user -O daw_user -E UNICODE recorridos -h localhost" postgres
	#password (de daw_user)
	

Postgis se pueden descargar desde http://postgis.net/install/ segun el SO que utilicemos. Una vez instalado es necesario instalar la extensión en la base de datos 'recorridos'. Para eso debemos conectarnos a 'recorridos' con a través del comando

	~$ psql -d recorridos

y luego instalamos POSTGIS con 

	CREATE EXTENSION postgis;

### 1.ii. Groovy/Grails Tool Suite

El desarrollo de la aplicación fue desarrollado en Groovy/Grails Tool Suite (GGTS). https://spring.io/tools/ggts. 

GGTS es un entorno de desarrollo basado en Eclipse optimizado para desarrollar, depurar y ejecutar aplicaciones Groovy y Grails. La versión de Grails por defecto es la 2.4.4 y fue la utilizada para el desarrollo del sistema.

Para utilizar la aplicación importamos el proyecto grails en https://github.com/PabloDeAlbu/daw-final y luego ejecutamos el comando Grails 'run-app'

> NOTA: notar que las relaciones/tablas en la BBDD se crean (automáticamente) cuando se inicia por primera vez la aplicación de Grails.

La cartografía es provista por la API de GoogleMaps para javascript. Esta API también nos provee de marcadores y la funcionalidad para trazar lineas entre coordenadas. También se utilza el servicio web de Google Maps para Geocoding que traduce ubicaciones en texto a coordenadas. 

### 2. Funcionalidad

La aplicación permite al usuario relizar un ABM de recorridos. Cada recorrido esta compuesto por un nombre y un objeto 'Multipoint'. Un objeto 'Multipoint' esta compuesta por objetos 'Point' a su vez generados por objetos 'Coordinate'. 

#### 2.i. Búsqueda de recorridos

La búsqueda se realiza en `{$app}/` (siendo `{$app}` la URL de la aplicación). Para buscar un recorrido es necesario 3 datos: Una origen, un destino y una distancia mínima a recorrer caminando. Para agregar una coordenada al formulario de búsqueda se puede hacer click derecho en el mapa o completar el campo `"Utilizar Geocode"` y hacer click en el botón `"Geocode"`. Sea cual fuese la forma mediante la cual se agrega una coordenada, primero se agrega el origen y luego el destino. Para modificar el valor de una coordenada alcanza con hacer click sobre la marca de la posición en el mapa y hacer un drag a la nueva ubicación.

![1 index](https://cloud.githubusercontent.com/assets/11927172/23177516/d08d55bc-f845-11e6-9773-3545acb78b23.png)

Tambien es posible listar todos los recorridos accediendo a `{$app}/recorrido/index` o a través del link provisto en el navbar

En caso de que una busqueda no arroje ningún resultado basadondose en la distancia establecida por el usuario, se procedera a hacer una nueva búsqueda con el valor de la distancia duplicada, aclarandose que estos resultados alternativos son las mejores aproximaciones. 

#### 2.ii. Crear recorridos

Para dar de alta un recorrido se accede a `{$app}/recorrido/create`. Un recorrido está compuesto por un nombre y una serie de coordenadas que se van agregando en el mapa haciendo click derecho. Cada coordenada puede ser editada clickeando sobre su posición y realizando un drag a la nueva ubicación. 

![4 new](https://cloud.githubusercontent.com/assets/11927172/23177514/d08cbe22-f845-11e6-9401-af4c608ae65e.png)

#### 2.iii. Ver recorridos

Para ver en detalle un recorrido se puede hacer un GET a `{$app}/recorrido/{$id}` donde `{$id}` es el id del recorrido. 

![5 show](https://cloud.githubusercontent.com/assets/11927172/23177513/d08c8114-f845-11e6-8633-121d7deb5505.png)

También es posible acceder a la vista del recorrido desde el botón `'Ver'` en la lista de recorridos

![2 list](https://cloud.githubusercontent.com/assets/11927172/23177515/d08d468a-f845-11e6-9141-f322b8bb8660.png)

#### 2.iv. Eliminar recorridos

Se puede elminar un recorrido haciendo click en el botón `Eliminar` correspondiente a un recorrido cuando se listan estos mismos.

#### 2.v. Editar recorridos

Para ver en editar un recorrido se puede hacer un GET a `{$app}/recorrido/edit/{$id}` donde `{$id}` es el id del recorrido. También es posible acceder a la vista de edición del recorrido desde el botón `'Editar'` en la lista de recorridos. Una vez en la vista de edición podemos arrastar las coordenadas a nuevas posiciones o agregar nuevos puntos haciendo click en el punto sombreado sobre la linea que existe entre dos coordenadas y luego arrastrandolo hacia otra posición. También es posbile arrastrar todo el recorrido a una nueva ubicación desplazando todos los puntos que lo conforman haciendo click sobre el recorrido y moviendolo a otra ubicación.

![6 edit](https://cloud.githubusercontent.com/assets/11927172/23177518/d0b32fe4-f845-11e6-991d-3928e4ccfa0f.png)
