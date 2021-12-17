package seguridad

class LoginController {

    def mail

    def dbConnectionService

    def index() {
        redirect(controller: 'login', action: 'login')
    }

    def conecta(user, pass) {

        def prmt = Parametros.findAll()[0]

        def connect = true
        try {

//            LDAP ldap = LDAP.newInstance('ldap://' + prmt.ipLDAP, "${user.getConnectionString()}", "${pass}")

            /*valida usuario en el LDAP */
//            ldap.exists("${prmt.textoCn}")
            println "ingresa..${user.login}"

        } catch (e) {
            println "no conecta ${user.login} error: " + e
            connect = false
        }
        return connect
    }

    def cambiarPass() {
        def usu = Persona.get(session.usuario.id)
        return [usu: usu]
    }

    def validarPass() {
//        println params
        render "No puede ingresar este valor"
    }

    def guardarPass() {
        def usu = Persona.get(params.id)
        usu.password = params.pass.toString().encodeAsMD5()
        usu.fechaCambioPass = new Date() + 30
        if (!usu.save(flush: true)) {
            println "Error: guardarPass " + usu.errors
            flash.message = "Ha ocurrido un error al guardar su nuevo password"
            flash.tipo = "error"
            redirect(action: 'cambiarPass')
        } else {
//            redirect(controller: "inicio", action: "index")
            redirect(controller: "provincia", action: "mapa", id: 1)
        }
    }

    def validarSesion() {
        println "sesion creada el:" + new Date(session.getCreationTime()) + " hora actual: " + new Date()
        println "último acceso:" + new Date(session.getLastAccessedTime()) + " hora actual: " + new Date()

        println session.usuario
        if (session.usuario) {
            render "OK"
        } else {
            flash.message = "Su sesión ha caducado, por favor ingrese nuevamente."
            render "NO"
        }
    }

    def olvidoPass() {
        def mail = params.email
        def personas = Persona.findAllByMail(mail)
        def msg
        if (personas.size() == 0) {
            flash.message = "No se encontró un usuario con ese email"
        } else if (personas.size() > 1) {
            flash.message = "Ha ocurrido un error grave (n)"
        } else {
            def persona = personas[0]

            def random = new Random()
            def chars = []
            ['A'..'Z', 'a'..'z', '0'..'9', ('!@$%^&*' as String[]).toList()].each { chars += it }
            def newPass = (1..8).collect { chars[random.nextInt(chars.size())] }.join()

            persona.password = newPass.encodeAsMD5()
            if (persona.save(flush: true)) {
                sendMail {
                    to mail
                    subject "Recuperación de contraseña"
                    body 'Hola ' + persona.login + ", tu nueva contraseña es " + newPass + "."
                }
                msg = "OK*Se ha enviado un email a la dirección " + mail + " con una nueva contraseña."
            } else {
                msg = "NO*Ha ocurrido un error al crear la nueva contraseña. Por favor vuelva a intentar."
            }
        }
        redirect(action: 'login')
    }

    def login() {
//        println "login " + params
//        def cn = dbConnectionService.getConnection()
//        def sql = "", sql1, sql2
        def usro = session.usuario
        def cn = "inicio"
        def an = "index"
        if (usro) {
            redirect(controller: cn, action: an)
        }
//        sql1 = "select max(prdo__id) prdo from smfr"
//        def ultimo = cn.rows(sql1.toString())[0]?.prdo
//        [ultimo: ultimo]
    }

    def validar() {
        println "valida " + params
        def user = Persona.withCriteria {
            eq("login", params.login, [ignoreCase: true])
            eq("activo", 1)
        }

        println "usuario: ${user.nombre} pass: ${user.password}"

        if (user.size() == 0) {
            flash.message = "No se ha encontrado el usuario"
            flash.tipo = "error"
            flash.icon = "fa fa-exclamation-triangle"
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
            flash.tipo = "error"
            flash.icon = "fa fa-exclamation-triangle"
        } else {
            user = user[0]

            println "está activo " + user.estaActivo

            if (!user.estaActivo) {
                flash.message = "El usuario ingresado no esta activo."
                flash.tipo = "error"
                flash.icon = "fa fa-exclamation-triangle"
//                redirect(controller: 'login', action: "login")
                redirect(controller: 'inicio', action: "index")
                return
            } else {
                session.usuario = user
                session.empresa = user.empresa
//                session.usuarioKerberos = user.login
                session.time = new Date()
//                session.unidad = user.unidadEjecutora

                println "pone valores " + session.usuario

                def perf = Sesn.findAllByUsuario(user)
                def perfiles = []
                perf.each { p ->
                    println "añade a perfiles $p activo:${p.estaActivo}"
                    if (p.estaActivo) {
                        perfiles.add(p)
                    }
                }

                if (perfiles.size() == 0) {
                    flash.message = "No puede ingresar porque no tiene ningun perfil asignado a su usuario. Comuníquese con el administrador."
                    flash.tipo = "error"
                    flash.icon = "fa fa-exclamation-triangle"
                    session.usuario = null
                } else {

                    println "el md5 del pass: ${params.pass} es ${params.pass.encodeAsMD5()} contraseña: ${user.password}"
                    if (params.pass.encodeAsMD5() != user.password) {
                        flash.message = "Contraseña incorrecta"
                        flash.tipo = "error"
                        flash.icon = "fa fa-exclamation-triangle"
                        session.usuario = null
                        session.departamento = null
//                            redirect(controller: 'login', action: "login")
                        redirect(controller: 'inicio', action: "index")
                        return
                    }

                    // registra sesion activa ------------------------------
                    //                println  "sesion ingreso: $session.id  desde ip: ${request.getRemoteAddr()}"  //activo
                    def activo = new SesionActiva()
                    activo.idSesion = session.id
                    activo.fechaInicio = new Date()
                    activo.activo = 'S'
                    activo.dirIP = request.getRemoteAddr()
                    activo.login = user.login
                    activo.save()
                    // pone X en las no .... cerradas del mismo login e ip
                    def abiertas = SesionActiva.findAllByLoginAndDirIPAndFechaFinIsNullAndIdSesionNotEqual(session.usuario.login,
                            request.getRemoteAddr(), session.id)
                    if (abiertas.size() > 0) {
                        abiertas.each { sa ->
                            sa.fechaFin = new Date()
                            sa.activo = 'X'
                            sa.save()
                        }
                    }
                    // ------------------fin de sesion activa --------------

                    println "perfiles: ${perfiles.size()}"
                    if (perfiles.size() == 1) {
                        session.usuario.vaciarPermisos()
                        session.perfil = perfiles.first().perfil  /* carga permisos */
                        cargarPermisos()
                        println "logeado usuario: ${session.usuario} , perfil: ${session?.perfil}"

//                        redirect(controller: 'inicio', action: 'index')
                        redirect(controller: 'inicio', action: 'index')
//                        println "...1"
                        return

                    } else {
//                        println "...2"
                        session.usuario.vaciarPermisos()
                        redirect(controller: 'login', action: "perfiles")
                        return
                    }
                }
            }
        }
//        redirect(controller: 'login', action: "login")
        redirect(controller: 'inicio', action: "index")
    }

    def perfiles() {
        def usuarioLog = session.usuario
        def perfilesUsr = Sesn.findAllByUsuario(usuarioLog, [sort: 'perfil'])
        def perfiles = []
        perfilesUsr.each { p ->
            if (p.estaActivo) {
                perfiles.add(p)
            }
        }
        println "---- perfiles ----"
        return [perfilesUsr: perfiles.sort{it.perfil.descripcion}]
    }

    def savePer() {
        println("entro save" + params)
        def sesn = Sesn.get(params.prfl)
        def perf = sesn.perfil

        if (perf) {

            def permisos = Prpf.findAllByPerfil(perf)
            permisos.each {
                def perm = PermisoUsuario.findAllByPersonaAndPermisoTramite(session.usuario, it.permiso)
                perm.each { pr ->
                    if (pr.estaActivo) {
                        session.usuario.permisos.add(pr.permisoTramite)
                    }
                }

            }
            session.perfil = perf
            cargarPermisos()
        } else {
            redirect(controller: 'login', action: "login")
        }
    }

    def logout() {
        def activo = SesionActiva.findByIdSesion(session.id)
        if (activo) {
            activo.fechaFin = new Date()
            activo.activo = 'N'
            activo.save(flush: true)
        }
        // -------------- fin -------------------------

        session.usuario = null
        session.perfil = null
        session.permisos = null
//        session.menu = null
//        session.an = null
//        session.cn = null
        session.invalidate()

//        redirect(controller: 'login', action: 'login')
        redirect uri: '/'

    }

    def finDeSesion() {

    }

    def cargarPermisos() {
        def permisos = Prms.findAllByPerfil(session.perfil)
        println "CARGAR PERMISOS  perfil: " + session.perfil + "  " + session.perfil.id
        println "Permisos:    " + permisos
        def hp = [:]
        permisos.each {
            if (hp[it.accion.control.ctrlNombre.toLowerCase()]) {
                hp[it.accion.control.ctrlNombre.toLowerCase()].add(it.accion.accnNombre.toLowerCase())
            } else {
                hp.put(it.accion.control.ctrlNombre.toLowerCase(), [it.accion.accnNombre.toLowerCase()])
            }

        }
        session.permisos = hp
        println "permisos menu " + session.permisos
    }

}