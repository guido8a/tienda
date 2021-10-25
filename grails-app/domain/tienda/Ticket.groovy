package tienda

class Ticket {

    Pago pago
    Carrito carrito
    int cantidad

    static mapping = {
        table 'tikt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tikt__id'
        id generator: 'identity'
        version false
        columns {
            pago column: 'pago__id'
            carrito column: 'crro__id'
            cantidad column: 'tiktcntd'
        }
    }
    static constraints = {
        pago(blank: false, nullable: false)
        carrito(blank: false, nullable: false)
        cantidad(blank: false, nullable: false)
    }

}
