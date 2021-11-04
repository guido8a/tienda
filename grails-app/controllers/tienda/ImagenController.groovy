package tienda


class ImagenController {


    def list(){
        def producto = Producto.get(params.id)
        def imagenes = Imagen.findAllByProducto(producto)
        return[producto: producto, imagenes: imagenes]
    }

}
