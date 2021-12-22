package sri

import inventario.Bodega
import sri.Proceso
import tienda.Publicacion

class DetalleFactura implements Serializable {

//    Item item
    Publicacion publicacion
    Proceso proceso
    CentroCosto centroCosto
    Bodega bodega

    double cantidad
    double precioUnitario
    double descuento
    String observaciones

    static auditable = true

    static mapping = {
        table 'dtfc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtfc__id'
        id generator: 'identity'
        version false
        columns {
            publicacion column: 'publ__id'
            proceso column: 'prcs__id'
            centroCosto column: 'cncs__id'
            bodega column: 'bdga__id'

            cantidad column: 'dtfccntd'
            precioUnitario column: 'dtfcpcun'
            descuento column: 'dtfcdsct'
            observaciones column: 'dtfcobsr'
        }
    }
    static constraints = {
        publicacion(blank: false, nullable: false, attributes: [title: 'item'])
        proceso(blank: false, nullable: false, attributes: [title: 'proceso'])
        centroCosto(blank: true, nullable: true, attributes: [title: 'centro de costo'])
        bodega(blank: true, nullable: true, attributes: [title: 'bodega'])

        cantidad(blank: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, nullable: false, attributes: [title: 'precioUnitario'])
        descuento(blank: false, nullable: false, attributes: [title: 'descuento'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
    }
}