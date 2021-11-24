package tienda

class VerController {

    def mailService
    def dbConnectionService

    /* debe llegar el id de la publicación en anun */
    def producto() {
        def cn = dbConnectionService.getConnection()
        println "carrusel params: $params"
        def publ = Publicacion.get(params.anun)

        def sql = "select publ.prod__id, publtitl, publsbtl, publtxto, publpcun from publ " +
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

        println"carrusel: $carrusel"
        return [carrusel: carrusel, publ: prod, anuncio: params.anun]
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
