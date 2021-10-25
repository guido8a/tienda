package tienda

class Subcategoria {

    Categoria categoria
    String descripcion
    Integer orden

    static mapping = {
        table 'sbct'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbct__id'
        id generator: 'identity'
        version false
        columns {
            categoria column: 'ctgr__id'
            descripcion column: 'sbctdscr'
            orden column: 'sbctordn'
        }
    }
    static constraints = {
        categoria(blank: false, nullable: false)
        descripcion(size: 0..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true)
    }
}
