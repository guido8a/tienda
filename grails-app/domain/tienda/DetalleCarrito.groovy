package tienda

class DetalleCarrito {

    Carrito carrito
    Publicacion publicacion
    Producto producto
    Double precioUnitario
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
            producto column: 'prod__id'
            precioUnitario column: 'dtcrpcun'
            cantidad column: 'dtcrcntd'
            subtotal column: 'dtcrsbtt'
        }
    }
    static constraints = {
        carrito(blank: false, nullable: false)
        publicacion(blank: false, nullable: false)
        cantidad(blank:false, nullable: false)
        subtotal(blank:false, nullable: false)
        producto(blank:false, nullable: false)
        precioUnitario(blank:false, nullable: false)
    }
}
