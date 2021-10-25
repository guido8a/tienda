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
    String sitio
    double latitud
    double longitud
    Date fechaModificacion

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
            sitio column: 'prodsito'
            longitud column: 'prodlong'
            latitud column: 'prodlatt'
            fechaModificacion column: 'prodfcmd'
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
        sitio(size: 0..127, blank: false, nullable: false, attributes: [title: 'sitio'])
        latitud(blank: false, nullable: false, attributes: [title: 'latitud'])
        longitud(blank: false, nullable: false, attributes: [title: 'longitud'])
        fechaModificacion(blank: false, nullable: false, attributes: [title: 'fecha modificacion'])
    }
}
