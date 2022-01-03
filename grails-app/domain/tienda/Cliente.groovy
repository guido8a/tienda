package tienda

import retenciones.Pais
import seguridad.Empresa
import sri.TipoIdentificacion
import sri.TipoPersona

class Cliente {

    TipoPersona tipoPersona
    Empresa empresa
    TipoIdentificacion tipoIdentificacion
    Pais pais
    String ruc
    String nombre
    String apellido
    String direccion
    String mail
    String telefono
    Date fecha
//    String login
    String password
    String relacion

    static mapping = {
        table 'clnt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'clnt__id'
        id generator: 'identity'
        version false
        columns {
            tipoPersona column: 'tppr__id'
            empresa column: 'empr__id'
            tipoIdentificacion column: 'tpid__id'
            pais column: 'pais__id'
            ruc column: 'clnt_ruc'
            nombre column: 'clntnmbr'
            apellido column: 'clntapll'
            direccion column: 'clntdire'
            mail column: 'clntmail'
            telefono column: 'clnttelf'
            fecha column: 'clntfcha'
            login column: 'clntlogn'
            password column: 'clntpass'
            relacion column: 'clntrlcn'
        }
    }
    static constraints = {
        nombre(size:0..31, blank: false, nullable: false, attributes: [title: 'nombre'])
        apellido(size:0..31, blank: true, nullable: true, attributes: [title: 'apellido'])
        direccion(size:0..255, blank: true, nullable: true, attributes: [title: 'direccion'])
        mail(size:0..63, blank: true, nullable: true, attributes: [title: 'mail'])
        telefono(size:0..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        login(size: 0..255, blank: true, nullable: true, attributes: [title: 'login'])
        password(size: 0..63, blank: true, nullable: true, attributes: [title: 'password'])
        relacion(size: 0..2, blank: true, nullable: true, attributes: [title: 'relacion'])
        tipoPersona(blank: true, nullable: true, attributes: [title: 'relacion'])
        pais(blank: true, nullable: true, attributes: [title: 'pais'])
        ruc(blank: true, nullable: true, attributes: [title: 'pais'])
        empresa(blank: true, nullable: true, attributes: [title: 'pais'])
        tipoIdentificacion(blank: true, nullable: true, attributes: [title: 'pais'])
    }
}
