package tienda

import seguridad.Persona
import seguridad.Prfl
import seguridad.SesionActiva
import seguridad.Sesn


class ClienteController {

    def mailService

    def saveRegistro_ajax(){

        println("params ---> " + params)

        def existeCorreo = Cliente.findAllByMail(params.mail)

        if(existeCorreo){
            render "er_Ya existe un usuario registrado con ese correo"
        }else{

            params.fecha = new Date()
//            params.login = params.mail

            def cliente = new Cliente()
            cliente.properties = params

            def pass = crearContrasenia()
            cliente.password = pass.encodeAsMD5()

            if(!cliente.save(flush:true)){
                println("error al crear el cliente " + cliente.errors)
                render "no"
            }else{
                    def ec = enviarCorreoRegistro(cliente.mail, pass)
                    if(ec){
                        render "ok"
                    }else{
                        render "no"
                    }
            }
        }
    }


    def crearContrasenia(){
        String charset = (('A'..'Z') + ('0'..'9')).join()
        Integer length = 8
        String randomString = org.apache.commons.lang.RandomStringUtils.random(length, charset.toCharArray())

        println("--> " + randomString)

        return randomString
    }


    def enviarCorreoRegistro(mail, pass){
        def errores = ''

        try{
            mailService.sendMail {

                to mail
                subject "Correo de verificación desde sistema TIENDA"
                body "Datos de ingreso: " +
                        "\n Usuario: ${mail} " +
                        "\n Contraseña: ${pass} "
            }
            println "Enviado mail a: ${mail}"
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

    def ingreso_ajax(){
        println "valida ingreso " + params
        def user = Cliente.withCriteria {
            eq("mail", params.mail, [ignoreCase: true])
        }

        if (user.size() == 0) {
            render "er_No se ha encontrado el usuario"
            return false
        } else if (user.size() > 1) {
            render "er_Error al ingresar"
            return false
        } else {
            user = user[0]

            if (params.password.encodeAsMD5() != user.password) {
                render "er_Contraseña incorrecta"
                return false
//                redirect(controller: 'principal', action: "index")
            }else{
                session.cliente = user
//                println "ok..."
//                session.time = new Date()
                render "ok"
            }
        }

    }

    def logout() {
        session.usuario = null
        session.cliente = null
        session.perfil = null
        session.permisos = null
        session.invalidate()
        redirect(controller: 'principal', action: 'index')
    }

    def password_ajax(){

    }

    def recuperarPassword_ajax(){

        println("params " + params)

        def existePassword = Cliente.findByMail(params.mail.toString().trim())

        if(existePassword){

            def pass = crearContrasenia()
            existePassword.password = pass.encodeAsMD5()
            existePassword.save(flush: true)

            def mail = existePassword.mail
            def errores = ''

            try{
                mailService.sendMail {
                    to mail
                    subject "Correo de recuperación de contraseña del sistema Tienda"
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
