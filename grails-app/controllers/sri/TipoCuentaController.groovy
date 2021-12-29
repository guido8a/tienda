package sri


class TipoCuentaController {

    def list(){
        def cuenta = TipoCuenta.list().sort{it.tipoCuenta}
        return [tipoCuentaInstanceList: cuenta]
    }

    def form_ajax(){

        def tipo

        if(params.id){
            tipo = TipoCuenta.get(params.id)
        }else{
            tipo = new TipoCuenta()
        }

        return[tipoCuentaInstance: tipo]
    }

    def save_ajax(){

        def tipo

        if(params.id){
            tipo = TipoCuenta.get(params.id)
        }else{
            tipo = new TipoCuenta()
        }

        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de cuenta " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def tipo = TipoCuenta.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de cuenta " + tipo.errors)
            render "no"
        }
    }
}
