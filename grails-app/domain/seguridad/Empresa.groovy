package seguridad

import sri.TipoEmpresa
import sri.TipoIdentificacion

class Empresa {

    String ruc
    String nombre
    String sigla
    String descripcion
    String mail             /* cratos es email*/
    String direccion
    String telefono
    Date fechaInicio
    Date fechaFin
    String observaciones
    String codigo
    String logo

    TipoEmpresa tipoEmpresa
    int numeroComprobanteDiario = 0
    int numeroComprobanteEgreso = 0
    int numeroComprobanteIngreso = 0
    String prefijoDiario
    String prefijoEgreso
    String prefijoIngreso
    String ordenCompra = '0'
    String establecimientos
    String tipoEmision

    String contribuyenteEspecial
    String obligadaContabilidad
    String razonSocial
    String ambiente

    String firma
    String clave
    TipoIdentificacion tipoIdentificacion

    static mapping = {
        table 'empr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'empr__id'
        id generator: 'identity'
        version false
        columns {
           ruc column: 'empr_ruc'
           nombre column: 'emprnmbr'
           sigla column: 'emprsgla'
           descripcion column: 'emprdscr'
            mail column: 'emprmail'
            direccion column: 'emprdire'
            telefono column: 'emprtelf'
            fechaInicio column: 'emprfcin'
            fechaFin column: 'emprfcfn'
            observaciones column: 'emprobsr'
            codigo column: 'emprcdgo'
            logo column: 'emprlogo'

            tipoEmpresa column: 'tpem__id'
            numeroComprobanteDiario column: 'emprncmd'
            numeroComprobanteEgreso column: 'emprncme'
            numeroComprobanteIngreso column: 'emprncmi'
            prefijoDiario column: 'emprprdr'
            prefijoEgreso column: 'emprpreg'
            prefijoIngreso column: 'emprprin'

            ordenCompra column: 'emprorcm'

            establecimientos column: 'emprestb'
            tipoEmision column: 'emprtpem'

            obligadaContabilidad column: 'emprcont'
            contribuyenteEspecial column: 'emprctes'
            razonSocial column: 'emprrzsc'
            ambiente column: 'emprambt'
            firma column: 'emprfrma'
            clave column: 'emprclve'
            tipoIdentificacion column: 'tpid__id'
        }
    }
    static constraints = {
        ruc(size:0..13,blank: false, nullable: false)
        nombre(size: 0..63, blank: false, nullable: false)
        sigla(size: 0..8, blank: false, nullable: false)
        descripcion(size: 0..255, blank: true, nullable: true)
        mail(size: 0..63, blank: true, nullable: true)
        direccion(size: 0..255,  blank: true, nullable: true)
        telefono(size: 0..63, blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        observaciones(size: 0..255, blank: true, nullable: true)
        codigo(size: 0..4, blank: true, nullable: true)
        logo(size: 0..255, blank: true, nullable: true)

        tipoEmpresa(blank: true, nullable: true, attributes: [title: 'Tipo de Empresa'])
        numeroComprobanteDiario(blank: true, nullable: true, size: 1..20)
        numeroComprobanteIngreso(blank: true, nullable: true, size: 1..20)
        numeroComprobanteEgreso(blank: true, nullable: true, size: 1..20)
        prefijoDiario(blank: true, nullable: true, size: 1..20)
        prefijoEgreso(blank: true, nullable: true, size: 1..20)
        prefijoIngreso(blank: true, nullable: true, size: 1..20)
        ordenCompra(blank: true, nullable: true, maxSize: 1)
        establecimientos(blank: false, nullable: false, maxSize: 63)
        tipoEmision(blank: false, nullable: false, maxSize: 1, inList: ['F', 'E'])
        obligadaContabilidad(blank: true, nullable: true, maxSize: 1)
        contribuyenteEspecial(blank: true, nullable: true)
        razonSocial(blank: true, nullable: true)
        ambiente(blank: true, nullable: true)
        firma(blank: true, nullable: true)
        clave(blank: true, nullable: true)

    }

    String toString() {
        return this.nombre
    }
}
