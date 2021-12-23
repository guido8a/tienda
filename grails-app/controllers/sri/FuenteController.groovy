package sri


class FuenteController {

    def list(){
        def fuentes = Fuente.list().sort{it.descripcion}
        return[fuenteInstanceList: fuentes]
    }

    def form_ajax(){

        def fuente

        if(params.id){
            fuente = Fuente.get(params.id)
        }else{
            fuente = new Fuente()
        }

        return[fuenteInstance: fuente]
    }

    def save_ajax(){
        def fuente

        if(params.id){
            fuente = Fuente.get(params.id)
        }else{
            fuente = new Fuente()
        }

        fuente.properties = params

        if(!fuente.save(flush:true)){
            println("error al guardar la fuente " + fuente.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def fuente = Fuente.get(params.id)

        try{
            fuente.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la fuente " + fuente.errors)
            render "no"
        }



    }


}
