package tienda

class Categoria {

    String descripcion
    Integer orden

    static mapping = {
        table 'ctgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ctgr__id'
        id generator: 'identity'
        version false
        columns {
           descripcion column: 'ctgrdscr'
           orden column: 'ctgrordn'
        }
    }
    static constraints = {
        descripcion(size: 0..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true)
    }
}
