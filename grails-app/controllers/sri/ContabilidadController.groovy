package sri

import seguridad.Empresa
import seguridad.Persona


class ContabilidadController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def utilitarioService

    def index(){
        
    }


    def cambiar() {
        def yo = Persona.get(session.usuario.id)
        def cont = Contabilidad.get(session.contabilidad.id)
        def empresa = Empresa.get(session.empresa.id)

        def contabilidades = Contabilidad.findAllByInstitucion(empresa, [sort: "fechaInicio"])
        contabilidades.remove(cont)

        return [yo: yo, cont: cont, contabilidades: contabilidades]
    }

    def cambiarContabilidad() {
        def contabilidad = Contabilidad.get(params.contabilidad)
        session.contabilidad = contabilidad
        if(params.tipo == '1'){
            redirect controller: 'contabilidad', action: 'buscarComp'
        }else{
            redirect controller: 'proceso', action: 'buscarPrcs'
        }

    }

    /* ************************ COPIAR DESDE AQUI ****************************/

    def list() {
        if(params.id == '-1') {
            flash.message = "No se ha creado aún una contabilidad, por favor cree una para registrar transacciones"
            flash.tipo = "error"
        }
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        params.sort = 'fechaInicio'

        def contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params)
        def contabilidadInstanceCount = Contabilidad.count()
        if (contabilidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params).sort{it.descripcion}
        def cuentas = Cuenta.countByNivelAndEmpresa(Nivel.get(1), session.empresa)

        return [contabilidadInstanceList: contabilidadInstanceList, contabilidadInstanceCount: contabilidadInstanceCount, cuentas: cuentas]
    } //list

    def show_ajax() {
        if (params.id) {
            def contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
            return [contabilidadInstance: contabilidadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def contabilidadInstance = new Contabilidad(params)
        def empresa = Empresa.get(session.empresa.id)
        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
        }

        def cuentas = Cuenta.withCriteria {
            ilike("numero", '3%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaCredito = Cuenta.withCriteria {
            ilike("numero", '1%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaRetencion = Cuenta.withCriteria {
            ilike("numero", '2%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaCosto = Cuenta.withCriteria {
            ilike("numero", '5%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaInvt = Cuenta.withCriteria {
            ilike("numero", '1%')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaBanco = Cuenta.withCriteria {
            ilike("numero", '1%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaPorPagar = Cuenta.withCriteria {
            ilike("numero", '2%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaPorCobrar = Cuenta.withCriteria {
            ilike("numero", '1%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        return [contabilidadInstance: contabilidadInstance, cuentas: cuentas, cntacr: cntaCredito, cntart: cntaRetencion,
                cntacsto: cntaCosto, cntainvt: cntaInvt, banco: cntaBanco, pagar: cntaPorPagar, cobrar: cntaPorCobrar]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        println("params save " + params)

//        println("fi " + params.fechaInicio[Calendar.DAY_OF_MONTH])
//        println("fi " + params.fechaInicio[Calendar.MONTH])

        def errores = ''
        def contabilidadInstance
        def cuenta = Cuenta.get(params.cuenta)
        def creditoIva = Cuenta.get(params.creditoIva)
        def creditoRenta = Cuenta.get(params.creditoRenta)
        def retencionIva = Cuenta.get(params.retencionIva)
        def retencionRenta = Cuenta.get(params.retencionRenta)
        def banco = Cuenta.get(params.banco)
        def porPagar = Cuenta.get(params.porPagar)
        def porCobrar = Cuenta.get(params.porCobrar)

        if(params.id){
            contabilidadInstance =  Contabilidad.get(params.id)
            contabilidadInstance.descripcion = params.descripcion
            contabilidadInstance.prefijo = params.prefijo.toUpperCase()
            contabilidadInstance.cuenta = cuenta
            contabilidadInstance.creditoTributarioIva = creditoIva
            contabilidadInstance.creditoTributarioRenta = creditoRenta
            contabilidadInstance.retencionCompraIva = retencionIva
            contabilidadInstance.retencionCompraRenta = retencionRenta
            contabilidadInstance.bancos = banco
            contabilidadInstance.porPagar = porPagar
            contabilidadInstance.porCobrar = porCobrar

            if (!contabilidadInstance.save(flush: true)) {
                render "NO_Error al guardar los datos de la contabilidad"
                println("Error editar" + contabilidadInstance.errors)
            } else{
                render "OK_Datos de la contabilidad actualizados correctamente"
            }

        }else{
            contabilidadInstance = new Contabilidad()
            contabilidadInstance.institucion = session.empresa
            contabilidadInstance.descripcion = params.descripcion
            contabilidadInstance.prefijo = params.prefijo.toUpperCase()
//            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio_input)
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
//            params.fechaCierre = new Date().parse("dd-MM-yyyy", params.fechaCierre_input)
            params.fechaCierre = new Date().parse("dd-MM-yyyy", params.fechaCierre)
            contabilidadInstance.fechaInicio = params.fechaInicio
            contabilidadInstance.fechaCierre = params.fechaCierre
            contabilidadInstance.cuenta = cuenta
            contabilidadInstance.creditoTributarioIva = creditoIva
            contabilidadInstance.creditoTributarioRenta = creditoRenta
            contabilidadInstance.retencionCompraIva = retencionIva
            contabilidadInstance.retencionCompraRenta = retencionRenta
            contabilidadInstance.bancos = banco
            contabilidadInstance.porPagar = porPagar
            contabilidadInstance.porCobrar = porCobrar

            if (!contabilidadInstance.save(flush: true)) {
                render "NO_Error al crear la contabilidad"
                println("Error" + contabilidadInstance.errors)
            } else{

                def mesFI = params.fechaInicio[Calendar.MONTH]
                def mesFF = params.fechaInicio[Calendar.MONTH]

//                def mesInicio = params.fechaInicio_month.toInteger()
                def mesInicio = (mesFI as Integer).plus(1)
//                def mesFin = params.fechaCierre_month.toInteger()
                def mesFin = (mesFF as Integer).plus(1)

                if(mesFin == mesInicio){

                    def soloPeriodo = new Periodo()
                    soloPeriodo.contabilidad = contabilidadInstance
                    soloPeriodo.fechaInicio = contabilidadInstance.fechaInicio
                    soloPeriodo.fechaFin = contabilidadInstance.fechaCierre
                    soloPeriodo.numero = 1

                    if(!soloPeriodo.save(flush: true)){
                        println("error solo periodo " + soloPeriodo.errors)
                        render "NO_Error al crear la contabilidad"
                    }else{
                        render "OK_Contabilidad creada correctamente!"
                    }

                }else{

                    def inicioPrimer = contabilidadInstance.fechaInicio
                    def finPrimer = utilitarioService.getLastDayOfMonth(inicioPrimer)

                    def primerPeriodo = new Periodo()
                    primerPeriodo.contabilidad = contabilidadInstance
                    primerPeriodo.fechaInicio = inicioPrimer
                    primerPeriodo.fechaFin = finPrimer
                    primerPeriodo.numero = 1

                    if(!primerPeriodo.save(flush: true)){
                        println("error primer periodo " + primerPeriodo.errors)
                        errores += primerPeriodo.errors
                    }else{
                        def siguientePeriodo
                        def repe = mesFin - mesInicio

                        repe.times {
                            def ini = new Date().parse("dd-MM-yyyy", "01-" + ((mesInicio + it + 1).toString().padLeft(2, '0')) + "-" + contabilidadInstance.fechaInicio.format("yyyy"))

                            def periodoInstance = new Periodo()
                            periodoInstance.contabilidad = contabilidadInstance
                            periodoInstance.fechaInicio = ini
                            periodoInstance.numero = it + 2


                            if(mesFin == (mesInicio + it + 1)){
                                periodoInstance.fechaFin = contabilidadInstance.fechaCierre
                            }else{
                                def fin = utilitarioService.getLastDayOfMonth(ini)
                                periodoInstance.fechaFin = fin
                            }

                            if (!periodoInstance.save(flush: true)) {
                                errores += periodoInstance.errors
                            }
                        }
                    }

//                    println("errores " + errores)

                    if(errores == ''){
                        render "OK_Contabilidad creada correctamente"
                    }else{
                        render "NO_Error al crear la contabilidad"
                    }
                }
            }
        }
    } //save para grabar desde ajax

    def delete_ajax() {

//        println("params delete " + params)

        def contabilidadInstance = Contabilidad.get(params.id)
        def periodos = Periodo.findAllByContabilidad(contabilidadInstance)
        def procesos = Proceso.findAllByContabilidad(contabilidadInstance)
        def errores = ''

        if(procesos){
            render "NO_No se puede borrar esta contabilidad, ya tiene procesos asociados!"
        }else{

            periodos.each {p->
                try{
                    p.delete(flush: true)
                }catch (e){
                    errores += p.errors
                }
            }

            if(errores == ''){
                try{
                    contabilidadInstance.delete(flush: true)
                    render "OK_Contabilidad borrada correctamente!"
                }catch (e){
                    render "NO_Error al borrar la contabilidad"
                }
            }
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Contabilidad."
    } //notFound para ajax

    /* ******************** COPIADO HASTA AQUI ********************************************* */


//    def index() {
//        redirect(action: "list", params: params)
//    }
//
//    def create() {
//        [contabilidadInstance: new Contabilidad(params)]
//    }

    def save() {

        if (params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }
        if (params.fechaCierre) {
            params.fechaCierre = new Date().parse("dd-MM-yyyy", params.fechaCierre)
        }
/*
        if (params.presupuesto) {
            params.presupuesto = new Date().parse("dd-MM-yyyy", params.presupuesto)
        }
*/

        def contabilidadInstance = new Contabilidad(params)

        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            contabilidadInstance.properties = params
        }

        if (!contabilidadInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [contabilidadInstance: contabilidadInstance])
            } else {
                render(view: "create", model: [contabilidadInstance: contabilidadInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Contabilidad actualizado"
            flash.tipo = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Contabilidad creado"
            flash.tipo = "success"
            flash.ico = "ss_accept"
        }

        12.times {
            def ini = new Date().parse("dd-MM-yyyy", "01-" + ((it + 1).toString().padLeft(2, '0')) + "-" + contabilidadInstance.fechaInicio.format("yyyy"))
            def fin = utilitarioService.getLastDayOfMonth(ini)
            def periodoInstance = new Periodo()

            if (periodoInstance.save(flush: true)) {

                periodoInstance.contabilidad = contabilidadInstance
                periodoInstance.fechaInicio = ini
                periodoInstance.fechaFin = fin
                periodoInstance.numero = it + 1
            } else {

                render "Error al grabar períodos"
            }
        }

        redirect(action: "show", id: contabilidadInstance.id)
    }

//    def show() {
//        def contabilidadInstance = Contabilidad.get(params.id)
//        if (!contabilidadInstance) {
//            flash.message = "No se encontró Contabilidad con id " + params.id
//            flash.tipo = "error"
//            flash.ico = "ss_delete"
//            redirect(action: "list")
//            return
//        }
//
//        [contabilidadInstance: contabilidadInstance]
//    }
//
//    def edit() {
//        def contabilidadInstance = Contabilidad.get(params.id)
//        if (!contabilidadInstance) {
//            flash.message = "No se encontró Contabilidad con id " + params.id
//            flash.tipo = "error"
//            flash.ico = "ss_delete"
//            redirect(action: "list")
//            return
//        }
//
//        [contabilidadInstance: contabilidadInstance]
//    }

//    def delete() {
//        def contabilidadInstance = Contabilidad.get(params.id)
//        if (!contabilidadInstance) {
//            flash.message = "No se encontró Contabilidad con id " + params.id
//            flash.tipo = "error"
//            flash.ico = "ss_delete"
//            redirect(action: "list")
//            return
//        }
//
//        try {
//            contabilidadInstance.delete(flush: true)
//            flash.message = "Contabilidad  con id " + params.id + " eliminado"
//            flash.tipo = "success"
//            flash.ico = "ss_accept"
//            redirect(action: "list")
//        }
//        catch (e) {
//            flash.message = "No se pudo eliminar Contabilidad con id " + params.id
//            flash.tipo = "error"
//            flash.ico = "ss_delete"
//            redirect(action: "show", id: params.id)
//        }
//    }

    def formPeriodo_ajax () {

    }

    def buscarComp () {

    }

    def tablaComprobantes_ajax () {
//        println("params c " + params)

        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def desde
        def hasta
        if(params.desde){
            desde = new Date().parse("dd-MM-yyyy", params.desde)
        }

        if(params.hasta){
            hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        }

        def comprobantes = Comprobante.withCriteria {

            proceso{
                eq("contabilidad", contabilidad)
            }

            eq("registrado", 'N')

            if(params.desde && params.hasta){
                between("fecha", desde, hasta)
            }

            if(params.descripcion){
                ilike("descripcion", "%" + params.descripcion.trim() + "%")
            }

            order("fecha","asc")
        }

        return [comprobantes: comprobantes]
    }

    def crear_ajax () {

    }
}
