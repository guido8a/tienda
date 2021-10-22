package pdf

import java.awt.Color

//import vesta.seguridad.Shield

import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.HeaderFooter
import com.lowagie.text.Phrase
import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.Rectangle
import com.lowagie.text.pdf.PdfContentByte
import com.lowagie.text.pdf.PdfImportedPage
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfReader
import com.lowagie.text.pdf.PdfWriter

import jxl.Workbook
import jxl.WorkbookSettings
import jxl.write.Label
import jxl.write.Number
import jxl.write.NumberFormat
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook


class PdfController {

    PdfService pdfService

    def index = { redirect(action: demo) }

    def pdfLink = {
        try {
            byte[] b
            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort

            params.url = params.url.replaceAll("W", "&")

            if (params.pdfController) {
                def content = g.include(controller: params.pdfController, action: params.pdfAction, id: params.pdfId)
                b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            } else {
                println "sin plugin --> params url " + params.url
                def url = baseUri + params.url
                println "URL --> $url, baseUri: $baseUri"

                b = pdfService.buildPdf(url, baseUri)
//                b = pdfService.buildPdf(params.url, baseUri)
            }
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment; filename=" + (params.filename ?: "document.pdf"))
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        }
        catch (Throwable e) {
            println "there was a problem with PDF generation 2 ${e}"
            e.printStackTrace()
            if (params.pdfController) {
                redirect(controller: params.pdfController, action: params.pdfAction, params: params)
            } else {
                redirect(action: "index", controller: "reportes", params: [msn: "Hubo un error en la genración del reporte. Si este error vuelve a ocurrir comuníquelo al administrador del sistema."])
            }
        }
    }

    def pdfForm = {
        try {
            byte[] b
            def baseUri = request.scheme + "://" + request.serverName + ":" + request.serverPort + grailsAttributes.getApplicationUri(request)
            if (request.method == "GET") {
                def url = baseUri + params.url + '?' + request.getQueryString()
                //println "BaseUri is $baseUri"
                //println "Fetching url $url"
                b = pdfService.buildPdf(url)
            }
            if (request.method == "POST") {
                def content
                if (params.template) {
                    content = g.render(template: params.template, model: [pdf: params])
                } else {
                    content = g.include(controller: params.pdfController, action: params.pdfAction, id: params.id, pdf: params)
                }
                b = pdfService.buildPdfFromString(content.readAsString(), baseUri)
            }
            response.setContentType("application/pdf")
            response.setHeader("Content-disposition", "attachment; filename=" + (params.filename ?: "document.pdf"))
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        }
        catch (Throwable e) {
            println "there was a problem with PDF generation ${e}"
            if (params.template) render(template: params.template)
            if (params.url) redirect(uri: params.url + '?' + request.getQueryString())
            else redirect(controller: params.pdfController, action: params.pdfAction, params: params)
        }
    }

    def demo = {
        def firstName = params.first ?: "Eric"
        def lastName = params.last ?: "Cartman"
        def age = params.age
        return [firstName: firstName, lastName: lastName, age: age]
    }

    def demo2 = {
        def id = params.id
        def name = params.name
        def age = params.age
        def randomString = params.randomString ?: "PDF creation is a blast!!!"
        def food = params.food
        def hometown = params.hometown
        return [id: id, name: name, age: age, randomString: randomString, food: food, hometown: hometown]
    }

    def demo3 = {
        def today = new Date()
        def tomorrow = today + 1
        def content = g.include(controller: "pdf", action: "sampleInclude", params: ['today': today, 'tomorrow': tomorrow])
        return ['content': content, 'pdf': params, 'id': params.id]
    }

    def sampleInclude = {
        def bar = 'foo'
        def today = params?.today
        def tomorrow = params?.tomorrow
        return ['bar': bar, 'today': today, 'tomorrow': tomorrow]
        //[today:today, tomorrow:tomorrow]
    }


    def reportePrueba() {

        def baos = new ByteArrayOutputStream()
        def name = "reportePrueba_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def titulo = new Color(40, 140, 180)
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD, titulo);
        Font fontTitulo16 = new Font(Font.TIMES_ROMAN, 16, Font.BOLD, titulo);
        Font info = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)
        Font fontTitle = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);
        Font fontTitle1 = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font fontTh = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontTd = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);
        Font fontTd10 = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);
        Font fontThTiny = new Font(Font.TIMES_ROMAN, 7, Font.BOLD);
        Font fontTdTiny = new Font(Font.TIMES_ROMAN, 7, Font.NORMAL);

        def fondoTotal = new Color(240, 240, 240);

        def prmsTdNoBorder = [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsTdBorder = [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def prmsNmBorder = [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]

        Document document
        document = new Document(PageSize.A4);
        document.setMargins(50, 30, 100, 45)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
        def pdfw = PdfWriter.getInstance(document, baos);
        document.resetHeader()
        document.resetFooter()

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Reporte de prueba");
        document.addSubject("Generado por el sistema Mercurio");
        document.addKeywords("reporte, ventas, ventas");
        document.addAuthor("Mercurio");
        document.addCreator("Tedein SA");

       PdfPTable tablaDetalles = null

        def printHeaderDetalle = {
            def fondo = new Color(240, 248, 250);
//            def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
            def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bcl: Color.RED,bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
            def frmtHR = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bcr: Color.RED, bcl: Color.RED, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]

            def tablaHeaderDetalles = new PdfPTable(5);
            tablaHeaderDetalles.setWidthPercentage(100);
            tablaHeaderDetalles.setWidths(arregloEnteros([7, 15, 20, 20, 34]))

            addCellTabla(tablaHeaderDetalles, new Paragraph("Dpto.", fontTh), frmtHd)
            addCellTabla(tablaHeaderDetalles, new Paragraph("Nombre", fontTh), frmtHd)
            addCellTabla(tablaHeaderDetalles, new Paragraph("Apellido", fontTh), frmtHd)
            addCellTabla(tablaHeaderDetalles, new Paragraph("Teléfono", fontTh), frmtHd)
            addCellTabla(tablaHeaderDetalles, new Paragraph("Firma", fontTh), frmtHR)



            addCellTabla(tablaDetalles, tablaHeaderDetalles, [border: Color.WHITE, align: Element.ALIGN_LEFT,
                                                              valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])
        }

        tablaDetalles = new PdfPTable(5);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([7, 15, 20, 20, 34]))
        tablaDetalles.setSpacingAfter(1f);


        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]

        printHeaderDetalle()

//        lista.each { persona ->
//            addCellTabla2(tablaDetalles, new Paragraph(persona.departamento, fontTd10), frmtDato)
//            addCellTabla2(tablaDetalles, new Paragraph(persona.nombre, fontTd10), frmtDato)
//            addCellTabla2(tablaDetalles, new Paragraph(persona.apellido, fontTd10), frmtDato)
//            addCellTabla2(tablaDetalles, new Paragraph('', fontTd10), frmtDato)
//            addCellTabla2(tablaDetalles, new Paragraph('', fontTd10), frmtDato)
//        }

        document.add(tablaDetalles)
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();


        encabezadoYnumeracion(b, "Reporte de prueba","Reporte", "reportePrueba_${new Date().format("dd-MM-yyyy")}.pdf")


//        response.setContentType("application/pdf")
//        response.setHeader("Content-disposition", "attachment; filename=" + name)
//        response.setContentLength(b.length)
//        response.getOutputStream().write(b)
    }

    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
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
        table.addCell(cell);
    }

    private static void addCellTabla2(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
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

        cell.fixedHeight = 30f

        table.addCell(cell);
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }
        return ia
    }

    def tx_footer = "Sistema de Ventas Mercurio " + " " * 136 + "www.tedein.com.ec/ventas"

    def encabezadoYnumeracion (f, tituloReporte, subtitulo, nombreReporte) {

        def titulo = new Color(30, 140, 160)
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD, titulo);
        Font fontTitulo16 = new Font(Font.TIMES_ROMAN, 16, Font.BOLD, titulo);
        Font fontTitulo8 = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL, titulo);

        def baos = new ByteArrayOutputStream()

        Document document
        document = new Document(PageSize.A4);

        def pdfw = PdfWriter.getInstance(document, baos);

        HeaderFooter footer1 = new HeaderFooter( new Phrase(tx_footer, new Font(fontTitulo8)), false);
        footer1.setBorder(Rectangle.NO_BORDER);
        footer1.setBorder(Rectangle.TOP);
        footer1.setAlignment(Element.ALIGN_CENTER);
        document.setFooter(footer1);

        document.open();

        PdfContentByte cb = pdfw.getDirectContent();

        PdfReader reader = new PdfReader(f);
        for (int i = 1; i <= reader.getNumberOfPages(); i++) {
            document.newPage();
            PdfImportedPage page = pdfw.getImportedPage(reader, i);
            cb.addTemplate(page, 0, 0);
            def en = encabezado(tituloReporte, subtitulo, fontTitulo16, fontTitulo)
            numeracion(i,reader.getNumberOfPages()).writeSelectedRows(0, -1, -1, 25, cb)
            document.add(en)
        }

        document.close();
        byte[] b = baos.toByteArray();

        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombreReporte)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def encabezado (titulo, subtitulo, fontTitulo, fontSub) {
        Paragraph preface = new Paragraph();
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph(titulo, fontTitulo));
        preface.add(new Paragraph(subtitulo, fontSub));
        return preface
    }

    def numeracion(x, y) {
        Font fontTd10 = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);
        PdfPTable table = new PdfPTable(2);
        table.setTotalWidth(327);
        table.setLockedWidth(true);
        table.getDefaultCell().setFixedHeight(20);
        table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
        table.addCell("");
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(new Paragraph(String.format("Página %d de %d", x, y), fontTd10) );
        return table;
    }

    def reportePruebaExcel () {

//        println("imprimirIngresos " + params)


        def fechaDesde = new Date().format('yyyy-MM-dd')
        def fechaHasta = new Date().format('yyyy-MM-dd')

        def totalEgresos = 0

        //excel
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
        file.deleteOnExit()

        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('MySheet', 0)
        // fija el ancho de la columna
        // sheet.setColumnView(1,40)

        WritableFont times16font = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false);
        WritableCellFormat times16format = new WritableCellFormat(times16font);
        sheet.setColumnView(0, 60)
        sheet.setColumnView(1, 60)
        sheet.setColumnView(2, 12)
        sheet.setColumnView(3, 10)
        sheet.setColumnView(4, 20)
        // inicia textos y numeros para asocias a columnas

        def label
        def nmro
        def number

        def fila = 6;

        NumberFormat nf = new NumberFormat("#.##");
        WritableCellFormat cf2obj = new WritableCellFormat(nf);

        label = new Label(1, 1, (''), times16format); sheet.addCell(label);
        label = new Label(1, 2, "Reporte del ${fechaDesde} al ${fechaHasta}", times16format); sheet.addCell(label);

        label = new Label(0, 4, "Columna 1: ", times16format); sheet.addCell(label);
        label = new Label(1, 4, "Columna 2:", times16format); sheet.addCell(label);
        label = new Label(2, 4, "Columna 3:", times16format); sheet.addCell(label);
        label = new Label(3, 4, "Columna 4:", times16format); sheet.addCell(label);
        label = new Label(4, 4, "Columna 5:", times16format); sheet.addCell(label);

//        egresos.eachWithIndex {i, j->
//            label = new Label(0, fila, i.prve.toString()); sheet.addCell(label);
//            label = new Label(1, fila, i.egrsdscr.toString()); sheet.addCell(label);
//            label = new Label(2, fila, i?.egrsfcha?.toString()); sheet.addCell(label);
//            number = new Number(3, fila, i?.egrsvlor); sheet.addCell(number);
//            label = new Label(4, fila, i?.egrsfctr?.toString()); sheet.addCell(label);
//            fila++
//        }

        label = new Label(0, fila, ''); sheet.addCell(label);
        label = new Label(1, fila, ''); sheet.addCell(label);
        label = new Label(2, fila,'TOTAL'); sheet.addCell(label);
        number = new Number(3, fila, totalEgresos); sheet.addCell(number);

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reportePruebaExcel.xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

}

