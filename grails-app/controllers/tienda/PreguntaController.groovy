package tienda

class PreguntaController {

    def agregarPregunta_ajax () {

        println("params " + params)

        def publicacion = Publicacion.get(params.id)

        def pregunta

        pregunta = new Pregunta()
        pregunta.publicacion = publicacion
        pregunta.fecha = new Date()
        pregunta.texto = params.texto
        pregunta.estado = 'R'

        if(!pregunta.save(flush:true)){
            println("error al guardar la pregunta " + pregunta.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def list(){
        def producto = Producto.get(params.id)
        def publicacion = Publicacion.findByProductoAndEstado(producto, 'A')
        println("publ " + publicacion.id)

        def preguntas = Pregunta.findAllByPublicacion(publicacion)

        println("preguntas " + preguntas)

        return[preguntas: preguntas, publicacion: publicacion]
    }

    def negar_ajax(){
        def pregunta = Pregunta.get(params.id)

        pregunta.estado = 'N'

        if(!pregunta.save(flush: true)){
            println("error al negar la pregunta " + pregunta.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def activar_ajax(){
        def pregunta = Pregunta.get(params.id)

        pregunta.estado = 'A'

        if(!pregunta.save(flush: true)){
            println("error al activar la pregunta " + pregunta.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def respuesta_ajax(){
        def pregunta = Pregunta.get(params.id)
        return[pregunta:pregunta]
    }

    def guardarRespuesta_ajax(){
        println("params " + params)
        def pregunta = Pregunta.get(params.id)

        pregunta.respuesta = params.respuesta
        pregunta.fechaRespuesta = new Date();

        if(!pregunta.save(flush: true)){
            println("error al guardar la pregunta " + pregunta.errors)
            render "no"
        }else{
            render "ok"
        }

    }


}
