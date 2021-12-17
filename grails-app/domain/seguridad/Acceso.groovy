package seguridad

class Acceso {

    Empresa empresa
    Accn accion
    String url
    Date fecha
    String desde

    static mapping = {
        table 'accs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'accs__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            accion column: 'accn__id'
            fecha column: 'accsfcha'
            desde column: 'accsdsde'
            url column: 'accs_url'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        accion(blank: false, nullable: false)
        url(blank:  true, nullable: true)
        fecha(blank:true, nullable: true)
        desde(blank:true, nullable: true)

    }
}
