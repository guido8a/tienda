package utilitarios

import audita.Auditable

class Parametros implements Auditable {
    static auditable = true

    String banco
    String tipoCuenta
    String cuenta
    String ruc
    String mail
    String nombre

    static mapping = {
        table 'prax'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prax__id'
        id generator: 'identity'
        version false
        columns {
            banco column: 'praxbnco'
            tipoCuenta column: 'praxtpct'
            cuenta column: 'praxcnta'
            ruc column: 'prax_ruc'
            mail column: 'praxmail'
            nombre column: 'praxnmbr'
        }
    }
    static constraints = {
        banco(blank: false, nullable: false, attributes: [title: 'Pagado'])
        tipoCuenta(blank: false, nullable: false)
        cuenta(blank: false, nullable: false)
        ruc(blank: false, nullable: false)
        mail(blank: false, nullable: false)
        nombre(blank: false, nullable: false)
    }
}
