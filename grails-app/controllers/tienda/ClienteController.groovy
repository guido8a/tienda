package tienda

import seguridad.Persona
import seguridad.Prfl
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
            params.login = params.mail

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

}
