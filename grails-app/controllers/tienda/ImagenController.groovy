package tienda

import groovy.io.FileType
import seguridad.Persona

import javax.imageio.ImageIO


class ImagenController {


    def list(){
//        def producto = Producto.get(params.id)
//        def imagenes = Imagen.findAllByProducto(producto)
//        return[producto: producto, imagenes: imagenes]


        println "wizardImagenes: $params"
        def persona = Persona.get(session.usuario.id)
        def producto = Producto.get(params.id)
        def imas = Imagen.findAllByProducto(producto)

        def imagenes = []

        println "producto: ${producto?.id}"
        /**** imágenes ****/
        if(producto?.id){
            def path = "/var/tienda/imagenes/productos/pro_" + producto.id + "/"
            new File(path).mkdirs()

            def imag = new File(path)
            imag?.eachFileRecurse(FileType.FILES) { file ->
                if(file.name.toString() in imas.ruta) {
                    def img = ImageIO.read(file)
                    if (img) {
                        imagenes.add([file: file.name])
                    }
                }
            }
            println "path: $path --> imagenes: $imagenes"
        }

        return[producto: producto, persona: persona, imagenes: imagenes, tam: imas.size(), tipo: params.tipo]
    }

    def imagenes_ajax() {
        def producto = Producto.get(params.id)
        return[producto: producto]
    }

    def tablaImagenes_ajax(){
        def producto = Producto.get(params.id)
        def imagenes = Imagen.findAllByProducto(producto)

        def path = "/var/tienda/imagenes/productos/pro_" + producto.id + "/"
        new File(path).mkdirs()

        def files = []

        def dir = new File(path)

//        dir.eachFileRecurse(FileType.FILES) { file ->
//            if(file.name.toString() in imagenes.ruta){
//                println("si " + file.name)
//                println("---------------------- " + file)
//                def img = ImageIO.read(file)
//                if (img) {
//                    files.add([
//
//                            dir : path,
//                            file: file.name,
//                            w   : img?.getWidth(),
//                            h   : img?.getHeight(),
//                    ])
//                }
//            }
//        }

        imagenes.each { im ->
            def file = new File(path + im.ruta)
            def img = ImageIO.read(file)
            if(file.name.toString() in imagenes.ruta){
            if (img) {
                files.add([
                        id  : im.id,
                        dir : path,
                        file: file.name,
                        w   : img?.getWidth(),
                        h   : img?.getHeight(),
                        pncp: im.principal
                ])
            }
        }
        }

        return[imagenes: files, producto: producto, tam: imagenes.size()]
    }

    def revisarImas_ajax(){
        println "revisarImas_ajax $params"
        def producto = Producto.get(params.id)
        def imagenes = Imagen.findAllByProducto(producto)
        if(imagenes.size() < 5){
            render "ok"
        }else{
            render "no"
        }
    }

    def deleteImagen_ajax() {
        println "deleteImagen_ajax params $params"
        def imagen = Imagen.get(params.idim)
        def imagenes = Imagen.findAllByProductoAndIdNotEqual(imagen.producto, imagen.id)
        def path = "/var/tienda/imagenes/productos/pro_" + imagen.producto.id + "/${imagen.ruta}"

        if(imagenes.size() == 0){
            render "er_No se puede borrar la imagen, el producto tiene una sola imagen asociada."
        }else{
            try{
                def principal = imagenes[0]
                principal.principal = 1
                imagen.delete(flush: true)
                def file = new File(path).delete()
                render "ok"
            }catch(e){
                println("error al borrar la imagen " + e)
                render "no"
            }
        }
    }

    def getImage() {
        println "params get image $params"
        byte[] imageInBytes = im(params.id, params.format, params.pro)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${params.format}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,producto) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/tienda/imagenes/productos/pro_" + producto + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

    def upload_ajax() {
        println ("params imas " +  params)
        def producto = Producto.get(params.id)
        def imagenes = Imagen.findAllByProducto(producto)
        def path = "/var/tienda/imagenes/productos/pro_" + producto.id + "/"
        new File(path).mkdirs()

//        def f = request.getFile('upload')
        def f = request.getFile('file')

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

        def canti = []
        def dir = new File(path)
        dir.eachFileRecurse(FileType.FILES) { file ->
            def img = ImageIO.read(file)

            if (img) {
                canti.add([
                        dir : path,
                        file: file.name,
                        w   : img?.getWidth(),
                        h   : img?.getHeight(),
                ])
            }
        }

//        if(canti.size() < 5){
        if(imagenes.size() < 5){

            if (f && !f.empty) {
                def fileName = f.getOriginalFilename() //nombre original del archivo
                def ext
                def parts = fileName.split("\\.")
                fileName = ""
                parts.eachWithIndex { obj, i ->
                    if (i < parts.size() - 1) {
                        fileName += obj
                    } else {
                        ext = obj
                    }
                }

                if (okContents.containsKey(f.getContentType())) {
                    ext = okContents[f.getContentType()]
                    fileName = fileName.size() < 40 ? fileName : fileName[0..39]
                    fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

//                    def nombre = fileName + "_${new Date().format("dd-MM-yyyy HH:mm")}" + "." + ext
                    def nombre = fileName + "." + ext
                    def pathFile = path + nombre
//                    def fn = fileName + "_${new Date().format("dd-MM-yyyy HH:mm")}"
                    def fn = fileName
                    def src = new File(pathFile)

                    println("path -->" + pathFile)

                    def i = 1
                    while (src.exists()) {
                        println "---> srs.exists"
                        nombre = fn + "_" + i + "." + ext
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        println "---> try:  ${f.getContentType()}"
                        f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                        println "transferTo --> $pathFile"
                        def imagenNueva = new Imagen()
                        imagenNueva.producto = producto
                        imagenNueva.ruta = nombre

                        if(canti.size() == 0){
                            imagenNueva.principal = 1
                        }

                        imagenNueva.save(flush:true)
                    } catch (e) {
                        println ("error al subir la imagen " + e)
                    }

                    /* fin resize */
//                def pathReturn = "/var/ventas/productos/pro_" + producto.id + "/" + nombre
                    def output = '<html>' +
                            '<body>' +
                            '<script type="text/javascript">' +
                            'Archivo subido correctamente.' +
                            '</script>' +
                            '</body>' +
                            '</html>';
                    render output
                } //contenido ok (extension ok
                else {
                    def ok = ""
                    okContents.each {
                        if (ok != "") {
                            ok += ", "
                        }
                        ok += it.value
                    }
                    def output = '<html>' +
                            '<body>' +
                            '<script type="text/javascript">' +
                            'Por favor utilice archivos de tipo' + ok +
                            '</script>' +
                            '</body>' +
                            '</html>';
                    render output
                }
            }//f not empty
            else {
                def output = '<html>' +
                        '<body>' +
                        '<script type="text/javascript">' +
                        'Por favor seleccione una imagen' +
                        '</script>' +
                        '</body>' +
                        '</html>';
                render output
            }
        }else{
            return false
        }
    }


}
