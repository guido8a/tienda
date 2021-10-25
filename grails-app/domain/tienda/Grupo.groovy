package tienda

class Grupo {

    Subcategoria subcategoria
    String descripcion
    Integer orden

    static mapping = {
        table 'grpo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'grpo__id'
        id generator: 'identity'
        version false
        columns {
            subcategoria column: 'sbct__id'
            descripcion column: 'grpodscr'
            orden column: 'grpoordn'
        }
    }
    static constraints = {
        subcategoria(blank: false, nullable: false)
        descripcion(size: 0..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true)
    }
}
