package tienda


import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class PrincipalController {
//    def mailService
    def dbConnectionService

    def index() {
//        def inst = Institucion.get(1)
//        def ejes = Ejes.list([sort: 'orden'])
//        [inst: inst, ejes: ejes]
    }


    def getImage(){
        println "getImage: $params"
        def path = "/var/ventas/" + params.ruta
//        def path = "/var/ventas/cedula.jpeg"
        //returns an image to display
        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        def fileext = path.substring(path.indexOf(".")+1, path.length())

        ImageIO.write( imagen, fileext, baos );
        baos.flush();

        byte[] img = baos.toByteArray();
        baos.close();
        response.setHeader('Content-length', img.length.toString())
        response.contentType = "image/"+fileext // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()
    }

    def getImgnCnsl(){
//        println "getImgnCnsl: $params"
        def path = "/var/ventas/imagen/consultas/" + params.ruta

        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        def fileext = path.substring(path.indexOf(".")+1, path.length())

        ImageIO.write( imagen, fileext, baos );
        baos.flush();

        byte[] img = baos.toByteArray();
        baos.close();
        response.setHeader('Content-length', img.length.toString())
        response.contentType = "image/"+fileext // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()
    }

    def getImgnProd(){
//        println "getImgnProd: $params"
        def producto = Producto.get(params.id)
        def path = (params.tp == 'p'? "/var/ventas/productos/pro_${producto.id}/" : "/var/ventas/imagen/destacados/") + params.ruta
        def fileext = path.substring(path.indexOf(".")+1, path.length())

//        println "ruta: $path"

        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write( imagen, fileext, baos );
        baos.flush();
        byte[] img = baos.toByteArray();
        baos.close();
        response.setHeader('Content-length', img.length.toString())
        response.contentType = "image/"+fileext // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()
    }

    def getImgnCarrusel(){
//        println "getImgnCarrusel: $params"
        def path = params.ruta
        def fileext = path.substring(path.indexOf(".")+1, path.length())

//        println "ruta: $path, fileext $fileext"

        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write( imagen, fileext, baos );
        baos.flush();
        byte[] img = baos.toByteArray();
        baos.close();
        response.setHeader('Content-length', img.length.toString())
        response.contentType = "image/"+fileext // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()
    }


    def enviarMail_ajax () {
//        println("params enviar mail " + params)
        def mailTedein = "informacion@tedein.com.ec"
        def mailTedein2 = "guido8a@gmail.com"
        def errores = ''


        try{
            mailService.sendMail {
                to mailTedein
                subject "Nuevo correo desde la página web de TEDEIN"
                body "Pregunta o información: " +
                        "\n Nombre: ${params.nombre} " +
                        "\n Teléfono: ${params.telefono} " +
                        "\n Email: ${params.correo} " +
                        "\n Mensaje: ${params.mensaje}"
            }
        }catch (e){
            println("Error al enviar el mail")
            errores += e
        }

        try{
            mailService.sendMail {
                to mailTedein2
                subject "Nuevo correo desde la página web de TEDEIN"
                body "Pregunta o información: " +
                        "\n Nombre: ${params.nombre} " +
                        "\n Teléfono: ${params.telefono} " +
                        "\n Email: ${params.correo} " +
                        "\n Mensaje: ${params.mensaje}"
            }
        }catch (e){
            println("Error al enviar el mail 2")
            errores += e
        }

        if(errores == ''){
            render "ok"
        }else{
            render "no"
        }
    }

    def login_ajax(){

    }

    def buscar() {
        println "buscar: $params"
        redirect(action: 'index', params: params)
//        render "hola"
    }

    def manual() {
        println "manual: $params"
        def nombre = 'externos.pdf'
        def path = '/var/ventas/manual/anuncios.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualAdm() {
        println "manual: $params"
        def nombre = 'administracion.pdf'
        def path = '/var/ventas/manual/administracion.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def terminos() {
//        println "manual: $params"
        def nombre = 'politica del sitio.pdf'
        def path = '/var/ventas/manual/política del sitio.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def error(){

    }
}
