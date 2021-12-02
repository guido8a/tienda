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
    Double precioUnidad = 0
    Double precioMayor = 0
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
            precioUnidad column: 'publpcun'
            precioMayor column: 'publpcmy'
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
        precioUnidad(blank: true, nullable: true, attributes: [title: 'unidad'])
        precioMayor(blank: true, nullable: true, attributes: [title: 'mayor'])
        observaciones(size: 0..255, blank: true, nullable: true, attributes: [title: 'longitud'])

    }
}
