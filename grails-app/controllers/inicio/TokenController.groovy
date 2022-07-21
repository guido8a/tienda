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

    static allowedMethods = [creatoken: "PATCH", creatoken: "GET"]

    def createJWT(JsonSlurper slurper, Integer validSeconds, String appID, String tenantID, String appSecret, String iss) {
        // Get the Unix Epoch timestamp. In this case we need the original one and the expiration one.
        TimeZone.setDefault(TimeZone.getTimeZone('UTC'))
        def rightNowMilli = System.currentTimeMillis()
        def rightNowSec = Math.round(rightNowMilli / 1000)
        def expirationSec = rightNowSec + validSeconds

        // Create a UUID to pass with the token. Avoids replay attacks.
        def jtiValue = UUID.randomUUID().toString()

        // Create maps for the header and payload.
        Map header = [alg: "HS256", typ: "JWT"]
        Map payload = [exp: expirationSec, iat: rightNowSec, iss: iss, sub: appID, tid: tenantID, jti: jtiValue]

        // Convert the maps to JSON.
        def headerJson = JsonOutput.toJson(header)
        def payloadJson = JsonOutput.toJson(payload)

        // Convert the header and payload to Base64.
        def headerBase64 = headerJson.getBytes("UTF-8").encodeBase64().toString().split("=")[0].replaceAll("\\+", "-").replaceAll("/", "_")
        def payloadBase64 = payloadJson.getBytes("UTF-8").encodeBase64().toString().split("=")[0].replaceAll("\\+", "-").replaceAll("/", "_")

        // Sign the header + payload combination.
        def toBeSigned = headerBase64 + "." + payloadBase64
        SecretKeySpec secretKeySpec = new SecretKeySpec(appSecret.getBytes("UTF-8"), "HmacSHA256")
        Mac mac = Mac.getInstance("HmacSHA256")
        mac.init(secretKeySpec)
        byte[] digest = mac.doFinal(toBeSigned.getBytes("UTF-8"))
        def signature = digest.encodeBase64().toString().split("=")[0].replaceAll("\\+", "-").replaceAll("/", "_")

        // Put it all together for the token.
        def token = headerBase64 + "." + payloadBase64 + "." + signature
        token
    }


    def creaToken2() {
// Main code. Start with importing the endpoint information.
        JsonSlurper slurper = new JsonSlurper()
        def headersJson = slurper.parseText("""
{
    "URL": "localhost",
    "AppID": "9999",
    "TenantID": "8888",
    "AppSecret": "Tienda",
    "ISS": "localhost"
}""")
        def url = headersJson.URL

// Create the JWT.
        def jwt = createJWT(slurper, 1800, headersJson.AppID, headersJson.TenantID, headersJson.AppSecret, headersJson.ISS)

// Bundle the JWT into JSON for the payload.
        Map payloadMap = [auth_token: jwt]
        def payloadJson = JsonOutput.toJson(payloadMap)

        def token = payloadJson

        //decodifiac JWT: parte 0: algoritmo HS256, parte1: payload
        def tokenParts = token.replaceAll("Bearer ", "").split("\\.")
        def bytes1 = java.util.Base64.getDecoder().decode(tokenParts[1])
        def parte1 = new String(bytes1, "UTF-8")

        def jsonSlurper = new JsonSlurper()
        def object = jsonSlurper.parseText(parte1)

        println "ok: ${token}, claims: ${parte1}, exp: ${object.exp}"

        /* ---------------------------------- */
        Algorithm algorithm = Algorithm.HMAC256("secret");

        String token2 = JWT.create()
                .withIssuer("Tedein")
                .withClaim("id", 120)
                .withClaim("Usuario", "Guido")
                .withClaim("Perfil", "ADMN")
                .withExpiresAt(new Date(System.currentTimeMillis() + (4 * 60 * 60 * 1000).toLong()))
//                .withExpiresAt((60 * 60 * 1000).toLong())
                .sign(algorithm);

        println "Token2: $token2"
//        token2 += '0'

        JWTVerifier verifier = JWT.require(algorithm)
                .withIssuer("Tedein")
                .build();

        println "---> ${verifier.verify(token2)}"

        def partes = token2.split("\\.")
        def header = java.util.Base64.getDecoder().decode(partes[1])
        def data = new String(header, "UTF-8")

        def js = new JsonSlurper()
        def datos = js.parseText(data)

//        assertThrows(JWTVerificationException.class, () -> verifier.verify(token + "x"));

//        DecodedJWT jwt2 = JWT.require(Algorithm.HMAC256("Tienda"))
//                .build()
//                .verify(token);
//        assertThat(jwt, is(notNullValue()));
//        assertThat(jwt.getHeaderClaim("isAdmin"), notNullValue());
//        assertThat(jwt.getHeaderClaim("isAdmin").asBoolean(), is(true));
//        assertThat(jwt.getClaim("isAdmin"), notNullValue());
//        assertThat(jwt.getClaim("isAdmin").asString(), is("nope"));
        Calendar calendar = Calendar.getInstance()
        calendar.setTimeInMillis(datos.exp * 1000.toLong())
        def termina = new Date(datos.exp * 1000.toLong())
        render "Token: ${token2}, claims: ${datos}, expira: ${termina.format('dd-MM-yyyy HH:mm')}, ${calendar.getTime()}"


    }

    def creatoken() {
        println "params: $params --> ${request.JSON}  --hd: ${request.getHeader('token')}"

        Algorithm algorithm = Algorithm.HMAC256("TEDEIN-1207");

        String token = JWT.create()
                .withIssuer("Tedein")
                .withClaim("id", 120)
                .withClaim("Usuario", "Guido")
                .withClaim("Perfil", "ADMN")
                .withExpiresAt(new Date(System.currentTimeMillis() + (4 * 60 * 60 * 1000).toLong()))
                .sign(algorithm);

        def verifica = verificaToken(token)

//        render "Token: ${token}\n --> ${verifica}"
              /*  {
                    "nombre": "Guido",
                    "ok": true,
                    "perfil": 1,
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmEiOjE2NjAzMTk4OTgsImZlY2hhIjoxNjU3NzI3ODk4LCJpZCI6MSwibG9naW4iOiJhZG1pbiIsIm5vbWJyZSI6Ikd1aWRvIiwicGVyZmlsSWQiOjF9.p1RTmHTWJEL4ZAlWCJz_4JMvTcmZIGbZMZ2KWgU1WZs",
                    "uid": 1
                } */
        def retorna =  [Token: token, ok: true]
        render retorna as JSON
//        render token


    }

    def verificaToken(token) {
        Algorithm algorithm = Algorithm.HMAC256("TEDEIN-1207");
        def retorna = ["ok": true]
        try {
            JWTVerifier verifier = JWT.require(algoritmo)
                    .withIssuer("Tedein")
                    .build();

            println "---> ${verifier.verify(token)}"

            def partes = token.split("\\.")
            def header = java.util.Base64.getDecoder().decode(partes[1])
            def data = new String(header, "UTF-8")

            def js = new JsonSlurper()
            def datos = js.parseText(data)
            def termina = new Date(datos.exp * 1000.toLong()).format("dd-MM-yyyy HH:mm")
            retorna["exp"] = termina
        } catch (e) {
            retorna["ok"] = false
        }
        return retorna

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
