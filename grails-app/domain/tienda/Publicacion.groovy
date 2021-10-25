package tienda

import seguridad.Persona

class Publicacion {

    Producto producto
    Persona persona
    Grupo grupo
    Date fecha
    Date fechaInicio
    Date fechaFin
    String destacado
    String titulo
    String subtitulo
    String texto
    double latitud
    double longitud
    String estado
    String observaciones

    static mapping = {
        table 'publ'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'publ__id'
        id generator: 'identity'
        version false
        columns {
            producto column: 'prod__id'
            persona column: 'prsn__id'
            grupo column: 'grpo__id'
            fecha column: 'publfcha'
            fechaInicio column: 'publfcin'
            fechaFin column: 'publfcfn'
            destacado column: 'publdstc'
            titulo column: 'publtitl'
            subtitulo column: 'publsbtl'
            texto column: 'publtxto'
            estado column: 'publetdo'
            longitud column: 'publlong'
            latitud column: 'publlatt'
            observaciones column: 'publobsr'
        }
    }
    static constraints = {
        producto(blank: false, nullable: false)
        persona(blank: false, nullable: false)
        grupo(blank: false, nullable: false)
        titulo(size: 0..255, blank: false, nullable: false, attributes: [title: 'titulo'])
        subtitulo(size: 0..255, blank: true, nullable: true, attributes: [title: 'subtitulo'])
        texto(blank: true, nullable: true, attributes: [title: 'texto'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: false, nullable: false, attributes: [title: 'fecha creacion'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fecha inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fecha fin'])
        latitud(blank: false, nullable: false, attributes: [title: 'latitud'])
        longitud(blank: false, nullable: false, attributes: [title: 'longitud'])
        observaciones(size: 0..255, blank: false, nullable: false, attributes: [title: 'longitud'])

    }
}
