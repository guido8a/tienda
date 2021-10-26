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

}
