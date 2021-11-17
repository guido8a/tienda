package tienda

class Cliente {

    String nombre
    String apellido
    String mail
    String telefono
    Date fecha
    String login
    String password

    static mapping = {
        table 'clnt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'clnt__id'
        id generator: 'identity'
        version false
        columns {
            nombre column: 'clntnmbr'
            apellido column: 'clntapll'
            mail column: 'clntmail'
            telefono column: 'clnttelf'
            fecha column: 'clntfcha'
            login column: 'clntlogn'
            password column: 'clntpass'
        }
    }
    static constraints = {
        nombre(size:0..31, blank: false, nullable: false, attributes: [title: 'nombre'])
        apellido(size:0..31, blank: true, nullable: true, attributes: [title: 'apellido'])
        mail(size:0..63, blank: true, nullable: true, attributes: [title: 'mail'])
        telefono(size:0..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        login(blank: true, nullable: true, attributes: [title: 'login'])
        password(blank: true, nullable: true, attributes: [title: 'password'])
    }
}
