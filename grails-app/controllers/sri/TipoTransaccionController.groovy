package sri


class TipoTransaccionController {

    def list(){
        def tipo = TipoTransaccion.list().sort{it.codigo}
        return [tipoTransaccionInstanceList:tipo]
    }

    def form_ajax(){

        def tipo

        if(params.id){
            tipo = TipoTransaccion.get(params.id)
        }else{
            tipo = new TipoTransaccion()
        }

        return[tipoTransaccionInstance:tipo]
    }

    def save_ajax(){

        def tipo

        def existente = TipoTransaccion.findByCodigo(params.codigo.toUpperCase())

        if(existente){
            if(params.id){
                tipo = TipoTransaccion.get(params.id)
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
            tipo = TipoTransaccion.get(params.id)
        }else{
            tipo = new TipoTransaccion()
        }


        params.codigo = params.codigo.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de transacción " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def tipo = TipoTransaccion.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de transacción")
            render "no"
        }
    }

}
