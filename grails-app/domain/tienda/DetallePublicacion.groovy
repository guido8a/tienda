package tienda

class DetallePublicacion {

    Publicacion publicacion
    String tipo
    String descripcion
    String valor
    String principal

    static mapping = {
        table 'dtpb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtpb__id'
        id generator: 'identity'
        version false
        columns {
            publicacion column: 'publ__id'
            tipo column: 'dtpbtipo'
            descripcion column: 'dtpbdscr'
            valor column: 'dtpbvlor'
            principal column: 'dtpbpncp'
        }
    }
    static constraints = {
        publicacion(blank: false, nullable: false)
        descripcion(size: 0..127, blank: false, nullable: false, attributes: [title: 'descripcion'])
        valor(blank:  true, nullable: true, attributes: [title: 'descripcion'])
        tipo(blank:  true, nullable: true, attributes: [title: 'descripcion'])
        principal(blank:  true, nullable: true, attributes: [title: 'principal'])
    }
}
