package tienda

class Comentario {

    Cliente cliente
    Publicacion publicacion
    String descripcion
    Integer calificacion
    Date fecha
    String estado

    static mapping = {
        table 'cmtr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cmtr__id'
        id generator: 'identity'
        version false
        columns {
            cliente column: 'clnt__id'
            publicacion column: 'publ__id'
            descripcion column: 'cmtrdscr'
            calificacion column: 'cmtrclfc'
            fecha column: 'cmtrfcha'
            estado column: 'cmtretdo'
        }
    }
    static constraints = {
        cliente(blank: false, nullable: false)
        publicacion(blank: false, nullable: false)
        descripcion(size: 0..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        calificacion(blank: true, nullable: true)
        fecha(blank: true, nullable: true)
        estado(size: 0..1, blank: true, nullable: true)
    }
}
