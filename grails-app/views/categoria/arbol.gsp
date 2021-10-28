<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 01/07/20
  Time: 16:48
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">

    <title>Categorías de productos</title>

    <asset:javascript src="/jstree-3.0.8/dist/jstree.min.js"/>
    <asset:stylesheet src="/jstree-3.0.8/dist/themes/default/style.min.css"/>

    <style type="text/css">
    #tree {
        overflow-y : auto;
        height     : 440px;
    }

    .jstree-search {
        color : #5F87B2 !important;
    }
    </style>

</head>

<body>

<div id="cargando" class="text-center">
    <p>Cargando...</p>
    <asset:image src="apli/spinner32.gif" style="padding: 40px;"/>
    <p>Por favor espere</p>
</div>

<div class="row" style="margin-bottom: 10px;">

%{--    <div class="btn-toolbar toolbar">--}%
%{--        <div class="btn-group">--}%
%{--            <g:link controller="inicio" action="parametros" class="btn btn-info">--}%
%{--                <i class="fa fa-arrow-left"></i> Parámetros--}%
%{--            </g:link>--}%
%{--        </div>--}%
%{--    </div>--}%

    <div class="col-md-2">
        <div class="input-group input-group-sm">
            <g:textField name="searchArbol" class="form-control input-sm" placeholder="Buscador"/>
            <span class="input-group-btn">
                <a href="#" id="btnSearchArbol" class="btn btn-sm btn-info">
                    <i class="fa fa-search"></i>&nbsp;
                </a>
            </span>
        </div><!-- /input-group -->
    </div>

    <div class="col-md-3 hidden" id="divSearchRes">
        <span id="spanSearchRes">
            5 resultados
        </span>

        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnNextSearch" title="Siguiente">
                <i class="fa fa-chevron-down"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnPrevSearch" title="Anterior">
                <i class="fa fa-chevron-up"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnClearSearch" title="Limpiar búsqueda">
                <i class="fa fa-times-circle"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-1">
        <div class="btn-group">
            <a href="#" class="btn btn-xs btn-default" id="btnCollapseAll" title="Cerrar todos los nodos">
                <i class="fa fa-minus-square"></i>&nbsp;
            </a>
            <a href="#" class="btn btn-xs btn-default" id="btnExpandAll" title="Abrir todos los nodos">
                <i class="fa fa-plus-square"></i>&nbsp;
            </a>
        </div>
    </div>

    <div class="col-md-4 text-right pull-right" style="font-size: 18px">
        <i class="fa fa-copyright text-success"></i> Categoría
        <i class="fa fa-parking text-primary"></i> Subcategoría
        <i class="fa fa-registered text-danger"></i> Grupo
    </div>
</div>

<div id="tree" class="well hidden">

</div>

<script type="text/javascript">
    var searchRes = [];
    var posSearchShow = 0;
    var $treeContainer = $("#tree");


    function createEditCategoria(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'categoria', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEdit",
                    title : title + " Categoría",
                    // class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormCategoria();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function createEditSubcategoria(id, parentId) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'subcategoria', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditC",
                    title : title + " Subcategoría",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormSubcategoria();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function createEditGrupo(id, parentId) {

        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        if (parentId) {
            data.padre = parentId;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'grupo', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditP",
                    title : title + " Grupo",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormGrupo();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit


    function submitFormCategoria() {
        var $form = $("#frmCategoria");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Categoría guardada correctamente", "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    }else{
                        log("Error al guardar la categoría","error");
                        // bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function submitFormSubcategoria() {
        var $form = $("#frmSubcategoria");
        var $btn = $("#dlgCreateEditC").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Subcategoría guardada correctamente", "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    }else{
                        log("Error al guardar la subcategoría","error");
                        // bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function submitFormGrupo() {
        var $form = $("#frmGrupo");
        var $btn = $("#dlgCreateEditP").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Grupo guardado correctamente", "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    }else{
                        log("Error al guardar el grupo","error");
                        // bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
                }
            });
        } else {
            return false;
        }
    }

    function createContextMenu(node) {
        $(".lzm-dropdown-menu").hide();

        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;

        // var nodeParentId = $node.parent().parent().children()[1].id.split("_")[1]
        // console.log("n " + nodeParentId)
        // var nodeText = $node.children("a").first().text();

        var esRoot = nodeType.contains("root");
        var esPrincipal = nodeType.contains("principal");
        var esSubcategoria = nodeType.contains("subcategoria");
        var esGrupo = nodeType.contains("grupo");
        // var esComunidad = nodeType.contains("comunidad");

        var items = {};

        var agregarCategoria = {
            label  : "Agregar Categoria",
            icon   : "fa fa-copyright text-success",
            action : function () {
                createEditCategoria(null);
            }
        };

        var agregarSubcategoria = {
            label  : "Agregar Subcategoría",
            icon   : "fa fa-parking text-info",
            action : function () {
                createEditSubcategoria(null, nodeId);
            }
        };

        var agregarSubcategoria2 = {
            label  : "Agregar Subcategoría",
            icon   : "fa fa-parking text-info",
            action : function () {
                createEditSubcategoria(null, $node.parent().parent().children()[1].id.split("_")[1]);
            }
        };

        var agregarGrupo = {
            label  : "Agregar Grupo",
            icon   : "fa fa-registered text-danger",
            action : function () {
                createEditGrupo(null, nodeId);
            }
        };

        var agregarGrupo2 = {
            label  : "Agregar Grupo",
            icon   : "fa fa-registered text-danger",
            action : function () {
                createEditGrupo(null, $node.parent().parent().children()[1].id.split("_")[1]);
            }
        };

        var editarCategoria = {
            label  : "Editar Categoría",
            icon   : "fa fa-pen text-info",
            action : function () {
                createEditCategoria(nodeId);
            }
        };

        var editarSubcategoria = {
            label  : "Editar Subcategoría",
            icon   : "fa fa-pen text-info",
            action : function () {
                createEditSubcategoria(nodeId, null);
            }
        };

        var editarGrupo = {
            label  : "Editar Grupo",
            icon   : "fa fa-pen text-info",
            action : function () {
                createEditGrupo(nodeId, null);
            }
        };

        var verCategoria= {
            label            : "Ver datos de la Categoría",
            icon             : "fa fa-laptop text-info",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "categoria", action:'show_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Categoría",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var verSubcategoria = {
            label            : "Ver datos de la subcategoría",
            icon             : "fa fa-laptop text-info",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "subcategoria", action:'show_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Subcategoría",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var verGrupo = {
            label            : "Ver datos del grupo",
            icon             : "fa fa-laptop text-info",
            separator_before : true,
            action           : function () {
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "grupo", action:'show_ajax')}",
                    data    : {
                        id : nodeId
                    },
                    success : function (msg) {
                        bootbox.dialog({
                            title   : "Ver Grupo",
                            message : msg,
                            buttons : {
                                ok : {
                                    label     : "Aceptar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            }
                        });
                    }
                });
            }
        };

        var borrarCategoria = {
            label            : "Borrar Categoría",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Categoría",
                    message: "Está seguro de borrar esta categoría? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'categoria', action: 'borrarCategoria_ajax')}',
                                data:{
                                    id: nodeId
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Categoría borrada correctamente","success");
                                        setTimeout(function () {
                                            location.reload(true);
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la categoría", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };


        var borrarSubcategoria = {
            label            : "Borrar Subcategoría",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Subcategoría",
                    message: "Está seguro de borrar esta subcategoría? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'subcategoria', action: 'borrarSubcategoria_ajax')}',
                                data:{
                                    id: nodeId
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Subcategoría borrada correctamente","success");
                                        setTimeout(function () {
                                            location.reload(true);
                                        }, 1000);
                                    }else{
                                        log("Error al borrar la subcategoría", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };


        var borrarGrupo = {
            label            : "Borrar Grupo",
            icon             : "fa fa-trash text-danger",
            separator_before : true,
            action           : function () {
                bootbox.confirm({
                    title: "Borrar Grupo",
                    message: "Está seguro de borrar este grupo? Esta acción no puede deshacerse.",
                    buttons: {
                        cancel: {
                            label: '<i class="fa fa-times"></i> Cancelar',
                            className: 'btn-primary'
                        },
                        confirm: {
                            label: '<i class="fa fa-trash"></i> Borrar',
                            className: 'btn-danger'
                        }
                    },
                    callback: function (result) {
                        if(result){
                            var dialog = cargarLoader("Borrando...");
                            $.ajax({
                                type: 'POST',
                                url: '${createLink(controller: 'grupo', action: 'borrarGrupo_ajax')}',
                                data:{
                                    id: nodeId
                                },
                                success: function (msg) {
                                    dialog.modal('hide');
                                    if(msg == 'ok'){
                                        log("Grupo borrado correctamente","success");
                                        setTimeout(function () {
                                            location.reload(true);
                                        }, 1000);
                                    }else{
                                        log("Error al borrar el grupo", "error")
                                    }
                                }
                            });
                        }
                    }
                });
            }
        };

         if (esRoot) {
            items.agregarCategoria = agregarCategoria;
        } else if (esPrincipal) {
            items.agregarCategoria = agregarCategoria;
            items.agregarSubcategoria = agregarSubcategoria;
            items.verCategoria = verCategoria;
            items.editarCategoria = editarCategoria;
            items.borrarCategoria = borrarCategoria;
        } else if (esSubcategoria) {
            items.agregarSubcategoria = agregarSubcategoria2;
            items.agregarGrupo = agregarGrupo;
            items.verSubcategoria = verSubcategoria;
            items.editarSubcategoria = editarSubcategoria;
            items.borrarSubcategoria = borrarSubcategoria;
        } else if (esGrupo) {
            items.agregarGrupo = agregarGrupo2;
            items.verGrupo = verGrupo;
            items.editarGrupo = editarGrupo;
            items.borrarGrupo = borrarGrupo;
        }

        // else if (esComunidad) {
        //     items.agregarComunidad = agregarComunidad2;
        //     items.verComunidad = verComunidad;
        //     items.editarComunidad = editarComunidad;
        //     items.borrarComunidad = borrarComunidad;
        // }
        return items;
    }

    function scrollToNode($scrollTo) {
        $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
            scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
        });
    }

    function scrollToRoot() {
        var $scrollTo = $("#root");
        scrollToNode($scrollTo);
    }

    function scrollToSearchRes() {
        var $scrollTo = $(searchRes[posSearchShow]).parents("li").first();
        $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
        scrollToNode($scrollTo);
    }

    $(function () {

        $treeContainer.on("loaded.jstree", function () {
            $("#cargando").hide();
            $("#tree").removeClass("hidden");

        }).on("select_node.jstree", function (node, selected, event) {
        }).jstree({
            plugins     : ["types", "state", "contextmenu", "search"],
            core        : {
                multiple       : false,
                check_callback : true,
                themes         : {
                    variant : "small",
                    dots    : true,
                    stripes : true
                },
                data           : {
                    // async : false,
                    url   : '${createLink(controller: 'categoria' , action:"loadTreePart_ajax")}',
                    data  : function (node) {
                        return {
                            id    : node.id,
                            sort  : "${params.sort?:'descripcion'}",
                            order : "${params.order?:'asc'}"
                        };
                    }
                }
            },
            contextmenu : {
                show_at_node : false,
                items        : createContextMenu
            },
            state       : {
                key : "unidades",
                opened: false
            },
            search      : {
                fuzzy             : false,
                show_only_matches : false,
                ajax              : {
                    url     : "${createLink(controller: 'categoria', action:'arbolSearch_ajax')}",
                    success : function (msg) {
                        var json = $.parseJSON(msg);
                        $.each(json, function (i, obj) {
                            $('#tree').jstree("open_node", obj);
                        });
                        setTimeout(function () {
                            searchRes = $(".jstree-search");
                            var cantRes = searchRes.length;
                            posSearchShow = 0;
                            $("#divSearchRes").removeClass("hidden");
                            $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                            scrollToSearchRes();
                        }, 300);

                    }
                }
            },
            types       : {
                root                : {
                    icon : "fa fa-sitemap text-info"
                },
                yachay              : {
                    icon : "fa fa-building text-info"
                },
                unidadPadreActivo   : {
                    icon : "fa fa-building-o text-info"
                },
                unidadPadreInactivo : {
                    icon : "fa fa-building-o text-muted"
                },
                unidadHijoActivo    : {
                    icon : "fa fa-home text-success"
                },
                unidadHijoInactivo  : {
                    icon : "fa fa-home text-muted"
                },
                usuarioActivo       : {
                    icon : "fa fa-user text-info"
                },
                usuarioInactivo     : {
                    icon : "fa fa-user text-muted"
                }
            }
        });

        $("#btnExpandAll").click(function () {
            $treeContainer.jstree("open_all");
            scrollToRoot();
            return false;
        });

        $("#btnCollapseAll").click(function () {
            $treeContainer.jstree("close_all");
            scrollToRoot();
            return false;
        });

        $('#btnSearchArbol').click(function () {
            $treeContainer.jstree("open_all");
            $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
            return false;
        });
        $("#searchArbol").keypress(function (ev) {
            if (ev.keyCode == 13) {
                $treeContainer.jstree("open_all");
                $treeContainer.jstree(true).search($.trim($("#searchArbol").val()));
                return false;
            }
        });

        $("#btnPrevSearch").click(function () {
            if (posSearchShow > 0) {
                posSearchShow--;
            } else {
                posSearchShow = searchRes.length - 1;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnNextSearch").click(function () {
            if (posSearchShow < searchRes.length - 1) {
                posSearchShow++;
            } else {
                posSearchShow = 0;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnClearSearch").click(function () {
            $treeContainer.jstree("clear_search");
            $("#searchArbol").val("");
            posSearchShow = 0;
            searchRes = [];
            scrollToRoot();
            $("#divSearchRes").addClass("hidden");
            $("#spanSearchRes").text("");
        });

    });
</script>

</body>
</html>