package seguridad

import tienda.Cliente

class Empresa {

    String ruc
    String nombre
    String sigla
    String descripcion
    String mail
    String direccion
    String telefono
    Date fechaInicio
    Date fechaFin
    String observaciones
    String codigo
    String logo

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
      }
}
