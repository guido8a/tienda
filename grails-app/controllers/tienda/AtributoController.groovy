package tienda



class AtributoController {

    def form_ajax(){
        def atributo
        def producto

        if(params.id){
            atributo = Atributo.get(params.id)
            producto =  atributo.producto
        }else{
            producto = Producto.get(params.producto)
            atributo = new Atributo()
        }

        return [atributo: atributo, producto: producto]
    }

    def list(){
        def producto = Producto.get(params.id)
        def atributos = Atributo.findAllByProducto(producto).sort{it.orden}
        return[producto: producto, atributos: atributos]
    }

    def validarOrden_ajax(){
        println ("params orden " + params)
        params.orden = params.orden.toString().trim()
        def orden
        def atributo

        if(params.id){
            atributo = Atributo.get(params.id)
            orden = Atributo.findAllByOrdenAndIdNotEqual(params.orden, atributo.id)
        }else{
            orden = Atributo.findAllByOrden(params.orden)
        }

        if(orden){
            render false
        }else{
            render true
        }
    }

    def saveAtributo_ajax(){

        def atributo

        if(params.id){
            atributo = Atributo.get(params.id)
        }else{
            atributo = new Atributo()
        }

        atributo.properties = params

        if(!atributo.save(flush:true)){
            println("error al guardar el atributo " + atributo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def deleteAtributo_ajax(){

        def atributo = Atributo.get(params.id)

        try{
            atributo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el atributo " + atributo.errors)
            render "no"
        }

    }
}
