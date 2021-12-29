package sri


class TipoComprobanteController {


    def list(){
        def tipos = TipoComprobante.list().sort{it.codigo}
        return[tipoComprobanteInstanceList: tipos]
    }

    def form_ajax(){
        def comprobante

        if(params.id){
            comprobante = TipoComprobante.get(params.id)
        }else{
            comprobante = new TipoComprobante()
        }

        return[tipoComprobanteInstance: comprobante]
    }

    def save_ajax(){

        def tipo


        def existente = TipoComprobante.findByCodigo(params.codigo.toUpperCase())

        if(existente){
            if(params.id){
                tipo = TipoComprobante.get(params.id)
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
            tipo = TipoComprobante.get(params.id)
        }else{
            tipo = new TipoComprobante()
        }


        params.codigo = params.codigo.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de comprobante " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def tipo = TipoComprobante.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de comprobante")
            render "no"
        }
    }





}
