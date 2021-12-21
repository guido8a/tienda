package sri

class ProcesoFormaDePago {

    Proceso proceso
    TipoPago tipoPago
    int plazo = 0
    Double valor = 0

    static mapping = {
        table 'prfp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prfp__id'
        id generator: 'identity'
        version false
        columns {
            proceso column: 'prcs__id'
            tipoPago column: 'tppg__id'
            plazo column: 'prfpplzo'
            valor column: 'prfpvlor'
        }
    }

    static constraints = {
        proceso(blank:false,nullable: false)
        tipoPago(blank:false,nullable: false)
        plazo(blank:false,nullable: false)
        valor(blank:false,nullable: false)
    }
}
