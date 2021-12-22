package sri

import seguridad.Empresa
import retenciones.Retencion
import inventario.Bodega
import sri.CentroCosto
import sri.DetalleFactura
import tienda.Cliente
import tienda.Publicacion
import seguridad.Persona
import retenciones.Pais
import retenciones.PorcentajeIva
import sri.SustentoTributario
import sri.TipoCmprSustento
import sri.TipoComprobanteSri
import sri.TipoTransaccion

import java.sql.Connection

import org.apache.poi.ss.usermodel.Row

import java.text.DecimalFormat
import java.text.NumberFormat


class ProcesoController {

    def buscadorService
//    def kerberosoldService
    def procesoService
    def loginService
    def utilitarioService
    def dbConnectionService

    def index = { redirect(action: "buscarPrcs") }

    def nuevoProceso = {
        println "nuevo proceso $params"

        def estb = Empresa.get(session.empresa.id).establecimientos.tokenize(',')

        def mp = [:]
        estb.each {
            mp[it] = it
        }

        def sucursal = Establecimiento.findAllByEmpresa(Empresa.get(session.empresa.id))

        if (params.id) {
            def proceso = Proceso.get(params.id).refresh()
            def fps = ProcesoFormaDePago.findAllByProceso(proceso)

            println "porceso: ${proceso.tipoProceso}"

            render(view: "procesoForm", model: [proceso: proceso, fps: fps, estb: sucursal])
        } else
            render(view: "procesoForm", model: [proceso: null, estb: sucursal])
    }

    /** actualiza los valores de proceso a los totales de detalle **/
    def actlProceso = {
        println "actlProceso $params"
        def proceso = Proceso.get(params.id)
        def detalle = DetalleFactura.findByProceso(proceso)
        def cn = dbConnectionService.getConnection()

        println "gestor tipo: ${proceso.gestor.tipo}"

        if(detalle) {
            if(proceso.estado != 'R') {
                def sql = "select * from total_detalle(${proceso.id}, 0, 0)"
                //  base__nz | basecero | basenoiv | iva  | ice  | dsct | flte | totl
                // ----------+----------+----------+------+------+------+------+------
                //      4.50 |     0.00 |     0.00 | 0.54 | 0.00 | 0.00 | 0.00 | 5.04
                cn.eachRow(sql.toString()) {d ->
                    proceso.valor = d.totl
                    proceso.baseImponibleIva = d.base__nz
                    proceso.baseImponibleIva0 = d.basecero
                    proceso.baseImponibleNoIva = d.basenoiv
                    proceso.ivaGenerado = d.iva
                    proceso.iceGenerado = d.ice
/*
                    if(proceso.gestor.tipo == 'I')
                        proceso.flete = d.flte
                    else {
                        proceso.flete = 0
                    }
*/
                }
                println "...graba datos de detalle --> ${proceso.gestor}"
                proceso.save(flush: true)
            }
        }
        redirect(action: 'nuevoProceso', id: proceso.id)
    }

    def save = {
        println "save proceso: $params"
        def proceso
        def comprobante

        def sustento = SustentoTributario.get(params.tipoCmprSustento)  //????
        def comprobanteSri = TipoCmprSustento.get(params."tipoComprobanteSri.id")

        def proveedor
        def gestor = Gestor.get(params.gestor)
        def fechaRegistro = new Date().parse("dd-MM-yyyy", params.fecha_input)   //fecha del cmpr
        def fechaIngresoSistema = new Date().parse("dd-MM-yyyy", params.fechaingreso_input)   //registro

        if(params.id){
            proceso = Proceso.get(params.id)
        } else {
            proceso = new Proceso()
            proceso.estado = "N"
            proceso.contabilidad = Contabilidad.get(session.contabilidad.id)
            proceso.empresa = Empresa.get(session.empresa.id)
        }


        proceso.gestor = gestor
        proceso.establecimiento = Establecimiento.get(params.establecimiento)
        proceso.valor = (params.baseImponibleIva0?:0).toDouble() + (params.baseImponibleIva?:0).toDouble() +
                (params.baseImponibleNoIva?:0).toDouble() + (params.excentoIva?:0).toDouble() +
                (params.ivaGenerado?:0).toDouble() + (params.iceGenerado?:0).toDouble() +
                (params.valorPago?:0).toDouble() + (params.flete ?: 0).toDouble()
        proceso.impuesto = (params.ivaGenerado?:0).toDouble() + (params.iceGenerado?:0).toDouble()
        proceso.baseImponibleIva = (params.baseImponibleIva?:0).toDouble()
        proceso.baseImponibleIva0 = (params.baseImponibleIva0?:0).toDouble()
        proceso.baseImponibleNoIva = (params.baseImponibleNoIva?:0).toDouble()
        proceso.excentoIva = (params.excentoIva?:0).toDouble()
        proceso.ivaGenerado = (params.ivaGenerado?:0).toDouble()
        proceso.iceGenerado = (params.iceGenerado?:0).toDouble()
        proceso.flete = (params.flete?:0).toDouble()
        proceso.retenidoIva = (params.retenidoIva?:0).toDouble()
        proceso.retenidoRenta = (params.retenidoRenta?:0).toDouble()
        proceso.fechaEmision= fechaRegistro
        proceso.fechaIngresoSistema = fechaIngresoSistema
        proceso.descripcion = params.descripcion
        proceso.fecha = new Date()

//        println "proceso: ${proceso.id}, tipoProceso: ${params.tipoProceso}, get: ${TipoProceso.get(params.tipoProceso)}"

        proceso.tipoProceso = TipoProceso.get(params.tipoProceso)
        proceso.usuario = session.usuario


        switch (params.tipoProceso) {
            case '1': //Compras
                def secuencial =  '0' * (9-params.dcmtSecuencial.size()) + params.dcmtSecuencial
                proceso.tipoTransaccion = TipoTransaccion.get(1)
                proceso.procesoSerie01 = params.dcmtEstablecimiento
                proceso.procesoSerie02 = params.dcmtEmision
                proceso.secuencial = secuencial
                proceso.autorizacion = params.dcmtAutorizacion
                proceso.documento = params.dcmtEstablecimiento + "-" + params.dcmtEmision + "-" + secuencial
                proceso.sustentoTributario = sustento
                proceso.tipoCmprSustento = comprobanteSri
                proveedor = Proveedor.get(params."proveedor.id")
                proceso.proveedor = proveedor
                proceso.pago = params.pago

                if(params?.dcmtAutorizacion) {
                    if(params?.dcmtAutorizacion.size() == 10) {
                        proveedor.autorizacionSri = params.dcmtAutorizacion
                    }
                }

                if (params.pago == '02') {
                    proceso.normaLegal = params.norma
                    proceso.convenio = params.convenio
                    proceso.pais = Pais.get(params.pais)
                } else {
                    proceso.normaLegal = null
                    proceso.convenio = null
                    proceso.pais = null
                }
                if (params?."mdfcComprobante.id"?.toInteger() > 0) {
//                    println "---- ${TipoCmprSustento.get(params."mdfcComprobante.id".toInteger())}"
                    proceso.modificaCmpr = TipoCmprSustento.get(params."mdfcComprobante.id".toInteger())
                    proceso.modificaSerie01 = params.mdfcEstablecimiento
                    proceso.modificaSerie02 = params.mdfcEmision
                    proceso.modificaScnc = params.mdfcSecuencial
                    proceso.modificaAutorizacion = params.mdfcAutorizacion
                } else {
                    poneNulos(proceso)
                }
                break
            case '2':  //ventas
//                println "------ ventas------"
                def secuencial =  '0' * (9-params.serie.size()) + params.serie
                proceso.tipoTransaccion = TipoTransaccion.get(2)
                proceso.documento = params.numEstablecimiento + "-" + params.numeroEmision + "-" + secuencial
                proceso.facturaEstablecimiento = params.numEstablecimiento
                proceso.facturaPuntoEmision = params.numeroEmision
                proceso.facturaSecuencial = secuencial.toInteger()
                proceso.tipoCmprSustento = comprobanteSri
                proveedor = Proveedor.get(params."proveedor.id")
                proceso.proveedor = proveedor
                proceso.pago = params.pago
                proceso.documentoEmpresa = DocumentoEmpresa.get(params.libretin)
                proceso.retencionVenta = params.retencionVenta

                break

            case ['6','7']:  //NC y ND
//                println "------ Nota de crédito y Débito------"
                def secuencial = "-" + '0' * (9-params.serie.size()) + params.serie
                proceso.tipoTransaccion = null
                proceso.documento = params.numEstablecimiento + "-" + params.numeroEmision + secuencial
                proceso.facturaEstablecimiento = params.numEstablecimiento
                proceso.facturaPuntoEmision = params.numeroEmision
                proceso.facturaSecuencial = secuencial.toInteger()
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
//                proceso.tipoCmprSustento = comprobanteSri
                proveedor = Proveedor.get(params."proveedor.id")
                proceso.proveedor = proveedor
                proceso.documentoEmpresa = DocumentoEmpresa.get(params.libretin)
                break

            case '3':  //Ajustes
//                println "------ Ajustes------"
                poneNulos(proceso)
                proceso.proveedor = null
//                proceso.baseImponibleIva = params.valorPago.toDouble()
                break

            case '4':  //Pagos
//                println "------ pagos------"
                poneNulos(proceso)
                proveedor = Proveedor.get(params."proveedor.id")
                proceso.proveedor = proveedor
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
//                proceso.baseImponibleIva = params.valorPago.toDouble()
                proceso.valor = params.valorPago.toDouble()
                break

            case '5':  //Ingresos
//                println "------ ingresos------"
                poneNulos(proceso)
                proveedor = Proveedor.get(params."proveedor.id")
                proceso.proveedor = proveedor
                proceso.comprobante = Comprobante.get(params.comprobanteSel_name)
//                proceso.baseImponibleIva = params.valorPago.toDouble()
                proceso.valor = params.valorPago.toDouble()
                break
            case '8':  //Transferencias
                poneNulos(proceso)
                proceso.proveedor = null
//                proceso.baseImponibleIva = params.valorPago.toDouble()
                def bodega1 = Bodega.get(params.bodega)
                def bodega2 = Bodega.get(params.bodegaRecibe)
                proceso.bodega = bodega1
                proceso.bodegaRecibe = bodega2
                break
        }


        try {
            proceso.save(flush: true)
            if(params.tipoProceso != '8' && params.tipoProceso != '3' ){
                println("ejecutó proceso.save")
                proveedor.save(flush: true)
            }
            proceso.refresh()

//            if (proceso.errors.getErrorCount() == 0) {
//
//
//                def formasPago = ProcesoFormaDePago.findAllByProceso(proceso)
//
//                formasPago.each {
//                    it.delete(flush: true)
//                }
//
//
//
//                if (params.data != "") {
//                    def data = params.data.split(";")
//                    def fp
//                    def tppgLista = []
//                    // println "data "+data
//                    data.each {
//                        if (it != "") {
//                            println "porcesando... $it"
//                            def tppg = TipoPago.get(it)
//                            fp = ProcesoFormaDePago.findByProcesoAndTipoPago(proceso, tppg)
//                            if(!fp) {
//                                def psfp = new ProcesoFormaDePago()
//                                psfp.proceso = proceso
//                                psfp.tipoPago = tppg
//                                psfp.save(flush: true)
//                            }
//                            tppgLista.add(tppg)
//                        }
//                    }
////                    println "existentes: $tppgLista"
//                    if(tppgLista) {
//                        fp = ProcesoFormaDePago.findAllByProcesoAndTipoPagoNotInList(proceso, tppgLista)
//                    } else {
////                        println "borrar todo........."
//                    }
//
////                    println "a borrar: $fp"
//                    fp.each {
//                        println "borrando: ${it}"
//                        it.delete(flush: true)
//                    }
//                }
//            } else {
//                println "errores: ${proceso.errors}"
//            }

            redirect(action: 'nuevoProceso', id: proceso.id)

        } catch (e) {
//            println "...8"
            println "error al grabar el proceso $e" + proceso.errors
        }
    }

    def poneNulos(proceso) {
        proceso.modificaCmpr = null
        proceso.modificaSerie01 = null
        proceso.modificaSerie02 = null
        proceso.modificaScnc = null
        proceso.modificaAutorizacion = null
    }

    def registrar = {
        if (request.method == 'POST') {
//            println "registrar " + params
            def proceso = Proceso.get(params.id)
            if (proceso.estado == "R") {
                render("El proceso ya ha sido registrado previamente")
            } else {
                def lista = procesoService.registrar(proceso)
//                kerberosoldService.generarEntradaAuditoria(params, proceso, "registrado", "R", session.usuario)
                if (lista[0] != false) {
                    render("ok_Proceso registrado exitosamente")
                } else {
                    render("Error_No se ha podido registrar el proceso")
                }
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargaGestor = {
//        println "cargar gestor $params "
        def proceso = Proceso.get(params.proceso)
        def detalle = DetalleFactura.findAllByProceso(proceso)
//        def gstr = Gestor.findAllByEmpresaAndTipoProceso(session.empresa, TipoProceso.get(params.tipo), [sort: 'nombre'])
        def gstr = Gestor.findAllByEmpresaAndTipoProcesoAndEstado(session.empresa, TipoProceso.get(params.tipo), 'R', [sort: 'nombre'])
        [gstr: gstr, gstr_id: params.gstr_id, rgst: params.rgst, detalle: detalle]
    }

    def cargaComprobantes = {
//        println "cargar comprobantes " + params
        def proceso = Proceso.get(params.proceso)
        def comprobantes = Comprobante.findByProceso(proceso)
        def asientos = []
        if (comprobantes)
            asientos += Asiento.findAllByComprobante(comprobantes)
        if (asientos.size() > 0) {
            asientos.sort { it.cuenta.numero }
        }
        def aux = false
        asientos.each {
            if (Auxiliar.findAllByAsiento(it).size() > 1)
                aux = true
        }
        //println "comp "+comprobantes+" as "+asientos
        render(view: "detalleProceso", model: [comprobantes: comprobantes, asientos: asientos, proceso: proceso, aux: aux])
    }

    def cargaTcsr() {
//        println "cargatcsr $params"
        def cn = dbConnectionService.getConnection()
        def tipo = 0
        def reembolso
        if(params.reembolso){
            reembolso = Reembolso.get(params.reembolso)
        }
        switch (params.tptr) {
            case '1':
                tipo = 1
                break
            case '2':
                tipo = 2
                break
            default:
                tipo = 0
        }
        def sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                "tptr.tptr__id = titt.tptr__id and tptrcdgo = '${tipo}'"
//        println "sql1: $sql"
        def titt = cn.rows(sql.toString())[0]?.cdgo
//        println "identif: $titt"
        if(tipo == 2) {
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                    "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' " +
                    "order by tcsrcdgo"
        } else {
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                    "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' and " +
                    "sstr @> '{${params.sstr}}' order by tcsrcdgo"
        }
//        println "sql2: $sql"
        def data = cn.rows(sql.toString())
        cn.close()
        [data: data, tpcpSri: params.tpcp, estado: params.etdo?:'', esta: params.esta, reembolso: reembolso]
    }

    def cargaSstr() {
//        println "cargaSstr $params"
        def cn = dbConnectionService.getConnection()
        def tipo = 0
        switch (params.tptr) {
            case '1':
                tipo = 1
                break
            case '2':
                tipo = 2
                break
            default:
                tipo = 0
        }

        def sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                "tptr.tptr__id = titt.tptr__id and tptrcdgo = '${tipo}'"
//        println "sql: $sql"

        def titt = cn.rows(sql.toString())[0]?.cdgo
//        println "identif: $titt"

        sql = "select sstr__id id, sstrcdgo codigo, sstrdscr descripcion from sstr " +
                "where sstr__id in (select distinct(unnest(sstr)) " +
                "from tcst where titt @> '{${titt}}') order by 1;"
//        println "sql2: $sql"
        def data = cn.rows(sql.toString())
        cn.close()
        [data: data, sstr: params.sstr, tpcpSri: params.tpcp, estado: params.etdo?:'']
    }


/*
    def registrarComprobante = {
        if (request.method == 'POST') {
            println "registrar comprobante " + params
            def comprobante = Comprobante.get(params.id)
            def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, 1])
            println "LOG: mayorizando por comprobante ${comprobante.id}" + msn["mayorizar"]
            try {
                def log = new LogMayorizacion()
                log.usuario = cratos.seguridad.Persona.get(session.usuario.id)
                log.comprobante = comprobante
                log.tipo = "M"
                log.resultado = msn["mayorizar"].toString()
                log.save(flush: true)
            } catch (e) {
                println "LOG: error del login de mayorizar " + msn["mayorizar"].toString()
            }
            if (msn["mayorizar"] =~ "Error") {
                render " " + msn["mayorizar"]
            } else {
                def proceso = comprobante.proceso
                params.controllerName = controllerName
                params.actionName = actionName
                comprobante.registrado = "S"
                comprobante.save(flush: true)
                proceso.estado = "R"
                proceso.save(flush: true)
                render "ok"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
*/

/*
    def desmayorizar() {
        if (request.method == 'POST') {
            def comprobante = Comprobante.get(params.id)
            def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, -1])
            println "LOG: desmayorizando  comprobante ${comprobante.id} " + msn["mayorizar"]
            try {
                def log = new LogMayorizacion()
                log.usuario = cratos.seguridad.Persona.get(session.usuario.id)
                log.comprobante = comprobante
                log.tipo = "D"
                log.resultado = msn["mayorizar"].toString()
                log.save(flush: true)
            } catch (e) {
                println "LOG: error del login de mayorizar " + msn["mayorizar"].toString()
            }
            if (msn["mayorizar"] =~ "Error") {

                render " " + msn["mayorizar"]
            } else {
                def proceso = comprobante.proceso
                params.controllerName = controllerName
                params.actionName = actionName
                comprobante.registrado = "N"
                comprobante.save(flush: true)
                proceso.estado = "N"
                proceso.save(flush: true)
                render "ok"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
*/

    def listar = {
        //println "buscar proceso"
        def extraComp = ""
        if (params.campos instanceof java.lang.String) {
            if (params.campos == "comp") {
                def comps = Comprobante.findAll("from Comprobante where numero like '%${params.criterios.toUpperCase()}%' or prefijo like '%${params.criterios.toUpperCase()}%' ")
                params.criterios = ""
                comps.eachWithIndex { p, i ->
                    extraComp += "" + p.proceso.id
                    if (i < comps.size() - 1)
                        extraComp += ","
                }
                if (extraComp.size() < 1)
                    extraComp = "-1"
                params.campos = ""
                params.operadores = ""
            }
        } else {
            def remove = []
            params.campos.eachWithIndex { p, i ->
                if (p == "comp") {
                    def comps = Comprobante.findAll("from Comprobante where numero like '%${params.criterios[i].toUpperCase()}%' or prefijo like '%${params.criterios[i].toUpperCase()}%' ")

                    comps.eachWithIndex { c, j ->
                        extraComp += "" + c.proceso.id
                        if (j < comps.size() - 1)
                            extraComp += ","
                    }
                    if (extraComp.size() < 1)
                        extraComp = "-1"
                    remove.add(i)
                }
            }
            remove.each {
                params.criterios[it] = null
                params.campos[it] = null
                params.operadores[it] = null
            }
        }
        def extras = " and empresa=${session.empresa.id} and contabilidad=${session.contabilidad.id}"
        if (extraComp.size() > 1)
            extras += " and id in (${extraComp})"

        def closure = { estado ->
            if (estado == "R")
                return "Registrado"
            else
                return "No registrado"
        }
        def comp = { proceso ->
            def c = Comprobante.findByProceso(proceso)
            if (c)
                return c.prefijo + "" + c.numero
            else
                return ""
        }
        def tipo = { t ->
            switch (t) {
                case "P":
                    return "Pago"
                    break;
                case "C":
                    return "Compra"
                    break;
                case "V":
                    return "Venta"
                    break;
                case "A":
                    return "Ajuste"
                    break;
                case "O":
                    return "Otro"
                    break;
                default:
                    return "Otro"
                    break;
            }
        }
        def listaTitulos = ["Fecha", "Descripcion", "Estado", "Comprobante", "Tipo", "Proveedor"]
        /*Titulos de la tabla*/
        def listaCampos = ["fecha", "descripcion", "estado", "comprobante", "tipoProceso", "proveedor"]
        /*campos que van a mostrarse en la tabla, en el mismo orden que los titulos*/
        def funciones = [["format": ["dd-MM-yyyy "]], null, ["closure": [closure, "?"]], ["closure": [comp, "&"]], ["closure": [tipo, "?"]], null]
        /*funciones para cada campo en caso de ser necesari. Cada campo debe tener un mapa (con el nombre de la funcion como key y los parametros como arreglo) o un null si no tiene funciones... si un parametro es ? sera sustituido por el valor del campo, si es & sera sustituido por el objeto */
        def link = "descripcion"                                      /*nombre del campo que va a llevar el link*/
        def url = g.createLink(action: "listar", controller: "proceso")
        /*link de esta accion ...  sive para la opcion de reporte*/
//        params.ordenado="fecha"
//        params.orden="desc"
        def listaSinFiltro = buscadorService.buscar(Proceso, "Proceso", "excluyente", params, true, extras)
        /* Dominio, nombre del dominio , excluyente dejar asi,params tal cual llegan de la interfaz del buscador, ignore case */
        listaSinFiltro.pop()
        def lista = []
        listaSinFiltro.each {
            if (it.estado != "B")
                lista.add(it.refresh())
        }

        def numRegistros = 10
        if (!params.reporte) {
//            println "no reporte"
            render(view: '../lstaTbla', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista, link: link, funciones: funciones, url: url, numRegistros: numRegistros])
        } else {
            /*De esto solo cambiar el dominio, el parametro tabla, el paramtero titulo y el tamaño de las columnas (anchos)*/
//            println "si reporte"
            session.dominio = Proceso
            session.funciones = funciones
            def anchos = [16, 70, 14] /*el ancho de las columnas en porcentajes*/
            redirect(controller: "reportes2", action: "reporteBuscador", params: [listaCampos: listaCampos, listaTitulos: listaTitulos, tabla: "Proceso", orden: params.orden, ordenado: params.ordenado, criterios: params.criterios, operadores: params.operadores, campos: params.campos, titulo: "Transacciones contables", anchos: anchos])
        }

    }


    def comprobarPassword = {
        if (request.method == 'POST') {
            println "comprobar password " + params
            def resp = loginService.autorizaciones(session.usuario, params.atrz)

            render(resp)
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargarAuxiliares = {
        //println "cargar auxiliares "+params
        def msn = null
        def asiento = Asiento.get(params.id);
        def auxiliares = Auxiliar.findAllByAsiento(asiento)
        def formas = [:]
        def fps = ProcesoFormaDePago.findAllByProceso(asiento.comprobante.proceso)
        fps.each {
            formas.put(it.id, it.tipoPago.descripcion)
        }
        formas.put("-1", "NOTA DE DEBITO")
        formas.put("-2", "NOTA DE CREDITO")
//        println "Formas "+formas
        if (auxiliares.size() == 0) {
            msn = "EL asiento no tiene registrado ningun plan de pagos"
        }
        def max = Math.abs(asiento.debe - asiento.haber)
        render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento, msn: msn, max: max, formas: formas])
    }

    def nuevoAuxiliar = {
        if (request.method == 'POST') {
            params.lang="en"
            def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
            def localeResolver = request.getAttribute(key)
            localeResolver.setLocale(request, response, new Locale("en"))
//            println "nuevo aux "+params
            def msn = null
            if (params.razon == "D")
                params["debe"] = params.valor
            else
                params["haber"] = params.valor
            if (params.proveedor.id == "-1") {
                def proceso = Proceso.get(params.proceso)
                if (proceso.proveedor != null)
                    params["proveedor.id"] = proceso.proveedor.id
            }
            def fecha = params.remove("fechaPago")
            def p = new Auxiliar(params)
            p.fechaPago = new Date().parse("dd-MM-yyyy", fecha)
            p.save(flush: true)
            println "nuevo auxiliar " + params + "  " + p.errors
            if (p.errors.getErrorCount() != 0)
                msn = "Error al insertar el auxiliar revise los datos ingresados"
            else
                redirect(action: "cargarAuxiliares", params: ["id": params.asiento.id])
//      def asiento=p.asientoContable
//      def auxiliares=Auxiliar.findAllByAsientoContable(asiento)

        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
    def borrarAuxiliar = {

        if (request.method == 'POST') {
            println " borrar auxiliar " + params
            def aux = Auxiliar.get(params.id)
            def pagos = PagoAux.findAllByAuxiliar(aux)
            if (pagos.size() > 0) {
                render "error"
                return
            } else {
                aux.delete(flush: true)
                def asiento = Asiento.get(params.idAs)
                def auxiliares = Auxiliar.findAllByAsiento(asiento)
                render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento])
            }

        } else {
            redirect(controller: "shield", action: "ataques")
        }

    }

    def buscarProveedor = {
//        println "buscar proveedor "+params
        def prve = []
        def proceso = Proceso.get(params.proceso)
        def tr = TipoRelacion.list()
        def tipo =   " 1,2,3 "
        switch (params.tipoProceso) {
            case "P":
                tr = TipoRelacion.findAllByCodigoInList(['C','P'])
                tipo = " 1, 3 "
                break
            case "NC" :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2,3 "
                break
            case "V"  :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2, 3 "
                break
        }

        def cn = dbConnectionService.getConnection()
        def sql

        if(params?.par?.trim() == ""){
            sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                    "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} order by prve_ruc;"
        }else{
            if(params.tipo == "1"){
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prve_ruc like '%${params.par}%' order by prve_ruc;"
            }else{
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prvenmbr ilike '%${params.par}%' order by prve_ruc;"
            }
        }

        prve = cn.rows(sql.toString())

        [prve: prve]
    }

    def detallePagos = {
        def aux = Auxiliar.get(params.id)
        def pagos = PagoAux.findAllByAuxiliar(aux)
        [pagos: pagos, aux: aux]
    }

    def prueba() {
        render "prueba"
    }


    def borrarProceso() {
        println("LOG: borrar proceso " + params)
        def proceso = Proceso.get(params.id)
        def comprobante = Comprobante.findByProceso(proceso)
        def asiento
        if (comprobante) {
            asiento = Asiento.findAllByComprobante(comprobante)
        }
        if (comprobante) {
            if (comprobante.registrado == 'N') {
                println "LOG: anulando el comprobante ${comprobante.id} "
                try {
                    def log = new LogMayorizacion()
                    log.usuario = seguridad.Persona.get(session.usuario.id)
                    log.comprobante = comprobante
                    log.tipo = "B"
                    log.save(flush: true)
                } catch (e) {
                    println "LOG: error del login de mayorizar " + e
                }
                proceso.estado = "B"
                proceso.save(flush: true)
                comprobante.registrado = "B"
                comprobante.save(flush: true)
                flash.message = "Proceso Anulado!"
                redirect(action: 'buscarPrcs')
            } else {
                flash.message = "No se puede anular el proceso, el proceso ya se encuentra registrado!"
                flash.tipo = "error"
                redirect(action: 'nuevoProceso', id: proceso.id)
            }

        } else {
            proceso.estado = "B"
            proceso.save(flush: true)
            flash.message = "Proceso Borrado!"
            redirect(action: 'buscarPrcs')
        }
    }


    def procesosAnulados() {
//        println "proc anulados "+params
        def contabilidad
        if (!params.contabilidad) {
            contabilidad = session.contabilidad
        } else {
            contabilidad = Contabilidad.get(params.contabilidad)
        }
//        println "contabilidad "+contabilidad
        def procesos = Proceso.findAllByEstadoAndContabilidad("B", contabilidad, [sort: "fecha"])
        [procesos: procesos, contabilidad: contabilidad]
    }

    def verComprobante() {
        def comp = Comprobante.get(params.id)
        def asientos = Asiento.findAllByComprobante(comp)
        [asientos: asientos, comp: comp]
    }


    def detalleSri() {
//        println "detalleSri: $params"
        def cn = dbConnectionService.getConnection()
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def fcdt
        def sql
        def nmro = 0
        def baseImponible = (proceso?.baseImponibleIva ?: 0)
        def crirBienes = ConceptoRetencionImpuestoRenta.findAllByTipo("B")
        def crirServicios = ConceptoRetencionImpuestoRenta.findAllByTipo("S")
        def pcivBien = PorcentajeIva.list([sort: 'valor'])
        def pcivSrvc = PorcentajeIva.list([sort: 'valor'])
        def data = []

        sql = "select fcdt__id id, fcdtdsde numeroDesde, fcdthsta numeroHasta, fcdtfcat fechaAutorizacion, " +
                "fcdtnmes numeroEstablecimiento, fcdtnmpe numeroEmision " +
                "from fcdt where '${proceso.fechaIngresoSistema}' between fcdtfcin and fcdtfcfn and " +
                "fcdttipo = 'R' and estb__id = '${proceso.establecimiento.id}' order by fcdtfcin"
        println "libretin: $sql"
        def libretin = cn.rows(sql.toString())


        [proceso: proceso, libreta: libretin, retencion: retencion, base: baseImponible, crirBienes: crirBienes,
         crirServicios: crirServicios, pcivBien: pcivBien, pcivSrvc: pcivSrvc]

/*
        if(!retencion){
            sql = "select coalesce(max(rtcnnmro), 0) mxmo from rtcn, fcdt " +
                    "where fcdt.fcdt__id = rtcn.fcdt__id and " +
                    "rtcn.fcdt__id = ${libretin[0]?.id} and rtcnnmro between fcdtdsde and fcdthsta and " +
                    "fcdtnmes = '${proceso.establecimiento}'"
            println "sql nmro: $sql"
            nmro = cn.rows(sql.toString())[0]?.mxmo
            println "nmro: $nmro"
            nmro = nmro == 0 ? libretin[0]?.numeroDesde : nmro + 1555

            println "valor de nmro: $nmro, ${libretin[0]?.numeroDesde}, lb: ${libretin.size()}"

            if(libretin?.size() > 0) {
                return [proceso: proceso, libreta: libretin, retencion: retencion, base: baseImponible, crirBienes: crirBienes,
                        crirServicios: crirServicios, pcivBien: pcivBien, pcivSrvc: pcivSrvc]
            } else {

            }
        } else {
            return [proceso: proceso, libreta: libretin, retencion: retencion, base: baseImponible, crirBienes: crirBienes,
                    crirServicios: crirServicios, pcivBien: pcivBien, pcivSrvc: pcivSrvc]
        }
*/


/*


        println "detalleSri: $params"
        def empresa = Empresa.get(session.empresa.id)
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def libreta = DocumentoEmpresa.findAllByEmpresaAndFechaInicioLessThanEqualsAndFechaFinGreaterThanEqualsAndTipo(empresa,
                new Date(), new Date(),'R', [sort: 'fechaAutorizacion'])

        def baseImponible = (proceso?.baseImponibleIva ?: 0)
        def crirBienes = ConceptoRetencionImpuestoRenta.findAllByTipo("B")
        def crirServicios = ConceptoRetencionImpuestoRenta.findAllByTipo("S")

        def pcivBien = PorcentajeIva.list([sort: 'valor'])
        def pcivSrvc = PorcentajeIva.list([sort: 'valor'])

        println "libretin: ${libreta}"
*/

/*
        return [proceso: proceso, libreta: libreta, retencion: retencion, base: baseImponible, crirBienes: crirBienes,
                crirServicios: crirServicios, pcivBien: pcivBien, pcivSrvc: pcivSrvc]
*/
    }

    def getPeriodosByAnio(anio) {
        def per = Periodo.withCriteria {
            ge("fechaInicio", new Date().parse("dd-MM-yyyy", "01-01-" + anio))
            le("fechaFin", new Date().parse("dd-MM-yyyy", "31-12-" + anio))
            order("fechaInicio", "asc")
        }
        def periodos = []
        per.each { p ->
            def key = p.fechaInicio.format("MM")
            def val = fechaConFormato(p.fechaInicio, "MMMM yyyy").toUpperCase()
            def m = [:]
            m.id = key
            m.val = val
            periodos.add(m)
        }
        return periodos
    }


    private String fechaConFormato(fecha, formato) {
        def meses = ["", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        def meses2 = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def strFecha
        switch (formato) {
            case "MMM-yy":
                strFecha = meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                break;
            case "MMMM-yy":
                strFecha = meses2[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                break;
            case "MMMM yyyy":
                strFecha = meses2[fecha.format("MM").toInteger()] + " " + fecha.format("yyyy")
                break;
        }
        return strFecha
    }

    def guardarSri() {
//        println("guardarSri:" + params)
        params.lang="en"
        def key = "org.springframework.web.servlet.DispatcherServlet.LOCALE_RESOLVER"
        def localeResolver = request.getAttribute(key)
        localeResolver.setLocale(request, response, new Locale("en"))
        def fecha = params.remove("fechaEmision")
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def concepto = ConceptoRetencionImpuestoRenta.get(params.concepto)

        if (retencion.save(flush: true)) {
            retencion.numeroEstablecimiento = params.numeroEstablecimiento
            retencion.numeroPuntoEmision = params.numeroEmision
            retencion.numeroAutorizacionComprobante = params.numeroAutorizacion
            retencion.tipoPago = params.pago
            retencion.numeroSecuencial = params.numeroSecuencial
            retencion.creditoTributario = params.credito
            if (params.pago == '02') {
                retencion.normaLegal = params.normaLegal
                retencion.convenio = params.convenio
                retencion.pais = Pais.get(params.pais)
            } else {
                retencion.normaLegal = ''
                retencion.convenio = ''
            }
            if (fecha) {
                retencion.fechaEmision = new Date().parse("dd-MM-yyyy", fecha)
            }
            //detalle

            render "ok"
//            println("ok")

        } else {
//            println("error al grabar la retencion" + retencion.errors)
            render "Error al grabar!"
        }
    }

    def borrarFormaPago_ajax () {
        println("params " + params)
        def formaPago = ProcesoFormaDePago.get(params.id)

        try{
            formaPago.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error borrar forma pago " + formaPago.errors)
        }
    }

    def listaFormas_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso).tipoPago
        def listaId = TipoPago.list().id - formasPago.id
        def listaFormasPago = TipoPago.findAllByIdInList(listaId)
        return [proceso: proceso, lista: listaFormasPago]
    }

    def agregarFormaPago_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        def tipoPago = TipoPago.get(params.forma)
        def formaPago = new ProcesoFormaDePago()
        formaPago.proceso = proceso
        formaPago.tipoPago = tipoPago

        if(!formaPago.save(flush: true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def cargarPagoMain_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso).tipoPago
        return [formasPago: formasPago]
    }

    def comprobante_ajax () {
        def proceso = Proceso.get(params.proceso)
        def comprobantes = Comprobante.findAllByProceso(proceso).sort{it.numero}
        return [comprobantes: comprobantes, proceso: proceso]
    }

    def asientos_ajax () {
        def proceso = Proceso.get(params.proceso)
        def comprobante = Comprobante.get(params.comprobante)
        def asientos = Asiento.findAllByComprobante(comprobante, [sort: 'numero'])
        def auxiliares = Auxiliar.findAllByAsientoInList(asientos)
        def band2 = proceso?.tipoProceso?.codigo?.trim() in ['P','I','NC','ND']
        return [asientos: asientos, comprobante: comprobante, proceso: proceso, auxiliares: auxiliares, band2: band2]
    }

    def formAsiento_ajax () {
//        println("params asiento " + params)
        def comprobante = Comprobante.get(params.comprobante)
        if(params.asiento){
            def asiento = Asiento.get(params.asiento)
            return [asiento: asiento]
        }else{
            return [comprobante: comprobante]
        }
    }


    def buscarCuenta_ajax () {
        def empresa = Empresa.get(params.empresa)
        return [empresa: empresa]
    }

    def tablaBuscarCuenta_ajax () {
//        println("params " + params)
        def empresa = Empresa.get(params.empresa)
        def res

        if(params.nombre == "" && params.codigo == ""){
            res = Cuenta.findAllByEmpresaAndMovimiento(empresa,"1").sort{it.numero}
        }else{
            res = Cuenta.withCriteria {
                eq("empresa", empresa)
                eq("movimiento", "1")

                and{
                    ilike("descripcion", '%' + params.nombre + '%')
                    ilike("numero", '%' + params.codigo + '%')
                }
                order ("numero","asc")
            }
        }

        return [cuentas: res]
    }

    def guardarAsiento_ajax () {
//        println("params guardar " + params)
        def asiento
        def cuenta = Cuenta.get(params.cuenta)
        def proceso = Proceso.get(params.proceso)
        def comprobante = Comprobante.get(params.comprobante)
        def asientos = Asiento.findAllByComprobante(comprobante).sort{it.numero}
        def siguiente = 0
        if(asientos){
            siguiente = asientos.numero.last() + 1
        }
//        println("asientos " + asientos.numero)

        if(params.asiento){
            asiento = Asiento.get(params.asiento)
            asiento.cuenta = cuenta
            asiento.debe = params.debe.toDouble()
            asiento.haber = params.haber.toDouble()
        }else{
            asiento = new Asiento()
            asiento.cuenta = cuenta
            asiento.debe = params.debe.toDouble()
            asiento.haber = params.haber.toDouble()
            asiento.comprobante = comprobante
            asiento.numero = siguiente
        }

        if(!asiento.save(flush: true)){
            render "no"
            println("error " + asiento.errors)
        }else{
            render "ok"
        }
    }

    def borrarAsiento_ajax () {
//        println("borrar asiento params " + params)
        def comprobante = Comprobante.get(params.comprobante)
        def asiento = Asiento.get(params.asiento)
        def auxiliar = Auxiliar.findByAsiento(asiento)

        if(comprobante.registrado == 'N'){
            if(!auxiliar){
                try{
                    asiento.delete(flush: true)
                    render "ok_Asiento borrado correctamente"
                }catch (e){
                    render "no_Error al borrar el asiento"
                }
            } else{
                render "no_No se puede borrar el asiento, debido a que posee un auxiliar"
            }
        }else{
            render "no_No se puede borrar el asiento, el comprobante ya se encuentra registrado"
        }
    }

    def borrarAuxiliar_ajax () {
        def comprobante = Comprobante.get(params.comprobante)
        def auxiliar = Auxiliar.get(params.auxiliar)

        if(comprobante.registrado == 'N'){
            try{
                auxiliar.delete(flush: true)
                render "ok_Auxiliar borrado correctamente"
            }catch (e){
                render "no_Error al borrar el auxiliar"
            }
        }else{
            render "no_No se puede borrar el auxiliar, el comprobante ya se encuentra registrado"
        }
    }

    def formAuxiliar_ajax() {
        println "formAuxiliar params: $params"
        def comprobante = Comprobante.get(params.comprobante)
        def asiento
        def auxiliar
        def empresa = Empresa.get(session.empresa.id)
        def proveedores = Proveedor.findAllByEmpresa(empresa).sort{it.nombre}
        def cn = dbConnectionService.getConnection()
        def sql
        def res
        def existentes
        def debeEx = 0
        def haberEx = 0
        def maximoDebe = 0
        def maximoHaber = 0
        def totDebe = 0
        def totHaber = 0
        def band
        def band2
        def band3
        def funcion = comprobante.proceso.tipoProceso.codigo.trim() in ['P']? "porpagar" : "ventas"

        if(params.auxiliar){
            auxiliar = Auxiliar.get(params.auxiliar)
            asiento = auxiliar.asiento
            existentes = Auxiliar.findAllByAsiento(asiento)
            debeEx = existentes.debe.sum()
            haberEx = existentes.haber.sum()
            maximoDebe = Math.round((asiento.debe.toDouble() - (debeEx ?: 0))*100)/100
            maximoHaber = Math.round((asiento.haber.toDouble() - (haberEx ?:0))*100)/100
            totDebe = auxiliar.debe + maximoDebe
            totHaber = auxiliar.haber + maximoHaber
//            println("debeEx " + debeEx)
//            println("haberEx " + haberEx)
//            println("maximoDebe " + maximoDebe)
//            println("maximoHaber " + maximoHaber)
//            println("debe " + asiento.debe.toDouble())
//            println("haber " + asiento.haber.toDouble())
            band = auxiliar?.asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'A' && auxiliar?.asiento?.comprobante?.proceso?.gestor?.codigo == 'SLDO'
            band2 = auxiliar?.asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I', 'NC', 'ND']
            band3 = auxiliar?.asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I', 'NC']
            sql = "select * from ${funcion}(${auxiliar?.asiento?.comprobante?.proceso?.proveedor?.id})"
            res = cn.rows(sql.toString())
            println("res " + sql)
            return [asiento: asiento, auxiliar: auxiliar, comprobante: comprobante, proveedores: proveedores,
                    maximoDebe: maximoDebe, maximoHaber: maximoHaber, totDebe: totDebe, totHaber: totHaber,
                    band: band, band2: band2, res: res, band3: band3]
        } else {
            asiento = Asiento.get(params.asiento)
            existentes = Auxiliar.findAllByAsiento(asiento)
            debeEx = existentes.debe.sum()
            haberEx = existentes.haber.sum()
            maximoDebe = Math.round((asiento.debe.toDouble() - (debeEx ?: 0))*100)/100
            maximoHaber = Math.round((asiento.haber.toDouble() - (haberEx ?: 0))*100)/100
//            println("debeEx " + debeEx)
//            println("haberEx " + haberEx)
//            println("maximoDebe " + maximoDebe)
//            println("maximoHaber " + maximoHaber)
            band = asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() == 'A' && asiento?.comprobante?.proceso?.gestor?.codigo == 'SLDO'
            band2 = asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I', 'NC', 'ND']
            band3 = asiento?.comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I', 'NC']
            sql = "select * from ${funcion}(${asiento?.comprobante?.proceso?.proveedor?.id})"
            res = cn.rows(sql.toString())
            println("res " + sql)
            return [asiento: asiento, comprobante: comprobante, proveedores: proveedores, maximoDebe: maximoDebe,
                    maximoHaber: maximoHaber, band: band, band2: band2, res: res, band3: band3]
        }
    }

    def guardarAuxiliar_ajax () {
        println "guardarAuxiliar_ajax: $params"
        def asiento
        def afecta = Auxiliar.get(params.factura)
        def tipoPago = TipoDocumentoPago.get(params.tipoPago)
        def proveedor = Proveedor.get(params.proveedor)
        def fechaPago
        if(params.fechaPago) {
            fechaPago =  new Date().parse("dd-MM-yyyy", params.fechaPago)
        }

        def auxiliar

        if(params.auxiliar){
            auxiliar = Auxiliar.get(params.auxiliar)
        }else{
            asiento = Asiento.get(params.asiento)
            auxiliar = new Auxiliar()
            auxiliar.asiento = asiento
        }

        auxiliar.descripcion = params.descripcion
        auxiliar.fechaPago = fechaPago
        auxiliar.proveedor = proveedor
        auxiliar.tipoDocumentoPago = tipoPago
        auxiliar.debe = params.debe.toDouble()
        auxiliar.haber = params.haber.toDouble()
        auxiliar.documento = params.documento

        if(params.factura) {
            auxiliar.afecta = afecta
        }
        if(params.fctr) {
            auxiliar.factura = params.fctr
        }
        println " .... auxiliar padre: ${auxiliar?.afecta?.id}"

        try{
            auxiliar.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

    def tablaBuscarComp_ajax () {
        println "tablaBuscarComp_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def sql = ''
        def whds = ''
        def whnm = ''
        def wh = ''
        def res
        def tipo = TipoProceso.get(params.tipo)

        if(params.descripcion) {
            whds = " dscr ilike '%${params.descripcion}%'"
        }
        if(params.numero) {
            whnm = " dcmt ilike '%${params.numero}%'"
        }

//        println("whds " + whds)
//        println("whnm " + whnm)


//        if(params.descripcion || params.numero) {
//            wh = "where ${whds? whds : ''} ${whnm? 'and ' + whnm : ''}"
//        }

        if(params.descripcion && params.numero){
            wh = "where ${whds ? whds : ''} ${whnm? 'and ' + whnm : ''}"
        }else{
            if(params.descripcion || params.numero){
                wh = "where ${whds ? whds : whnm}"
            }
        }

//        println "where: $wh"

        if(params.tipo.toInteger() == 4) {
            sql = "select cmpr__id, prvenmbr, dscr, dcmt, fcha, hber, pgdo, sldo from porpagar(${params.proveedor}) ${wh}"
        } else if(params.tipo.toInteger() in [5, 6, 7]) {
            sql = "select cmpr__id, clntnmbr prvenmbr, dscr, dcmt, fcha, debe hber, ntcr pgdo, sldo from ventas(${params.proveedor}) ${wh}"
        }

        println("sql " + sql)

        res = cn.rows(sql.toString())
        return [res:res, tipo: tipo]
    }

    def filaComprobante_ajax () {
//        println "filaComprobante_ajax: $params"
        def proceso = Proceso.get(params.proceso)
        def data
        def cn = dbConnectionService.getConnection()
        def sql
        if(params.proceso){
            println "tipo de proceso: ${proceso.tipoProceso.id}"
            if(proceso.tipoProceso.id == 4) {
                println "1---------"
                sql = "select sldo from porpagar(${proceso?.proveedor?.id}) where cmpr__id = ${proceso?.comprobante?.id}"
            } else
                println "2--------- ${proceso.tipoProceso.id}"
            if(proceso.tipoProceso.id.toInteger() in [5, 6, 7]) {
                println "si se contiene-----"
                sql = "select sldo from ventas(${proceso?.proveedor?.id}) where cmpr__id = ${proceso?.comprobante?.id}"
            }
            println "sql: $sql"
            data = cn.firstRow(sql.toString())
        }
        println "saldo: ${data?.sldo}"
        return[proceso: proceso, saldo: data?.sldo ?: 0]
    }

    def valores_ajax () {
        println "valores_ajax $params"
        def cn = dbConnectionService.getConnection()
        def proceso = Proceso.get(params.proceso)
        def data = []
        def atrz
        def fcha = "now()"
        if(proceso) {
            fcha = "'${proceso?.fechaEmision}'"
        } else {
            fcha = "'" + new Date().parse("dd-MM-yyyy", params.fcha).format('yyyy-MM-dd') + "'"
        }
        def sql = "select paux_iva from paux where ${fcha} between pauxfcin and " +
                "coalesce(pauxfcfn, now())"
        println "sqlIva: $sql"
        def valorIva = cn.rows(sql.toString())[0]?.paux_iva

        def detalles = DetalleFactura.findAllByProceso(proceso)
//        println("--> " + detalles)
        def band
        if(detalles.size() > 0){
            band = true
        }else{
            band = false
        }

        def tipo = 0
        def tpcp = params?.tpcp?.toInteger()
        if(tpcp in [4, 5] && params.tpps == '1') {
            sql = "select cast(tittcdgo as integer) cdgo from titt, prve, tptr " +
                    "where prve.tpid__id = titt.tpid__id and prve__id = ${params.prve} and " +
                    "tptr.tptr__id = titt.tptr__id and tptrcdgo = '1'"
//        println "sql1: $sql"
            def titt = cn.rows(sql.toString())[0]?.cdgo
//            println "identif: $titt"
            sql = "select tcst__id id, tcsrcdgo codigo, tcsrdscr descripcion from tcst, tcsr " +
                    "where tcsr.tcsr__id = tcst.tcsr__id and titt @> '{${titt}}' " +
                    "order by tcsrcdgo"
//        println "sql2: $sql"
            data = cn.rows(sql.toString())
            cn.close()
        }
        sql = "select prveatrz from prve where prve__id = ${params.prve}"
//        println "sql1: $sql"
        atrz = cn.rows(sql.toString())[0]?.prveatrz
//        println "autorizacion: $atrz"

        [proceso: proceso, tipo: params.tipo, data: data, atrz: atrz, band: band, valorIva: valorIva]
    }

    def proveedor_ajax () {
//        println "proveedor_ajax: $params"
        def proceso = Proceso.get(params.proceso)
        def proveedores
        def tr
        def prve
        if(params.id) {
            prve = Proveedor.get(params.id.toInteger())
        }

        switch (params.tipo) {
            case ["1", "4"]:  //Pagos proveedores
                proveedores = Proveedor.findAll()
                break
            case ["2", "6", "7"]:  //ventas, NC y ND - clientes
//                proveedores = Proveedor.findAllByTipoRelacionInList(tr)
                proveedores = Cliente.findAll()
                break
        }
//        println "proveedores: $proveedores"
        return [proveedores : proveedores, proceso: proceso, tipo: params.tipo, proveedor: prve]
    }

    def cambiarContabilidad_ajax () {
        def usuario = Persona.get(session.usuario.id)
        def contabilidad = Contabilidad.get(session.contabilidad.id)
        def empresa = Empresa.get(session.empresa.id)
        def contabilidades = Contabilidad.findAllByInstitucion(empresa, [sort: "fechaInicio"])
        contabilidades.remove(contabilidad)
        return [usuario: usuario, contabilidad: contabilidad, contabilidades: contabilidades, tipo: params.tipo]
    }

    def botonesMayo_ajax () {
        def comprobante = Comprobante.get(params.comprobante).refresh()
        def proceso = Proceso.get(comprobante.proceso.id)
        def auxiliares = Auxiliar.findAllByComprobante(comprobante)
        def asientos = Asiento.findAllByComprobante(comprobante)
        println "asientos: $asientos, cmpr: ${comprobante.id}"
        def totalDebe = asientos.debe.sum()
        def totalHaber = asientos.haber.sum()
        def debe = Math.round(totalDebe*100)/100
        def haber = Math.round(totalHaber*100)/100
        def valor
        def retencion = Retencion.findByProceso(proceso)
        if(comprobante?.tipo?.codigo == 'R'){
            valor = (retencion ?  Math.round(retencion?.total * 100)/100 : 0)
        }else{
            valor = Math.round(comprobante.proceso.valor*100)/100
        }
        def band
        def gestor = comprobante.proceso.gestor

//        println "Mayorizar: debe: $debe, haber: $haber, valor: $valor"

        if((gestor.codigo == 'SLDO' || comprobante.tipo.codigo == 'R') && Math.abs(debe - haber) < 0.001){
            band = true
        }else{
            if(( debe - haber) == 0 && debe == valor && haber == valor){
                band = true
            }else{
                band = false
            }
        }

        return[comprobante: comprobante, auxiliares: auxiliares, band: band]
    }
    def mayorizar_ajax () {
        def cn = dbConnectionService.getConnection()
        def sql = "select sum(asntdebe) - sum(asnthber) suma from asnt " +
                "where cmpr__id = ${params.id}"
        def sumaAsnt = cn.rows(sql.toString())[0].suma
        def res

        sql = "select count(*) cnta from asnt, axlr where asnt.asnt__id = axlr.asnt__id and asnt.cmpr__id = ${params.id}"

        if(cn.rows(sql.toString())[0].cnta > 0) {
            sql = "select asntdebe - sum(axlrdebe) debe, asnthber - sum(axlrhber) hber from asnt, axlr " +
                    "where asnt.asnt__id = axlr.asnt__id and asnt.cmpr__id = ${params.id} group by asntdebe, asnthber;"
            def valores = cn.rows(sql.toString())[0]
            println("valores " + sql)
            if(valores?.debe == 0 && valores?.hber == 0) {
//            println "cuadra"
                res = procesoService.mayorizar(params.id)
            }  else {
//            println "no cuadra"
                render "no_no cuadran los valores de asientos y sus respectivos auxiliares"
                return
            }
        } else {
            if(sumaAsnt == 0) {
                res = procesoService.mayorizar(params.id)
            }  else {
//            println "no cuadra"
                render "no_no cuadran los valores de asientos"
                return
            }
        }
        println("res " + res)
        render res
    }

    def desmayorizar_ajax () {
//        println("params " + params)
        def comprobante = Comprobante.get(params.id)
        def res = procesoService.desmayorizar(comprobante)
//        println("res " + res)
        render res
    }


    def numeracion_ajax () {
        println "numeracion_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def empr = Empresa.get(session.empresa.id)
        def proceso
        if(params.proceso) {
            proceso = Proceso.get(params.proceso)
        }

        def tpdc = ""
        def tipo = "Facturas"
        def fcdt
        def sql
        def nmro = 0
        switch (params.tpps){
            case '2':
                tpdc = 'F'
                tipo = 'Facturas'
                break
            case '6':
                tpdc = 'NC'
                tipo = 'Notas de Crédito'
                break
            case '7':
                tpdc = 'ND'
                tipo = 'Notas de Débito'
                break
        }

        if(params.libretin){
            fcdt = DocumentoEmpresa.get(params.libretin)
            sql = "select coalesce(max(prcsfcsc), 0) mxmo from prcs, fcdt " +
                    "where tpps__id = ${params.tpps} and fcdt.fcdt__id = prcs.fcdt__id and " +
                    "prcs.fcdt__id = ${params.libretin} and prcsfcsc between fcdtdsde and fcdthsta and " +
                    "estb__id = '${params.nmes}' and empr__id = ${session.empresa.id}"
            nmro = cn.rows(sql.toString())[0]?.mxmo + 1
            render "${fcdt.numeroEstablecimiento}_${fcdt.numeroEmision}_${nmro}"
        } else {
            sql = "select fcdt__id id, fcdtdsde numeroDesde, fcdthsta numeroHasta, fcdtfcat fechaAutorizacion, " +
                    "fcdtnmes numeroEstablecimiento, fcdtnmpe numeroEmision " +
                    "from fcdt where to_date('${params.fcha}', 'DD-MM-YYYY') between fcdtfcin and fcdtfcfn and " +
                    "fcdttipo = '${tpdc}' and estb__id = '${params.nmes}' and empr__id = ${session.empresa.id} order by fcdtfcin"
            println "libretin: $sql"
            def libretin = cn.rows(sql.toString())
//            def lb = DocumentoEmpresa.findAllByEmpresaAndTipo(empr, tpdc)

            sql = "select coalesce(max(prcsfcsc), 0) mxmo from prcs, fcdt " +
                    "where tpps__id = ${params.tpps} and fcdt.fcdt__id = prcs.fcdt__id and " +
//                    "prcs.fcdt__id = ${libretin[0]?.id} and prcsfcsc between fcdtdsde and fcdthsta and " +
                    "prcs.fcdt__id = ${libretin[0]?.id} and prcsfcsc between fcdtdsde and fcdthsta"
            println "sql nmro: $sql"



            nmro = cn.rows(sql.toString())[0]?.mxmo ?: 0
            nmro = nmro == 0 ? libretin[0]?.numeroDesde : nmro + 1

            println "valor de nmro: $nmro, ${libretin[0]?.numeroDesde} , libretin: $libretin"



            if(libretin?.size() > 0) {
//            if(lb.size() > 0) {

                [libretin: libretin, estb: libretin[0].numeroEstablecimiento, emsn: libretin[0].numeroEmision, nmro: nmro,
                 tipo: tipo, proceso: proceso]
//                [libretin: lb, estb: lb[0].numeroEstablecimiento, emsn: lb[0].numeroEmision, nmro: nmro,
//                 tipo: tipo, proceso: proceso]
            } else {
                [libretin: libretin, estb: 0, emsn: 0, nmro: 0, tipo: tipo, proceso: proceso]
            }
        }
    }

    /** se usa en retenciones */
    def libretin_ajax () {
        println "libretin_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def proceso
        if(params.proceso) {
            proceso = Proceso.get(params.proceso)
        }

        def fcdt = DocumentoEmpresa.get(params.libretin)
        def sql
        def nmro = 0
        if(params.libretin){
            fcdt = DocumentoEmpresa.get(params.libretin)
            sql = "select coalesce(max(rtcnnmro), 0) mxmo from rtcn, fcdt " +
                    "where fcdt.fcdt__id = rtcn.fcdt__id and " +
                    "rtcn.fcdt__id = ${params.libretin} and rtcnnmro between fcdtdsde and fcdthsta and " +
                    "estb__id = ${proceso.establecimiento.id}"
            def mxmo = cn.rows(sql.toString())[0]?.mxmo
            nmro = (mxmo > 0)? mxmo + 1 : fcdt.numeroDesde

            if(!params.rtcn){
                render "${fcdt.numeroEstablecimiento}_${fcdt.numeroEmision}_${nmro}"
            } else {
                def rtcn = Retencion.get(params.rtcn)
                if(params.libretin.toInteger() == rtcn.documentoEmpresa.id){
                    render "${fcdt.numeroEstablecimiento}_${fcdt.numeroEmision}_${rtcn.numero}"
                } else {
                    render "${fcdt.numeroEstablecimiento}_${fcdt.numeroEmision}_${nmro}"
                }
            }
        } else {
            render "0_0_"
        }
    }

    /** antes buscarPrcs**/
    def buscarPrcs() {
//        println "session: ${session.empresa.nombre}"
        def empresa = Empresa.get(session.empresa.id)
        def contabilidades = Contabilidad.findAllByInstitucion(empresa)
//        println "empresa --> ${empresa.nombre}, cont: $contabilidades"
        return[contabilidades: contabilidades]
    }

    def armaSqlProcesos(params){
        println "armaSql: $params"
        def cont = session.contabilidad.id
        def campos = buscadorService.parmProcesos()
        def operador = buscadorService.operadores()
        def wh = " prcs__id is not null " //condicion fija
        def fcds = "null"
        def fchs = "null"
        def tpps = params.tpps.toInteger()

        if(tpps) {
            def tipo = TipoProceso.get(tpps).descripcion
            wh = "tpps = '${tipo}'"
        }

        if(params.desde) fcds = "'" + new Date().parse("MM/dd/yyyy",params.desde).format('yyyy-MM-dd') + "'"
        if(params.hasta) fchs = "'" + new Date().parse("MM/dd/yyyy",params.hasta).format('yyyy-MM-dd') + "'"

        def sqlSelect = "select * from procesos(${session.empresa.id}, ${cont}, ${fcds}, ${fchs}) "

        def sqlWhere = "where (${wh})"

        def sqlOrder = "order by prcsfcha desc limit 31"

//        if(params.criterio) {
        if(params.operador && params.criterio) {
            if(campos.find {it.campo == params.buscador}?.size() > 0) {
                def op = operador.find {it.valor == params.operador}
                sqlWhere += " and ${params.buscador} ${op.operador} ${op.strInicio}${params.criterio}${op.strFin}";
            }
        }
//        println "sql: $sqlSelect $sqlWhere $sqlOrder"
        "$sqlSelect $sqlWhere $sqlOrder".toString()
    }



    def tablaBuscarPrcs() {
        println "buscar .... $params"
        def cn = dbConnectionService.getConnection()
        params.old = params.criterio
        params.criterio = buscadorService.limpiaCriterio(params.criterio)

        def sql = armaSqlProcesos(params)
        params.criterio = params.old
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        def msg = ""
        if(data?.size() > 30){
            data.pop()   //descarta el último puesto que son 21
            msg = "<div class='alert-danger' style='margin-top:-20px; diplay:block; height:25px;margin-bottom: 20px;'>" +
                    " <i class='fa fa-warning fa-2x pull-left'></i> Su búsqueda ha generado más de 30 resultados. " +
                    "Use más letras para especificar mejor la búsqueda.</div>"
        }
        cn.close()

        return [data: data, msg: msg]
    }

    def validarSerie_ajax () {
//        println "validarSerie_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def fcdt = DocumentoEmpresa.get(params.fcdt)
        def nmro = params.serie.toInteger()
        def sql = ""

//        println "nmro:; $nmro"
//        println ("fcdt " + fcdt)

        if(nmro) {
            if(nmro >= fcdt?.numeroDesde && nmro <= fcdt?.numeroHasta) {
//                println "esta en el rango"
                sql = "select count(*) cnta from rtcn where empr__id = ${session.empresa.id} and rtcnnmro = ${nmro}"
                if(params.id) {
                    sql += " and rtcn__id <> ${params.id}"
                }
//                println "sql: $sql"
                def existe = cn.rows(sql.toString())[0].cnta
                cn.close()

//                render existe > 0 ? true : false
//                println "existe: $existe"
                if(existe > 0) {
                    render false
                } else {
//                    println "no existe... $existe"
                    render true
                }
            } else {
//                println "fuera del rango..."
                render false
            }
        } else {
            render true
        }
    }

    def validaSerie_ajax () {
        println "validaSerie_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def fcdt = DocumentoEmpresa.get(params.fcdt)
        def nmro = params.serie.toInteger()
        def sql = ""
        println "nmro:; $nmro"

        if(nmro != 0) {
            if(nmro >= fcdt.numeroDesde && nmro <= fcdt.numeroHasta) {
                println "esta en el rango"
                sql = "select count(*) cnta from prcs where empr__id = ${session.empresa.id} and prcsfcsc = ${nmro}"
                if(params.id) {
                    sql += " and prcs__id <> ${params.id}"
                }
                println "sql: $sql"
                def existe = cn.rows(sql.toString())[0].cnta
                cn.close()

                println "existe: $existe"
                if(existe > 0) {
                    render "no_"
                } else {
                    println "no existe... $existe"
                    render "ok"
                }
            } else {
                println "fuera del rango..."
                render "no_Fuera del rango de valores"
            }
        } else {
            println "no hay valor..."
            render "no_No hay valor"
        }
    }

    def cargaCrir_ajax () {
        def concepto = ConceptoRetencionImpuestoRenta.get(params.id)
//        println "cargaCrir_ajax params: $params --> porcentaje: ${concepto?.porcentaje}"
        render concepto?.porcentaje?:0
    }

    def carga_pciv () {
        def pciv = PorcentajeIva.get(params.id)
        println "carga_pciv porcentajeIva: ${pciv?.valor}"
        render pciv?.valor?:0
    }

    def validarBase_ajax () {
        println("params " + params)
        def sumatoria = params.baseBienes.toDouble() + params.baseServicios.toDouble()
        if(params.baseBienes.toDouble() > params.baseImponible.toDouble() || params.baseBienes.toDouble() > sumatoria ){
            render false
        }else{
            render true
        }
    }

    def calcularValorICE_ajax () {
//        def porcentaje = PorcentajeIva.get(params.porcentaje)
//        def valor = params.base.toDouble() * (porcentaje.valor / 100)
        def valor = (params.base ? params.base.toDouble() : 0) * (params.porcentaje ? (params.porcentaje.toDouble()  / 100) : 0)
        return [valor: valor]
    }

    def saveRetencion_ajax () {
        println("params save " + params)
        def proceso = Proceso.get(params.proceso)
        def retencion
        def mnsj

        def proveedor = Proveedor.get(proceso.proveedor.id)
        def libretin  = DocumentoEmpresa.get(params.documentoEmpresa)

        if(params.retencion){  /** update **/
            retencion = Retencion.get(params.retencion)
        }else{
            retencion = new Retencion()
            retencion.proceso = proceso
            retencion.proveedor = proveedor
        }
        retencion.empresa = proceso.empresa
        retencion.persona = proveedor.nombre
        retencion.telefono = proveedor.telefono
        retencion.ruc = proveedor.ruc
        retencion.direccion = proveedor.direccion
        retencion.fecha = new Date()
        retencion.fechaEmision = new Date().parse("dd-MM-yyyy",params.fechaEmision)

        println "${retencion.fechaEmision} >=  ${proceso.fechaIngresoSistema}"
        if(retencion.fechaEmision < proceso.fechaIngresoSistema) {
            mnsj = "La fecha de la retención es anterior a la emisión del comprobante: ${proceso.fechaRegistro.format('dd-MM-yyyy')}"
            render mnsj
            return
        }


        if(params.conceptoRIRBienes != '-1') {
            retencion.conceptoRIRBienes = ConceptoRetencionImpuestoRenta.get(params.conceptoRIRBienes)
            retencion.baseRenta = params.baseRenta.toDouble()
            retencion.renta = params.renta.toDouble()

        } else {
            retencion.conceptoRIRBienes = null
            retencion.baseRenta = 0
            retencion.renta = 0
        }

        if(params.conceptoRIRBienes != '23') {
            retencion.numero = params.numero.toInteger()
            retencion.numeroComprobante = (libretin.numeroEstablecimiento + "-" + libretin.numeroEmision + "-" + params.numero)

            retencion.conceptoRIRServicios = ConceptoRetencionImpuestoRenta.get(params.conceptoRIRServicios)
            retencion.baseRentaServicios = params.baseRentaServicios.toDouble()
            retencion.rentaServicios = params.rentaServicios.toDouble()
            retencion.pcntIvaBienes = PorcentajeIva.get(params.pcntIvaBienes)
            retencion.baseIvaBienes = params.baseIvaBienes.toDouble()
            retencion.ivaBienes = params.ivaBienes.toDouble()
            retencion.pcntIvaServicios = PorcentajeIva.get(params.pcntIvaServicios)
            retencion.baseIvaServicios = params.baseIvaServicios.toDouble()
            retencion.ivaServicios = params.ivaServicios.toDouble()

            retencion.documentoEmpresa = DocumentoEmpresa.get(params.documentoEmpresa)
        } else {
            retencion.numero = 0
            retencion.numeroComprobante = null
            retencion.renta = 0
            retencion.baseRentaServicios = 0
            retencion.rentaServicios = 0
            retencion.baseIvaBienes = 0
            retencion.ivaBienes = 0
            retencion.baseIvaServicios = 0
            retencion.ivaServicios = 0
        }

        try {
            retencion.save(flush: true)
//            println("retencion id " + retencion.errors)
            render "ok"
        }catch (e){
            println("errores " + e)
            render "no"
        }
    }

    def comprobarSerieFactura_ajax () {
        def documentoEmpresa = DocumentoEmpresa.get(params.libretin)
        def desde = documentoEmpresa.numeroDesde
        def hasta = documentoEmpresa.numeroHasta

        if((params.serie.toInteger() >= desde.toInteger()) && (params.serie.toInteger() <= hasta.toInteger())){
            render 'ok'
        }else{
            render 'no'
        }
    }

    def validarSerieFactura_ajax () {
        def proceso
        def todas
        def empresaF = Empresa.get(session.empresa.id)

        if(params.proceso){
            proceso = Proceso.get(params.retencion)
            todas = Proceso.findAllByEmpresa(proceso.empresa) - proceso
            if(todas.facturaSecuencial.contains(params.serie.toInteger())){
                render 'no'
            }else{
                render 'ok'
            }
        }else{
            todas = Proceso.findAllByEmpresa(empresaF)
            if(todas.facturaSecuencial.contains(params.serie.toInteger())){
                render 'no'
            }else{
                render 'ok'
            }
        }
    }


    def compBuscador () {
        def proveedor = Proveedor.get(params.proveedor)
        def tipo = TipoPago.get(params.tipo)
        return [proveedor: proveedor, tipo:tipo]
    }

    def bodegaRecibe_ajax () {
        def bodega = Bodega.get(params.bodega)
        def todas = Bodega.list().sort{it.descripcion}
        def bodegasRecibe = todas - bodega
        def proceso = Proceso.get(params.proceso)

        return[bodegas: bodegasRecibe, proceso: proceso]
    }

    def centroCostos_ajax () {
        def empresa = Empresa.get(session.empresa.id)
        def cs = CentroCosto.findAllByEmpresa(empresa)
        def asiento = Asiento.get(params.asiento)
        def centros = AsientoCentro.findAllByAsiento(asiento)
        def valorTotal = 0
        def tipo = 0

        if(asiento.debe == 0){
            valorTotal = (asiento.haber.toDouble() - (centros.haber.sum() ? centros.haber.sum().toDouble() : 0 ))
            tipo = 2
        }else if(asiento.haber == 0){
            valorTotal = (asiento.debe.toDouble() - (centros.debe.sum() ? centros.debe.sum().toDouble() : 0 ))
            tipo = 1
        }
//        println("--> " + valorTotal)

        return[cs:cs, asiento: asiento, valor: valorTotal, tipo: tipo]
    }

    def tablaCentroCostos_ajax () {
        def asiento = Asiento.get(params.asiento)
        def centros = AsientoCentro.findAllByAsiento(asiento)
        return[centros: centros, tipo: params.tipo, asiento: asiento]
    }

    def guardarCentro_ajax () {
//        println("params " + params)

        def asiento = Asiento.get(params.asiento)
        def centro = CentroCosto.get(params.centro)
        def centroEspe = AsientoCentro.findByAsientoAndCentroCosto(asiento,centro)
        def asientoCentro
        params.valor = params.valor.replaceAll(',','')
        if(centroEspe){
            asientoCentro = AsientoCentro.get(centroEspe.id)
            if(params.tipo == '1'){
                asientoCentro.debe = params.valor.toDouble() + asientoCentro.debe.toDouble()
            }else{
                asientoCentro.haber = params.valor.toDouble() + asientoCentro.haber.toDouble()
            }
        }else{
            asientoCentro = new AsientoCentro()
            asientoCentro.asiento = asiento
            asientoCentro.centroCosto = centro
            if(params.tipo == '1'){
                asientoCentro.debe = params.valor.toDouble()
            }else{
                asientoCentro.haber = params.valor.toDouble()
            }
        }

        try{
            asientoCentro.save(flush: true)
            render "ok"
        }catch (e){
            println("Error al agregar el cs " + e)
            render "no"
        }
    }

    def calcularValor_ajax () {
        def asiento = Asiento.get(params.asiento)
        def centros = AsientoCentro.findAllByAsiento(asiento)
        def valorTotal = 0

        if(asiento.debe == 0){
            valorTotal = (asiento.haber.toDouble() - (centros.haber.sum() ? centros.haber.sum().toDouble() : 0 ))
        }else if(asiento.haber == 0){
            valorTotal = (asiento.debe.toDouble() - (centros.debe.sum() ? centros.debe.sum().toDouble() : 0 ))
        }
        render valorTotal
    }

    def borrarCentro_ajax () {
        def asientoCentro = AsientoCentro.get(params.id)
        try{
            asientoCentro.delete(flush: true)
            render "ok"
        }catch (e){
            println("Error al borrar el centro " + e)
            render "no"
        }
    }

    def comprobante () {
        def proceso = Proceso.get(params.proceso)
        return[proceso: proceso]
    }

    def reembolso () {
        def proceso = Proceso.get(params.proceso)
        def reembolsos = Reembolso.findAllByProceso(proceso)
        return[proceso: proceso, reembolsos: reembolsos]
    }

    def formReembolso_ajax () {
        def proceso = Proceso.get(params.proceso)
        def reembolso = Reembolso.get(params.id)
        return[proceso: proceso, reembolso: reembolso]
    }

    def buscarProveedor_ajax () {
        def proceso = Proceso.get(params.proceso)
        return[proceso: proceso]
    }

    def tablaProveedor_ajax () {
//        println "buscar proveedor "+params
        def prve = []
        def proceso = Proceso.get(params.proceso)
        def tr = TipoRelacion.list()
        def tipo =   " 1,2,3 "
        if(!params.tipoProceso){
            params.tipoProceso = proceso.tipoProceso.codigo.trim()
        }
        switch (params.tipoProceso) {
            case "P":
                tr = TipoRelacion.findAllByCodigoInList(['C','P'])
                tipo = " 1, 3 "
                break
            case "NC" :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2,3 "
                break
            case "V"  :
                tr = TipoRelacion.findAllByCodigoInList(['C','E'])
                tipo = " 2, 3 "
                break
        }

        def cn = dbConnectionService.getConnection()
        def sql

        if(!params.ruc && !params.nom){
            sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                    "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} order by prve_ruc;"
        }else{
            if(params.ruc && params.nom){
                sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                        "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prve_ruc like '%${params.ruc}%' and prvenmbr ilike '%${params.nom}%' order by prve_ruc;"
            }else{
                if(params.nom){
                    sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                            "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prvenmbr ilike '%${params.nom}%' order by prve_ruc;"
                }

                if(params.ruc){
                    sql = "select prve__id id, prve_ruc ruc, prvenmbr nombre, tppvdscr tipoProveedor, prveatrz from prve, tppv " +
                            "where tppv.tppv__id = prve.tppv__id and tprl__id in (${tipo}) and empr__id = ${session?.empresa?.id} and prve_ruc like '%${params.ruc}%' order by prve_ruc;"
                }
            }
        }

        prve = cn.rows(sql.toString())

        [prve: prve, proceso: proceso]
    }

    def tablaReembolso_ajax () {
        def proceso = Proceso.get(params.proceso)
        def reembolsos = Reembolso.findAllByProceso(proceso)
        return [reembolsos: reembolsos, proceso: proceso]
    }

    def verificarReembolsos_ajax (){
        def proceso = Proceso.get(params.proceso)
        def reembolsos = Reembolso.findAllByProceso(proceso)
        if(!reembolsos){
            render "ok"
        }else{
            if(Math.round(proceso?.valor*100)/100 == Math.round(reembolsos?.valor?.sum()*100)/100){
                render "ok"
            }else{
                render "no"
            }
        }
    }

    def fechas_ajax () {

    }

    def revisarFecha_ajax() {
        println("params revisar fecha " + params)
        if(params.desde && params.hasta){
//            def desde = new Date().parse("dd-MM-yyyy", params.desde)
//            def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
            def desde = new Date().parse("MM/dd/yyyy", params.desde)
            def hasta = new Date().parse("MM/dd/yyyy", params.hasta)

            if(desde > hasta){
                render "no"
            }else{
                render "ok"
            }
        }else{
            render "ok"
        }
    }

    def borrarCeros_ajax(){
        def comprobante = Comprobante.get(params.comprobante)
        def asientos = Asiento.findAllByComprobanteAndDebeAndHaber(comprobante,0.0,0.0)
        def errores = ''

        asientos.each {
            try{
                it.delete(flush: true)
            }catch (e){
                errores += e
                println("error al borrar los asientos con 0 " + e)
            }

        }

        if(errores == ''){
            render "ok"
        }else{
            render "no"
        }
    }

    def con_ajax(){
        def proceso = Proceso.get(params.proceso)
        return[proceso: proceso]
    }

    def conciliar_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        proceso.valor = params.valor.toDouble()
        proceso.baseImponibleIva = params.valor.toDouble()

        try{
            proceso.save(flush:true)
            render "ok"
        }catch (e){
            println("error al cambiar el valor " + e)
            render "no"
        }
    }

    def docRetencion_ajax () {
        def proceso = Proceso.get(params.proceso)
        return [proceso: proceso]
    }

    def guardarDocRetencion_ajax () {
//        println("params " + params)
        def proceso = Proceso.get(params.proceso)
        proceso.retencionVenta = params.documento
        proceso.retenidoIva = params.retenido.toDouble()
        proceso.retenidoRenta = params.renta.toDouble()

        try{
            proceso.save(flush: true)
            render "ok"
        }catch (e){
            println("error al guardar el doc de retencion " + e)
            render "no"
        }
    }

    def verAuxiliar_ajax () {
        def auxiliar = Auxiliar.get(params.auxiliar)
        def comprobante = Comprobante.get(params.comprobante)
        return[auxiliar: auxiliar, comprobante: comprobante]
    }

    def formaPago_ajax () {
        def proceso = Proceso.get(params.id)
        return [proceso: proceso]
    }

    def tablaFormaPago_ajax () {
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso)
        return[formasPago: formasPago, proceso: proceso]
    }

    def guardarFormaPago_ajax () {

        println "guardar FP: $params"
        def proceso = Proceso.get(params.id)
        def tipoPago = TipoPago.get(params.tipo)
        def formaPago = new ProcesoFormaDePago()

        formaPago.proceso = proceso
        formaPago.tipoPago = tipoPago

        if(params.plazo){
            formaPago.plazo = params.plazo.toInteger()
        }else{
            formaPago.plazo = 0
        }

        try{
            formaPago.save(flush: true)
            render "ok"
        }catch (e){
            println "error al agregar una forma de pago: $e"
            render "no"
        }
    }

    def revisarFormaPago_ajax () {
        println "revisarFormaPago_ajax $params"
        def proceso = Proceso.get(params.proceso)
        def formasPago = ProcesoFormaDePago.findAllByProceso(proceso)

        println "valor: ${proceso.valor}"

        if(proceso.valor <= 0.0) {
            render "no_Revise el valor ingresado"
        }

        println "... no es cero"
        if(proceso.tipoProceso.codigo.trim() == 'C') {
            println "compra con: ${formasPago.size()} registro de pago, valor: ${proceso.valor} "
            if((formasPago.size() < 1) && (proceso.valor >= 1000)) {
                render "no_Ingrese una forma de pago!"
            }
            else {
                render "ok"
            }
        }

        if(proceso.tipoProceso.codigo.trim() == 'V') {
            if(formasPago.size() > 0){
                render "ok"
            }else{
                render "no_Ingrese una forma de pago!"
            }
        }
    }
}

