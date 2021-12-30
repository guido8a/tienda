package sri

class TipoIdentificacionController {

    def list(){
        def tipos = TipoIdentificacion.list().sort{it.descripcion}
        return [tipoIdentificacionInstanceList: tipos]
    }

    def form_ajax(){
        def tipo

        if(params.id){
            tipo = TipoIdentificacion.get(params.id)
        }else{
            tipo = new TipoIdentificacion()
        }

        return[tipoIdentificacionInstance:tipo]
    }

    def save_ajax(){

        def tipo

        def existente = TipoIdentificacion.findByCodigo(params.codigo.toUpperCase())

        if(existente){
            if(params.id){
                tipo = TipoIdentificacion.get(params.id)
                if(tipo.id != existente.id){
                    render"er"
                    return true
                }
            }else{
                render "er"
                return true
            }
        }

        if(params.id){
            tipo = TipoIdentificacion.get(params.id)
        }else{
            tipo = new TipoIdentificacion()
        }

        params.codigo = params.codigo.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de identificacion " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }

    }

    def delete_ajax(){

        def tipo = TipoIdentificacion.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de identificacion " + tipo.errors)
            render"no"
        }
    }


}
