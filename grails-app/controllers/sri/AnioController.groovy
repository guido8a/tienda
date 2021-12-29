package sri


class AnioController {

    def list(){

        def anios = Anio.list().sort{it.anio}
        return [anioInstanceList: anios]

    }

    def form_ajax(){

        def anio

        if(params.id){
            anio = Anio.get(params.id)
        }else{
            anio = new Anio()
        }

        return[anioInstance: anio]

    }

    def save_ajax(){
        println("params " + params)

        def anio

        def existente = Anio.findByAnio(params.anio)

        if(existente){
            if(params.id){
                anio = Anio.get(params.id)
                if(anio.id != existente.id){
                    render"er"
                    return true
                }
            }else{
                render "er"
                return true
            }
        }


        if(params.id){
            anio = Anio.get(params.id)
        }else{
            anio = new Anio()
        }

        anio.properties = params

        if(!anio.save(flush:true)){
            println("error al guardar el anio" + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
     }

    def delete_ajax(){
        def anio = Anio.get(params.id)

        try{
            anio.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al guardar el anio " + anio.errors)
            render "no"
        }
    }


}
