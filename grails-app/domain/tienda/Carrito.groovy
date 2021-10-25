package tienda

class Carrito {

    Cliente cliente
    Date fecha
    int cantidad
    Double subtotal
    int ticket

    static mapping = {
        table 'crro'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crro__id'
        id generator: 'identity'
        version false
        columns {
            cliente column: 'clnt__id'
            fecha column: 'crrofcha'
            cantidad column: 'crrocntd'
            subtotal column: 'crrosbtt'
            ticket column: 'crrotikt'
        }
    }
    static constraints = {
        cliente(blank: false, nullable: false)
        fecha(blank:true, nullable: true)
        cantidad(blank:false, nullable: false)
        subtotal(blank:false, nullable: false)
        ticket(blank:true, nullable: true)
    }
}
