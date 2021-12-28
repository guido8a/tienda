package tienda

import seguridad.Empresa

class TipoIva {

    String descripcion

    static mapping = {
        table 'tpiv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpiv__id'
        id generator: 'identity'
        version false
        columns {
           descripcion column: 'tpivdscr'
        }
    }
    static constraints = {
        descripcion(size: 0..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
