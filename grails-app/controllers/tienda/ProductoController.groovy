package tienda


class ProductoController {

    def list(){

    }

    def tablaProductos_ajax(){

    }

    def subcategorias_ajax(){
        def categoria = Categoria.get(params.id)
        def subcategorias = Subcategoria.findAllByCategoria(categoria)
        return[subcategorias: subcategorias, tipo: params.tipo]
    }

    def grupos_ajax(){
        def subcategoria = Subcategoria.get(params.id)
        def grupos = Grupo.findAllBySubcategoria(subcategoria)
        return[grupos:grupos, tipo: params.tipo]
    }

    def form(){

        def producto

        if(params.id){
            producto = Producto.get(params.id)
        }else{
            producto = new Producto()
        }

        return[producto:producto]
    }

}
