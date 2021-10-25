package tienda

class Atributo {

    Producto producto
    String descripcion
    Integer orden

    static mapping = {
        table 'atrb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'atrb__id'
        id generator: 'identity'
        version false
        columns {
            producto column: 'prod__id'
            descripcion column: 'atrbdscr'
            orden column: 'atrbordn'
        }
    }
    static constraints = {
        producto(blank:false, nullable: false)
        descripcion(size: 0..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true)
    }
}
