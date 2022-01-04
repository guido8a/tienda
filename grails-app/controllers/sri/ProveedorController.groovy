package sri

import seguridad.Empresa
import seguridad.Persona


class ProveedorController {

    def list(){

    }

    def tablaProveedor_ajax(){

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        def proveedores = Proveedor.withCriteria {
            eq("empresa",empresa)

            and{
                ilike("ruc", "%" + params.ruc + "%")
                ilike("nombre", "%" + params.nombre + "%")
            }

            order("nombre", "asc")
        }

//        println("pro " + proveedores)

        return[proveedores: proveedores]
    }

    def form_ajax(){

        def proveedor

        if(params.id){
            proveedor = Proveedor.get(params.id)
        }else{
            proveedor = new Proveedor()
        }

        return[proveedorInstance: proveedor]
    }

    def ruc_ajax(){
        def proveedorInstance
        def lectura
        def longitud
        if(params.id){
            lectura = true
            proveedorInstance = Proveedor.get(params.id)
        }else{
            lectura = false
        }

        if(params.tipo == '2'){
            longitud = 10
        }else{
            longitud = 13
        }

        return[proveedorInstance: proveedorInstance, lectura: lectura, longitud: longitud.toInteger()]
    }

    def tipoPersona_ajax () {
        def lista
        def proveedorInstance
        if(params.id){
            proveedorInstance = Proveedor.get(params.id)
        }

        if(params.tipo == '2' || params.tipo == '3'){
            lista = TipoPersona.withCriteria {
                ne("codigo","J")
            }
        }else{
            lista = TipoPersona.list()
        }

        return[lista: lista, proveedorInstance: proveedorInstance]
    }

    def validarCedula_ajax() {
        println("params " + params)
        params.ruc = params.ruc.toString().trim()
        if (params.id) {
            def prov = Proveedor.get(params.id)
            if (prov.ruc.trim() == params.ruc.trim()) {
                render true
                return
            } else {
                render Proveedor.countByRuc(params.ruc) == 0
                return
            }
        } else {
            render Proveedor.countByEmpresaAndRuc(session.empresa, params.ruc) == 0
            return
        }
    }
    def save_ajax(){
        println("params " + params)

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        params.empresa = empresa
        params.pais = params."pais.id"

        def proveedor

        if(params.id){
            proveedor = Proveedor.get(params.id)
        }else{
            proveedor = new Proveedor()
            proveedor.fecha = new Date()
        }

        proveedor.properties = params

        if(!proveedor.save(flush:true)){
            println("error al guardar el proveedor " + proveedor.errors)
            render "no"
        }else{
            render "ok"
        }

    }

    def show_ajax() {
        if (params.id) {
            def proveedorInstance = Proveedor.get(params.id)
            if (!proveedorInstance) {
                notFound_ajax()
                return
            }
            return [proveedorInstance: proveedorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog


    protected void notFound_ajax() {
        render "NO_No se encontró Proveedor."
    } //notFound para ajax


    def delete_ajax(){

        def proveedor = Proveedor.get(params.id)

        try{
            proveedor.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el proveedor " + proveedor.errors)
            render "no"
        }

    }
}
