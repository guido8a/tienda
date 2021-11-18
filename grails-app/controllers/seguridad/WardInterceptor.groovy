package seguridad

class WardInterceptor {

    WardInterceptor () {
        matchAll().excludes(controller:'login')
                .excludes(controller:'shield')
                .excludes(controller:'principal')
                .excludes(controller:'ver')
                .excludes(controller:'cliente')
//                .excludes(controller:'empresa')
//                .excludes(controller:'categoria')
//                .excludes(controller:'subcategoria')
//                .excludes(controller:'grupo')
//                .excludes(controller:'producto')
    }

    boolean before() {
//        println "before acción: " + actionName + " controlador: " + controllerName + " params: $params"
//        println "usuario: ${session.usuario} , perfil: ${session?.perfil}"
        session.an = actionName
        session.cn = controllerName
        session.pr = params
        def usro
        if(session) {
            usro = session.usuario
        }
//        println "usuario: ${session?.usuario} && perfil: ${session?.perfil}"
        if(session.an == 'saveTramite' && session.cn == 'tramite'){
            println("entro")
            return true
        } else {
            if (!session?.usuario && !session?.perfil) {
                if(controllerName != "inicio" && actionName != "index") {
//                    flash.message = "Usted ha superado el tiempo de inactividad máximo de la sesión"
                }
                render "<script type='text/javascript'> window.location.href = '/' </script>"
                session.finalize()
                return false
            }
        }

        true
    }

    boolean after() {
//        println "+++++después"
        true
    }

    void afterView() {
//        println "+++++afterview"
        // no-op
    }


    boolean isAllowed() {
//        println "--> ${session.permisos[controllerName.toLowerCase()]} --> ${actionName}"
//
//        try {
//            if((request.method == "POST") || (actionName.toLowerCase() =~ 'ajax')) {
//                println "es post no audit"
//                return true
//            }
////            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
//            if (!session.permisos[controllerName.toLowerCase()]) {
//                return false
//            } else {
//                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())) {
//                    return true
//                } else {
//                    return false
//                }
//            }
//
//        } catch (e) {
//            println "Shield execption e: " + e
//            return false
//        }

        return true

    }

}
