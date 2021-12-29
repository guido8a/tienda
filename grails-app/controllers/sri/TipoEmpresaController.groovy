package sri


class TipoEmpresaController {

    def list(){
        def tipo = TipoEmpresa.list().sort{it.descripcion}
        return[tipoEmpresaInstanceList: tipo]
    }

    def form_ajax(){

        def tipo

        if(params.id){
            tipo = TipoEmpresa.get(params.id)
        }else{
            tipo = new TipoEmpresa()
        }

        return[tipoEmpresaInstance:tipo]
    }

    def save_ajax(){

        def tipo

        if(params.id){
            tipo = TipoEmpresa.get(params.id)
        }else{
            tipo = new TipoEmpresa()
        }

        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def tipo = TipoEmpresa.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de empresa " + tipo.errors)
            render "no"
        }
    }


}
