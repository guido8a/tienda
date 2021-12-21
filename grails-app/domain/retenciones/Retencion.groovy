package retenciones

import retenciones.Pais
import seguridad.Empresa
import sri.DocumentoEmpresa
import sri.Proceso
import sri.Proveedor

class Retencion implements Serializable {

    Proceso proceso
    ConceptoRetencionImpuestoRenta conceptoRIRBienes
    ConceptoRetencionImpuestoRenta conceptoRIRServicios
    DocumentoEmpresa documentoEmpresa
    PorcentajeIva pcntIvaBienes
    PorcentajeIva pcntIvaServicios

    Empresa empresa
    Proveedor proveedor
    String direccion
    Date fecha

    int numero
    String numeroComprobante
    String persona
    String telefono
    String ruc
    Date fechaEmision

    double baseIvaBienes = 0
    double ivaBienes = 0
    double baseIvaServicios = 0
    double ivaServicios = 0
    double baseRenta = 0
    double renta = 0
    double baseRentaServicios = 0
    double rentaServicios = 0
    String estado = 'N'


    static mapping = {
        table 'rtnc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rtnc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rtnc__id'
            proceso column: 'prcs__id'
            conceptoRIRBienes column: 'crir__id'
            conceptoRIRServicios column: 'crirsrvc'
            documentoEmpresa column: 'fcdt__id'
            empresa column: 'empr__id'
            proveedor column: 'prve__id'

            direccion column: 'rtncdire'
            fecha column: 'rtncfcha'
            numero column: 'rtncnmro'
            numeroComprobante column: 'rtncnmcp'
            persona column: 'rtncprsn'
            telefono column: 'rtnctelf'
            ruc column: 'rtnc_ruc'
            fechaEmision column: 'rtncfcem'

            pcntIvaBienes column: 'pciv__id'
            baseIvaBienes column: 'rtncbsiv'
            ivaBienes column: 'rtnc_iva'
            pcntIvaServicios column: 'pcivsrvc'
            baseIvaServicios column: 'rtncbisr'
            ivaServicios column: 'rtncivsr'

            baseRenta column: 'rtncbsrt'
            renta column: 'rtncrnta'
            baseRentaServicios column: 'rtncbrsr'
            rentaServicios column: 'rtncrnsr'
            estado column: 'rtncetdo'
        }
    }

    static constraints = {
        conceptoRIRBienes(blank: true, nullable: true)
        conceptoRIRServicios(blank: true, nullable: true)
        documentoEmpresa (blank: true, nullable: true)

        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        numeroComprobante(blank: true, nullable: true)
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        ruc(blank: false, nullable: false, size: 10..13)
        fechaEmision (blank: false, nullable: false)

        pcntIvaBienes(blank: true, nullable: true)
        baseIvaBienes(blank: true, nullable: true)
        ivaBienes(blank: true, nullable: true)
        pcntIvaServicios(blank: true, nullable: true)
        baseIvaServicios(blank: true, nullable: true)
        ivaServicios(blank: true, nullable: true)

        baseRenta(blank: true, nullable: true)
        renta(blank: true, nullable: true)
        baseRentaServicios(blank: true, nullable: true)
        rentaServicios(blank: true, nullable: true)

        estado(blank: false, nullable: false)

    }

    def getTotal() {
        this.renta + this.rentaServicios + this.ivaBienes + this.ivaServicios
    }

    def getHayIva() {
        (this.ivaBienes + this.ivaServicios) > 0
    }

    def getHayRenta() {

        (this.renta + this.rentaServicios) > 0
    }

}