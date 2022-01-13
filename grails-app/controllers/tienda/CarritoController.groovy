package tienda

import retenciones.Pais
import sri.TipoIdentificacion
import sri.TipoPersona


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
                    }else{

                    }
                }

//                productos = DetalleCarrito.findAllByCarrito(carrito).sort{it.publicacion.producto.titulo}
                def sql = "select prod.prod__id, dtcr.publ__id, dtcr__id, publtitl, publsbtl, publpcun, dtcrcntd, " +
                        "dtcrsbtt, publpcmy from publ, prod, dtcr where prod.prod__id = publ.prod__id and " +
                        "publ.publ__id = dtcr.publ__id and crro__id = ${carrito?.id} and publetdo = 'A'"
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

        def cliente = null

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
            return[cliente: cliente]
        }else{
            redirect(controller: 'principal', action: 'index')
        }
    }


    def guardarCliente_ajax(){
        println("datos " + params)

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
                render "ok"
            }

        }else{
            redirect(controller: 'principal', action: 'index')
        }


    }
}
