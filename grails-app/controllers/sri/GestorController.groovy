package sri

import seguridad.Empresa


class GestorController {

    def buscadorService
    def dbConnectionService


    def buscarGestor() {
        session.movimientos=[]
//        println "params " + params
        def lista = buscadorService.buscar(Gestor, "Gestor", "incluyente", [campos: ["nombre", "descripcion"],
                                                                            criterios: [params.nombre, params.nombre], operadores: ["like", "like"], ordenado: "nombre", orden: "asc"],
                true," and empresa=${session.empresa.id}")
        def numRegistros = lista.get(lista.size() - 1)
        lista.pop()
        return [lista: lista]
    }

    def nuevoGestor() {
        //println "nuevo gestor " + params
        def gestorInstance
        def nuevo = true
        def tipoCom
        if (params.id) {
            nuevo = false
            gestorInstance = Gestor.get(params.id.toLong())
//            println "gestor " + gestorInstance
            def movs = Genera.findAll("from Genera where gestor=${gestorInstance.id} order by debeHaber,cuenta")
            if (movs.size() > 0) {
                movs.each {
                    println "add " + it
                    tipoCom = it.tipoComprobante
                    session.movimientos.add(it)
                }
                session.tipoComp = movs[0]?.tipoComprobante?.id
            }
        } else {

            gestorInstance = new Gestor()
        }
        //println "nuevo gestor "+gestorInstance
        render(view: 'gestorForm', model: [gestorInstance: gestorInstance, nuevo: nuevo, tipoCom: tipoCom])
    }

    def buscarCuentas() {
        println "buscar cuentas!!! " + params

        def descripcion = (params.nombre) ?: null
        def numero = (params.codigo) ?: null
        def res = buscadorService.buscar(Cuenta, "Cuenta", "excluyente", [campos: ["descripcion", "numero", "movimiento"], criterios: [descripcion, numero, "1"], operadores: ["like", "like der", "="], ordenado: "numero", orden: "asc"], true," and empresa=${session.empresa.id}")
        def numRegistros = res.get(res.size() - 1)
        res.pop()
        return [planCuentas: res]
    }

    def cargarCuentas() {
        println "cuentas !!!!! " + session.movimientos
//        def cuentas=[]
        render(view: 'agregarCuenta', model: [cuentas: session.movimientos])
    }

    def cambiarComprobante() {
        def tipo = TipoComprobante.get(params.tc)
        session.tipoComp=tipo
        render(view: 'agregarCuenta', model: [cuentas: session.movmientos])
    }

    def agregarCuenta() {
        // println "agregar cuenta !! " + params
        if (params.posicion) {
            if (!params.eliminar) {
                session.movimientos[params.posicion.toInteger()].porcentaje = params.por.toDouble()
                session.movimientos[params.posicion.toInteger()].porcentajeImpuestos = params.imp.toDouble()
                session.movimientos[params.posicion.toInteger()].valor = params.val.toDouble()
            } else {
                println "tam " + session.movimientos.size() + " pos " + params.posicion
                session.movimientos.remove(params.posicion.toInteger())
            }

        } else {
            def genera = new Genera()
            def cuenta = Cuenta.get(params.id)
            def tipo = TipoComprobante.get(params.tc)
            genera.cuenta = cuenta
            genera.tipoComprobante = tipo
            genera.debeHaber = (params.razon == "Debe") ? "D" : "H"
            session.tipoComp=tipo
            session.movimientos.add(genera)
        }
        session.movimientos=ordernarLista(session.movimientos)
        return [cuentas: session.movimientos]
    }

    def save() {
//        params.movimientos = null
        println "params save gestor !!! " + params + " id " + params.id
        def p
        if (params.id == null || params.id == "") {
            // println "save "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
                p = new Gestor(params)
                p.fecha = new Date()
                p.empresa = session.empresa
                p.save(flush: true)
                println "errores gestor  " + p.errors
//                if (session.movimientos.size() > 0) {
//                    session.movimientos.each {
//                        it.gestor = p
//                        println " save genera " + it + " " + it.save()
//                        p.addToMovimientos(it)
//                    }
//
//                    session.movimientos = []
//                }
                flash.message = "Gestor contable guardado exitosamente"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
            }
        } else {
            //  println "edit "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
                p = Gestor.get(params.id)
                p.properties = params
                p.save(flush: true)
                println "errores " + p.properties.errors
                def lista = []
                def generaAntiguos = Genera.findAllByGestor(p)
                if (session.movimientos.size() > 0) {
                    println "  size!!!!!!  " + session.movimientos.size() + " \n\n\n\n\n"
                    def genera
                    session.movimientos.each {
                        println "cuentas  ==> " + it.id
                        if (it.id == null) {
                            //  println "save cuenta"
                            it.gestor = p
                            println " save new " + it + " " + it.save()
                            p.addToMovimientos(it)
                        } else {
                            // println "edit cuenta"
                            genera = Genera.get(it.id)
                            genera.porcentaje = it.porcentaje
                            genera.porcentajeImpuestos = it.porcentajeImpuestos
                            genera.valor = it.valor
                            println "tipo  !! " + session.tipoComp
                            if (session.tipoComp)
                                genera.tipoComprobante = TipoComprobante.get(session.tipoComp)
                            //println " datos " + it.porcentajeImpuestos + " " + it.porcentaje + " " + it.valor
                            //println "paso genera " + genera
                            genera.save(flush: true)
                            lista.add(it.id)
                            println " save edit " + genera + " " + genera.save()
                            genera = null
                        }

                    }
                    generaAntiguos.each {
                        if (!lista.contains(it.id)) {
                            it.delete()
                        }
                    }

                    p.save()
                    session.movimientos = []
                }
                flash.message = "Gestor contable guardado exitosamente"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                flash.message = "Error al guardar el gestor contable"
//                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
                redirect(action: 'index')
            }
        }
    }

    def verGestor() {
        params.ver = 1
        redirect(action: 'formGestor', params: params)
    }

//    def editarGestor() {
//        def gestor = Gestor.get(params.id)
//        if (!gestor) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'Gestor.label', default: 'Gestor'), params.id])}"
//            redirect(action: "index")
//        } else {
//            render(view: 'gestorForm', model: [GestorInstance: gestor])
//        }
//    }

    def deleteGestor() {
        def gestor = Gestor.get(params.id)
        if (!gestor) {
            flash.message = "No se ha encontrado el gestor a eliminar"
            return
        }

        def procesos = Proceso.findAllByGestor(gestor)

        if (procesos.size() == 0) {
            def generas = Genera.findAllByGestor(gestor)
            generas.each { gen ->
                try {
                    gen.delete(flush: true)
                } catch (e) {
                    println e.stackTrace
                }
            }
            try {
                gestor.delete(flush: true)
            } catch (e) {
                println e.stackTrace
            }
            redirect(action: "index")
        } else {
            def msn = "El gestor ya ha sido utilizado en "
            if (procesos.size() > 0) {
                msn += procesos.size() + " proceso" + (procesos.size() == 1 ? ", " : "s, ")
            }
            msn += " por lo que no puede ser eliminado."
            return [msn: msn, gestor: gestor]
        }
    }


    def ordernarLista(lista){
        println "original "+lista
        def res
        if(lista.size()>1)
            res = lista.sort{it?.debeHaber}
        else
            res=lista
        //res = res.sort{it.cuenta}
        println "despues "+res
        return res
    }

    def formGestor () {
        def empresa = Empresa.get(session.empresa.id)
        def gestorInicial = Gestor.findByEmpresaAndCodigo(empresa, 'SLDO')
        def titulo = "Nuevo Gestor"
        def tipo = ['G': 'Gasto', 'I':'Inventario', 'S': 'Servicios', 'C': 'Sin detalle']
        if(params.id){
            titulo = params.ver? "Ver Gestor" : "Editar Gestor"
            def gestorInstance = Gestor.get(params.id)
            def band = (gestorInstance.empresa == empresa)
            def genera = Genera.findAllByGestor(gestorInstance)
            return [gestorInstance: gestorInstance, verGestor: params.ver, titulo: titulo, tipo: tipo, band: band, tieneAsientos: genera, gestorInicial: gestorInicial]
        } else
            return [verGestor: params.ver, titulo: titulo, tipo: tipo, band: true, gestorInicial: gestorInicial]
    }

    def tablaGestor_ajax () {
//        println("tabla gestor" + params)
        def gestor = Gestor.get(params.id)
        def tipoComprobante = TipoComprobante.get(params.tipo)
        def empresa = Empresa.get(session.empresa.id)
        def movimientos = Genera.findAllByGestorAndTipoComprobante(gestor, tipoComprobante)?.sort{it.cuenta.numero}?.sort{it.debeHaber}
        return [movimientos: movimientos, gestor: gestor, tipo: tipoComprobante, empresa: empresa]
    }

    def buscarMovimiento_ajax () {
        def empresa = Empresa.get(params.empresa)
        def gestor = Gestor.get(params.id)
        def tipo = TipoComprobante.get(params.tipo)

        return [empresa: empresa, gestor: gestor, tipo: tipo]
    }

    def tablaBuscar_ajax () {
//        println("params " + params)
        def empresa = Empresa.get(params.empresa)
        def gestor = Gestor.get(params.gestor)
        def tipo = TipoComprobante.get(params.tipo)
        def res

        if(params.nombre == "" && params.codigo == ""){
            res = Cuenta.findAllByEmpresaAndMovimiento(empresa,'1').sort{it.numero}
        }else{
            res = Cuenta.withCriteria {
                eq("empresa", empresa)

                and{
                    ilike("descripcion", '%' + params.nombre + '%')
                    ilike("numero", '%' + params.codigo + '%')
                    eq("movimiento", '1')
                }
                order ("numero","asc")
            }
        }

        return [cuentas: res, gestor: gestor, tipo: tipo]
    }

    def agregarDebeHaber_ajax () {
//        println("params agregar debe " + params)
        def gestor = Gestor.get(params.gestor)
        def tipo = TipoComprobante.get(params.tipo)
        def cuenta = Cuenta.get(params.cuenta)

        def genera = new Genera()
        genera.gestor = gestor
        genera.tipoComprobante = tipo
        genera.cuenta = cuenta
        genera.debeHaber = params.dif
        genera.porcentaje = 0
        genera.porcentajeImpuestos = 0
        genera.valor = 0

        if(!genera.save(flush: true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def borrarCuenta_ajax () {
//        println("genera borrar " + params)
        def genera = Genera.get(params.genera)
        def errores = ''

        try {
            genera.delete(flush: true)
        } catch (e) {
            errores += e.stackTrace
        }

        if(errores == ''){
            render "ok"
        }else{
            render "no"
        }
    }

    def guardarValores_ajax () {
        println "guardarValores_ajax " + params
        def genera = Genera.get(params.genera)
        genera.ice = params.ice.toDouble()
        genera.porcentajeImpuestos = params.impuesto.toDouble()
        genera.porcentaje = params.porcentaje.toDouble()
        genera.baseSinIva = params.sinIva.toDouble()
        genera.flete = params.flete.toDouble()
        genera.debeHaber = params.debeHaber
        genera.valor = params.valor.toDouble()
//        genera.retRenta = params.retRenta.toDouble()

        try{
            genera.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

    def guardarGestor () {
        println "params guardar $params"
        def gestor
        def fuente = Fuente.get(params.fuente)
        def empresa = session.empresa
        def tipoProceso = TipoProceso.get(params.tipoProceso)

        if(params.gestor){
            gestor = Gestor.get(params.gestor)
        }else{
            gestor = new Gestor()
            gestor.empresa = empresa
            gestor.estado = 'A'
            gestor.fecha = new Date()
        }

        gestor.nombre = params.nombre
        gestor.tipoProceso = tipoProceso
        if(tipoProceso.codigo.trim() == 'A'){
            if(params.saldoInicial == 'true'){
                gestor.codigo = 'SLDO'
            }else{
                gestor.codigo = null
            }
        }else{
            gestor.codigo = null
        }
        gestor.observaciones = params.observacion
        gestor.fuente = fuente
        if(params.tipo != '-1') {
            gestor.tipo = params.tipo
        } else {
            gestor.tipo = null
        }


        try{
            gestor.save(flush: true)
            render "ok_" + gestor?.id
        }catch (e){
            render "no"
            println("error " + gestor.errors)
        }
    }

    def totales_ajax () {
        def gestor = Gestor.get(params.id)
        def tipoComprobante = TipoComprobante.get(params.tipo)
        def cuentasDebe = Genera.findAllByGestorAndTipoComprobanteAndDebeHaber(gestor, tipoComprobante,'D')
        def cuentasHaber = Genera.findAllByGestorAndTipoComprobanteAndDebeHaber(gestor, tipoComprobante,'H')

        def baseD =  cuentasDebe.porcentaje.sum()
        def impD = cuentasDebe.porcentajeImpuestos.sum()
        def valorD =  cuentasDebe.valor.sum()
        def sinD = cuentasDebe.baseSinIva.sum()
        def fleteD = cuentasDebe.flete.sum()

        def baseH =  cuentasHaber.porcentaje.sum()
        def impH = cuentasHaber.porcentajeImpuestos.sum()
        def valorH =  cuentasHaber.valor.sum()
        def sinH = cuentasHaber.baseSinIva.sum()
        def fleteH = cuentasHaber.flete.sum()

        return [baseD: baseD, impD: impD, valorD: valorD, baseH: baseH, impH: impH, valorH: valorH, sinD: sinD,
                sinH: sinH, fleteD:fleteD, fleteH: fleteH]
    }

    def registrar_ajax () {

        def gestor = Gestor.get(params.id)
        def tiposComprobantes = TipoComprobante.list()
        def tipo
        def generaDebe
        def generaHaber
        def errores = 0
        def vr = 0

        tiposComprobantes.each {t->

            tipo = TipoComprobante.get(t?.id)

            generaDebe = Genera.findAllByGestorAndDebeHaberAndTipoComprobante(gestor, 'D',tipo)
            generaHaber = Genera.findAllByGestorAndDebeHaberAndTipoComprobante(gestor, 'H',tipo)

            if(generaDebe && generaHaber){

                def debeValor = generaDebe.valor.sum()
                def debeImpuesto = generaDebe.porcentaje.sum()
                def debePorcentaImpuesto = generaDebe.porcentajeImpuestos.sum()

                def haberValor = generaHaber.valor.sum()
                def haberImpuesto = generaHaber.porcentaje.sum()
                def haberPorcentaImpuesto = generaHaber.porcentajeImpuestos.sum()

                def fleteDebe = generaDebe.flete.sum()
                def fleteHaber = generaHaber.flete.sum()

                def debeSinIvaD = generaDebe.baseSinIva.sum()
                def debeSinIvaH = generaHaber.baseSinIva.sum()


                def totalesDebe = debeValor + debeImpuesto + debePorcentaImpuesto + fleteDebe + debeSinIvaD
                def totalesHaber = haberValor + haberImpuesto + haberPorcentaImpuesto + fleteHaber + debeSinIvaH

//                println("totalesdebe " + totalesDebe)
//                println("totaleshaber " + totalesHaber)

                if(totalesDebe == 0 && totalesHaber == 0 && gestor.codigo != 'SLDO'){
                    render "no_No se puede registrar el gestor contable, los valores se encuentran en 0, COMPROBANTE: (${tipo?.descripcion})"
                }else{
                    if( (debeImpuesto.toDouble() != haberImpuesto.toDouble()) || (debeSinIvaD.toDouble() != debeSinIvaH.toDouble()) || (debePorcentaImpuesto.toDouble() != haberPorcentaImpuesto.toDouble()) || (debeValor.toDouble() != haberValor.toDouble()) || (fleteDebe.toDouble() != fleteHaber.toDouble() )){
                        render "no_No se puede registrar el gestor contable, los valores no cuadran entre DEBE y HABER, COMPROBANTE: (${tipo?.descripcion})"
                        return
                    }else{
                        errores += 1
                    }
                }
            }else{
                if(!generaDebe && !generaHaber){
                    errores += 1
                    vr += 1
                }else{
                    render "no_No se puede registrar el gestor contable, ingrese valores tanto en DEBE como en HABER, COMPROBANTE: (${tipo?.descripcion})"
                    return
                }
            }
        }

        def tam = tiposComprobantes.size()

        println("tam " + tam)
        println("errores  " + errores)

        if(tam == errores && tam != vr){
            gestor.estado = 'R'
            if(!gestor.save(flush: true)){
                render "no_Error al registrar el gestor contable"
                println("error save gestor " + gestor.errors)
            }else{
                render "ok_Gestor contable registrado correctamente"
            }
        }else{
            render "no_Error al registrar el gestor contable"
        }
    }

    def desRegistrar_ajax() {
        def gestor = Gestor.get(params.id)
        gestor.estado = 'A'

        try{
            gestor.save(flush:true)
            render "ok_Gestor contable desregistrado correctamente!"
        }catch (e){
            println("error al quitar el registro del gestor contable " + e)
            render "no_Error al quitar el registro del gestor contable"
        }
    }

    def buscarGstr() {
//        println "busqueda "
        def empresa = Empresa.get(session.empresa.id)
        def gestor = Gestor.findByEmpresaAndCodigo(empresa, 'SLDO')
        return[empresa: empresa, gestorIniciales: gestor]
    }

    def tablaBuscarGstr() {
//        println "buscar .... $params"
        def data = []
        def cn = dbConnectionService.getConnection()
//        def cont = session.contabilidad.id
        def buscar = params.buscar.trim()?:'%'

        def sql = "select gstr__id, tppsdscr, gstrnmbr, gstretdo, case gstrtipo when 'G' then 'Gasto' " +
                "when 'I' then 'Inventario' end as tipo from gstr, tpps where tpps.tpps__id = gstr.tpps__id and " +
                "empr__id = ${session.empresa.id} and gstrnmbr ilike '%${buscar}%' order by tppsdscr, gstrnmbr"

//        println "buscar .. ${sql}"

        data = cn.rows(sql.toString())

        def msg = ""
        if(data?.size() > 20){
            data.pop()   //descarta el último puesto que son 21
            msg = "<div class='alert-danger' style='margin-top:-20px; diplay:block; height:25px;margin-bottom: 20px;'>" +
                    " <i class='fa fa-warning fa-2x pull-left'></i> Su búsqueda ha generado más de 20 resultados. " +
                    "Use más letras para especificar mejor la búsqueda.</div>"
        }
        cn.close()

        return [data: data, msg: msg]
    }

    def copiarGestor_ajax () {
//        println("params copiar " + params)
        def gestor = Gestor.get(params.id)
        def nuevo = new Gestor()
        nuevo.nombre = params.nombre
        nuevo.empresa = gestor.empresa
        nuevo.estado = 'A'
        nuevo.fecha = new Date()
        nuevo.fuente = gestor.fuente
        nuevo.tipo = gestor.tipo
        nuevo.tipoProceso = gestor.tipoProceso
        nuevo.observaciones = gestor.observaciones

        try {
            nuevo.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al copiar el gestor " + e )
        }
    }

    def revisarAsiento_ajax () {
        def gestor = Gestor.get(params.gestor)
        def genera = Genera.findAllByGestor(gestor)

        if(genera?.size() > 0){
            render 'ok'
        }else{
            render 'no'
        }
    }

    def crearGestorSaldoInicial_ajax () {

        def empresa = Empresa.get(session.empresa.id)
        def tipoProceso = TipoProceso.findByCodigo("A")
        def fuente = Fuente.get(1)
        def cn = dbConnectionService.getConnection()
        def tipoComprobante = TipoComprobante.findByCodigo("D")

        def cuentas1= "select cnta__id from cnta where cntanmro ILIKE '1%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"
        def cuentas5= "select cnta__id from cnta where cntanmro ILIKE '5%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"
        def cuentas6= "select cnta__id from cnta where cntanmro ILIKE '6%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"
        def cuentas2= "select cnta__id from cnta where cntanmro ILIKE '2%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"
        def cuentas3= "select cnta__id from cnta where cntanmro ILIKE '3%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"
        def cuentas4= "select cnta__id from cnta where cntanmro ILIKE '4%' and cntapdre is not null and empr__id = ${empresa?.id} and cnta__id not in (select cntapdre from cnta where empr__id = ${empresa?.id} and cntapdre is not null);"

        def cuentasDebe
        def cuentasHaber

        cuentasDebe =  cn.rows(cuentas1.toString()).cnta__id + cn.rows(cuentas5.toString()).cnta__id + cn.rows(cuentas6.toString()).cnta__id
        cuentasHaber =  cn.rows(cuentas2.toString()).cnta__id + cn.rows(cuentas3.toString()).cnta__id + cn.rows(cuentas4.toString()).cnta__id

//        println("cd " + cuentasDebe)
//        println("ch " + cuentasHaber)

        def errores = ''

        def gestor = new Gestor()
        gestor.nombre = "Saldos iniciales para apertura de contabilidad"
        gestor.codigo = "SLDO"
        gestor.empresa = empresa
        gestor.estado = "A"
        gestor.tipo = "G"
        gestor.tipoProceso = tipoProceso
        gestor.fuente = fuente
        gestor.observaciones = "Saldos iniciales generados automáticamente"

        try{
            gestor.save(flush: true)
        }catch (e){
            println("error al crear el gestor de saldos iniciales " + e)
            errores += e
        }

        if(errores == ''){

            cuentasDebe.each{ debe->

                def genera = new Genera()
                genera.gestor = gestor
                genera.cuenta = Cuenta.get(debe)
                genera.tipoComprobante = tipoComprobante
                genera.porcentaje = 0.000
                genera.porcentajeImpuestos = 0.000
                genera.valor = 0.00
                genera.debeHaber = 'D'
                genera.baseSinIva = 0.0
                genera.flete = 0.0
                genera.ice = 0.0

                try{

                    genera.save(flush: true)

                }catch (e){
                    println("error al crear los genera debe de los saldos iniciales")
                    errores += e
                }
            }

            cuentasHaber.each{ haber->

                def generaH = new Genera()
                generaH.gestor = gestor
                generaH.cuenta = Cuenta.get(haber)
                generaH.tipoComprobante = tipoComprobante
                generaH.porcentaje = 0.000
                generaH.porcentajeImpuestos = 0.000
                generaH.valor = 0.00
                generaH.debeHaber = 'H'
                generaH.baseSinIva = 0.0
                generaH.flete = 0.0
                generaH.ice = 0.0

                try{
                    generaH.save(flush: true)
                }catch (e){
                    println("error al crear los genera haber de los saldos iniciales")
                    errores += e
                }
            }

            if(errores == ''){
                render "OK"
            }else{
                render "no"
            }
        }else{
            render "no"
        }
    }
}
