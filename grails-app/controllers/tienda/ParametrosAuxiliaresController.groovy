package tienda

class ParametrosAuxiliaresController {

    def list(){
        def ivas = ParametrosAuxiliares.list().sort{it.iva}
        return[parametrosAuxiliaresInstanceList: ivas]
    }

    def form_ajax(){

        def iva

        if(params.id){
            iva = ParametrosAuxiliares.get(params.id)
        }else{
            iva = new ParametrosAuxiliares()
        }

        return[parametrosAuxiliaresInstance: iva]
    }

    def save_ajax(){

        println("params " + params)

        def iva

        if(params.id){
            iva = ParametrosAuxiliares.get(params.id)
        }else{
            iva = new ParametrosAuxiliares()
        }

        params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        iva.properties = params

        if(!iva.save(flush:true)){
            println("error al guardar el iva " + iva.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){

        def iva = ParametrosAuxiliares.get(params.id)

        try{
            iva.delete(flush:true)
            render"ok"
        }catch(e){
            println("error al borrar el iva " + iva.errors)
            render "no"
        }
    }


}
