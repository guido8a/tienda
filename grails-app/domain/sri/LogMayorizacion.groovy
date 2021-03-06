package sri

class LogMayorizacion{

    Date fecha = new Date()
    Comprobante comprobante
    seguridad.Persona usuario
    String resultado
    String tipo

    static mapping = {
        table 'logm'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'logm__id'
        id generator: 'identity'
        version false
        columns {
            fecha column: 'logmfcha'
            comprobante column: 'cmpr__id'
            usuario column: 'prsn__id'
            resultado column: 'logmresl'
            tipo column: 'logmtipo'
        }
    }
    static constraints = {
        resultado(blank: true,nullable: true,size:1..255)
        tipo(blank: false,nullable: false,size: 1..1)
    }
}
