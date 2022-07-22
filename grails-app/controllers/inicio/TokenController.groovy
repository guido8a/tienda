package inicio

import grails.converters.JSON
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import org.apache.xml.security.algorithms.Algorithm

import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;

class TokenController {

    static allowedMethods = [creatoken: "POST", archivo: "GET"]

    def tokenService

    def creatoken() {
        println "params: $params --> ${request.JSON}  --hd: ${request.getHeader('token')}"
        def data = request.JSON
        def retorna = tokenService.creatoken(data)
        render retorna as JSON
    }

    def archivo() {
        println "archivo params: $params --> ${request.JSON}  --hd: ${request.getHeader('token')}"
        def nombre = 'manual_avales.pdf'
        def path = '/var/fida/manual avales.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

    }

}
