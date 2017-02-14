package recorridos



import static org.springframework.http.HttpStatus.*
import com.vividsolutions.jts.geom.GeometryFactory
import com.vividsolutions.jts.geom.MultiPoint
import com.vividsolutions.jts.geom.Point
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RecorridoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    GeometryFactory factory = new com.vividsolutions.jts.geom.GeometryFactory()
	    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Recorrido.list(params), model:[recorridoInstanceCount: Recorrido.count()]
    }

    def search(Recorrido recorridoInstance) {
		if (params.origenX == '' | params.destinoX == '' | params.origenX == null | params.destinoX == null ){
			flash.message = "Agregar coordenadas de origen y destino"
			redirect(uri: "/")
			return
		}
		def coordenadaOrigen = new com.vividsolutions.jts.geom.Coordinate(params.origenX.toDouble(),params.origenY.toDouble())
		def coordenadaDestino = new com.vividsolutions.jts.geom.Coordinate(params.destinoX.toDouble(),params.destinoY.toDouble())
		
		def origen= factory.createPoint(coordenadaOrigen)
		def destino = factory.createPoint(coordenadaDestino)
		def distancia = params.distancia.toDouble()
		def recorridos = searchPointInRecorridos(origen, destino, distancia)
		
		if (recorridos.empty){
			recorridos = searchPointInRecorridos(origen, destino, distancia * 2)
			if (distancia < 100){
				distancia = 200
			}
			else {
				distancia = distancia * 2
			}

			flash.message = "No se han encontrado resultados para la distancia ingresada. Los siguientes resultados son los que mas acercan al criterio establecido con anterioridad"
			if (recorridos.empty){
			flash.message = "No se han encontrado resultados para la distancia ingresada"
				redirect(uri: "/")
				return
			}
		}
        respond recorridos, view:'list'
    }

	def show(Recorrido recorridoInstance) {
        def size = recorridoInstance.points.getNumPoints()
        def coordinates = new com.vividsolutions.jts.geom.Coordinate[size]
        
        coordinates.eachWithIndex { it, index ->
            coordinates.putAt(index, recorridoInstance.points.getCoordinate(index))
        }
        render (view:'show', model:[array:coordinates, recorridoInstance:recorridoInstance])
    }

    def create() {
        respond new Recorrido(params)
    }

    @Transactional
    def save(Recorrido recorrido) {

		if (params.points == '' | params.nombre == '' | params.points == null | params.nombre == null ){
			flash.message = "Agregar nombre del nuevo recorrido, coordenadas de origen y destino"
			redirect(uri: "/recorrido/create")
			return
		}


        def recorridoInstance = new Recorrido(points: generateMultiPointsFromParam(params.points), nombre:params.nombre)
        if (recorridoInstance == null) {
            notFound()
            return
        }
        if (recorridoInstance == null) {
            notFound()
            return
        }

        if (recorridoInstance.hasErrors()) {
            respond recorridoInstance.errors, view:'create'
            return
        }

        recorridoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'recorrido.label', default: 'Recorrido'), recorridoInstance.id])
                redirect recorridoInstance
            }
            '*' { respond recorridoInstance, [status: CREATED] }
        }
    }

    def edit(Recorrido recorridoInstance) {
    def size = recorridoInstance.points.getNumPoints()
        def coordinates = new com.vividsolutions.jts.geom.Coordinate[size]
        
        coordinates.eachWithIndex { it, index ->
            coordinates.putAt(index, recorridoInstance.points.getCoordinate(index))
        }
        render (view:'edit', model:[array:coordinates, recorridoInstance:recorridoInstance])
    }

    @Transactional
    def update() {
		def recorridoInstance = Recorrido.get(params.id)
		recorridoInstance.setNombre(params.nombre)
        recorridoInstance.setPoints(generateMultiPointsFromParam(params.points))
        if (recorridoInstance == null) {
            notFound()
            return
        }

        if (recorridoInstance.hasErrors()) {
            render recorridoInstance.errors
        }

        
        recorridoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Recorrido.label', default: 'Recorrido'), recorridoInstance.id])
                redirect recorridoInstance
            }
            '*'{ respond recorridoInstance, [status: OK] }
        }

    }

    @Transactional
    def delete(Recorrido recorridoInstance) {

        if (recorridoInstance == null) {
            notFound()
            return
        }

        recorridoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Recorrido.label', default: 'Recorrido'), recorridoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'recorrido.label', default: 'Recorrido'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    protected generateMultiPointsFromParam(param){
        def array = param.split(';')
        Point[] points = new com.vividsolutions.jts.geom.Point[array.length]
        array.eachWithIndex { it, index ->
            def point = it.split(',')
            def coordenada = new com.vividsolutions.jts.geom.Coordinate(point[0].toDouble(),point[1].toDouble())
            points.putAt(index, factory.createPoint(coordenada))
        }
        return new MultiPoint(points, factory)

    }
	protected searchPointInRecorridos(origen, destino, distancia){
		def recorridos = Recorrido.getAll()
		def recorridosWithPoint = []
		recorridos.eachWithIndex { recorrido, index ->	
			
			recorrido.getPoints().geometries.each{ points ->
				points.each { point ->
					if (distancia - (point.distance(origen) * 100000) > 0){
						recorridos[index].getPoints().geometries.each{ pointsD ->
							pointsD.each { pointD ->
								if (distancia - (pointD.distance(destino) * 100000) > 0){
									if (!recorridosWithPoint.contains(recorridos[index])){
										recorridosWithPoint << recorridos[index]
									}
								}
							}	
						}
					}
				}
			}
		}
		return recorridosWithPoint

	}
	
}
