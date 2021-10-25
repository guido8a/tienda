package tienda

class Imagen {

    Producto producto
    String texto
    String ruta
    String estado
    String principal

    static mapping = {
        table 'imag'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'imag__id'
        id generator: 'identity'
        version false
        columns {
            producto column: 'prod__id'
            texto column: 'imagtxto'
            ruta column: 'imagruta'
            estado column: 'imagetdo'
            principal column: 'imagpncp'
        }
    }
    static constraints = {
        producto(blank: false, nullable: false)
        ruta(size: 0..255, blank: false, nullable: false, attributes: [title: 'ruta'])
        texto(blank:  true, nullable: true, attributes: [title: 'descripcion'])
        estado(blank:  true, nullable: true, attributes: [title: 'estado'])
        principal(blank:  true, nullable: true, attributes: [title: 'principal'])
    }
}
