package seguridad

import groovy.io.FileType
import tienda.Imagen
import tienda.ImagenEmpresa
import tienda.Producto

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC


class EmpresaController {

    def list(){
        def usro = Persona.get(session?.usuario?.id)
        def empresas
        def band = 0

        if(usro.login == 'admin') {
            empresas = Empresa.list([sort: 'nombre'])
            band = 1
        } else {
            empresas = Empresa.findAllById(session.empresa.id)
        }

        return[empresas:empresas, band: band]
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

    def imagenesEmpresa_ajax(){
        def empresa = Empresa.get(params.id)
        return[empresa:empresa]
    }


    def revisarImas_ajax(){
        def empresa = Empresa.get(params.id)
        def imagenes = ImagenEmpresa.findAllByEmpresa(empresa)
        if(imagenes.size() < 20){
            render "ok"
        }else{
            render "no"
        }
    }

    def tablaImagenesEmp_ajax(){
        def empresa = Empresa.get(params.id)
        def imagenes = ImagenEmpresa.findAllByEmpresa(empresa)

        def path = "/var/tienda/imagenes/empresa/emp_" + empresa.id + "/"
        new File(path).mkdirs()

        def files = []

        def dir = new File(path)

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
//                            pncp: im.principal
                    ])
                }
            }
        }

        return[imagenes: files, empresa: empresa, tam: imagenes.size()]
    }

    def deleteImagen_ajax() {
        println "deleteImagen_ajax params $params"
        def imagen = ImagenEmpresa.get(params.idim)
        def imagenes = ImagenEmpresa.findAllByEmpresaAndIdNotEqual(imagen.empresa, imagen.id)
        def path = "/var/tienda/imagenes/empresa/emp_" + imagen.empresa.id + "/${imagen.ruta}"

        try{
                imagen.delete(flush: true)
                def file = new File(path).delete()
                render "ok"
            }catch(e){
                println("error al borrar la imagen " + e)
                render "no"
            }
    }

    def getImage() {
        println "params get image $params"
        byte[] imageInBytes = im(params.id, params.format, params.emp)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${params.format}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,empresa) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/tienda/imagenes/empresa/emp_" + empresa + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

    def upload_ajax() {
        println ("params imas emp " +  params)
        def empresa = Empresa.get(params.id)
        def imagenes = ImagenEmpresa.findAllByEmpresa(empresa)
        def path = "/var/tienda/imagenes/empresa/emp_" + empresa.id + "/"
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
        if(imagenes.size() < 20){

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

//                    println("path -->" + pathFile)

                    def i = 1
                    while (src.exists()) {
//                        println "---> srs.exists"
                        nombre = fn + "_" + i + "." + ext
                        pathFile = path + nombre
                        src = new File(pathFile)
                        i++
                    }
                    try {
                        println "---> try:  ${f.getContentType()}"
                        f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                        println "transferTo --> $pathFile"
                        def imagenNueva = new ImagenEmpresa()
                        imagenNueva.empresa = empresa
                        imagenNueva.ruta = nombre

//                        if(canti.size() == 0){
//                            imagenNueva.principal = 1
//                        }

                        imagenNueva.save(flush:true)
                    } catch (e) {
                        println ("error al subir la imagen " + e)
                    }

                    def img = ImageIO.read(new File(pathFile))
                    def scale = 0.5
                    def minW = 1000
                    def minH = 500
                    def maxW = 1000
                    def maxH = 500
                    def w = img.width
                    def h = img.height

                    if (w > maxW || h > maxH || w < minW || h < minH) {
                        def newW = w * scale
                        def newH = h * scale
                        def r = 1
                        if (w > h) {
                            if (w > maxW) {
                                r = w / maxW
                                newW = maxW
                                println "w>maxW:    r=" + r + "   newW=" + newW
                            }
                            if (w < minW) {
                                r = minW / w
                                newW = minW
                                println "w<minW:    r=" + r + "   newW=" + newW
                            }
                            newH = h / r
                            println "newH=" + newH
                        } else {
                            if (h > maxH) {
                                r = h / maxH
                                newH = maxH
                                println "h>maxH:    r=" + r + "   newH=" + newH
                            }
                            if (h < minH) {
                                r = minH / h
                                newH = minH
                                println "h<minxH:    r=" + r + "   newH=" + newH
                            }
                            newW = w / r
                            println "newW=" + newW
                        }
                        println newW + "   " + newH

                        newW = Math.round(newW.toDouble()).toInteger()
                        newH = Math.round(newH.toDouble()).toInteger()

                        println newW + "   " + newH

                        new BufferedImage(newW, newH, img.type).with { j ->
                            createGraphics().with {
                                setRenderingHint(KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC)
                                drawImage(img, 0, 0, newW, newH, null)
                                dispose()
                            }
                            ImageIO.write(j, ext, new File(pathFile))
                        }
                    }



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

    def formContabilidad(){
        def empresa = Empresa.get(params.id)
        return[empresaInstance: empresa]
    }

    def saveFormCont_ajax(){
//        println("params " + params)

        def empresa = Empresa.get(params.id)

        params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params."contribuyenteEspecial_name"){
            params.contribuyenteEspecial = 'S'
        }else{
            params.contribuyenteEspecial = 'N'
        }

        if(params."obligadaContabilidad_name"){
            params.obligadaContabilidad =  '1'
        }else{
            params.obligadaContabilidad =  '0'
        }

        if(params."tipoEmision_name"){
            params.tipoEmision = 'E'
        }else{
            params.tipoEmision = 'F'
        }

        if(params."ambiente_name"){
            params.ambiente = '2'
        }else{
            params.ambiente = '1'
        }

        empresa.properties = params


        if(!empresa.save(flush:true)){
            println("error al guardar los datos de la contabilidad de la empresa " + empresa.errors)
            render "no"
        }else{
            render "ok"
        }

    }

}
