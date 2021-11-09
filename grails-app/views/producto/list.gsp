<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 10:31
--%>

<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <meta name="layout" content="main">
    <title>Productos</title>

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }
    .aviso{
        font-size: 16px;
        font-weight: normal;
    }
    .caja50{
        width: 100px !important;
        height: 70px;
        display: block;
    }

    </style>

</head>

<body>

<div style="text-align: center; margin-top: -20px;margin-bottom:20px">
    <h3>Administración de Productos</h3>
</div>

<div style="margin-top: -15px;" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -15px"><i class="fa fa-search-plus"></i></p>

    <div class="linea45"></div>
    <div class="row" style="margin-bottom: 10px;">

        <div class="row-fluid">
            <div style="margin-left: 20px;">
%{--                <div class="col-xs-8 col-md-8">--}%
                    <div class="col-xs-2 col-md-2">
                        <b>Categoría: </b>
                        <g:select name="categoria" from="${tienda.Categoria.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control"/>
                    </div>
                    <div class="col-xs-3 col-md-3" id="divSubcategoria">

                    </div>

                    <div class="col-xs-2 col-md-2" id="divGrupo">

                    </div>

                    <div class="col-xs-3 col-md-3">
                        <b>Criterio: </b>
                        <g:textField name="criterio" class="form-control" />
                    </div>

                    <div class="btn-group col-xs-2 col-md-2" style="margin-left: -10px; margin-top: 18px;">

                        <a href="#" name="busqueda" class="btn btn-info" id="btnBusqueda" title="Buscar"
                           style="height: 34px; width: 46px">
                            <i class="fa fa-search"></i>
                        </a>

                        <a href="#" name="limpiarBus" class="btn btn-warning" id="btnLimpiarBusqueda"
                           title="Borrar criterios" style="height: 34px; width: 34px">
                            <i class="fa fa-eraser"></i>
                        </a>


                        <a href="${createLink(controller: 'producto', action: 'form')}" class="btn btn-success" id="btnNuevo"
                           title="Nuevo producto" style="height: 34px; width: 46px">
                            <i class="fa fa-plus-square"></i>
                        </a>

                    </div>
            </div>

        </div>
    </div>


</div>



<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Productos</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px">
        <thead>
        <tr>
            <th class="alinear" style="width: 25%">Nombre</th>
            <th class="alinear" style="width: 50%">Título</th>
            <th class="alinear" style="width: 20%">Grupo</th>
            <th class="alinear" style="width: 5%">Estado</th>
        </tr>
        </thead>
    </table>


    <div class="alert alert-danger hidden" id="mensaje" style="text-align: center">
    </div>

    <div id="detalle">
    </div>
</div>

%{--<div><strong>Nota</strong>: Si existen muchos registros que coinciden con el criterio de búsqueda, se retorna--}%
%{--como máximo 30--}%
%{--</div>--}%


<script type="text/javascript">

    cargarsubcategorias($("#categoria option:selected").val());

    $("#categoria").change(function () {
       var cat = $(this).val();
       cargarsubcategorias(cat)
    });

    function cargarsubcategorias(categoria){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'producto', action: 'subcategorias_ajax')}',
            data:{
                id: categoria
            },
            success: function (msg) {
                $("#divSubcategoria").html(msg)
            }
        })
    }

    function cargarGrupos(subcategoria){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'producto', action: 'grupos_ajax')}',
            data:{
                id: subcategoria
            },
            success: function (msg) {
                $("#divGrupo").html(msg)
            }
        })
    }


    // cargarBusqueda();


    $("#categoriaId").change(function () {
        cargarBusqueda();
    });


    function cargarBusqueda() {
        var cat = $("#categoria option:selected").val();
        var sub = $("#subcategoria option:selected").val();
        var grp = $("#grupo option:selected").val();
        $("#detalle").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        $.ajax({
            type: "POST",
            url: "${g.createLink(controller: 'producto', action: 'tablaBuscar')}",
            async: true,
            data: {
                criterio: $("#criterio").val(),
                categoria: cat,
                subcategoria: sub,
                grupo: grp
            },
            success: function (msg) {
                $("#detalle").html(msg);
            },
            error: function (msg) {
                $("#detalle").html("Ha ocurrido un error");
            }
        });
    }

    $("#btnBusqueda").click(function () {
        cargarBusqueda();
    });

    $("input").keyup(function (ev) {
        if (ev.keyCode == 13) {
            $("#btnBusqueda").click();
        }
    });

    function createContextMenu(node) {
        var $tr = $(node);
        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var id = $tr.data("id");

        // console.log('id', id, 'tr', $tr)
        var editar = {
            label: "Editar",
            icon: "fa fa-edit",
            separator_before : true,
            action : function ($element) {
                var id = $element.attr("id");
                location.href="${createLink(controller: 'producto', action: 'form')}?id=" + id
            }
        };

        var aprobar = {
            label: "Aprobar",
            icon: "fa fa-check",
            separator_before : true,
            action : function ($element) {
                var id = $element.data("id");
                console.log('pago--id', id)
                verPago(id);
            }
        };

        /*
                var administrar = {
                    label: "Administrar",
                    icon: "fa fa-pencil",
                    separator_before : true,
                    submenu: {
                        editar
                    }
                };
        */

        // items.administrar = administrar;
        items.editar = editar;
        if("{data.prod__id}") items.aprobara = aprobar;

        return items
    }

    $("#btnLimpiarBusqueda").click(function () {
        $(".fechaD, .fechaH, #criterio_con").val('');
    });

    $("#nuevo").click(function () {
        createEditRow(null);
    });

    $("#buscador_con").change(function(){
        var anterior = "${params.operador}";
        var opciones = $(this).find("option:selected").attr("class").split(",");

        poneOperadores(opciones);
    });

    function cargarFechas (id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'reportes', action:'fechasDetalle_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgFechasDetalle",
                    title   : "Período para el detalle de Pagos",
//                    class   : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar : {
                            label     : "<i class='fa fa-print'></i> Imprimir",
                            className : "btn-success",
                            callback  : function () {
                                var hasta = $("#fechaHastaDet").val();
                                var desde = $("#fechaDesdeDet").val();
                                location.href='${createLink(controller: 'reportes', action: 'reporteDetallePagos')}?id=' + id + "&desde=" + desde + "&hasta=" + hasta ;
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 100);
            } //success
        }); //ajax
    }

    function poneOperadores (opcn) {
        var $sel = $("<select name='operador' id='oprd' style='width: 120px' class='form-control'>");
        for(var i=0; i<opcn.length; i++) {
            var opt = opcn[i].split(":");
            var $opt = $("<option value='"+opt[0]+"'>"+opt[1]+"</option>");
            $sel.append($opt);
        }
        $("#selOpt").html($sel);
    };

    /* inicializa el select de oprd con la primea opción de busacdor */
    $(document).ready(function() {
        $("#buscador_con").change();
    });

    function verPago(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'anuncio', action:'revisarPago_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgRevisaPago",
                    title   : "Ver constancia de Pago y Aprobaciónde anuncio",
                    message : msg,
                    // class : "modal-lg",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        Aceptar : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Aceptar el Anuncio",
                            className : "btn-success",
                            callback  : function () {
                                return aceptarAnuncio(id);
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    };



    function aceptarAnuncio(id) {
        var l1 = cargarLoader("Procesando...");
        bootbox.dialog({
            title   : "Aceptar producto",
            message : "<i class='fa fa-check fa-3x pull-left text-warning text-shadow'></i>" +
                "<span style='font-size: 14px; font-weight: bold'>&nbsp;¿Está seguro que desea aceptar " +
                "el anuncio de este producto?.</span>",
            buttons : {
                cancelar : {
                    label     : "<i class='fa fa-times'></i> Cancelar",
                    className : "btn-gris",
                    callback  : function () {
                    }
                },
                aceptar : {
                    label     : "<i class='fa fa-check'></i> Aceptar",
                    className : "btn-rojo",
                    callback  : function () {
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'anuncio', action: 'aceptarAnuncio_ajax')}',
                            data:{
                                id: id
                            },
                            success: function (msg){
                                l1.modal("hide");
                                if(msg == 'ok'){
                                    bootbox.dialog({
                                        title   : "Confirmación",
                                        message : "<i class='fa fa-thumbs-up fa-3x pull-left text-warning text-shadow'>" +
                                            "</i><p>&nbsp; Anuncio revisado correctamente</p>",
                                        buttons : {
                                            aceptar : {
                                                label     : "<i class='fa fa-check'></i> Aceptar",
                                                className : "btn-gris",
                                                callback  : function () {
                                                    %{--location.href="${createLink(controller: 'anuncio', action: 'revisados')}?id=" + id--}%
                                                    location.reload()
                                                }
                                            }
                                        }
                                    });
                                }else{
                                    bootbox.alert("<i class='fa fa-times fa-3x pull-left text-warning text-shadow'>" +
                                        "</i><span style='font-size: 14px; font-weight: bold'>" +
                                        "&nbsp;Error al aceptar anuncio del producto</span>")
                                }
                            }
                        })
                    }
                }
            }
        });
    }

    function negarProducto(id) {
        bootbox.dialog({
            title   : "Negar producto",
            message : "<i class='fa fa-user-slash fa-2x pull-left text-warning text-shadow'></i><span style='font-size: 14px; font-weight: bold'>&nbsp; ¿Está seguro que desea negar el anuncio de este producto?.</span>",
            buttons : {
                cancelar : {
                    label     : "<i class='fa fa-times'></i> Cancelar",
                    className : "btn-gris",
                    callback  : function () {
                    }
                },
                aceptar : {
                    label     : "<i class='fa fa-check'></i> Aceptar",
                    className : "btn-rojo",
                    callback  : function () {
                        var l2 = cargarLoader("Procesando...");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller: 'anuncio', action:'negarAnuncio_ajax')}",
                            data    : {
                                id:id
                            },
                            success : function (msg) {
                                l2.modal("hide")
                                if(msg == 'ok'){
                                    log("Producto negado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
                                }else{
                                    log("Error al negar el producto","error")
                                }
                            } //success
                        }); //ajax
                    }
                }
            }
        });
    } //createEdit

    function quitarAnuncio(itemId, prod) {
        bootbox.dialog({
            title   : 'Dejar de Publicar: "' + prod + '"',
            message : "<i class='fas fa-skull-crossbones fa-3x pull-left text-danger text-shadow caja50'></i>" +
                "<p class='aviso'>¿Está seguro que desea dejar de publicar: <strong>" + prod + "</strong>?<br>" +
                "<strong>Esta acción no se puede deshacer</strong>.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fas fa-skull-crossbones'></i> Quitar Publicación",
                    className : "btn-danger",
                    callback  : function () {
                        var l1 = cargarLoader("Eliminando");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'producto', action:'quitarAnuncio_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                l1.modal("hide");
                                // console.log('msg', msg)
                                if (msg == "ok") {
                                    log("Anuncio eliminado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
                                } else {
                                    log("Error al desactivar el Anuncio","error");
                                }
                            }
                        });
                    }
                }
            }
        });
    }



</script>

</body>
</html>