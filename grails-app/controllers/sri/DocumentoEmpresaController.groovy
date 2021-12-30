package sri

import seguridad.Empresa


class DocumentoEmpresaController {

    def dbConnectionService

    def list(){
        def empresa = Empresa.get(params.id)
        def documentos = DocumentoEmpresa.findAllByEmpresa(empresa)
        return[documentoEmpresaInstanceList:documentos, empresa: empresa]
    }

    def form_ajax(){

        def documento

        if(params.id){
            documento = DocumentoEmpresa.get(params.id)
        }else{
            documento = new DocumentoEmpresa()
        }

        def empresa = Empresa.get(params.empresa)
        def establecimientos = Establecimiento.findAllByEmpresa(empresa)

        return[documentoEmpresaInstance: documento, establecimientos: establecimientos, empresa: empresa]
    }

    def verificar_ajax () {
        def documentoEmpresa = DocumentoEmpresa.get(params.id)
        def usado = Proceso.findByDocumentoEmpresa(documentoEmpresa)
        println ".....verificar_ajax: $usado"
        render (usado?.size() > 0)
    }

    def save_ajax() {

        println("params " + params)
        def documentoEmpresa
//        def empresa = Empresa.get(session.empresa.id)
        def empresa = Empresa.get(params.empresa)
        def establecimiento = Establecimiento.get(params.numeroEstablecimiento)
        def fechaFin = new Date().parse("dd-MM-yyyy",params.fechaFin)
        def fechaInicio = new Date().parse("dd-MM-yyyy",params.fechaAutorizacion)
        def cn = dbConnectionService.getConnection()
        def st = ''

        def sql = "select fcdtatrz from fcdt where empr__id = ${empresa.id} and fcdttipo = '${params.tipo}' and " +
                "(${params.numeroDesde} between fcdtdsde and fcdthsta or " +
                "${params.numeroHasta} between fcdtdsde and fcdthsta) and fcdt__id <> ${params.id?:0}"
        println "sql: $sql"
        def cruzado = cn.rows(sql.toString())[0]?.fcdtatrz
        println "cruzado: $cruzado"

        if(cruzado){
            render "no_1_El rango de valores de ${params.numeroDesde} a ${params.numeroHasta} ya está contenido en el Libretin con autorización: $cruzado"
            return
        }

        if(fechaInicio >= fechaFin){
            render "no_2_La fecha de autorización es mayor a la fecha de finalización"
            return
        }

        if(params.id){
            documentoEmpresa = DocumentoEmpresa.get(params.id)
//            documentoEmpresa.properties = params
        } else {
            documentoEmpresa = new DocumentoEmpresa(params)
            documentoEmpresa.fechaIngreso = new Date()
        }

        println("--> " + fechaInicio)
        println("--> " + fechaFin)

        documentoEmpresa.fechaAutorizacion = fechaInicio
        documentoEmpresa.fechaInicio = fechaInicio
        documentoEmpresa.fechaFin = fechaFin
        documentoEmpresa.empresa = empresa
        documentoEmpresa.establecimiento = establecimiento
        documentoEmpresa.numeroEstablecimiento = establecimiento.numero


        if(!documentoEmpresa.save(flush:true)){
            println("error libretin " + documentoEmpresa.errors)
            render "no_Error al guardar la información del libretín"
        }else{
            render "OK_Libretín creado correctamente"
        }

//        try {
//            documentoEmpresa.save(flush: true)
//            println "grabó....."
//            render "OK_Libretín creado correctamente"
//        }catch (e){
//            println("error libretin " + e + documentoEmpresa.errors)
//            render "no_Error al guardar la información del libretín"
//        }
    }

    def delete() {
        def documentoEmpresa = DocumentoEmpresa.get(params.id)

        try{
            documentoEmpresa.delete(flush: true)
            render "OK_Libretín borrado correctamente!"
        }catch (e){
            println("error al borrar libretín " + e)
            render "NO_Error al borrar el libretín"
        }
    } //delete
}
