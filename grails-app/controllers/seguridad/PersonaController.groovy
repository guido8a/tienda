package seguridad

import geografia.Canton
import geografia.Provincia
import groovy.json.JsonBuilder
import org.apache.commons.lang.WordUtils
import sun.security.provider.MD5

import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC

class PersonaController {

    def tramitesService
    def mailService

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        println "getLista: " + params
        params.offset = params.offset ?: 0
        if (params.search) {
            def tx = params.search.toList()
            tx.size().times() {
                if (tx[it].toString().getBytes('UTF-8').size() > 1) {
                    println "posibe carácter especial: ${tx[it]} es en utf-8:" + tx[it].toString().getBytes('UTF-8')
                    if (tx[it].toString().getBytes('UTF-8')[1] == -123) {
                        println "llega texto en ISO-8859-1"
                    }
                }
            }
        }

        def prms = params.clone()

        if (prms.sort == "perfil") {
            prms.remove("sort")
        }

        if (all || params.estado == "admin") {
            prms.remove("offset")
            prms.remove("max")
        }
        def lista

        def c = Persona.createCriteria()

        lista = c.list(prms) {
            and {
                if (prms.search) {
                    or {
                        ilike("nombre", "%" + prms.search + "%")
                        ilike("apellido", "%" + prms.search + "%")
                        ilike("login", "%" + prms.search + "%")
                        departamento {
                            or {
                                ilike("descripcion", "%" + prms.search + "%")
                            }
                        }
                    }
                }
                if (params.perfil) {
                    perfiles {
                        eq("perfil", Prfl.get(params.perfil.toLong()))
                    }
                }

                if (params.estado) {
                    if (params.estado == "jefe") {
                        eq("jefe", 1)
                    }
                    if (params.estado == "usuario") {
                        eq("activo", 1)
                    }
                    if (params.estado == "inactivo") {
                        eq("activo", 0)
                    }
                }
            }
        }

        lista.unique()

        if (params.estado == "usuario") {
            lista = lista.findAll { it.estaActivo }
        }
        if (params.estado == "inactivo") {
            lista = lista.findAll { !it.estaActivo }
        }
        if (params.estado == "admin") {
            lista = lista.findAll { it.puedeAdmin }
            if (!all && /*params.offset && */params.max && lista.size() > params.max.toInteger()) {
                def init = params.offset.toInteger()/* * params.max.toInteger()*/
                def fin = init + params.max.toInteger()
                if (fin > lista.size()) {
                    fin = lista.size()
                }
                lista = lista.subList(init, fin)
            }
        }

        return lista
    }

    def uploadFile() {
        def usuario = Persona.get(session.usuario.id)
        def path = servletContext.getRealPath("/") + "images/perfiles/"    //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = usuario.id + "." + ext
                def pathFile = path + fileName
                def nombre = fileName
                try {
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                } catch (e) {
                    println "????????\n" + e + "\n???????????"
                }
                /* RESIZE */
                def img = ImageIO.read(new File(pathFile))
                def scale = 0.5
                def minW = 300 * 0.7
                def minH = 400 * 0.7
                def maxW = minW * 3
                def maxH = minH * 3
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

                /* fin resize */

                if (!usuario.foto || usuario.foto != nombre) {
                    def fotoOld = usuario.foto
                    if (fotoOld) {
                        def file = new File(path + fotoOld)
                        file.delete()
                    }
                    usuario.foto = nombre
                    if (usuario.save(flush: true)) {
                        def data = [
                                files: [
                                        [
                                                name: nombre,
                                                url : resource(dir: 'images/perfiles/', file: nombre),
                                                size: f.getSize(),
                                                url : pathFile
                                        ]
                                ]
                        ]
                        def json = new JsonBuilder(data)
                        render json
                        return
                    } else {
                        def data = [
                                files: [
                                        [
                                                name : nombre,
                                                size : f.getSize(),
                                                error: "Ha ocurrido un error al guardar"
                                        ]
                                ]
                        ]
                        def json = new JsonBuilder(data)
                        render json
                        return
                    }
                } else {
                    def data = [
                            files: [
                                    [
                                            name: nombre,
                                            url : resource(dir: 'images/perfiles/', file: nombre),
                                            size: f.getSize(),
                                            url : pathFile
                                    ]
                            ]
                    ]
                    def json = new JsonBuilder(data)
                    render json
                    return
                }
            } else {
                def data = [
                        files: [
                                [
                                        name : fileName + "." + ext,
                                        size : f.getSize(),
                                        error: "Extensión no permitida"
                                ]
                        ]
                ]

                def json = new JsonBuilder(data)
                render json
                return
            }
        }
        render "OK"
    }

    def resizeCropImage() {
        def usuario = Persona.get(session.usuario.id)
        def path = servletContext.getRealPath("/") + "images/perfiles/"    //web-app/archivos
        def fileName = usuario.foto
        def ext = fileName.split("\\.").last()
        def pathFile = path + fileName
        /* RESIZE */
        def img = ImageIO.read(new File(pathFile))

        def oldW = img.getWidth()
        def oldH = img.getHeight()

        int newW = 300 * 0.7
        int newH = 400 * 0.7
        int newX = params.x?.toInteger()
        int newY = params.y?.toInteger()
        def rx = newW / (params.w?.toDouble())
        def ry = newH / (params.h?.toDouble())

        int resW = oldW * rx
        int resH = oldH * ry
        int resX = newX * rx * -1
        int resY = newY * ry * -1

        new BufferedImage(newW, newH, img.type).with { j ->
            createGraphics().with {
                setRenderingHint(KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC)
                drawImage(img, resX, resY, resW, resH, null)
                dispose()
            }
            ImageIO.write(j, ext, new File(pathFile))
        }
        /* fin resize */
        render "OK"
    }

    def personal() {
        def persona = Persona.get(session.usuario.id)

        return [persona: persona]
    }

    def personalAdm() {
        if (session.usuario.puedeAdmin) {
            def usuario = Persona.get(params.id)
            def dep = usuario.departamento
            def triangulos = dep.getTriangulos()
            def personas = Persona.findAllByDepartamentoAndActivo(dep, 1)
            personas.remove(usuario)
            return [usuario: usuario, params: params, triangulos: triangulos, personas: personas]
        } else {
            response.sendError(403)
        }

    }

    def personalArbol() {
        def usuario = Persona.get(params.id)
        def dep = usuario.departamento
        def triangulos = dep.getTriangulos()
        def personas = Persona.findAllByDepartamentoAndActivo(dep, 1)
        personas.remove(usuario)
        return [usuario: usuario, params: params, triangulos: triangulos, personas: personas]
    }

    def loadFoto() {
        def usuario = Persona.get(session.usuario.id)
        def path = servletContext.getRealPath("/") + "images/perfiles/" //web-app/archivos
        def img
        def w
        def h
        if (usuario?.foto) {
            if(ImageIO?.read(new File(path + usuario.foto))){
                img = ImageIO?.read(new File(path + usuario.foto));
                w = img.getWidth();
                h = img.getHeight();
            }
        } else {
            w = 0
            h = 0
        }
        return [usuario: usuario, w: w, h: h]
    }

    def validarPass_ajax() {
        def usuario = Persona.get(session.usuario.id)
        render usuario.password == params.password_actual.toString().trim().encodeAsMD5()
    }

    def validar_aut_previa_ajax() {
        println "validar_aut_previa_ajax $params"
        params.input1 = params.input1.trim()
        def obj = Persona.get(params.id)
        if (obj.autorizacion == params.input1.encodeAsMD5()) {
            render true
        } else {
            render false
        }
    }


//    def savePass_ajax() {
//        println "savePass_ajax  $params"
//        def persona = Persona.get(params.id)
//        def str = params.tipo == "pass" ? "contraseña" : "autorización"
//        params.input2 = params.input2.trim()
//        params.input3 = params.input3.trim()
//        if (params.input2 == params.input3) {
//            println "....1 autoriz: ${persona.autorizacion}"
//            if (params.tipo == "pass") {
//                persona.password = params.input2.encodeAsMD5()
//                persona.save(flush: true)
//            } else {
//                if (persona.autorizacion == params.input1.trim().encodeAsMD5() || !persona.autorizacion) {
//                    persona.autorizacion = params.input2.encodeAsMD5()
//                    persona.save(flush: true)
//                } else {
//                    render "ERROR*La autorización actual es incorrecta"
//                    return
//                }
//            }
//        } else {
//            render "ERROR*La ${str} y la verificación no coinciden"
//            return
//        }
//        render "SUCCESS*La ${str} ha sido modificada exitosamente"
//    }


    def savePass_ajax() {
        println "savePass_ajax  $params"
        def persona = Persona.get(params.id)
//        params.input2 = params.input2.trim()

        if(params.nuevoPass.trim() == params.passConfirm.trim()){

            persona.password = params.nuevoPass.encodeAsMD5()
            persona.fecha = new Date() + 90
            if(!persona.save(flush: true)){
                println("error al guardar el nuevo password " + persona.errors)
                render "no_Error al guardar el password"
            }else{
                render "ok_La contraseña ha sido modificada exitosamente"
            }
        }else{
            render "no_El password ingresado y su confirmación no coinciden"
        }
    }



    def saveTelf() {
        def usuario = Persona.get(session.usuario.id)
        def telefono = params.telefono
        usuario.telefono = params.telefono?.trim()
        if (usuario.save(flush: true)) {
            render "OK_Teléfono actualizado correctamente"
        }
    }

    def accesos() {
        def usu = Persona.get(params.id)
        def accesos = Acceso.findAllByUsuario(usu, [sort: 'accsFechaInicial'])
        return [accesos: accesos]
    }

    def permisos() {
        def usu = Persona.get(params.id)
        def permisos = PermisoUsuario.findAllByPersona(usu, [sort: 'fechaInicio'])
        return [permisos: permisos]
    }

    def ausentismo() {
        def usu = Persona.get(params.id)
        return [usuario: usu/*, perfilesUsu: perfilesUsu, permisosUsu: permisosUsu*/]
    }

    def config() {
        def usu = Persona.get(params.id)
        def perfilesUsu = Sesn.findAllByUsuario(usu)
        def pers = []
        perfilesUsu.each {
            if (it.estaActivo) {
                pers.add(it.perfil.id)
            }
        }

        def perfiles

        def perfilAdmin = Prfl.findByCodigo('ADMN')
        def usuarioActual = Persona.get(session.usuario.id)
        def sesionActual = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfilAdmin, usuarioActual)



        if(sesionActual){
            perfiles = Prfl.list().sort{it.nombre}
        }else{
            def perfilesSinAccesso = [1,2]
            perfiles = Prfl.findAllByIdNotInList(perfilesSinAccesso).sort{it.nombre}
        }

        return [usuario: usu, perfilesUsu: pers, perfiles: perfiles]
    }


    def terminarPermiso_ajax() {
        def perm = PermisoUsuario.get(params.id)
        def now = new Date().clearTime()
        if (perm.fechaFin && perm.fechaFin <= now) {
            render "INFO_El permiso ya ha caducado, no puede terminarlo de nuevo."
        } else {
            if (perm.fechaInicio <= now && (perm.fechaFin >= now || !perm.fechaFin)) {
                perm.fechaFin = now
                if (!perm.save(flush: true)) {
                    render "NO_" + renderErrors(bean: perm)
                } else {
                    render "OK_Terminación del permiso exitosa"
                }
            } else {
                render "INFO_No puede terminar un permiso que no ha empezado aún. Puede eliminarlo."
            }
        }
    }

    def eliminarPermiso_ajax() {
        def perm = PermisoUsuario.get(params.id)
        def now = new Date()
        if (perm.fechaFin && perm.fechaFin <= now) {
            render "INFO_El permiso ya ha caducado, no puede ser eliminado."
        } else {
            if (perm.fechaInicio <= now && (perm.fechaFin >= now || !perm.fechaFin)) {
                render "INFO_No puede eliminar un permiso en curso. Puede terminarlo."
            } else {
                try {
                    perm.delete(flush: true)
                    render "OK_Permiso eliminado."
                } catch (e) {
                    render "NO_Ha ocurrido un error al eliminar el permiso."
                }
            }
        }
    }

    /**
     * los perfiles activos del usaurio deben tener fecha de inicio y fecha de fin en nulo
     * cada vez que se elimina un perfil del usuario se lo borra de la tabla sesn
     * hay que manejar las fechas para cuando se elimina un perfil de susuario y no el borrar sesion
     * validar tambien con el dominio Sesn para los atributos   getEstaActivo
     * @return
     */
    def savePerfiles_ajax() {
        println "save perfiles: " + params
        def usu = Persona.get(params.id)
        def now = new Date()
//        def perfilesUsu = Sesn.findAllByUsuario(usu).perfil.id*.toString()
        def perfilesUsu = Sesn.findAllByUsuarioAndFechaInicioLessThanAndFechaFinIsNull(usu, now).perfil.id*.toString()

        def arrRemove = perfilesUsu, arrAdd = []
        def errores = ""

        if (params.perfil instanceof java.lang.String) {
            params.perfil = [params.perfil]
        }
//        println "params perfil: " + params.perfil
        println "perfiles usu: " + perfilesUsu

        params.perfil.each { pid ->
            if (perfilesUsu.contains(pid)) {
                //ya tiene este perfil: le quito de la lista de los de eliminar
                arrRemove.remove(pid)
            } else {
                //no tiene este perfil: le pongo en la lista de agregar
                arrAdd.add(pid)
            }
        }

        println "ADD " + arrAdd
        println "REMOVE " + arrRemove

        arrRemove.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = Sesn.findByUsuarioAndPerfil(usu, perf)
            try {
                sesn.fechaFin = new Date()
//                sesn.fechaInicio = null
//                sesn.delete(flush: true)
            } catch (e) {
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }
        arrAdd.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = new Sesn([usuario: usu, perfil: perf, fechaInicio: new Date()])
            if (!sesn.save(flush: true)) {
                errores += "<li>No se puedo remover el perfil ${perf.nombre}</li>"
            }
        }

        if (errores == "") {
            def permisosDebeTener = []
            /* *********** actualiza PRUS  ************ */
            Sesn.findAllByUsuarioAndFechaFinIsNull(usu).each {
                def prpf = Prpf.findAllByPerfil(it.perfil)
                permisosDebeTener += prpf.permiso
            }
            permisosDebeTener = permisosDebeTener.unique()
            println "permisos que debe tener: $permisosDebeTener"

            def permisosTiene = PermisoUsuario.findAllByPersonaAndFechaFinIsNull(usu)
            def permisosAgregar = permisosDebeTener.clone()
            def permisosTerminar = []
            permisosTiene.each { actual ->
                if (!permisosDebeTener.contains(actual.permisoTramite)) {
                    permisosTerminar.add(actual)
                    permisosAgregar.remove(actual.permisoTramite)
                }
                if (permisosDebeTener.contains(actual.permisoTramite) && (actual.fechaFin == null)) {
                    permisosAgregar.remove(actual.permisoTramite)
                }
            }
            println "permisos que debe terminar: $permisosTerminar"
            permisosTerminar.each {
                it.fechaFin = new Date()
                if (!it.save(flush: true)) {
                    println "savePerfiles_ajax:" + it.errors
                    errores += "<li>No se pudo terminar permiso ${it.permisoTramite.descripcion}</li>"
                }
            }

            if (errores == "") {
                render "OK_Cambios efectuados exitosamente"
            } else {
                render "<ul>" + errores + "</ul>"
            }
        } else {
            render "<ul>" + errores + "</ul>"
        }
    }

    def verRedireccionar_ajax() {
        def persona = Persona.get(params.id)
        return [persona: persona, tramites: params.tramites.toInteger()]
    }

    def verDesactivar_ajax() {
        def persona = Persona.get(params.id)
        return [persona: persona, tramites: params.tramites.toInteger()]
    }

    def list() {

        def empresa = Empresa.get(params.id)

        def perfilAdmin = Prfl.findByCodigo('ADMN')
        def usuarioActual = Persona.get(session.usuario.id)
        def sesionActual = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfilAdmin, usuarioActual)
        def usuarios


        if(sesionActual){
            usuarios = Persona.findAllByEmpresa(empresa).sort{it.login}
        }else{
            def sesionesAdmin = Sesn.findAllByPerfilAndFechaFinIsNull(perfilAdmin)
            usuarios = Persona.findAllByEmpresaAndIdNotInList(empresa, sesionesAdmin.usuario.id).sort{it.login}
        }

        return[usuarios: usuarios, empresa: empresa]


//        println "list: $params"
//        if (session.usuario.puedeAdmin) {
//            params.max = Math.min(params.max ? params.max.toInteger() : 15, 100)
//            params.sort = params.sort ?: "apellido"
//            params.perfil = params.perfil ?: ''
//            params.estado = params.estado ?: ''
//            def personaInstanceList = getLista(params, false)
//            def personaInstanceCount = getLista(params, true).size()
//            if (personaInstanceList.size() == 0 && params.offset && params.max) {
//                params.offset = params.offset - params.max
//                personaInstanceList = getLista(params, false)
//            }
//
//            println("p " + personaInstanceList)
//
//            return [personaInstanceList: personaInstanceList, personaInstanceCount: personaInstanceCount, params: params]
//        } else {
//            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
//            response.sendError(403)
//        }
    } //list

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return personaInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */

    def show_ajax() {
        if (params.id) {
            def personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }

            def perfiles = Sesn.findAllByUsuarioAndFechaFinIsNull(personaInstance).sort{it.perfil.descripcion}

            return [personaInstance: personaInstance, perfiles: perfiles]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        println("params fp " + params)

        def empresa = Empresa.get(params.empresa)
        def personaInstance = new Persona(params)
        def perfiles = []
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
            perfiles = Sesn.withCriteria {
                eq("usuario", personaInstance)
                perfil {
                    order("nombre", "asc")
                }
            }
        }
        personaInstance.properties = params
        return [personaInstance: personaInstance, perfiles: perfiles, empresa: empresa]
    }

    def activar_ajax() {
        def persona = Persona.get(params.id)
        persona.activo = 1
        persona.fechaInicio = new Date()
        persona.fechaFin = null
        if (persona.save(flush: true)) {
            render "OK_Persona activada exitosamente"
        } else {
            render "NO_Ha ocurrido un error: " + renderErrors(bean: persona)
        }
    }

    def redireccionarTramites(params) {
        def persona = Persona.get(params.id)
        def dpto = persona.departamento
        def rolPara = RolPersonaTramite.findByCodigo('R001');
        def rolCopia = RolPersonaTramite.findByCodigo('R002');
        def rolImprimir = RolPersonaTramite.findByCodigo('I005')
        def tramites = PersonaDocumentoTramite.findAll("from PersonaDocumentoTramite as p  inner join fetch p.tramite as tramites where p.persona=${params.id} and  p.rolPersonaTramite in (${rolPara.id + "," + rolCopia.id + "," + rolImprimir.id}) and p.fechaEnvio is not null and tramites.estadoTramite in (3,4) order by p.fechaEnvio desc ")
        def errores = "", ok = 0
        tramites.each { pr ->
            if (pr.rolPersonaTramite.codigo == "I005") {
                pr.delete(flush: true)
            } else {
                def obs = "Trámite antes dirigido a " + persona.nombre + " " + persona.apellido + ", ${params.razon}"

                def personaAntes = pr.persona
                def dptoAntes = pr.departamento

                if (params.quien == "-") {
                    pr.persona = null
                    pr.departamento = dpto
                    obs += " al departamento ${dpto.descripcion}"
                } else {
                    pr.persona = Persona.get(params.quien)
                    obs += " al usuario ${pr.persona.login}"
                }
                obs += " el ${new Date().format('dd-MM-yyyy HH:mm')} por ${session.usuario.login}"
                def tramite = pr.tramite

                println "NO DEBERIA IMPRIMIR ESTO NUNCA"
                tramite.observaciones = tramitesService.modificaObservaciones(tramite.observaciones, obs)
                pr.observaciones = tramitesService.modificaObservaciones(pr.observaciones, obs)
                if (tramite.save(flush: true)) {
                } else {
                    errores += renderErrors(bean: tramite)
                    println tramite.errors
                }
                if (!pr.persona && !pr.departamento) {
                    pr.persona = personaAntes
                    pr.departamento = dptoAntes
                    println "NO DEBERIA IMPRIMIR ESTO NUNCA"
                    pr.observaciones = tramitesService.modificaObservaciones(pr.observaciones, "Ocurrió un error al redireccionar (${new Date().format('dd-MM-yyyy HH:mm')}).")
                    errores += "<ul><li>Ha ocurrido un error al redireccionar.</li></ul>"
                }
                if (pr.save(flush: true)) {
                    ok++
                } else {
                    println pr.errors
                    errores += renderErrors(bean: pr)
                }
            }
        }
        if (errores != "") {
            println "NOPE: " + errores
            return "NO_" + errores
        } else {
            return "OK_Cambio realizado exitosamente"
        }
    }

    def redireccionar_ajax() {
        params.razon = "redireccionado"
        render redireccionarTramites(params)
    }

    def desactivar_ajax() {
        def persona = Persona.get(params.id)
        def dpto = persona.departamento
        persona.activo = 0
        persona.fechaFin = new Date()
        if (persona.save(flush: true)) {
            render "OK_Cambio realizado exitosamente"
        } else {
            render "NO_Ha ocurrido un error al desactivar la persona.<br/>" + renderErrors(bean: persona)
        }
    }

    def formUsuario_ajax() {
        def personaInstance = new Persona(params)
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        }
        return [personaInstance: personaInstance]
    }


    def validarMail_ajax() {
        params.mail = params.mail.toString().trim()
        if (params.id) {
            def prsn = Persona.get(params.id)
            if (prsn.mail == params.mail) {
                render true
                return
            } else {
                render Persona.countByMail(params.mail) == 0
                return
            }
        } else {
            render Persona.countByMail(params.mail) == 0
            return
        }
    }

    def validarLogin_ajax() {
        params.login = params.login.toString().trim()
        if (params.id) {
            def prsn = Persona.get(params.id)
            if (prsn.login.toLowerCase() == params.login.toLowerCase()) {
                render true
                return
            } else {
                render Persona.countByLoginIlike(params.login) == 0
                return
            }
        } else {
            render Persona.countByLoginIlike(params.login) == 0
            return
        }
    }


    def save_ajax() {
//        println "save_ajx: $params"

        params.mail = params.mail.toString().toLowerCase()
        def personaInstance = new Persona()
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        } else {
            params.fecha = new Date()
            params.password = '123'.encodeAsMD5()
        }
        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            println "error al guardar la persona " + personaInstance.errors
            render "ERROR*Ha ocurrido un error al guardar Persona: "
        }else{
            render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Persona exitosa."
        }

//        def perfiles = params.perfilUsuario
//
//        if (perfiles) {
//            def perfilesOld = Sesn.findAllByUsuario(personaInstance)
//            def perfilesSelected = []
//            def perfilesInsertar = []
//            (perfiles.split("_")).each { perfId ->
//                def perf = Prfl.get(perfId.toLong())
//                if (!perfilesOld.perfil.id.contains(perf.id)) {
//                    perfilesInsertar += perf
//                } else {
//                    perfilesSelected += perf
//                }
//            }
//            def commons = perfilesOld.perfil.intersect(perfilesSelected)
//            def perfilesDelete = perfilesOld.perfil.plus(perfilesSelected)
//            perfilesDelete.removeAll(commons)
//
//            def errores = ""
//
//            perfilesInsertar.each { perfil ->
//                def sesion = new Sesn()
//                sesion.usuario = personaInstance
//                sesion.perfil = perfil
//                if (!sesion.save(flush: true)) {
//                    errores += renderErrors(bean: sesion)
//                    println "error al guardar sesion: " + sesion.errors
//                }
//            }
//            perfilesDelete.each { perfil ->
//                def sesion = Sesn.findAllByPerfilAndUsuario(perfil, personaInstance)
//                try {
//                    if (sesion.size() == 1) {
//                        sesion.first().delete(flush: true)
//                    } else {
//                        errores += "Existen ${sesion.size()} registros del permiso " + perfil.nombre
//                    }
//                } catch (Exception e) {
//                    errores += "Ha ocurrido un error al eliminar el perfil " + perfil.nombre
//                    println "error al eliminar perfil: " + e
//                }
//            }
//        }
    } //save para grabar desde ajax


    def cambioDpto_ajax() {
        def persona = Persona.get(params.id)
        def dpto = Departamento.get(params.dpto)
        def dptoOld = persona.departamento
        persona.departamento = dpto
        if (persona.save(flush: true)) {
            def rolPara = RolPersonaTramite.findByCodigo('R001');
            def rolCopia = RolPersonaTramite.findByCodigo('R002');
            def rolImprimir = RolPersonaTramite.findByCodigo('I005')

            def tramites = PersonaDocumentoTramite.findAll("from PersonaDocumentoTramite as p inner join fetch p.tramite as tramites " +
                    "where p.persona=${params.id} and  p.rolPersonaTramite in (${rolPara.id + "," + rolCopia.id + "," + rolImprimir.id}) and " +
                    "p.fechaEnvio is not null and tramites.estadoTramite in (3,4) order by p.fechaEnvio desc ")
            def errores = "", ok = 0
            /**
             * a cada trámite si el usuario cambia de departamento se cambia PRTR eliminando la persona destinaria
             * y haciendo que aparezca su dpto como destinatario
             * todo: revisar para que el trámite quede tal cual y no cambie el destinatario.. ver si se afecta el arbol
             */
            tramites.each { pr ->
                if (pr.rolPersonaTramite.codigo == "I005") {
                    pr.delete(flush: true)
                } else {
                    pr.persona = null
                    pr.departamento = dptoOld
                    def tramite = pr.tramite
                    def observacionOriginal = pr.observaciones
                    def accion = "Cambio de departamento"
                    def solicitadoPor = ""
                    def usuario = session.usuario.login
                    def texto = "Trámite antes dirigido a " + persona.nombre + " " + persona.apellido
                    def nuevaObservacion = ""
                    pr.observaciones = tramitesService.observaciones(observacionOriginal, accion, solicitadoPor, usuario, texto, nuevaObservacion)
                    observacionOriginal = tramite.observaciones
                    tramite.observaciones = tramitesService.observaciones(observacionOriginal, accion, solicitadoPor, usuario, texto, nuevaObservacion)

                    if (tramite.save(flush: true)) {
                    } else {
                        errores += renderErrors(bean: tramite)
                        println tramite.errors
                    }
                    if (pr.save(flush: true)) {
                        ok++
                    } else {
                        println pr.errors
                        errores += renderErrors(bean: pr)
                    }
                }
            }
            if (errores != "") {
                println "NOPE: " + errores
                render "NO_" + errores
            } else {
                render "OK_Cambio realizado exitosamente"
            }
        } else {
            render "NO_Ha ocurrido un error al cambiar el departamento de la persona.<br/>" + renderErrors(bean: persona)
        }
    } //cambio dpto

    /*** se puede boirrar el usaurio siempre y cuando no haya registros en:
     *   trmt.prsn__de: Persona.de
     *   prtr.prsn__id: Persona.persona
     *   accs.usro__id: Persona.usuario y Persona.asignadoPor
     */
    def delete_ajax() {
        def mnsj = ""
        if (params.id) {
            def personaInstance = Persona.get(params.id)

//            if (Acceso.findByUsuario(personaInstance)) {
//                mnsj += "La persona tiene permisos de ausentismo\n"
//            }
//            if (Acceso.findByAsignadoPor(personaInstance)) {
//                mnsj += "La persona ha registrado ausentismo\n"
//            }
//            if (PermisoUsuario.findByAsignadoPor(personaInstance)) {
//                mnsj += "La persona ha realizado Asignación de permisos\n"
//            }
//            if (PermisoUsuario.findByModificadoPor(personaInstance)) {
//                mnsj += "La persona ha realizado Modificación de permisos\n"
//            }
//            if (personaInstance.activo) {
//                mnsj += "La persona se halla activa\n"
//            }

//            if (!mnsj) {
                def prsn = personaInstance.nombre + " " + personaInstance.apellido
                if (personaInstance) {
                    try {
                        Sesn.findAllByUsuario(personaInstance).each { pr ->
                            pr.delete(flush: true)
                        }

//                        PermisoUsuario.findAllByPersona(personaInstance).each { pr ->
//                            pr.delete(flush: true)
//                        }

                        personaInstance.delete(flush: true)
                        render "OK_${prsn} ha sido eliminada(o) del sistema"
                    } catch (e) {
                        render "NO_" + "Error al eliminar el usuario del sistema"
                    }
                } else {
                    notFound_ajax()
                }

//            } else {
//                render "NO_" + mnsj
//            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró la persona."
    } //notFound para ajax


    def cambiarNombresUsuarios() {
        Persona.list().each { p ->
            p.nombre = WordUtils.capitalizeFully(p.nombre)
            p.apellido = WordUtils.capitalizeFully(p.apellido)
            p.save(flush: true)
        }
    }

    def guardarPerfiles_ajax () {
//        println("params prfl " + params)

        def errores = ''
        def personaInstance = Persona.get(params.id)
        def perfilActual = Prfl.get(session.perfil.id)
        def usuarioActual = Persona.get(session.usuario.id)
        def sesionActual = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfilActual, personaInstance)
        def sesionActualAdmin = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfilActual, usuarioActual)
        def perfilesOld = Sesn.findAllByUsuarioAndFechaFinIsNull(personaInstance)
//        def perfilesOld = Sesn.findAllByUsuarioAndFechaFinIsNull(usuarioActual)

//        println("old " + perfilesOld)
//        println("perfiles " + perfiles)
//        println("<<<< " + perfiles?.size())
//        println("se ac " + sesionActual.perfil.descripcion)
//        println("se ac " + sesionActual.usuario)

//        if (perfiles?.size() > 0) {
        if (params.perfiles) {

            def perfiles = params.perfiles.split("_")
            def perfilesSelected = []
            def perfilesInsertar = []

            perfiles.each { perfId ->
                def perf = Prfl.get(perfId.toLong())
                if (!perfilesOld.perfil.id.contains(perf.id)) {
                    perfilesInsertar += perf
                } else {
                    perfilesSelected += perf
                }
            }
            def commons = perfilesOld.perfil.intersect(perfilesSelected)
            def perfilesDelete = perfilesOld.perfil.plus(perfilesSelected)
            perfilesDelete.removeAll(commons)



//            println("p i " + perfilesInsertar)
//            println("p b " + perfilesDelete)

            if(perfilesInsertar){
                perfilesInsertar.each { perfil ->
                    def sesion = new Sesn()
                    sesion.usuario = personaInstance
                    sesion.perfil = perfil
                    sesion.fechaInicio = new Date();
                    if (!sesion.save(flush: true)) {
                        errores += sesion.errors
                        println "error al guardar sesion: " + sesion.errors
                        render "no"
                    }
                }
            }

            def bandera = false

            if(errores == ''){
                if(perfilesDelete){
                    if(perfilesDelete.contains(sesionActual.perfil)){
                        bandera = true
                    }else{
                        perfilesDelete.each { perfil ->
                            def perfilB = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfil.perfil, personaInstance)

                            if(perfilB){
                                perfilB.fechaFin = new Date()

                                if(!perfilB.save(flush: true)){
                                    errores += "Ha ocurrido un error al eliminar el perfil " + perfilB.errors
                                    println "error al eliminar perfil: " + perfilB.errors
                                }
                            }
                        }
                    }

                    if(bandera){
                        println("entro1")
                        render "er_No puede borrar el perfil ${sesionActual}, está actualmente en uso"
                    }else{
                        if(errores != ''){
                            render "no"
                        }else{
                            render "ok"
                        }
                    }
                }else{
                    render "ok"
                }
            }else{
                render "no"
            }
        }else{
//            if(sesionActual.usuario == personaInstance){
            if(sesionActualAdmin.usuario == personaInstance){
                render "er_No puede borrar el perfil ${sesionActual}, está actualmente en uso"
            }else{

                def perfilesBorrar = Sesn.findAllByUsuario(personaInstance)

                perfilesBorrar.each { perfil ->
                    def perfilB = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfil.perfil, personaInstance)

                    if(perfilB){
                        perfilB.fechaFin = new Date()

                        if(!perfilB.save(flush: true)){
                            errores += "Ha ocurrido un error al eliminar el perfil " + perfilB.errors
                            println "error al eliminar perfil: " + perfilB.errors
                        }
                    }
                }

                if(errores != ''){
                    render "no"
                }else{
                    render "ok"
                }

            }
        }
    }

    def savePersona_ajax(){

        println("params sp " + params)
        def persona

        if(params.id){
            persona = Persona.get(params.id)
        }else{
            persona = new Persona()
            persona.fechaInicio = new Date()
        }

        persona.properties = params

        if(!persona.save(flush:true)){
            println("error al guardar la informacion de la persona" + persona.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def borrarPersona_ajax(){

    }

    def perfiles_ajax(){

        def persona = Persona.get(params.id)

        return[personaInstance: persona]
    }


    def perfilesDisponibles_ajax(){
        def persona = Persona.get(params.id)
        def perfilesActuales = Sesn.findAllByUsuarioAndFechaFinIsNull(persona).perfil
//        println("perfil actual " + perfilesActuales)
        def perfilesDisponibles
        if(perfilesActuales){
            perfilesDisponibles = Prfl.findAllByIdNotInList(perfilesActuales.id).sort{it.nombre}
        }else{
            perfilesDisponibles = Prfl.list().sort{it.nombre}
        }

//        println("perfil disponible " + perfilesDisponibles)

        return[persona: persona, perfiles: perfilesDisponibles]
    }

    def tablaPerfiles_ajax(){
        def persona = Persona.get(params.id)
        def perfilesActuales = Sesn.findAllByUsuarioAndFechaFinIsNull(persona)
        return[persona: persona, perfiles: perfilesActuales]
    }

    def borrarPerfil_ajax(){

        def persona = Persona.get(params.id)
        def perfil =  Prfl.get(params.perfil)
        def sesionActual = session.pr.id
        def sesion = Sesn.findByUsuarioAndPerfilAndFechaFinIsNull(persona, perfil)
//        if(sesionActual.toInteger() == sesion.id.toInteger()){
//            render "er_No se puede borrar el perfil, está siendo usado por el usuario actual!"
//        }else{
        sesion.fechaFin = new Date()
        if(!sesion.save(flush: true)){
            println("error al borrar el perfil " + sesion.errors)
            render "no"
        }else{
            render "ok"
        }
//        }
    }

    def agregarPerfil_ajax(){
        def persona = Persona.get(params.id)
        def perfil =  Prfl.get(params.perfil)
        def sesion = new Sesn()

        sesion.fechaInicio = new Date()
        sesion.perfil = perfil
        sesion.usuario = persona
        sesion.permisoPerfil = null

        if(!sesion.save(flush: true)){
            println("error al guardar el perfil" + sesion.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def registro_ajax(){
        println "registro_ajax $params"
        def persona = new Persona()
        return[persona: persona]
    }

    def saveRegistro_ajax(){

        println("params" + params)


        def existeCorreo = Persona.findAllByMail(params.mail)

        if(existeCorreo){
            render "er_Ya existe un usuario registrado con ese correo"
        }else{

            params.fecha = new Date()
            params.activo = 1
            params.login = params.mail

            def persona = new Persona()
            persona.properties = params

            if(!persona.save(flush:true)){
                println("error al crear el usuario " + persona.errors)
                render "no"
            }else{

                def sesion = new Sesn()
                sesion.usuario = persona
                sesion.fechaInicio = new Date()
                sesion.perfil = Prfl.findByCodigo('USUV')

                if(!sesion.save(flush:true)){
                    println("error al asignar el perfil del usuario " + sesion.errors)
                    render "no"
                }else{
                    println("persona p " + persona)

                    def ec = enviarCorreoRegistro(persona)
                    if(ec){
                        render "ok"
                    }else{
                        render "no"
                    }
                }
            }
        }


    }

    def enviarCorreoRegistro(Persona per){

//        println("persona -> " + per)

        def pass = crearContrasenia()
        per.password = pass.encodeAsMD5()
        per.save(flush: true)

        def mail = per.mail
        def errores = ''

        try{
            mailService.sendMail {
                to mail
                subject "Correo de verificación desde VENTAS"
                body "Datos de ingreso: " +
                        "\n Usuario: ${per.mail} " +
                        "\n Contraseña: ${pass} "
            }
        }catch (e){
            println("Error al enviar el mail: " + e)
            errores += e
        }

        if(errores == ''){
            return true
        }else{
            return false
        }
    }

    def crearContrasenia(){

        String charset = (('A'..'Z') + ('0'..'9')).join()
        Integer length = 9
        String randomString = org.apache.commons.lang.RandomStringUtils.random(length, charset.toCharArray())

        println("--> " + randomString)

        return randomString
    }

    def canton_ajax(){
        println("params c " + params)
        def provincia = Provincia.get(params.id)
        def persona = Persona.get(params.persona)
        def cantones = Canton.findAllByProvincia(provincia).sort{it.nombre}
        return[cantones: cantones, persona: persona]
    }

    def password_ajax(){

    }

    def recuperarPassword_ajax(){

        println("params " + params)

        def existePassword = Persona.findByMail(params.mail.toString().trim())

        if(existePassword){

            def pass = crearContrasenia()
            existePassword.password = pass.encodeAsMD5()
            existePassword.save(flush: true)

            def mail = existePassword.mail
            def errores = ''

            try{
                mailService.sendMail {
                    to mail
                    subject "Correo de recuperación de contraseña del sistema Ventas"
                    body "Datos: " +
                            "\n Usuario: ${existePassword.mail} " +
                            "\n Nueva Contraseña: ${pass} "
                }
            }catch (e){
                println("Error al enviar el mail: " + e)
                errores += e
            }

            if(errores == ''){
                render "ok"
            }else{
                render "no"
            }

        }else{
            render "er_El mail ingresado no se encuentra registrado en el sistema"
        }

    }
}
