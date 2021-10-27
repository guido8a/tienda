package tienda


class CategoriaController {

    def arbol () {

    }

    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }


    def makeTreeNode(params) {
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
            def hh = Categoria.count()
            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Categorías</a>" +
                    "</li>"
        } else {
//            println "---- no es raiz... procesa: $tipo"


            if(id == 'root'){
                hijos = Categoria.findAll().sort{it.descripcion}
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
                        hijos = Subcategoria.findAllByCategoria(Categoria.get(id), [sort: params.sort])
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

}
