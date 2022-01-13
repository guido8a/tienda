package tienda

import seguridad.Persona


class CategoriaController {

    def arbol () {

    }

    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }


    def makeTreeNode(params) {

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

        println "makeTreeNode categorias.. $params"
        def id = params.id
        def tipo = ""
        def liId = ""
        def ico = ""

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

        String tree = "", clase = "", rel = ""
        def padre
        def hijos = []

//        println "---> id: $id, tipo: $tipo, es #: ${id == '#'}"

        if (id == "#") {
            //root
//            def hh = Provincia.countByZonaIsNull()
            def hh = Categoria.findAllByEmpresa(empresa).size()
            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Categorías</a>" +
                    "</li>"
        } else {
//            println "---- no es raiz... procesa: $tipo"


            if(id == 'root'){
//                hijos = Categoria.findAllByEmpresa(empresa).sort{it.descripcion}
                hijos = Categoria.findAllByEmpresa(empresa, [sort: 'descripcion'])
                def data = ""
                ico = ", \"icon\":\"fa fa-copyright text-success\""
                hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
                    clase = Subcategoria.findByCategoria(hijo) ? "jstree-closed hasChildren" : "jstree-closed"

//                    tree += "<ul>"
                    tree += "<li id='cat_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<a href='#' class='label_arbol'>" + hijo?.descripcion + "</a>"
                    tree += "</li>"
                }
            }else{
                switch(tipo) {
                    case "cat":
                        hijos = Subcategoria.findAllByCategoria(Categoria.get(id), [sort: 'orden'])
                        liId = "scat_"
//                    println "tipo: $tipo, ${hijos.size()}"
                        ico = ", \"icon\":\"fa fa-parking text-info\""
                        hijos.each { h ->
//                        println "procesa $h"
                            clase = Grupo.findBySubcategoria(h)? "jstree-closed hasChildren" : ""
//                            clase = "jstree-closed hasChildren"
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"subcategoria"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.descripcion + "</a>"
                            tree += "</li>"
                        }
                        break
                    case "scat":
                        hijos = Grupo.findAllBySubcategoria(Subcategoria.get(id), [sort: params.sort])
                        liId = "grp_"
//                    println "tipo: $tipo, ${hijos.size()}"
                        ico = ", \"icon\":\"fa fa-registered text-danger\""
                        hijos.each { h ->
//                        println "procesa $h"
//                        clase = Comunidad.findByParroquia(h)? "jstree-closed hasChildren" : ""
                            clase = ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"grupo"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.descripcion + "</a>"
                            tree += "</li>"
                        }
                        break
                    case "parr":
                        break
                }
            }
        }
        return tree
    }

    def form_ajax(){

        def categoria

        if(params.id){
            categoria = Categoria.get(params.id)
        }else{
            categoria = new Categoria()
        }

        return[categoria: categoria]
    }

    def validarOrden_ajax(){
//        println("params orden " + params)

        def categorias = false
        def categoria

        if(params.orden){
            if(params.id){
                categoria = Categoria.get(params.id)
                categorias = Categoria.findAllByOrdenAndIdNotEqual(params.orden.toInteger(), categoria.id)
            }else{
                categorias = Categoria.findAllByOrden(params.orden.toInteger())
            }

            if(categorias){
                render "false"
            }else{
                render "true"
            }
        }else{
            render "true"
        }
    }

    def saveCategoria_ajax(){
//        println("params svc " + params)

        def categoria

        if(params.id){
            categoria = Categoria.get(params.id)
        }else{
            categoria = new Categoria()
        }

        categoria.properties = params

        if(!categoria.save(flush:true)){
            println("error al guardar la categoria " + categoria.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def show_ajax(){
        def categoria = Categoria.get(params.id)
        return[categoria:categoria]
    }

    def borrarCategoria_ajax(){
        def categoria = Categoria.get(params.id)

        try{
            categoria.delete(flush:true)
            render "ok"
        }catch(e){
            println("Error al borrar la categoria " + categoria.errors)
            render "no"
        }
    }

    def arbolSearch_ajax() {
        println "arbolSearch_ajax $params"
        def search = params.str.trim()
        if (search != "") {
            def c = Subcategoria.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("descripcion", "%" + search + "%")
                    categoria {
                        or {
                            ilike("descripcion", "%" + search + "%")
                        }
                    }
                }
            }

            def categorias = []
            find.each { pers ->
                if (pers.categoria && !categorias.contains(pers.categoria)) {
                    categorias.add(pers.categoria)
                    def dep = pers.categoria
                }
            }
            categorias = categorias.reverse()
            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                categorias.each { dp ->
                    ids += "\"#lidep_" + dp.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }

}
