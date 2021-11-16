package tienda

import seguridad.Persona

class Producto {

    Persona persona
    Grupo grupo
    String titulo
    String subtitulo
    String texto
    String estado
    Date fecha
//    String sitio
//    double latitud
//    double longitud
    Date fechaModificacion
    String destacado
    String nuevo

    static mapping = {
        table 'prod'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prod__id'
        id generator: 'identity'
        version false
        columns {
            persona column: 'prsn__id'
            grupo column: 'grpo__id'
            titulo column: 'prodtitl'
            subtitulo column: 'prodsbtl'
            texto column: 'prodtxto'
            estado column: 'prodetdo'
            fecha column: 'prodfcha'
//            sitio column: 'prodsito'
//            longitud column: 'prodlong'
//            latitud column: 'prodlatt'
            fechaModificacion column: 'prodfcmd'
            destacado column: 'proddstc'
            nuevo column: 'prodnuvo'
        }
    }
    static constraints = {
        persona(blank: false, nullable: false)
        grupo(blank: false, nullable: false)
        titulo(size: 0..255, blank: false, nullable: false, attributes: [title: 'titulo'])
        subtitulo(size: 0..255, blank: true, nullable: true, attributes: [title: 'subtitulo'])
        texto(blank: true, nullable: true, attributes: [title: 'texto'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha creacion'])
//        sitio(size: 0..127, blank: true, nullable: true, attributes: [title: 'sitio'])
//        latitud(blank: true, nullable: true, attributes: [title: 'latitud'])
//        longitud(blank: true, nullable: true, attributes: [title: 'longitud'])
        fechaModificacion(blank: true, nullable: true, attributes: [title: 'fecha modificacion'])
        destacado(blank: true, nullable: true, attributes: [title: 'destacado'])
        nuevo(size: 0..1, blank: true, nullable: true, attributes: [title: 'destacado'])
    }
}
