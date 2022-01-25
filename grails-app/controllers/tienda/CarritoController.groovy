package tienda

import inventario.Bodega
import retenciones.Pais
import seguridad.Empresa
import sri.Contabilidad
import sri.DocumentoEmpresa
import sri.Gestor
import sri.Proceso
import sri.TipoCmprSustento
import sri.TipoIdentificacion
import sri.TipoPersona
import sri.TipoProceso
import sri.TipoTransaccion


class CarritoController {

    def dbConnectionService

    def carrito(){
        def cliente = null
        def productos
        def carrito

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
            carrito = Carrito.findByClienteAndEstado(cliente, 'A')
            def productosRevisar

            if(carrito){

                productosRevisar = DetalleCarrito.findAllByCarrito(carrito)

                productosRevisar.each { dtc->

                    if(dtc.publicacion.estado == 'B'){
                        carrito.subtotal = carrito.subtotal - dtc.subtotal
                        carrito.cantidad = carrito.cantidad - dtc.cantidad
                        carrito.save(flush:true)
                        dtc.delete(flush:true)
                    }
                }

//                productos = DetalleCarrito.findAllByCarrito(carrito).sort{it.publicacion.producto.titulo}
                def sql = "select empr__id, prod.prod__id, dtcr.publ__id, dtcr__id, publtitl, publsbtl, publpcun, dtcrcntd, " +
                        "dtcrsbtt, publpcmy from publ, prod, dtcr, prsn where prod.prod__id = publ.prod__id and " +
                        "publ.publ__id = dtcr.publ__id and crro__id = ${carrito?.id} and publetdo = 'A' and " +
                        "prsn.prsn__id = prod.prsn__id"
                // select cont__id from cont where now()::date between contfcin and contfcci;
                def cn = dbConnectionService.getConnection()
                def res = cn.rows(sql.toString());

                println("sql " + sql)

                productos = res

            }else{
                productos = false
            }

            return[cliente: cliente, productos: productos]
        }else{
            redirect(controller: 'principal', action: 'index')
        }
    }

    def agregarProducto_ajax(){
//        println("params " + params)
//        println("---> " + session.cliente)

        def publicacion = Publicacion.get(params.id)
        def cliente
        def carrito
        def existente
        def detalle

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
            carrito = Carrito.findByClienteAndEstado(cliente, 'A')

            if(carrito){
                existente = DetalleCarrito.findAllByCarritoAndPublicacion(carrito, publicacion)

                if(existente){
                    render "er_El producto seleccionado ya se encuentra en su carrito de compras"
                }else{
                    detalle = new DetalleCarrito()
                    detalle.carrito = carrito
                    detalle.publicacion = publicacion
                    detalle.producto = publicacion.producto
                    detalle.precioUnitario = publicacion.precioUnidad.toDouble()
                    detalle.cantidad = 1
                    detalle.subtotal = publicacion.precioUnidad.toDouble()

                    if(!detalle.save(flush:true)){
                        println("error al agregar el producto del carrito " + detalle.errors)
                        render "no"
                    }else{
                        carrito.cantidad += 1
                        carrito.subtotal += Math.round((detalle.subtotal)*100)/100
                        carrito.save(flush:true)
                        render "ok"
                    }
                }

            }else{
                carrito = new Carrito()
                carrito.cliente = cliente
                carrito.cantidad = 0
                carrito.subtotal = 0
                carrito.estado = 'A'
                carrito.fecha = new Date()

                if(!carrito.save(flush:true)){
                    println("error al crear el carrito " + carrito.errors)
                    render "no"
                }else{

                    detalle = new DetalleCarrito()
                    detalle.carrito = carrito
                    detalle.publicacion = publicacion
                    detalle.producto = publicacion.producto
                    detalle.precioUnitario = publicacion.precioUnidad.toDouble()
                    detalle.cantidad = 1
                    detalle.subtotal = publicacion.precioUnidad.toDouble()

                    if(!detalle.save(flush:true)){
                        println("error al agregar el producto del carrito " + detalle.errors)
                        render "no"
                    }else{

                        carrito.cantidad += 1
                        carrito.subtotal += Math.round((detalle.subtotal)*100)/100
                        carrito.save(flush:true)

                        render "ok"
                    }
                }
            }
        }else{
            render "er_Primero debe ingresar en el sistema para poder agregar productos a su carrito de compras"
        }
    }


    def borrarDetalle_ajax(){
        println("params " + params)

        def carrito
        def detalle = DetalleCarrito.get(params.id)

        try{
            detalle.delete(flush:true)
            carrito = Carrito.get(detalle.carrito.id)
            def totalDetalles = DetalleCarrito.findAllByCarrito(carrito)?.subtotal?.sum()
            carrito.subtotal = totalDetalles ? (Math.round((totalDetalles)*100)/100) : 0
            if(carrito.cantidad >= 1){
                carrito.cantidad += -1
            }
            carrito.save(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el detalle " + detalle.errors)
            render "no"
        }
    }

    def totales_ajax(){
        def cliente = Cliente.get(session.cliente.id)
        def carrito = Carrito.findByClienteAndEstado(cliente, 'A')
        def productos
//        def productos = DetalleCarrito.findAllByCarrito(carrito).sort{it.publicacion.producto.titulo}


        def sql = "select prod.prod__id, dtcr.publ__id, dtcr__id, publtitl, publsbtl, publpcun, dtcrcntd, " +
                "dtcrsbtt, publpcmy from publ, prod, dtcr where prod.prod__id = publ.prod__id and " +
                "publ.publ__id = dtcr.publ__id and crro__id = ${carrito?.id} and publetdo = 'A'"
        def cn = dbConnectionService.getConnection()
        def res = cn.rows(sql.toString());

        productos = res

        return[cliente: cliente, productos: productos]
    }

    def guardarCantidad_ajax(){
        def carrito
        def detalle = DetalleCarrito.get(params.id)
        detalle.cantidad = params.cantidad.toInteger()

        if(params.cantidad.toInteger() >= 10){
            detalle.precioUnitario = detalle.publicacion.precioMayor
            detalle.subtotal = Math.round((params.cantidad.toInteger() * detalle.publicacion.precioMayor)*100)/100
        }else{
            detalle.precioUnitario = detalle.publicacion.precioUnidad
            detalle.subtotal = Math.round((params.cantidad.toInteger() * detalle.publicacion.precioUnidad)*100)/100
        }

        if(!detalle.save(flush:true)){
            println("error al modificar la cantidad " + detalle.errors)
            render "no"
        }else{

            carrito = Carrito.get(detalle.carrito.id)
            def totalDetalles = DetalleCarrito.findAllByCarrito(carrito)?.subtotal?.sum()
            carrito.subtotal = totalDetalles ? (Math.round((totalDetalles)*100)/100) : 0
            carrito.save(flush:true)

            render "ok"
        }
    }

    def datos(){

        println("params dt " + params)

        def empresa = Empresa.get(params.empresa)
        def cliente = null

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
            return[cliente: cliente, empresa: empresa]
        }else{
            redirect(controller: 'principal', action: 'index')
        }
    }


    def guardarCliente_ajax(){
        println("datos " + params)

        def empresa = Empresa.get(params.empresa)

        if(session.cliente){
            def cliente = Cliente.get(session.cliente.id)

            def pais = Pais.get(params.pais)
            def tipoIdentificacion = TipoIdentificacion.get(params.tipoIdentificacion)
            def tipoPersona = TipoPersona.get(params.tipoPersona)

            params.pais = pais
            params.tipoPersona = tipoPersona
            params.tipoIdentificacion = tipoIdentificacion
            cliente.properties = params

            if(!cliente.save(flush:true)){
                println("error al guardar la informacion del cliente " + cliente.errors)
                render "no"
            }else{

                if(generarProcesoVentas(empresa?.id, cliente?.id)){
                    render "ok"
                }else{
                    println("error al generar el proceso de ventas ")
                    render "no"
                }

            }

        }else{
            redirect(controller: 'principal', action: 'index')
        }
    }

    def generarProcesoVentas(empresa, cliente){

        def clienteActual = Cliente.get(cliente)
        def carrito = Carrito.findByClienteAndEstado(clienteActual, 'A')
        def empresaActual = Empresa.get(empresa)
        def gestor = Gestor.get(22)
        def contabilidad = Contabilidad.findByFechaInicioLessThanEqualsAndFechaCierreGreaterThanEqualsAndInstitucion(new Date(), new Date(), empresaActual)
        //proveedor no
        //comprobante no
        def tipoProceso = TipoProceso.get(2)
        def libretin = DocumentoEmpresa.findByFechaInicioLessThanEqualsAndFechaFinGreaterThanEqualsAndEmpresa(new Date(), new Date(), empresaActual)

         //tipoEmision no
        //rolPagos no

        def tipoTransaccion = TipoTransaccion.get(2)

        //sustentoTributario no
        //modificaCmpr no

        def tipoCmprSustento = TipoCmprSustento.get(12)

        def fecha = new Date()
        def fechaRegistro = null
        def fechaIngreso = new Date()
        def fechaEmision = new Date()


       def sql = "select coalesce(max(prcsfcsc), 0) mxmo from prcs, fcdt " +
                "where tpps__id = ${tipoProceso?.id} and fcdt.fcdt__id = prcs.fcdt__id and " +
                "prcs.fcdt__id = ${libretin?.id} and prcsfcsc between fcdtdsde and fcdthsta and " +
                "prcs.empr__id = ${empresaActual?.id}"
        def cn = dbConnectionService.getConnection()

        def numEstablecimiento = libretin.numeroEstablecimiento
        def numeroEmision = libretin.numeroEmision
        def secuencial = cn.rows(sql.toString())[0]?.mxmo + 1

        def documento = numEstablecimiento + "-" + numeroEmision + "-" + secuencial

        def facturaEstablecimiento = numEstablecimiento
        def facturaPuntoEmision = numeroEmision
        def facturaSecuencial = secuencial.toInteger()

        def descripcion = "Venta " +  " - " + documento + " generada el " + new Date()
        def estado = 'N'

        //establecimiento no

//        def fechaIva = "'" + new Date().parse("dd-MM-yyyy", params.fcha).format('yyyy-MM-dd') + "'"

        def sqlIva = "select paux_iva from paux where now()::date between pauxfcin and " +
                "coalesce(pauxfcfn, now())"
        def valorIva = cn.rows(sqlIva.toString())[0]?.paux_iva

        def baseImponibleIva = carrito?.subtotal
        def baseImponibleIva0 = 0
        def baseImponibleNoIva = 0
        def excentoIva = 0
        def ivaGenerado = baseImponibleIva * valorIva.toDouble()
        def iceGenerado = 0
        def impuesto = 0
        def valor = baseImponibleIva + ivaGenerado
        def flete = 0
        def retenidoIva = 0
        def retenidoRenta = 0

        //procesoSerie01 no
        //procesoSerie02 no

        //facturaAutorizacion no
        // pagono
        def pais = Pais.findByCodigo('593')
        //normaLegal no
        //convenio no
        //claveAcceso no

        //modificaSerie01 no
        //modificaSerie02 no
        //modificaScnc no
        // modificaAutorizacion no

        //bodega no
        //bodegaRecibe no

        String retEstado = 'N'

        println("conta " + contabilidad)
        println("libretin " + libretin)


        def proceso = new Proceso()

        proceso.gestor = gestor
        proceso.contabilidad = contabilidad
        proceso.empresa = empresaActual
        proceso.proveedor = null
        proceso.comprobante = null
        proceso.usuario = null
        proceso.tipoProceso = tipoProceso
        proceso.documentoEmpresa = libretin
        proceso.establecimiento = null
        proceso.tipoEmision = null
        proceso.rolPagos = null
        proceso.tipoTransaccion = tipoTransaccion
        proceso.sustentoTributario = null
        proceso.tipoCmprSustento = tipoCmprSustento
        proceso.modificaCmpr = null
        proceso.fecha = fecha
        proceso.fechaRegistro = fechaRegistro
        proceso.fechaEmision = fechaEmision
        proceso.fechaIngresoSistema = fechaIngreso
        proceso.descripcion = descripcion
        proceso.estado = estado
        proceso.baseImponibleIva = baseImponibleIva
        proceso.baseImponibleIva0 = baseImponibleIva0
        proceso.baseImponibleNoIva = baseImponibleNoIva
        proceso.excentoIva = excentoIva
        proceso.ivaGenerado = ivaGenerado
        proceso.iceGenerado = iceGenerado
        proceso.impuesto = impuesto
        proceso.valor = valor
        proceso.flete = flete
        proceso.retenidoIva = retenidoIva
        proceso.retenidoRenta = retenidoRenta
        proceso.procesoSerie01 = null
        proceso.procesoSerie02 = null
        proceso.autorizacion = null
        proceso.documento = documento
        proceso.facturaEstablecimiento = facturaEstablecimiento
        proceso.facturaPuntoEmision = facturaPuntoEmision
        proceso.facturaSecuencial = secuencial
        proceso.facturaAutorizacion = null
        proceso.pago = null
        proceso.pais = pais
        proceso.normaLegal = null
        proceso.convenio = null
        proceso.claveAcceso = null
        proceso.modificaSerie01 = null
        proceso.modificaSerie02 = null
        proceso.modificaAutorizacion = null

        if(!proceso.save(flush:true)){
            println("error al guardar el proceso " + proceso.errors)
            return false
        }else{
            return true
        }

    }
}
