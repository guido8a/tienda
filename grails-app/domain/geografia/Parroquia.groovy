package geografia

class Parroquia {

    Canton canton
    String numero
    String nombre
    double longitud
    double latitud
    String codigo

    static mapping = {
        table 'parr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'parr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'parr__id'
            canton column: 'cntn__id'
            numero column: 'parrnmro'
            nombre column: 'parrnmbr'
            longitud column: 'parrlong'
            latitud column: 'parrlatt'
            codigo column: 'parrcdgo'
        }
    }
    static constraints = {
        nombre(size: 1..63, blank: false, nullable: false, attributes: [title: 'nombre'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        latitud(blank: true, nullable: true, attributes: [title: 'latitud'])
        longitud(blank: true, nullable: true, attributes: [title: 'longitud'])
        codigo(size: 0..6, blank: true, nullable: true, attributes: [title: 'codigo'])
    }
}
