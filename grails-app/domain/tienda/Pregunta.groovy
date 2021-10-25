package tienda

class Pregunta {

    Producto producto
    String texto
    Date fecha
    String respuesta
    Date fechaRespuesta

    static mapping = {
        table 'preg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'preg__id'
        id generator: 'identity'
        version false
        columns {
            producto column: 'prod__id'
            texto column: 'pregtxto'
            fecha column: 'pregfcha'
            respuesta column: 'pregresp'
            fechaRespuesta column: 'pregfcrp'
        }
    }
    static constraints = {
        producto(blank: false, nullable: false)
        texto(size: 0..255, blank: false, nullable: false, attributes: [title: 'descripcion'])
        fecha(blank: true, nullable: true)
        respuesta(size: 0..255, blank: true, nullable: true)
        fechaRespuesta(blank: true, nullable: true)
    }
}
