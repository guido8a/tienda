package tienda

import seguridad.Empresa

class ImagenEmpresa {

    Empresa empresa
    String ruta
    String estado
    int orden

    static mapping = {
        table 'imep'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'imep__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            ruta column: 'imepruta'
            estado column: 'imepetdo'
            orden column: 'imepordn'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        ruta(size: 0..255, blank: false, nullable: false, attributes: [title: 'ruta'])
        estado(blank:  true, nullable: true, attributes: [title: 'estado'])
        orden(blank:  true, nullable: true, attributes: [title: 'orden'])
    }
}
