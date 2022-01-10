package inventario

import sri.Proceso
import tienda.Producto


class Kardex {

    Proceso proceso
    Bodega bodega
    Producto producto
    double cantidad
    double precioUnitario
    Date fecha
    double existencias
    double pc
    String tipo

    static mapping = {
        table 'krdx'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'krdx__id'
        id generator: 'identity'
        version false

        columns {
            proceso column: 'prcs__id'
            bodega column: 'bdga__id'
            producto column: 'prod__id'
            cantidad column: 'krdxcntd'
            precioUnitario column: 'krdxpcun'
            fecha column: 'krdxfcha'
            existencias column: 'krdxexst'
            pc column: 'krdxpccs'
            tipo column: 'krdxtipo'
        }
    }
    static constraints = {
        producto(blank: true, nullable: true, attributes: [title: 'Item'])
        proceso(blank: true, nullable: true,attributes: [title: 'Proceso'])
        bodega(blank: true, nullable: true, attributes: [title: 'Bodega'])
        cantidad(blank: true, nullable: true)
        precioUnitario(blank: true, nullable: true)
        existencias(blank: true, nullable: true)
        tipo(blank: true, nullable: true)
        pc(blank: true, nullable: true)
        fecha(blank: true, nullable: true)
    }
}
