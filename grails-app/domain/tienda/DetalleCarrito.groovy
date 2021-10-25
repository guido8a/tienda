package tienda

class DetalleCarrito {

    Carrito carrito
    Publicacion publicacion
    int cantidad
    Double subtotal

    static mapping = {
        table 'dtcr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtcr__id'
        id generator: 'identity'
        version false
        columns {
            carrito column: 'crro__id'
            publicacion column: 'publ__id'
            cantidad column: 'dtcrcntd'
            subtotal column: 'dtcrsbtt'
        }
    }
    static constraints = {
        carrito(blank: false, nullable: false)
        publicacion(blank: false, nullable: false)
        cantidad(blank:false, nullable: false)
        subtotal(blank:false, nullable: false)
    }
}
