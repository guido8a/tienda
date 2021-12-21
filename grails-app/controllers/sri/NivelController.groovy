package sri

class NivelController {

    def list(){
        def niveles = Nivel.list().sort{it.id}
        return[niveles: niveles]
    }


    def form_ajax(){
        def nivel
        if(params.id){
            nivel = Nivel.get(params.id)
        }else{
            nivel = new Nivel()
        }

        return[nivel: nivel]
    }

    def save_ajax(){

        def nivel
        if(params.id){
            nivel = Nivel.get(params.id)
        }else{
            nivel = new Nivel()
        }

        nivel.properties = params

        if(!nivel.save(flush:true)){
            println("error al guardar el nivel " + nivel.errors)
            render "no"
        }else{
            render "ok"
        }
    }


}
