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
        def sqlWhere = "where prodetdo != 'B' and ${wh} ${condicionAdicional}"


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
        println("params sv pr" + params)

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

        def totalDestacados = Producto.withCriteria {
            eq("destacado","S")
            persona{
                eq("empresa", usuario.empresa)
            }
        }
//        println("td " + totalDestacados.size())

        if(totalDestacados.size() < 3){
            params.destacado = (params.destacado2 == 'true' ? 'S' : 'N')
        }else{
            params.destacado = 'N'
        }

        params.nuevo = (params.nuevo2 == 'true' ? 'S' : 'N')

        producto.properties = params

        if(!producto.save(flush:true)){
            println("error al guardar el producto " + producto.errors)
            render "no"
        }else{
            render "ok_" + producto?.id
        }
    }


    /*
* insertar en PUBL: prod__id, prodfcha, prodtitl, prodsbtt, prodtxto, prodlong, prodlatt
* En DTPB: Imágenes: {dtpbtipo = 'I', dtpbdscr = imagtxto, dtpbvlor = imagruta }
*          Valores:  {dtpbtipo = 'V', dtpbdscr = atvldscr, dtpbvlor = atvlvlor }
* Si hay una publicación activa, se la da de baja: publetdo = 'B' el nuevo queda como 'A' **/
    def publicar_ajax(){
        println "publicar_ajax: $params"
        def cn = dbConnectionService.getConnection()
        def prod = Producto.get(params.id)
        def prsn = session.usuario.id
        def obsr = ""
        def fcha = new Date().format('yyyy-MM-dd HH:mm:ss')
        def sql = "update publ set publetdo = 'B', publfcmd = '${fcha}' " +
                "where prod__id = ${params.id} and publetdo = 'A' returning publfcha"
        println "sql: $sql"

        def publfcha = cn.rows(sql.toString())[0]?.publfcha

        // si  existió una publicación OBSR: 'Producto modificado

        sql = "insert into publ(prod__id, prsn__id, grpo__id, publfcha, publdstc, " +
                "publnuvo, publtitl, publsbtl, publtxto, publetdo, publpcun, publpcmy, publobsr) select " +
                "${params.id}, ${prsn}, ${prod.grupo.id}, '${fcha}', prod.proddstc, " +
                "prod.prodnuvo, prodtitl, prodsbtl, prodtxto, 'A', prodpcun, prodpcmy "
        if(publfcha) {
            sql += ",'Publicado anteriormente el ${publfcha.format('yyyy-MM-dd HH:mm:ss')}' " +
                    "from prod where prod__id = ${params.id} returning publ__id"
        } else {
            sql += ",null from prod where prod__id = ${params.id} returning publ__id"
        }
        println "sql: $sql"
        def publ__id = cn.rows(sql.toString())[0].publ__id

        sql = "insert into dtpb(publ__id, dtpbtipo, dtpbdscr, dtpbvlor, dtpbpncp) " +
                "select ${publ__id}, 'I', imagtxto, imagruta, imagpncp " +
                "from imag where prod__id = ${params.id} returning dtpb__id"

        println "sql: $sql"
        def dtpbimag = cn.rows(sql.toString()).size()

        sql = "insert into dtpb(publ__id, dtpbtipo, dtpbdscr, dtpbvlor) " +
                "select ${publ__id}, 'V', atrbdscr, atrbvlor from atrb " +
                "where prod__id = ${params.id} returning dtpb__id"

        def dtpbvlor = cn.rows(sql.toString()).size()

        prod.estado = 'P'
        prod.save(flush: true)

        render("Publicación Existosa del anuncio: <br><strong>${prod.titulo}</strong><br>" +
                "Con ${dtpbimag} imágenes y ${dtpbvlor} atributos")
//        render("Publicación Existosa del anuncio: <br><strong>${prod.titulo}</strong><br>" +
//                "Con 4 imágenes y 4 atributos")
    }

    def revisarProd_ajax() {
        def producto = Producto.get(params.id)
        def imag = Imagen.countByProductoAndPrincipal(producto, 1)
        println "revisarProd_ajax: $params, --> ${producto?.id} --> imag: $imag"
        render "${imag > 0 ? 'ok' : 'no' }"
    }

    def agregarComentario_ajax(){

        println("params " + params)

        def publicacion = Publicacion.get(params.id)
        def comentario

        def cliente = null

        if(session.cliente){
            cliente = Cliente.get(session.cliente.id)
        }

        def comentarioExistente = Comentario.findAllByPublicacionAndCliente(publicacion, cliente)

        if(comentarioExistente){
            render "er_Ya existe un comentario para este producto"
        }else{
            comentario = new Comentario()
            comentario.cliente = cliente
            comentario.publicacion = publicacion
            comentario.fecha = new Date()
            comentario.descripcion = params.texto
            comentario.calificacion = params.calificacion.toInteger()
            comentario.estado = 'I'

            if(!comentario.save(flush:true)){
                println("error al guardar el comentario " + comentario.errors)
                render "no"
            }else{
                render "ok"
            }

        }
    }

    def darDeBaja_ajax(){
        def producto = Producto.get(params.id)
        def publicacionActiva = Publicacion.findByProductoAndEstado(producto, 'A')

        if(publicacionActiva){
            publicacionActiva.estado = 'B'

            if(!publicacionActiva.save(flush:true)){
                println("error al dar de baja la publicacion " + publicacionActiva.errors)
                render "er_Error al dar de baja la publicación"
            }else{
                producto.estado = 'B'

                if(!producto.save(flush:true)){
                    println("error al dar de baja el producto " + producto.errors)
                    render "no"
                }else{
                    render "ok"
                }
            }
        }else{
            producto.estado = 'B'

            if(!producto.save(flush:true)){
                println("error al dar de baja el producto " + producto.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

}
