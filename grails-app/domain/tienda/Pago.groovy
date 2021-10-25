package tienda

class Pago {

    Carrito carrito
    Date fecha
    double valor
    String tipo
    Date fechaInicio
    Date fechaFin
    String ruta
    String estado
    String observaciones

    static mapping = {
        table 'pago'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pago__id'
        id generator: 'identity'
        version false
        columns {
            carrito column: 'crro__id'
            fecha column: 'pagofcha'
            valor column: 'pagovlor'
            tipo column: 'pagotipo'
            fechaInicio column: 'pagofcin'
            fechaFin column: 'pagofcfn'
            ruta column: 'pagoruta'
            estado column: 'pagoetdo'
            observaciones column: 'pagoobsr'
        }
    }
    static constraints = {
        carrito(blank: false, nullable: false)
        tipo(blank: false, nullable: false)
        valor(blank: false, nullable: false)
        fecha(blank:true, nullable: true)
        fechaInicio(blank:true, nullable: true)
        fechaFin(blank:true, nullable: true)
        ruta(blank:true, nullable: true)
        estado(blank:true, nullable: true)
        observaciones(blank:true, nullable: true)
    }
}
