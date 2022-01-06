package sri

import com.itextpdf.text.BaseColor
import com.itextpdf.text.Chunk
import com.itextpdf.text.Image
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfShadingPattern
import com.itextpdf.text.pdf.PdfTemplate
import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.BaseFont
import com.lowagie.text.pdf.PdfContentByte
import com.lowagie.text.pdf.PdfImportedPage
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfReader
import com.lowagie.text.pdf.PdfWriter
import pdf.PdfService
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import seguridad.Empresa

//import org.krysalis.barcode4j.impl.code128.Code128Bean
//import org.krysalis.barcode4j.impl.code128.EAN128Bean
//import org.krysalis.barcode4j.impl.code39.Code39Bean
//
//import org.krysalis.barcode4j.*

import java.awt.Color
import java.text.DecimalFormat
import java.text.NumberFormat

class Reportes3Controller {

    def dbConnectionService
    def cuentasService
    def buscadorService
    def barcode4jService
    def mailService
    PdfService pdfService
    def reportesPdfService
//    def kerberosoldService

    def reporteComprobante() {
        def contabilidad = Contabilidad.get(params.cont)
        def tipoComprobante = TipoComprobante.get(params.tipo)

        def numComp = params.num.toInteger()
        def tipoComp = params.tipo

        def comp = Comprobante.withCriteria {
            proceso {
                eq("contabilidad", contabilidad)
            }
            eq("numero", numComp)
            eq("tipo", tipoComprobante)
        }

        if (comp) {
            if (comp.size() == 1) {
                render comp[0].id
            } else {
                render "NO_Se encontró más de un comprobante"
            }
        } else {
            render "NO_No se encontró el comprobante"
        }
    }

    /*Reporte de cuentas por pagar
    * Sale de la tabla de axlr (plan de pagos)
    * Las pagas en teoria crean un registro en la tabla pagos
    * */

    def reporteCxP() {
//        println "reporte cxp "+params
//        params.empresa=1
//        params.fechaInicio="01/03/2013"
//        params.fechaFin="31/04/2013"
        def fechaInicio = new Date().parse("yyyy-MM-dd", params.fechaInicio)
        def fechaFin = new Date().parse("yyyy-MM-dd", params.fechaFin)
        def empresa = Empresa.get(params.empresa)
        def axl = Auxiliar.findAllByFechaPagoBetweenAndDebeGreaterThan(fechaInicio, fechaFin, 0, [sort: "fechaPago"])
        def cxp = []
        def valores = [:]
        axl.each { a ->
            if (a.asiento.cuenta.empresa.id.toInteger() == params.empresa.toInteger()) {
                def pagos = PagoAux.findAllByAuxiliar(a)
                def pagado = 0
                pagos.each { p ->
                    pagado += p.monto
                }
                if (pagado < a.debe) {
                    cxp.add(a)
                    valores.put(a.id, a.debe - pagado)
                }
            }
        }
        [cxp: cxp, empresa: empresa, fechaInicio: fechaInicio, fechaFin: fechaFin, valores: valores]

    }

    def auxiliarPorCliente() {
//        println "\n\n\n\n"
        println("params:-->" + params)

        if (!params.cli) {
            params.cli = "-1"
        }

//        params.cont = 1
//        params.per = 10
//        params.cli = -1
//        params.emp = 1
//
//        println params
//        println "\n\n\n\n"
        def html = "", header = ""
        if (!params.per || !params.cli || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.cli) {
                html += "<li>Seleccione un cliente</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
//            println("entro!!!!!")

            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)
            def cliente = Proveedor.get(params.cli)
            if (params.cli == "-1" || params.cli == -1) {
                cliente = Proveedor.list()
            }
            if (!empresa || !periodo || !cliente) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += "<li>No se encontró el periodo " + params.per + "</li>"
                }
                if (!cliente) {
                    html += "<li>No se encontró el cliente " + params.cli + "</li>"
                }
                if (!empresa) {
                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                }
                html += "</ul>"
                html += "</div>"
            } else {

                header += "<h1>" + empresa.nombre + "</h1>"
                header += "<h2>AUXILIAR POR CLIENTES</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def cn = dbConnectionService.getConnection()
                def cn2 = dbConnectionService.getConnection()

                def sql = "select\n" +
                        "        u.cnta__id              cuenta_id,\n" +
                        "        u.cntanmro              cuenta_num,\n" +
                        "        u.cntadscr              cuenta_desc,\n" +
                        "        r.prve__id              cli_id,\n" +
                        "        r.prve_ruc              cli_ruc,\n" +
                        "        r.prvenmbr              cli_nombre,\n" +
                        "        r.prvenbct              cli_nombrecontacto,\n" +
                        "        r.prveapct              cli_apellidocontacto,\n" +
                        "        x.axlrfcrg              fecha,\n" +
                        "        p.prcs__id              trans,\n" +
                        "        c.cmpr__id              comp,\n" +
                        "        t.tpcpdscr              tipocomp,\n" +
                        "        x.axlrdscr              descripcion,\n" +
                        "        x.axlrdebe              debe,\n" +
                        "        x.axlrhber              haber,\n" +
                        "        x.axlrdebe-x.axlrhber   saldo\n" +
                        "  from axlr x,\n" +
                        "          asnt s,\n" +
                        "          cmpr c,\n" +
                        "          prcs p,\n" +
                        "          tpcp t,\n" +
                        "          cnta u,\n" +
                        "          prve r\n" +
                        "  where x.asnt__id = s.asnt__id\n" +
                        "          and s.cmpr__id = c.cmpr__id\n" +
                        "          and c.prcs__id = p.prcs__id\n" +
                        "          and c.tpcp__id = t.tpcp__id\n" +
                        "          and s.cnta__id = u.cnta__id\n" +
                        "          and x.prve__id = r.prve__id\n" +
                        "          and u.empr__id = ${params.emp}\n" +
                        "          and c.cmprrgst = 'S'"
                "          and\n" +
                        "          c.cmprfcha >=\n" +
                        "                  (select prdofcin from prdo where prdo__id = ${params.per})\n" +
                        "          and\n" +
                        "          c.cmprfcha <=\n" +
                        "                  (select prdofcfn from prdo where prdo__id = ${params.per})"

//                println sql

                if (params.cli != -1 && params.cli != "-1") {
                    sql += "          and r.prve__id = ${params.cli}\n"
                }
                sql += " order by cuenta_id asc, cli_nombre asc, fecha asc"


                def cuentaId = null, cliId = null
                cn.eachRow(sql) { rs ->

//            println rs
                    def b = false
                    if (rs["cuenta_id"] != cuentaId) {
                        if (html != "") {
                            html += "</table>"
                        }
                        html += "<h1 class='cuenta'>Cuenta contable: " + rs["cuenta_num"] + " " + rs["cuenta_desc"] + "</h1>"
                        html += "<table border='1'>"
                        cuentaId = rs["cuenta_id"]
                        b = true
                    }
                    if (rs["cli_id"] != cliId || b) {

                        if (b) {
                            html += "<tr>"
                            html += "<th>Fecha</th>"
                            html += "<th>Trans.</th>"
                            html += "<th>Comp.</th>"
                            html += "<th>Tipo</th>"
                            html += "<th>Descripción</th>"
                            html += "<th>Debe</th>"
                            html += "<th>Haber</th>"
                            html += "<th>Saldo</th>"
                            html += "</tr>"
                        }

                        def sql2 = "select\n" +
                                "        u.cnta__id                    cuenta_id,\n" +
                                "        x.prve__id                    cli_id,\n" +
                                "        sum(x.axlrdebe-x.axlrhber)    saldo\n" +
                                "  from axlr x,\n" +
                                "          asnt s,\n" +
                                "          cmpr c,\n" +
                                "          prcs p,\n" +
                                "          cnta u\n" +
                                "  where x.asnt__id = s.asnt__id\n" +
                                "          and s.cmpr__id = c.cmpr__id\n" +
                                "          and c.prcs__id = p.prcs__id\n" +
                                "          and s.cnta__id = u.cnta__id\n" +
                                "          and u.empr__id = ${params.emp}\n" +
                                "          and x.prve__id = ${rs['cli_id']}\n" +
                                "          and u.cnta__id = ${rs['cuenta_id']}\n" +
                                "          and\n" +
                                "          c.cmprfcha <\n" +
                                "                  (select prdofcin from prdo where prdo__id=10)\n" +
                                "  group by cuenta_id, cli_id\n" +
                                "  order by cuenta_id asc;"

                        html += "<tr class='cliente'>"
                        html += "<th colspan='5'>"
                        html += "<b>Persona:</b> " + rs["cli_ruc"]
                        if (rs["cli_nombre"]) {
                            html += " " + rs["cli_nombre"]
                        }
                        html += " (" + rs["cli_nombrecontacto"] + " " + rs["cli_apellidocontacto"] + ")"
                        html += "</th>"

                        html += "<th colspan='2' class='right'>Saldo inicial:</th>"

                        html += "<th class='right'>"
                        def b2 = false
                        cn2.eachRow(sql2) { r ->
                            html += r["saldo"]
                            b2 = true
                        }
                        if (!b2) {
                            html += "0.00"
                        }
                        html += "</th>"

                        html += "</tr>"
                        cliId = rs["cli_id"]
                    }

                    html += "<tr>"
                    html += "<td width='80'>" + rs["fecha"].format("dd-MM-yyyy") + "</td>"
                    html += "<td width='80'>" + rs["trans"] + "</td>"
                    html += "<td width='80'>" + rs["comp"] + "</td>"
                    html += "<td width='80'>" + rs["tipocomp"] + "</td>"
                    html += "<td width='180'>" + rs["descripcion"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["debe"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["haber"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["saldo"] + "</td>"
                    html += "</tr>"
                }
                if (html != "") {
                    println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + html.contains("<table")
                    if (html.contains("<table")) {
                        html += "</table>"
                    }
                } else {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para el reporte"
                    html += "</div>"
                }
                cn.close()
                cn2.close()
            }
        }

        html = header + html
        println html
        return [html: html]
    }

    def getCuentas(html, cuenta, per) {
//        println cuenta
        html += "<tr class='cuenta'>"
        html += "<td class='numero'>" + cuenta.numero + "</td>"
//        html += "<td class='nombre'>" + cuenta.descripcion + "</td>"
        //  <util:clean str="${cuenta.descripcion}"></util:clean>
        html += "<td class='nombre'>" + util.clean(str: cuenta.descripcion) + "</td>"


        html += "<td class='valor ${cuenta.nivel.descripcion.trim().toLowerCase()}'>"
        def saldos = SaldoMensual.findAllByCuentaAndPeriodo(cuenta, per)
        def saldoInit = 0
        saldos.each {
            it.refresh()
            saldoInit += (it.saldoInicial + it.debe - it.haber)
        }
        html += g.formatNumber(number: saldoInit, maxFractionDigits: 2, minFractionDigits: 2)
        html += "</td>"
        html += "</tr>"

//        println "\t" + cuenta.movimiento
        if (cuenta.movimiento == "0") {
//            println "\t "+Cuenta.countByPadre(cuenta)
            Cuenta.findAllByPadre(cuenta).each { cuentaHija ->
                html = getCuentas(html, cuentaHija, per)
            }
        } else {
//            println "\t"+Asiento.countByCuenta(cuenta)
            Asiento.findAllByCuenta(cuenta).each { asiento ->
                html += "<tr class='asiento'>"
                html += "<td class='numero'> </td>"
                html += "<td class='nombre'>"
                if (asiento.comprobante.proceso?.proveedor) {
                    if (asiento.comprobante.proceso?.proveedor?.nombre) {
//                        html += asiento.comprobante.proceso?.proveedor?.nombre
                        html += util.clean(str: asiento.comprobante.proceso?.proveedor?.nombre)
                    } else if (asiento.comprobante.proceso?.proveedor?.nombreContacto) {
//                        html += asiento.comprobante.proceso?.proveedor?.nombreContacto + " " + asiento.comprobante.proceso?.proveedor?.apellidoContacto
                        html += util.clean(str: asiento.comprobante.proceso?.proveedor?.nombreContacto) + " " + util.clean(str: asiento.comprobante.proceso?.proveedor?.apellidoContacto)
                    } else {
                        html += ""
                    }
                } else {
                    html += ""
                }

                html += "</td>"
                html += "<td class='valor asiento'>"
                html += g.formatNumber(number: asiento.debe - asiento.haber, minFractionDigits: 2, maxFractionDigits: 2)
                html += "</td>"
                html += "</tr>"
            }
        }

        return html
    }


    def balanceGeneralAuxiliares() {
//        params.emp = 1
//        params.per = 10

        def html = "", header = ""

        if (!params.per || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)

            if (!empresa || !periodo) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += util.clean(str: "<li>No se encontró el periodo " + params.per + "</li>")
                }
                if (!empresa) {
//                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                    html += util.clean(str: "<li>No se encontró la empresa " + util.clean(str: empresa.nombre) + "</li>")
                }
                html += "</ul>"
                html += "</div>"
            } else {

//                def sp = kerberosoldService.ejecutarProcedure("saldos", periodo.contabilidadId)

                header += "<h1>" + util.clean(str: empresa.nombre) + "</h1>"
                header += "<h2>ESTADO DE SITUACION FINANCIERA (BALANCE GENERAL CON AUXILIARES)</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def tabla = ""

                Cuenta.findAllByEmpresaAndNivel(empresa, Nivel.get(1)).each { cuenta ->
                    tabla = getCuentas(tabla, cuenta, periodo)
                }

                if (tabla == "") {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para generar el reporte"
                    html += "</div>"
                } else {
                    html = "<table border='1'>"
                    html += tabla

                    def dos = valores(empresa, "2", periodo)
                    def tres = valores(empresa, "3", periodo)
                    def cuatro = valores(empresa, "4", periodo)
                    def cinco = valores(empresa, "5", periodo)
                    def seis = valores(empresa, "6", periodo)
                    def siete = valores(empresa, "7", periodo)

                    html += "<tr class='resultado'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>RESULTADO DEL EJERCICIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: ((cuatro + seis) - (cinco + siete)), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "<tr class='total'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>TOTAL PASIVO + PATRIMONIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: (dos + tres), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "</table>"

                }
            }
        }

        html = header + html

        html = "<div>TEST</div>"

//        println html
        return [html: html]
    }

    def valores(empresa, nivel, periodo) {
        def valor = SaldoMensual.withCriteria {
            eq("cuenta", Cuenta.findByEmpresaAndNumero(empresa, nivel))
            eq("periodo", periodo)
        }
        if (valor.size() == 1) {
            valor = valor[0]
            valor.refresh()
            valor = valor.saldoInicial + valor.debe - valor.haber
            return valor
        } else if (valor.size() == 0) {
            return 0
        } else {
            println "HAY MAS DE 1 SALDO INICIAL PARA " + nivel
            return 0
        }
    }

    def imprimirRetencion() {
//        println("params " + params)
        def empresa = Empresa.get(params.empresa)
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)
        def meses = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]

        return [empresa: empresa, retencion: retencion, meses: meses, proceso: proceso]
    }


    def reporteExcel() {

        def comprobantes = cuentasService.getComprobante(582)
        def tipoComprobante = []
        comprobantes.each { i ->
            tipoComprobante += i.tipo.codigo
        }

        def asiento = []
        def comprobante = null
        def numero = null
        if (comprobantes) {
            numero = "" + comprobantes[0].prefijo + "" + comprobantes[0].numero
            comprobante = comprobantes[0]
            asiento = cuentasService.getAsiento(comprobantes?.pop()?.id)
        }
        def comp = [:]

        asiento.each { asientos ->
            def fecha = asientos.comprobante.fecha
            def descripcion = asientos.comprobante.descripcion
            if (!comp.containsKey(numero)) {
                comp[numero] = [:]
                comp[numero].fecha = fecha
                comp[numero].descripcion = descripcion
                comp[numero].tipo = asientos.comprobante.tipo.descripcion
                comp[numero].items = []
            }
            def c = [:]
            c.debe = asientos.debe
            c.haber = asientos.haber
            c.cuenta = asientos.cuenta.numero
            c.descripcion = asientos.cuenta.descripcion
            def cont = comp[numero].items.add(c)
        }

        comp[numero]?.items?.sort { it?.cuenta }


        XSSFWorkbook wb = new XSSFWorkbook()
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("PAC")

        Row row = sheet.createRow(0)
        row.createCell(0).setCellValue("")

        Row row0 = sheet.createRow(1)
        row0.createCell(1).setCellValue("COMPROBANTE")

        Row row1 = sheet.createRow(2)
        row1.createCell(1).setCellValue("NÚMERO")
        row1.createCell(2).setCellValue("CUENTA")
        row1.createCell(3).setCellValue("DEBE")
        row1.createCell(4).setCellValue("HABER")

        comp.each { item ->
            def val = item.value
            val.items.eachWithIndex { i, j ->
                if (i.debe + i.haber > 0) {
                    Row row2 = sheet.createRow(j+3)
                    row2.createCell(1).setCellValue(i.cuenta)
                    row2.createCell(2).setCellValue(i.descripcion)
                    row2.createCell(3).setCellValue(i.debe)
                    row2.createCell(4).setCellValue(i.haber)
                }
            }
        }


        def output = response.getOutputStream()
        def header = "attachment; filename=" + "Excel.xlsx";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        wb.write(output)

    }

    def imprimirCompraGasto () {
//        println("params comprobante " + params)
        def comprobante = Comprobante.get(params.id)
        def proceso = comprobante.proceso
        return [empresa: params.empresa,proceso: proceso, comprobante: comprobante]
    }

    def imprimirCompDiario () {
//        def comprobante = Comprobante.get(params.id)
//        def proceso = comprobante.proceso

        def proceso = Proceso.get(params.id)
        def comprobante = Comprobante.findByProceso(proceso)

        def asientos = Asiento.findAllByComprobante(comprobante).sort{it.numero}
        return [empresa: params.empresa,proceso: proceso, comprobante: comprobante, asientos: asientos]
    }

    def imprimirLibroDiario () {
        def contabilidad = Contabilidad.get(params.cont)
        def periodo = Periodo.get(params.periodo)
        def empresa = Empresa.get(params.empresa)

        def comprobantes = Comprobante.withCriteria {

            proceso{
                eq("empresa",empresa)
                eq("estado",'R')
            }

            and{
                le("fecha", periodo.fechaFin)
                ge("fecha", periodo.fechaInicio)
            }

        }
        return[comprobantes: comprobantes, empresa: params.empresa]

    }

    def reporteSituacion () {


//        println("params " + params)
        def periodoFinal = Periodo.get(params.periodo).fechaFin.format("yyyy-MM-dd")
        def empresa = Empresa.get(params.empresa)

        def cn = dbConnectionService.getConnection()
        def sql = "select * from estado_st(${params.periodo},${params.nivel})"
//        def sql = "select * from estado_st(${params.periodo},${params.nivel}) where slin + debe + hber > 0"
        println("sql " + sql)
        def data = cn.rows(sql.toString())
        cn.close()

//        println("data " + data)

        return[periodo: periodoFinal, empresa: empresa.id, cuentas: data]
    }


    def facturaElectronica () {
        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}


        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def showBarcode(String barcode) {
//        println("params " + barcode)
//        def generator = new
//        def generator = new Code39Bean()


//        def generator = new Code128Bean()



//        def generator = new EAN128Bean()



//        generator.height = 6
//        generator.fontSize = 2



//        def imageMimeType = "image/png"
//        barcode4jService.png(generator, barcode)
//       barcode4jService.render(generator, barcode, imageMimeType)

//        new File("barcode.png").withOutputStream { out ->
//         barcode4jService.png(generator, barcode, out)
//            render out
//        }

        renderBarcodePng(generator, barcode)
    }

    def notaCreditoElectronica () {

        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}

        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def notaDebitoElectronica () {

        def proceso = Proceso.get(params.id)
        def empresa = Empresa.get(params.emp)
        def detalles = DetalleFactura.findAllByProceso(proceso).sort{it?.item?.codigo}

        return[proceso: proceso, empresa: empresa, detalles: detalles]
    }

    def modalKardex4_ajax () {

    }

    def kardex4 (){
        println("params " + params)
        def desde = new Date().parse("dd-MM-yyyy", params.desde)
        def hasta = new Date().parse("dd-MM-yyyy", params.hasta)
        def contabilidad = Contabilidad.get(params.cont)
        def bodega = Bodega.get(params.bodega)
        def item = Item.get(params.item)
        def d = desde.format("dd-MM-yyyy")
        def h = hasta.format("dd-MM-yyyy")

        def cn = dbConnectionService.getConnection()
        def res = cn.rows("select * from rp_kardex('${contabilidad?.id}','${bodega?.id}','${item?.id}', '${d}', '${h}')")

        return[res: res, empresa: params.emp, desde: desde, hasta: hasta, item: item]
    }



    def _correo () {

    }

    def pdfLink2 (urlOriginal) {
        try{
            byte[] b
            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort
            // def baseUri = g.createLink(uri:"/", absolute:"true").toString()
            // TODO: get this working...
            //if(params.template){
            //println "Template: $params.template"
            //def content = g.render(template:params.template, model:[pdf:params])
            //b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            //}
            urlOriginal=urlOriginal.replaceAll("W","&")
            if(params.pdfController){
                def content = g.include(controller:params.pdfController, action:params.pdfAction, id:params.pdfId)
                b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            }
            else{
                println "sin plugin --> params url "+urlOriginal
                def url = baseUri + urlOriginal
                println "url pdf "+url
                b = pdfService.buildPdf(url)
            }
//            response.setContentType("application/pdf")
//            response.setHeader("Content-disposition", "attachment; filename=" + (params.filename ?: "document.pdf"))
//            response.setContentLength(b.length)
//            response.getOutputStream().write(b)
        }
        catch (Throwable e) {
            println "there was a problem with PDF generation 2 ${e}"
            //if(params.template) render(template:params.template)
            if(params.pdfController){
                println "no"
                redirect(controller:params.pdfController, action:params.pdfAction, params:params)
            }else{
                redirect(action: "index",controller: "reportes",params: [msn:"Hubo un error en la genración del reporte. Si este error vuelve a ocurrir comuniquelo al administrador del sistema."])
            }
        }
    }

    def enviarMail () {

        def para = "correo@hotmail.com"
        def xml = servletContext.getRealPath("/") + "xml/46/"
        def completo = xml + 'fc_667.xml'

//        def x = pdfPrueba()

//        try {
//            def mail = para
//            if (mail) {
//                mailService.sendMail {
//                    multipart true
//                    to mail
//                    subject "Correo de prueba"
//                    html g.render(template:'/reportes3/correo', model:[name:'TEDEIN'])
//                    body "Prueba body "
//                    attachBytes "documentoSri.xml", " application/xml", new File(completo).bytes
//                    attachBytes "facturaElectronica.pdf", "application/pdf", facturaE()
//                }
//            } else {
//                println "El usuario no tiene email"
//            }
//        } catch (e) {
//            println "error email " + e.printStackTrace()
//        }
    }

    def enviarMail2 () {

//        println("params " + params)

        def para = "fegrijalva2501@hotmail.com"
        def xml = servletContext.getRealPath("/") + "xml/46/"
        def completo = xml + 'fc_667.xml'

        //        def x = pdfPrueba()

        try {
            def mail = para
            if (mail) {
                mailService.sendMail {
                    multipart true
                    to mail
                    subject "Factura Electrónica"
                    html g.render(template:'/reportes3/correo', model:[name:'TEDEIN'])
                    body "Prueba body "
                    attachBytes "documentoSri.xml", " application/xml", new File(completo).bytes
                    attachBytes "facturaElectronica.pdf", "application/pdf", pdfLink2(params.url)
                }

                redirect(controller:'proceso', action:'buscarPrcs')

            } else {
                println "El usuario no tiene email"
            }
        } catch (e) {
            println "error email " + e.printStackTrace()
        }
    }


    def excelPlan() {

        def empresa = Empresa.get(params.empresa)

        XSSFWorkbook wb = new XSSFWorkbook()
        org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("PLAN")

        Row row = sheet.createRow(0)
        row.createCell(0).setCellValue("")

        Row row0 = sheet.createRow(1)
        row0.createCell(1).setCellValue(empresa.nombre)

        Row rowT = sheet.createRow(2)
        rowT.createCell(1).setCellValue("PLAN DE CUENTAS")

        Row row1 = sheet.createRow(3)
        row1.createCell(1).setCellValue("NÚMERO")
        row1.createCell(2).setCellValue("PADRE")
        row1.createCell(3).setCellValue("NIVEL")
        row1.createCell(4).setCellValue("DESCRIPCIÓN")

        def contabilidad = Contabilidad.get(params.cont.toDouble())
        def cuentas = Cuenta.findAllByEmpresa(empresa, [sort: "numero"])

        CuentaContable.findAllByContabilidad(contabilidad).each { cc ->
            if (cuentas.contains(cc.antiguo)) {
                cuentas.remove(cc.antiguo)
            }
        }

        cuentas.eachWithIndex{cuenta, j->
            Row row2 = sheet.createRow(j+4)
            row2.createCell(1).setCellValue(cuenta.numero)
            row2.createCell(2).setCellValue(cuenta?.padre?.numero)
            row2.createCell(3).setCellValue(cuenta.nivel.id)
            row2.createCell(4).setCellValue(cuenta.descripcion)
        }

        def output = response.getOutputStream()
        def header = "attachment; filename=" + "PlanCuentas.xlsx";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        wb.write(output)
    }



    def encabezadoYnumeracion (f, tituloReporte, subtitulo, nombreReporte) {

        def titulo = new Color(30, 140, 160)
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD, titulo);
        Font fontTitulo16 = new Font(Font.TIMES_ROMAN, 16, Font.BOLD, titulo);

        def baos = new ByteArrayOutputStream()
        Document document
        document = new Document(PageSize.A4);

        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();

        PdfContentByte cb = pdfw.getDirectContent();

        PdfReader reader = new PdfReader(f);
        for (int i = 1; i <= reader.getNumberOfPages(); i++) {
            document.newPage();
            PdfImportedPage page = pdfw.getImportedPage(reader, i);
            cb.addTemplate(page, 0, 0);
            def en = reportesPdfService.encabezado(tituloReporte, subtitulo, fontTitulo16, fontTitulo)
            reportesPdfService.numeracion(i,reader.getNumberOfPages()).writeSelectedRows(0, -1, -1, 25, cb)

            document.add(en)
        }

        document.close();
        byte[] b = baos.toByteArray();

        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombreReporte)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def reporteResultadoIntegral () {

//        println("params " + params)

        def periodo = Periodo.get(params.per);
        def empresa = Empresa.get(params.empresa)

        def cuenta4 = Cuenta.findAllByNumeroIlikeAndEmpresa("4%", empresa, [sort: "numero"])
        def cuenta5 = Cuenta.findAllByNumeroIlikeAndEmpresa("5%", empresa, [sort: "numero"])
        def cuenta6 = Cuenta.findAllByNumeroIlikeAndEmpresa("6%", empresa, [sort: "numero"])
        def saldo4 = [:]
        def saldo5 = [:]
        def saldo6 = [:]
        def total4 = 0
        def total5 = 0
        def total6 = 0
        def maxLvl = 1
        def saldo41

        if (cuenta4) {
            cuenta4.eachWithIndex { i, j ->
                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)

                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo4.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo4.put(i.id.toString(), 0)
                if (j == 0)
                    total4 = saldo4[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }
        }
        if (cuenta5) {
            cuenta5.eachWithIndex { i, j ->
                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)
                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo5.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo5.put(i.id.toString(), 0)
                if (j == 0)
                    total5 = saldo5[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }

        }

        if (cuenta6) {
            cuenta6.eachWithIndex { i, j ->
                def saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo)
                if (saldo) {
                    saldo = SaldoMensual.findByCuentaAndPeriodo(i, periodo).refresh()
                    saldo6.put(i.id.toString(), saldo.saldoInicial + saldo.debe - saldo.haber)
                } else
                    saldo6.put(i.id.toString(), 0)
                if (j == 0)
                    total6 = saldo6[i.id.toString()]
                if (i.nivel.id > maxLvl)
                    maxLvl = i.nivel.id
            }

        }

        return [periodo: periodo, empresa: empresa, cuenta4: cuenta4, cuenta5: cuenta5, cuenta6: cuenta6, saldo4: saldo4.values(),
                saldo5: saldo5.values(), saldo6: saldo6.values(), total4: total4, total5: total5, total6: total6, maxLvl: maxLvl]
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }

        return ia
    }

    private static void addCellTabla(com.itextpdf.text.pdf.PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
//            cell.setBorderColor(BaseColor.WHITE);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }
        if(params.color){
            cell.setBackgroundColor(params.color)
        }

        table.addCell(cell);
    }


    def reporteDetallePagoEmpleado () {

        def empresa = Empresa.get(session.empresa.id)
        def empleado = Empleado.get(params.id)
        def rol = RolPagos.get(params.rol)

        def baos = new ByteArrayOutputStream()
        com.itextpdf.text.Font fontTitulo = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 12, com.itextpdf.text.Font.NORMAL);
        com.itextpdf.text.Font fontTitulo2 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.BOLD);
        fontTitulo2.setColor(255,255,255)
        com.itextpdf.text.Font fontThUsar = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.NORMAL);
        com.itextpdf.text.Font font2 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.BOLD);
        com.itextpdf.text.Font font3 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 12, com.itextpdf.text.Font.BOLD);
        com.itextpdf.text.Font font4 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 16, com.itextpdf.text.Font.NORMAL);

        BaseColor colorAzul = new BaseColor(50, 96, 144)

        def prmsTdNoBorder = [border: BaseColor.WHITE, align: com.itextpdf.text.Element.ALIGN_LEFT, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsNmBorder = [border: BaseColor.WHITE, align: com.itextpdf.text.Element.ALIGN_RIGHT, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsCrBorder = [border: BaseColor.WHITE, align: com.itextpdf.text.Element.ALIGN_CENTER, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsCrBorderAzul = [border: BaseColor.BLACK, align: com.itextpdf.text.Element.ALIGN_CENTER, valign: com.itextpdf.text.Element.ALIGN_MIDDLE, color: colorAzul]

        com.itextpdf.text.Document document
        document = new com.itextpdf.text.Document(com.itextpdf.text.PageSize.A4);
        document.setMargins(50f,50f,50f,50f)
        def pdfw = com.itextpdf.text.pdf.PdfWriter.getInstance(document, baos);

        document.open();
        com.itextpdf.text.pdf.PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Detalle Pagos Empleados");
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, empleados");
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");

        com.itextpdf.text.Paragraph preface = new com.itextpdf.text.Paragraph();
        preface.add(new com.itextpdf.text.Paragraph("Reporte", fontTitulo));

        com.itextpdf.text.Paragraph parrafo1 = new com.itextpdf.text.Paragraph(empresa.nombre.toUpperCase(), font4)
        parrafo1.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);

//        com.itextpdf.text.Paragraph parrafo2 = new com.itextpdf.text.Paragraph("Nombre: " + empleado?.persona?.apellido + " " + empleado?.persona?.nombre, fontTitulo)
//        parrafo2.setAlignment(com.lowagie.text.Element.ALIGN_LEFT);
//
//        com.itextpdf.text.Paragraph parrafo3 = new com.itextpdf.text.Paragraph("Cédula: " +  empleado?.persona?.cedula, fontTitulo )
//        parrafo3.setAlignment(com.lowagie.text.Element.ALIGN_LEFT);
//
//        com.itextpdf.text.Paragraph parrafo4 = new com.itextpdf.text.Paragraph("Nómina: " +  rol?.anio?.anio + " - " + rol?.mess?.descripcion, fontTitulo )
//        parrafo4.setAlignment(com.lowagie.text.Element.ALIGN_LEFT);
//
//        com.itextpdf.text.Paragraph parrafo5 = new com.itextpdf.text.Paragraph("Período: ", fontTitulo )
//        parrafo5.setAlignment(com.lowagie.text.Element.ALIGN_LEFT);
//
//        com.itextpdf.text.Paragraph parrafo6 = new com.itextpdf.text.Paragraph("Dependencia: " +  empleado?.departamento?.descripcion, fontTitulo )
//        parrafo6.setAlignment(com.lowagie.text.Element.ALIGN_LEFT);

        com.itextpdf.text.Paragraph lineaVacia = new com.itextpdf.text.Paragraph(" ", fontTitulo)

        document.add(parrafo1)
        document.add(lineaVacia)
//        document.add(parrafo2)
//        document.add(parrafo3)
//        document.add(parrafo4)
//        document.add(parrafo5)
//        document.add(parrafo6)
//        document.add(lineaVacia)
        document.add(lineaVacia)


        com.itextpdf.text.pdf.PdfPTable tablaC = new com.itextpdf.text.pdf.PdfPTable(4);
        tablaC.setWidthPercentage(100);
        tablaC.setSpacingBefore(4f)
        tablaC.setWidths(arregloEnteros([25, 15, 40, 20]))

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Nombre: ", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph(empleado?.persona?.apellido + " " + empleado?.persona?.nombre, fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Cédula: ", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph(empleado?.persona?.cedula, fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Nómina: ", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph(rol?.anio?.anio + " - " + rol?.mess?.descripcion, fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Período: ", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Dependencia: ", fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph(empleado?.departamento?.descripcion, fontTitulo), prmsTdNoBorder)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("", font3), prmsNmBorder)


        def detalles = DetallePago.findAllByRolPagosAndEmpleadoAndValorNotEqual(rol,empleado, 0.00,[sort: 'rubroTipoContrato.rubro.tipoRubro', order: 'asc'])
        def totalIng = 0
        def totalDesc = 0
        def neto = 0

        Locale loc = new Locale("en_US")
        NumberFormat nf = NumberFormat.getNumberInstance(loc);
        DecimalFormat df = (DecimalFormat)nf;
        df.applyPattern("\$##,###.##");


        com.itextpdf.text.pdf.PdfPTable tablaD = new com.itextpdf.text.pdf.PdfPTable(3);
        tablaD.setWidthPercentage(100);
        tablaD.setSpacingBefore(8f)
        tablaD.setWidths(arregloEnteros([60, 20, 20]))

        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("Concepto", font3), prmsCrBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("Ingresos", font3), prmsCrBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("Descuentos", font3), prmsCrBorder)

        com.itextpdf.text.pdf.PdfPTable table = new com.itextpdf.text.pdf.PdfPTable(1);
        table.setTotalWidth(450);

        detalles.each { d ->

            addCellTabla(tablaD, new com.itextpdf.text.Paragraph(d?.rubroTipoContrato?.descripcion, fontThUsar), prmsTdNoBorder)
            if(d?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'I'){
                addCellTabla(tablaD, new com.itextpdf.text.Paragraph("" + Math.abs(d?.valor), fontThUsar), prmsNmBorder)
                addCellTabla(tablaD, new com.itextpdf.text.Paragraph("", fontThUsar), prmsNmBorder)
                totalIng += d?.valor
            }else{
                addCellTabla(tablaD, new com.itextpdf.text.Paragraph("", fontThUsar), prmsNmBorder)
                addCellTabla(tablaD, new com.itextpdf.text.Paragraph(""  + Math.abs(d?.valor), fontThUsar), prmsNmBorder)
                totalDesc += d?.valor
            }
        }

        neto = totalIng + totalDesc

        totalDesc = Math.abs(totalDesc)

        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("", font2), prmsNmBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("" + df.format(totalIng), font2), prmsNmBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("" + df.format(totalDesc), font2), prmsNmBorder)

        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("", font2), prmsNmBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("Neto a Pagar:", font2), prmsNmBorder)
        addCellTabla(tablaD, new com.itextpdf.text.Paragraph("" + df.format(neto), font2), prmsNmBorder)


        com.itextpdf.text.pdf.PdfPTable tablaF = new com.itextpdf.text.pdf.PdfPTable(3);
        tablaF.setWidthPercentage(100);
        tablaF.setSpacingBefore(4f)
        tablaF.setWidths(arregloEnteros([20, 40, 20]))

        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)
        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("__________________________________", fontTitulo), prmsCrBorder)
        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)

        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)
        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("Firma del Empleado", fontTitulo), prmsCrBorder)
        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)

        document.add(tablaC);
        document.add(lineaVacia)
        document.add(tablaD);
        document.add(lineaVacia)
        document.add(lineaVacia)
        document.add(tablaF)
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'detallePagoEmpleado')
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

    }

    def reporteRolPagosGeneral () {
        def empresa = Empresa.get(session.empresa.id)
        def rol = RolPagos.get(params.id)

        def baos = new ByteArrayOutputStream()
        com.itextpdf.text.Font fontTitulo = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 12, com.itextpdf.text.Font.NORMAL);
        com.itextpdf.text.Font fontTitulo2 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.BOLD);
        fontTitulo2.setColor(255,255,255)
        com.itextpdf.text.Font fontThUsar = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.NORMAL);
        com.itextpdf.text.Font font2 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 10, com.itextpdf.text.Font.BOLD);
        com.itextpdf.text.Font font3 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 12, com.itextpdf.text.Font.BOLD);
        com.itextpdf.text.Font font4 = new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.TIMES_ROMAN, 16, com.itextpdf.text.Font.NORMAL);

        BaseColor colorAzul = new BaseColor(50, 96, 144)

        def prmsTdNoBorder = [border: BaseColor.BLACK, align: com.itextpdf.text.Element.ALIGN_LEFT, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsTdBorder = [border: BaseColor.WHITE, align: com.itextpdf.text.Element.ALIGN_LEFT, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsNmBorder = [border: BaseColor.BLACK, align: com.itextpdf.text.Element.ALIGN_RIGHT, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsCrBorder = [border: BaseColor.BLACK, align: com.itextpdf.text.Element.ALIGN_CENTER, valign: com.itextpdf.text.Element.ALIGN_MIDDLE]
        def prmsCrBorderAzul = [border: BaseColor.BLACK, align: com.itextpdf.text.Element.ALIGN_CENTER, valign: com.itextpdf.text.Element.ALIGN_MIDDLE, color: colorAzul]

        com.itextpdf.text.Document document
        document = new com.itextpdf.text.Document(com.itextpdf.text.PageSize.A4);
        document.setMargins(50f,50f,50f,50f)
        def pdfw = com.itextpdf.text.pdf.PdfWriter.getInstance(document, baos);

        document.open();
        com.itextpdf.text.pdf.PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte Rol de Pagos General");
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, empleados");
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");

        com.itextpdf.text.Paragraph preface = new com.itextpdf.text.Paragraph();
        preface.add(new com.itextpdf.text.Paragraph("Reporte", fontTitulo));

        com.itextpdf.text.Paragraph parrafo1 = new com.itextpdf.text.Paragraph(empresa.nombre.toUpperCase(), font4)
        parrafo1.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        com.itextpdf.text.Paragraph lineaVacia = new com.itextpdf.text.Paragraph(" ", fontTitulo)

        document.add(parrafo1)
        document.add(lineaVacia)

        com.itextpdf.text.pdf.PdfPTable tablaA = new com.itextpdf.text.pdf.PdfPTable(4);
        tablaA.setWidthPercentage(100);
        tablaA.setSpacingBefore(4f)
        tablaA.setWidths(arregloEnteros([35, 10, 20, 30]))

        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("Mes: ", fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph(rol?.mess?.descripcion, fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)

        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("Año: ", fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph(rol?.anio?.anio, fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)

        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("Fecha: ", fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph(rol?.fecha?.format("dd-MM-yyyy"), fontTitulo), prmsTdBorder)
        addCellTabla(tablaA, new com.itextpdf.text.Paragraph("", font3), prmsTdBorder)

        Locale loc = new Locale("en_US")
        NumberFormat nf = NumberFormat.getNumberInstance(loc);
        DecimalFormat df = (DecimalFormat)nf;
        df.applyPattern("\$##,###.##");

        com.itextpdf.text.pdf.PdfPTable tablaC = new com.itextpdf.text.pdf.PdfPTable(5);
        tablaC.setWidthPercentage(100);
        tablaC.setSpacingBefore(4f)
        tablaC.setWidths(arregloEnteros([40, 15, 15, 15, 15]))

        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Empleado", fontTitulo2), prmsCrBorderAzul)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Sueldo", fontTitulo2), prmsCrBorderAzul)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Otros Ingresos", fontTitulo2), prmsCrBorderAzul)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("Descuentos", fontTitulo2), prmsCrBorderAzul)
        addCellTabla(tablaC, new com.itextpdf.text.Paragraph("A Pagar", fontTitulo2), prmsCrBorderAzul)

        def detallePagos = DetallePago.findAllByRolPagos(rol).sort{it.empleado.persona.id}

        def ingresos = 0
        def descuentos = 0
        def sueldo = 0

        def personas = detallePagos.empleado.unique().sort{it.persona.id}

        personas.each { p->

            ingresos = 0
            descuentos = 0

            detallePagos.each{ f->

                if(p.id == f.empleado.id){

                    if(f?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'I'){
                        ingresos += f.valor
                    }

                    if(f?.rubroTipoContrato?.rubro?.tipoRubro?.codigo == 'D'){
                        descuentos += f.valor
                    }

                    if(f?.rubroTipoContrato?.rubro?.codigo == 'SLDO'){
                        sueldo = (f.valor ?: 0)
                    }

                }
            }

            def desc = Math.abs(descuentos)
            ingresos = Math.abs(sueldo - ingresos)
            def total = sueldo + ingresos + descuentos

            addCellTabla(tablaC, new com.itextpdf.text.Paragraph(p?.persona?.nombre + " " + p?.persona?.apellido, fontThUsar), prmsNmBorder)
            addCellTabla(tablaC, new com.itextpdf.text.Paragraph("" + df.format(sueldo), fontThUsar), prmsNmBorder)
            addCellTabla(tablaC, new com.itextpdf.text.Paragraph("" + df.format(ingresos), fontThUsar), prmsNmBorder)
            addCellTabla(tablaC, new com.itextpdf.text.Paragraph("" + df.format(desc), fontThUsar), prmsNmBorder)
            addCellTabla(tablaC, new com.itextpdf.text.Paragraph("" + df.format(total),  fontThUsar), prmsNmBorder)

        }


//        com.itextpdf.text.pdf.PdfPTable tablaF = new com.itextpdf.text.pdf.PdfPTable(3);
//        tablaF.setWidthPercentage(100);
//        tablaF.setSpacingBefore(4f)
//        tablaF.setWidths(arregloEnteros([20, 40, 20]))
//
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("__________________________________", fontTitulo), prmsCrBorder)
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)
//
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("Firma del Empleado", fontTitulo), prmsCrBorder)
//        addCellTabla(tablaF, new com.itextpdf.text.Paragraph("", font3), prmsCrBorder)

        document.add(tablaA);
        document.add(lineaVacia)
        document.add(tablaC)
//        document.add(tablaF)
//        document.add(tablaF)
        document.close()
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + 'rolPagos')
        response.setContentLength(b.length)
        response.getOutputStream().write(b)

    }

}