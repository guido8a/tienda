package tienda

import seguridad.Persona


class ProductoController {
    def dbConnectionService
    def buscadorService

    def list(){

    }

    def tablaProductos_ajax(){

    }

    def subcategorias_ajax(){
        def categoria = Categoria.get(params.id)
        def subcategorias = Subcategoria.findAllByCategoria(categoria)
        def subcategoria = null

        if(params.tipo == '1'){
            subcategoria = Subcategoria.get(params.sub)
        }

        return[subcategorias: subcategorias, tipo: params.tipo, sub: subcategoria]
    }

    def grupos_ajax(){
        def subcategoria = Subcategoria.get(params.id)
        def grupos = Grupo.findAllBySubcategoria(subcategoria)
        def grupo = null

        if(params.tipo == '1'){
            grupo = Grupo.get(params.gru)
        }

        return[grupos:grupos, tipo: params.tipo, gru: grupo]
    }

    def form(){

        def producto

        if(params.id){
            producto = Producto.get(params.id)
        }else{
            producto = new Producto()
        }

        return[producto:producto]
    }

    def tablaBuscar() {
//        println "buscar .... $params"
        def cn = dbConnectionService.getConnection()
//        params.old = params.criterio
//        params.criterio = buscadorService.limpiaCriterio(params.criterio)
//        params.ordenar  = buscadorService.limpiaCriterio(params.ordenar)

        def sql = armaSql(params)
//        params.criterio = params.old
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        def msg = ""
        if(data?.size() > 50){
            data.pop()   //descarta el último puesto que son 21
            msg = "<div class='alert-danger' style='margin-top:-20px; diplay:block; height:25px;margin-bottom: 20px;'>" +
                    " <i class='fa fa-warning fa-2x pull-left'></i> Su búsqueda ha generado más de 50 resultados. " +
                    "Use más letras para especificar mejor la búsqueda.</div>"
        }
        cn.close()

        return [data: data, msg: msg]
    }

    def armaSql(params){
//        println "armaSql: $params"
        def categoria = Categoria.get(params.categoria)
        def subcategoria
        def grupo
        def condicionAdicional = ''


        if(params.categoria){
            condicionAdicional = ' and sbct.ctgr__id = '  + categoria?.id
        }

        if(params.subcategoria){
            subcategoria = Subcategoria.get(params.subcategoria)
            condicionAdicional += ' and sbct.sbct__id = ' + subcategoria?.id
        }

        if(params.grupo){
            grupo = Grupo.get(params.grupo)
            condicionAdicional += ' and prod.grpo__id =' + grupo?.id
        }

        if(params.criterio){
            condicionAdicional += ' and prodtitl ilike ' + " '%" + params.criterio + "%'"
        }

        def campos = buscadorService.parmInstructor()
        def operador = buscadorService.operadores()
        def sqlSelect = "select prod__id, prodtitl, prodsbtl, grpodscr, prodetdo " +
                "from prod, ctgr, sbct, grpo "

        //condicion fija
        def wh = " grpo.grpo__id = prod.grpo__id and sbct.sbct__id = grpo.sbct__id and ctgr.ctgr__id = sbct.ctgr__id "
        def sqlWhere = "where ${wh} ${condicionAdicional}"

        def sqlOrder = "order by prodtitl limit 51"

//        if(params.operador && params.criterio) {
//            if(campos.find {it.campo == params.buscador}?.size() > 0) {
//                def op = operador.find {it.valor == params.operador}
//                sqlWhere += " and ${params.buscador} ${op.operador} ${op.strInicio}${params.criterio}${op.strFin}";
//            }
//        }

//        println("---> " + "$sqlSelect $sqlWhere $sqlOrder".toString())

       return "$sqlSelect $sqlWhere $sqlOrder".toString()
    }

    def guardarProducto_ajax(){
//        println("params sv pr" + params)

        def usuario = Persona.get(session.usuario.id)

        def producto

        if(params.id){
            producto = Producto.get(params.id)
            producto.fechaModificacion = new Date()
        }else{
            producto = new Producto()
            producto.fecha = new Date()
            producto.estado = 'A'
            producto.persona = usuario
        }

        params.texto = params.texto2

        producto.properties = params

        if(!producto.save(flush:true)){
            println("error al guardar el producto " + producto.errors)
            render "no"
        }else{
            render "ok_" + producto?.id
        }
    }

}
