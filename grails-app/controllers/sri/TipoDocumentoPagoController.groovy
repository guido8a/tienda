package sri


class TipoDocumentoPagoController {

    def list(){
        def tiposPagos = TipoDocumentoPago.list().sort{it.descripcion}
        return [formaDePagoInstanceList: tiposPagos]
    }

    def form_ajax(){
        def forma

        if(params.id){
            forma = TipoDocumentoPago.get(params.id)
        }else{
            forma = new TipoDocumentoPago()
        }

        return[formaDePagoInstance: forma]
    }

    def save_ajax(){
        def forma

        if(params.id){
            forma = TipoDocumentoPago.get(params.id)
        }else{
            forma = new TipoDocumentoPago()
        }

        forma.properties = params

        if(!forma.save(flush:true)){
            println("error al guardar la forma de pago " + forma.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def forma = TipoDocumentoPago.get(params.id)

        try{
            forma.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la forma de pago " + forma.errors)
            render "no"
        }
    }


}
