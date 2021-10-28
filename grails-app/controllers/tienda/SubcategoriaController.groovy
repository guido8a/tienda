package tienda

class SubcategoriaController {


    def form_ajax(){

        def categoria
        def subcategoria

        if(params.id){
            subcategoria = Subcategoria.get(params.id)
            categoria = subcategoria.categoria
        }else{
            subcategoria = new Subcategoria()
            categoria = Categoria.get(params.padre)
        }

        return[subcategoria: subcategoria, categoria: categoria]
    }

    def validarOrdenSub_ajax(){
        println("params orden " + params)

        def categoria = Categoria.get(params.categoria)
        def subCategorias = false
        def subcategoria

        if(params.orden){
            if(params.id){
                subcategoria = Subcategoria.get(params.id)
                subCategorias = Subcategoria.findAllByOrdenAndCategoriaAndIdNotEqual(params.orden.toInteger(), categoria, subcategoria.id)
            }else{
                subCategorias = Subcategoria.findAllByOrdenAndCategoria(params.orden.toInteger(), categoria)
            }

            if(subCategorias){
                render "false"
            }else{
                render "true"
            }
        }else{
            render "true"
        }
    }


    def saveSubcategoria_ajax(){
        println("params sv sbc " + params)

        def subcategoria

        if(params.id){
            subcategoria = Subcategoria.get(params.id)
        }else{
            subcategoria = new Subcategoria()
        }

        subcategoria.properties = params

        if(!subcategoria.save(flush:true)){
            println("error al guardar la subcategoria " + subcategoria.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def show_ajax(){
        def subcategoria = Subcategoria.get(params.id)
        return[subcategoria: subcategoria]
    }


    def borrarSubcategoria_ajax(){
        def subcategoria = Subcategoria.get(params.id)

        try{
            subcategoria.delete(flush:true)
            render "ok"
        }catch(e){
            println("Error al borrar la subcategoria " + subcategoria.errors)
            render "no"
        }
    }

}
