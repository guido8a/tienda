package seguridad


class EmpresaController {

    def list(){
        def empresas = Empresa.list().sort{it.nombre}
        return[empresas:empresas]
    }

    def form_ajax(){
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return[empresa:empresa]
    }

    def show_ajax(){
        def empresa = Empresa.get(params.id)
        return[empresa: empresa]
    }

    def validarRuc_ajax() {
        println ("params vruc " + params)
        params.ruc = params.ruc.toString().trim()
        def ruc
        def empresa

        if(params.id){
            empresa = Empresa.get(params.id)
            ruc = Empresa.findAllByRucAndIdNotEqual(params.ruc, empresa.id)
        }else{
            ruc = Empresa.findAllByRuc(params.ruc)
        }

        if(ruc){
            render false
        }else{
            render true
        }
    }//validador unique


    def save_ajax(){

        println("params " + params)

        def empresa
        def ruc

        if(params.id){
            empresa = Empresa.get(params.id)
            ruc = Empresa.findAllByRucAndIdNotEqual(params.ruc, empresa.id)
        }else{
            ruc = Empresa.findAllByRuc(params.ruc)
        }

        if(ruc){
            render "er"
        }else{
            if(params.id){
                empresa = Empresa.get(params.id)
            }else{
                empresa = new Empresa()
                empresa.fechaInicio = new Date()
            }

            params.sigla = params.sigla.toUpperCase()
            params.codigo = params.codigo.toUpperCase()
            empresa.properties = params

            if(!empresa.save(flush:true)){
                println("error al crear la empresa " + empresa.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def delete_ajax(){

        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la empresa " + empresa.errors)
            render "no"
        }
    }

}
