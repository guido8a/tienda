package retenciones

class Pais implements Serializable {

    String codigo
    String nombre

    static mapping = {
        table 'pais'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pais__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'paiscdgo'
            nombre column: 'paisdscr'
        }
    }

    static constraints = {
        nombre(maxSize: 127)
    }
}