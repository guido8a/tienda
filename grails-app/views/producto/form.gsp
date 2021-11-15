<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 14:37
--%>

<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <meta name="layout" content="main">
    <title>Producto</title>

    <ckeditor:resources/>

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

    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        text-align: right;
    }

    .sobrepuesto {
        position: absolute;
        top: 3px;
        font-size: 14px;
    }

    .negrita {
        font-weight: bold;
    }

    .izquierda{
        margin-left: 4px;
    }
    </style>

</head>

<body>

<div style="text-align: center; margin-top: -20px;margin-bottom:20px">
    <h3>${producto?.titulo ? ("Producto: "  + producto?.titulo) : 'Nuevo Producto'}</h3>
</div>

<div class="panel panel-primary col-md-12">

    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: left">
        <div class="btn-group">
            <a href="${createLink(controller: 'producto', action: 'list')}" id="btnSalir"
               class="btn btn-sm btn-warning" title="Regresar a la lista de productos">
                <i class="fa fa-arrow-left"></i> Regresar
            </a>
        </div>

        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar">
            <i class="fa fa-save"></i> Guardar
        </a>

        <a href="#" id="btnNuevo" class="btn btn-sm btn-info" title="Nuevo producto">
            <i class="fa fa-file"></i> Nuevo producto
        </a>

        <g:if test="${producto?.id}">
            <div class="btn-group" style="margin-left: 50px">
                <a href="${createLink(controller: 'atributo', action: 'list', id: producto?.id)}" id="btnAtributos"
                   class="btn btn-sm btn-warning" title="Lista de atributos ">
                    <i class="fa fa-list"></i> Atributos
                </a>
                <a href="${createLink(controller: 'imagen', action: 'list', id: producto?.id)}" id="btnImagenes"
                   class="btn btn-sm btn-success" title="Lista de imágenes ">
                    <i class="fa fa-image"></i> Imágenes
                </a>
            </div>
        </g:if>

    </div>

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmProducto" role="form" method="POST" controller="curso" action="saveCurso_ajax">
                <g:hiddenField name="id" value="${producto?.id}"/>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-1 label label-primary text-info mediano">Categoría</span>
                        <div class="col-md-3">
                            <g:select name="categoria" from="${tienda.Categoria.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control" value="${producto?.grupo?.subcategoria?.categoria?.id}"/>
                        </div>

                        <span class="col-md-1 label label-primary text-info mediano">Subcategoria</span>
                        <div class="col-xs-3 col-md-3" id="divSubcategoria">

                        </div>

                        <span class="col-md-1 label label-primary text-info mediano">Grupo</span>
                        <div class="col-xs-3 col-md-3" id="divGrupo">

                        </div>
                    </div>
                </div>


                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-1 label label-primary text-info mediano">Título</span>
                        <div class="col-md-8">
                            <g:textField name="titulo" maxlength="255" class="form-control required" value="${producto?.titulo}"/>
                        </div>

                        <span class="col-md-1 label label-primary text-info mediano">Promoción</span>
                        <div class="col-md-2">
                            <span class="grupo">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input des" type="checkbox" name="destacado" ${producto?.destacado == 'S' ? 'checked' : ''}>
                                </div>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-1 label label-primary text-info mediano">Subtítulo</span>
                        <div class="col-md-8">
                            <span class="grupo">
                                <g:textField name="subtitulo" maxlength="255" class="form-control" value="${producto?.subtitulo}"/>
                            </span>
                        </div>
                        <span class="col-md-1 label label-primary text-info mediano">Estado</span>
                        <div class="col-md-2">
                            <span class="grupo">
                                <g:textField name="estado_name" class="allCaps form-control" value="${producto?.estado == 'A' ? 'Activo' : 'Inactivo'}" readonly="true"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-1 label label-primary text-info mediano">Texto</span>
                        <div class="col-md-8">
                            <span class="grupo">
%{--                                <g:textArea name="texto" class="form-control" value="${producto?.texto}" style="resize: none; height: 200px"/>--}%
                                <textarea name='texto' id="texto" class="editor">${producto?.texto}</textarea>
                            </span>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    $.switcher('input[type=checkbox]');

    CKEDITOR.replace( 'texto', {
         height                  : 150,
         width                   : 1000,
         resize_enabled          : false,
         language: 'es',
         uiColor: '#9AB8F3',
         extraPlugins: 'entities',
         toolbar                 : [
             ['FontSize', 'Scayt', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
             ['Bold', 'Italic', 'Underline','Subscript', 'Superscript'],
             ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-']
         ]
     });

    $("#btnNuevo").click(function (){
        location.href="${createLink(controller: 'producto', action: 'form')}"
    });

    $("#btnGuardar").click(function () {
        var texto = CKEDITOR.instances.texto.getData();
        var $form = $("#frmProducto");
        var destacado = $(".des").is(":checked");
        if ($form.valid()) {
            if($("#grupo option:selected").val() == '' || $("#grupo option:selected").val() == null){
                bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i> Seleccione un grupo")
            }else{
                var r = cargarLoader("Grabando");
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'producto', action: 'guardarProducto_ajax')}',
                    data: $form.serialize() + "&texto2=" + texto + "&destacado2=" + destacado,
                    success: function (msg) {
                        r.modal("hide");
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            log("Producto guardado correctamente", "success");
                            setTimeout(function () {
                                location.href="${createLink(controller: 'producto', action: 'form')}?id=" + parts[1]
                            }, 1100);
                        }else{
                            log("Error al guardar el producto","error")
                        }
                    }
                });
            }
        }
    });

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
                id: categoria,
                tipo: 1,
                sub: '${producto?.grupo?.subcategoria?.id}'
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
                id: subcategoria,
                tipo: 1,
                gru: '${producto?.grupo?.id}'
            },
            success: function (msg) {
                $("#divGrupo").html(msg)
            }
        })
    }






    $(function () {
        $("#limpiaBuscar").click(function () {
            $("#buscar").val('');
        });
    });

    <g:if test="${areas}">
    cargarBusqueda();
    </g:if>
    <g:else>
    $("#mensaje").removeClass('hidden').append("No existen registros");
    </g:else>


    $("#categoriaId").change(function () {
        cargarBusqueda();
    });


    function cargarBusqueda() {
        var area = $("#areas option:selected").val();
        var nvel = $("#niveles option:selected").val();
        $("#detalle").html("").append($("<div style='width:100%; text-align: center;'/>").append(spinnerSquare64));
        $.ajax({
            type: "POST",
            url: "${g.createLink(controller: 'admnParticipante', action: 'tablaBuscar')}",
            data: {
                buscador: $("#buscador_con").val(),
                ordenar: $("#ordenar_por").val(),
                criterio: $("#criterio_con").val(),
                operador: $("#oprd").val(),
                area: area,
                nvel: nvel
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

        console.log('id', id, 'tr', $tr)
        var detalle = {
            label: "Detalle Pagos",
            icon: "fa fa-print",
            separator_before : true,
            action : function ($element) {
                var id = $element.data("id");
                console.log('--id', id)
                cargarFechas(id);
            }
        };

        var pago = {
            label: "Pagos",
            icon: "fa fa-dollar-sign",
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
        items.detalle = detalle;
        if("{data.pago__id}") items.pago = pago;

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






</script>

</body>
</html>