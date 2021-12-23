package sri


class TipoPagoController {

    def list(){
        def tiposPago = TipoPago.list().sort{it.codigo}
        return[tipoPagoInstanceList: tiposPago]
    }

    def form_ajax(){
        def tipo

        if(params.id){
            tipo = TipoPago.get(params.id)
        }else{
            tipo = new TipoPago()
        }

        return [tipoPagoInstance: tipo]
    }

    def save_ajax(){

        def tipo


        def existente = TipoPago.findByCodigo(params.codigo)

        if(existente){
            if(params.id){
                tipo = TipoPago.get(params.id)
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
            tipo = TipoPago.get(params.id)
        }else{
            tipo = new TipoPago()
        }

        params.descripcion = params.descripcion.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de pago " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def tipo = TipoPago.get(params.id)

        try{
            tipo.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de pago " + tipo.errors)
            render "no"
        }

    }

}
