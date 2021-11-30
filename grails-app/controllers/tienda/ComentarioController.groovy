package tienda


class ComentarioController {

    def list(){
        def producto = Producto.get(params.id)
        def publicacion = Publicacion.findByProductoAndEstado(producto, 'A')
        def comentarios = Comentario.findAllByPublicacion(publicacion)
        return[comentarios: comentarios, publicacion: publicacion]
    }


    def negar_ajax(){
        def comentario = Comentario.get(params.id)

        comentario.estado = 'N'

        if(!comentario.save(flush: true)){
            println("error al negar el comentario " + comentario.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def aceptar_ajax(){
        def comentario = Comentario.get(params.id)

        comentario.estado = 'A'

        if(!comentario.save(flush: true)){
            println("error al aceptar el comentario " + comentario.errors)
            render "no"
        }else{
            render "ok"
        }
    }


}
