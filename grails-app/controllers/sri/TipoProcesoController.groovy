package sri


class TipoProcesoController {

    def list(){
        def tipos = TipoProceso.list().sort{it.descripcion}
        return[tipoPagoInstanceList: tipos]
    }


    def form_ajax(){
        def tipo

        if(params.id){
            tipo = TipoProceso.get(params.id)
        }else{
            tipo = new TipoProceso()
        }

        return [tipoProcesoInstance: tipo]
    }

    def save_ajax(){
        def tipo


        def existente = TipoProceso.findByCodigo(params.codigo)

        if(existente){
            if(params.id){
                tipo = TipoProceso.get(params.id)
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
            tipo = TipoProceso.get(params.id)
        }else{
            tipo = new TipoProceso()
        }

        params.codigo = params.codigo.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de proceso " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def tipo = TipoProceso.get(params.id)

        try{
            tipo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de proceso " + tipo.errors)
            render "no"
        }
    }

}
