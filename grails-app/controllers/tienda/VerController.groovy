package tienda

class VerController {

    def mailService
    def dbConnectionService

    /* debe llegar el id de la publicación en anun */
    def producto() {
        def cn = dbConnectionService.getConnection()
        println "carrusel params: $params"
        def publ = Publicacion.get(params.publ)
        def ctgr = Categoria.list([sort: 'descripcion'])

        def sql = "select publ.prod__id, publtitl, publ__id, publsbtl, publtxto, publpcun from publ " +
                "where publ__id = ${params.publ}"
        println "sql: $sql"
        def prod = cn.rows(sql.toString())[0]

//        def atrb = Valores.findAllByProducto(producto.producto)
//        def preguntas = Pregunta.findAllByProducto(producto.producto).sort{it.fecha}
        def carrusel = []

        sql = "select prod__id, dtpbvlor, dtpbpncp from publ, dtpb where publ.publ__id = ${params.publ} and " +
                "dtpb.publ__id = publ.publ__id and dtpbtipo = 'I' order by dtpbpncp"
        cn.eachRow(sql.toString()) { d ->
            carrusel.add([ruta: "${d.prod__id}/${d.dtpbvlor}"])
        }

//        println"carrusel: $carrusel"

        def cliente = null

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
        }

        def comentarios = Comentario.findAllByPublicacionAndEstado(publ, 'A')
        def comentarioExistente = Comentario.findByPublicacionAndCliente(publ, cliente)
        def carrito = Carrito.findAllByCliente(cliente)
        def productoAdquirido = false

        if(carrito){
            productoAdquirido = DetalleCarrito.findAllByPublicacionAndCarritoInList(publ, carrito)
        }

//        println("pu " + params.publ)
//        println("com " + comentarios)
//        println("com2 " + comentarioExistente)

        def existe = '0'

        if(comentarios?.size() < 5){
            if(comentarioExistente){
                existe = '0'
            }else{
                if(productoAdquirido){
                    existe = '1'
                }else{
                    existe = '2'
                }
            }
        }else{
            existe = '0'
        }


        def estrellas = 5

        if(comentarios){
           estrellas =  Math.round(comentarios.calificacion.sum()  / comentarios.size())
        }


        def detallePublicacion = DetallePublicacion.findAllByPublicacionAndTipo(publ, 'V')


        return [ctgr: ctgr, carrusel: carrusel, publ: prod, anuncio: params.anun, cliente:cliente, comentarios: comentarios, existe: existe, estrellas: estrellas, atributos: detallePublicacion]
    }

    def preguntas_ajax(){
        def producto = Producto.get(params.id)
        def preguntas = Pregunta.findAllByProducto(producto)

        println("preguntas " +  preguntas)
        return[preguntas:preguntas]
    }

    def guardarPregunta_ajax(){

        def producto = Producto.get(params.id)
        def pregunta = new Pregunta()
        pregunta.producto = producto
        pregunta.texto = params.texto
        pregunta.fecha = new Date()

        if(!pregunta.save(flush:true)){
            println("error al guardar la pregunta" + pregunta.errors)
            render "no"
        }else{

            def mail = producto.persona.mailContacto
            def errores = ''

            try{
                mailService.sendMail {
                    to mail
                    subject "Pregunta sobre el producto: ${producto?.titulo}"
                    body "Ha recibido una pregunta referente a su producto: ${producto?.titulo} " +
                            "\n Pregunta: ${params.texto} " +
                            "\n Para responder a esta pregunta, porfavor ingrese al sistema"
                }
            }catch (e){
                println("Error al enviar el mail: " + e)
                errores += e
            }

            if(errores == ''){
                render  "ok"
            }else{
                render "no"
            }




        }

    }
}
