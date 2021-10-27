package tienda

class GrupoController {

    def form_ajax(){

        println("params f grp " + params)

        def subcategoria
        def grupo

        if(params.id){
            grupo = Grupo.get(params.id)
            subcategoria = grupo.subcategoria
        }else{
            grupo = new Grupo()
            subcategoria = Subcategoria.get(params.padre)
        }

        return[subcategoria: subcategoria, grupo: grupo]
    }

    def validarOrdenGrupo_ajax(){
        println("params orden " + params)

        def subcategoria = Subcategoria.get(params.subcategoria)
        def grupos = false
        def grupo

        if(params.orden){
            if(params.id){
                grupo = Grupo.get(params.id)
                grupos = Grupo.findAllByOrdenAndSubcategoriaAndIdNotEqual(params.orden.toInteger(), subcategoria, grupo.id)
            }else{
                grupos = Grupo.findAllByOrdenAndSubcategoria(params.orden.toInteger(), subcategoria)
            }

            if(grupos){
                render "false"
            }else{
                render "true"
            }
        }else{
            render "true"
        }
    }

    def saveGrupo_ajax(){
        println("params sv grp " + params)

        def grupo

        if(params.id){
            grupo = Grupo.get(params.id)
        }else{
            grupo = new Grupo()
        }

        grupo.properties = params

        if(!grupo.save(flush:true)){
            println("error al guardar el grupo " + grupo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

}
