package tienda

import seguridad.Empresa

class Marca {

    Empresa empresa
    String descripcion

    static mapping = {
        table 'mrca'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mrca__id'
        id generator: 'identity'
        version false
        columns {
           empresa column: 'empr__id'
           descripcion column: 'mrcadscr'
        }
    }
    static constraints = {
        descripcion(size: 0..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
