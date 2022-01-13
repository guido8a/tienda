package tienda


import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class PrincipalController {
//    def mailService
    def dbConnectionService

    def index() {
        println "index params: $params"
        def cn = dbConnectionService.getConnection()
        def ctgr = Categoria.list([sort: 'descripcion'])
        def grupo, productos = [], ls = []
        def busqueda = ""
        def enCategoria = ""
        def appUrl
        if (grails.util.Environment.getCurrent().name == 'development') {
            appUrl = '/'
        } else {
            appUrl = '/tienda/'
        }

        if(params.grpo) {
            grupo = Grupo.get(params.grpo)
//            productos = Producto.findAllByGrupo(grupo)
        } else {
            params.grpo = 1
//            productos = Producto.list([sort: 'fecha', order:'desc'])
        }

        def campos = "publ.publ__id, prod__id, publtitl, publsbtl, dtpbvlor, publpcun::numeric(12,2) publpcun, publpcmy "
        def sql = ""

        sql = "select ${campos} from publ, dtpb " +
                "where publetdo = 'A' and dtpb.publ__id = publ.publ__id and dtpbtipo = 'I' and dtpbpncp = '1'"

        def sqlBs = "select ${campos} from publ, dtpb " +
                "where publetdo = 'A' and dtpb.publ__id = publ.publ__id and dtpbtipo = 'I' and dtpbpncp = '1'"

        /* todo: hacer función para descartar palabras: "de para a la el las los las .." */

        /** Se deben mostrar los anuncios vigentes
         * 1. carrusel: destacados de todos los anuncios, si no hay suficientes completar con vntaXX
         * 2. Destacados: productos de anuncios vigentes, completar con "aqui su anuncio" **/
        if(params.bscr) {
            sql = ""
            params.bscr.split(' ').each { t ->
                sql += (sql=='')? "${sqlBs} and prodtitl ilike '%${t}%'" : " union ${sqlBs} and prodtitl ilike '%${t}%'"
            }
        }
        println "sql: $sql"
/*
        if(params.bscr && anuncios){
            sbct = Subcategoria.get(anuncios?.first().sbct__id)
        } else if(params?.bscr?.size() > 3) {
            def ctgr = Categoria.get(params.ctgr)
            enCategoria = ctgr? "la categoría ${ctgr.descripcion}" :'todas las categorías'
            busqueda = "No se ha encontrado anúncios para su búsqueda '<strong>${params.bscr}</strong>' en " +
                    "<strong>${enCategoria}</strong>"
        }
*/

        /** se muestran en el carrusel todos los anuncios vigentes con publicación "destacada": publdstc = '1' **/

        cn.eachRow(sql.toString()) {pb ->
            ls = [tp: 'p', rt: pb.dtpbvlor, p: pb.prod__id, tt: pb.publtitl,
                      sb: pb.publsbtl, id: pb.publ__id, pc: pb.publpcun ]
            productos.add(ls)
        }

        while (productos.size < 4) {
            productos.add(ls)
        }

        println "carrusel ${productos.rt}"
        println "session ${session.cliente}  grpo: ${params.grpo}"


        def cliente = null

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
        }


        [ctgr: ctgr, productos: productos, grpo: params.grpo, cliente: cliente, appUrl: appUrl]
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
        println "getImgnProd: $params"
        def producto = Producto.get(params.id)
//        def path = (params.tp == 'p'? "/var/ventas/productos/pro_${producto.id}/" : "/var/ventas/imagen/destacados/") + params.ruta
        def path
        if(params.tp == 'P') {
            def imagenPrincipal = Imagen.findByProductoAndPrincipal(producto, '1')
            path = "/var/tienda/imagenes/productos/pro_${params.id}/${imagenPrincipal?.ruta}"
        }
        if(params.tp == 'v') path = "/var/tienda/imagenes/images/" + params.ruta
        if(params.tp == 'c') path = "/var/tienda/imagenes/productos/pro_" + params.ruta
        def fileext = path.substring(path.indexOf(".")+1, path.length())

        println "ruta: $path"

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

    def saveRegistro_ajax(){
        println("params -->" + params)
    }

    def carrito_ajax(){
        def cliente = null
        def carrito

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
            carrito = Carrito.findByClienteAndEstado(cliente, 'A')
        }else{

        }

        return[cliente: cliente, carrito: carrito]

    }


}
