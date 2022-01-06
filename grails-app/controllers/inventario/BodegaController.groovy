package inventario

import seguridad.Empresa


class BodegaController {

    def bodega_ajax(){
        def empresa = Empresa.get(params.empresa)

        def bodega

        if(params.id){
            bodega = Bodega.get(params.id)
        }else{
            bodega = new Bodega()
        }

        return[empresa:empresa, bodega: bodega]
    }

    def tablaBodega_ajax(){
        def empresa = Empresa.get(params.id)
        def bodegas = Bodega.findAllByEmpresa(empresa)
        return[bodegas: bodegas]
    }

    def delete_ajax(){

        def bodega = Bodega.get(params.id)

        try{
            bodega.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la bodega " + bodega.errors)
            render "no"
        }

    }

    def save_ajax(){
        def empresa = Empresa.get(params.empresa)

        def bodega

        if(params.id){
            bodega = Bodega.get(params.id)
        }else{
            bodega = new Bodega()
        }

        bodega.properties = params

        if(!bodega.save(flush:true)){
            println("error al guardar la bodega " + bodega.errors)
            render "no"
        }else{
            render "ok"
        }

    }

}
