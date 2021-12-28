package tienda

import seguridad.Persona

class Producto {

    Persona persona
    TipoIva tipoIva
    Marca marca
    Grupo grupo
    String codigo
    String titulo
    String subtitulo
    String texto
    String estado
    Date fecha
    Date fechaModificacion
    String destacado
    String nuevo
    Double precioUnidad = 0
    Double precioMayor = 0
    Double ice = 0

    static mapping = {
        table 'prod'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prod__id'
        id generator: 'identity'
        version false
        columns {
            persona column: 'prsn__id'
            tipoIva column: 'tpiv__id'
            marca column: 'mrca__id'
            grupo column: 'grpo__id'
            codigo column: 'prodcdgo'
            titulo column: 'prodtitl'
            subtitulo column: 'prodsbtl'
            texto column: 'prodtxto'
            estado column: 'prodetdo'
            fecha column: 'prodfcha'
            fechaModificacion column: 'prodfcmd'
            destacado column: 'proddstc'
            nuevo column: 'prodnuvo'
            precioUnidad column: 'prodpcun'
            precioMayor column: 'prodpcmy'
            ice column: 'prod_ice'
        }
    }

    static constraints = {
        persona(blank: false, nullable: false)
        grupo(blank: false, nullable: false)
        tipoIva(blank: false, nullable: false)
        marca(blank: false, nullable: false)
        codigo(blank: false, nullable: false, attributes: [title: 'código'])
        titulo(size: 0..255, blank: false, nullable: false, attributes: [title: 'titulo'])
        subtitulo(size: 0..255, blank: true, nullable: true, attributes: [title: 'subtitulo'])
        texto(blank: true, nullable: true, attributes: [title: 'texto'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha creacion'])
        fechaModificacion(blank: true, nullable: true, attributes: [title: 'fecha modificacion'])
        destacado(blank: true, nullable: true, attributes: [title: 'destacado'])
        nuevo(size: 0..1, blank: true, nullable: true, attributes: [title: 'nuevo'])
        precioUnidad(blank: true, nullable: true, attributes: [title: 'unidad'])
        precioMayor(blank: true, nullable: true, attributes: [title: 'mayor'])
        ice(blank: false, nullable: false, attributes: [title: 'ICE'])
    }

}
