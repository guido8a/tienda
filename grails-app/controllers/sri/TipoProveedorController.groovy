package sri


class TipoProveedorController {

    def list(){
        def tipo = TipoProveedor.list().sort{it.descripcion}
        return[tipoProveedorInstanceList: tipo]
    }

    def form_ajax(){

        def tipo

        if(params.id){
            tipo = TipoProveedor.get(params.id)
        }else{
            tipo = new TipoProveedor()
        }

        return[tipoProveedorInstance: tipo]
    }


    def save_ajax(){

        def tipo


        def existente = TipoProveedor.findByCodigo(params.codigo.toUpperCase())

        if(existente){
            if(params.id){
                tipo = TipoProveedor.get(params.id)
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
            tipo = TipoProveedor.get(params.id)
        }else{
            tipo = new TipoProveedor()
        }


        params.codigo = params.codigo.toUpperCase()
        tipo.properties = params

        if(!tipo.save(flush:true)){
            println("error al guardar el tipo de proveedor " + tipo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def tipo = TipoProveedor.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al guardar el tipo de proveedor " + tipo.errors)
            render "no"
        }


    }

}
