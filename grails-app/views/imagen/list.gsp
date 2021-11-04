<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/11/21
  Time: 13:27
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/11/21
  Time: 10:19
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

<div class="btn-group">
    <a href="${createLink(controller: 'producto', action: 'form', id: producto?.id)}" id="btnRegresarForm"
       class="btn btn-sm btn-warning" title="Regresar al producto">
        <i class="fa fa-arrow-left"></i> Regresar
    </a>
</div>

<div style="text-align: center; margin-top: -20px;margin-bottom:20px">
    <h3>Administración de Imágenes del producto: ${producto?.titulo}</h3>
</div>

<div style="margin-top: 30px; min-height: 650px" class="vertical-container">
    <p class="css-vertical-text">Imágenes</p>

    <div class="linea"></div>
%{--    <table class="table table-bordered table-hover table-condensed" style="width: 100%">--}%
%{--        <thead>--}%
%{--        <tr>--}%
%{--            <th class="alinear" style="width: 15%">Orden</th>--}%
%{--            <th class="alinear" style="width: 85%">Descripción</th>--}%
%{--        </tr>--}%
%{--        </thead>--}%
%{--        <tbody>--}%
%{--        <g:each in="${atributos}" status="i" var="atributo">--}%
%{--            <tr data-id="${atributo.id}">--}%
%{--                <td style="width: 15%">${atributo?.orden}</td>--}%
%{--                <td style="width: 85%">${atributo?.descripcion}</td>--}%
%{--            </tr>--}%
%{--        </g:each>--}%
%{--        </tbody>--}%
%{--    </table>--}%




    <div class="col-md-12" style="margin-bottom: 10px">
%{--        <h3> Agregar imágenes de su producto '${producto.titulo}'</h3>--}%

        <a href="#" class="btn btn-rojo" id="btnImasProducto" title="Imágenes asociadas al producto">
            <i class="fa fa-images"></i> Agregar o Editar las imágenes
        </a>

        <g:if test="${producto?.id}">
            <g:if test="${tam > 0}">
                <div class="col-md-12">
                    <div id="carrusel">
                        <a href="#" class="left-arrow"><asset:image src="apli/left-arrow.png" title='Anterior'/></a>
                        <a href="#" class="right-arrow"><asset:image src="apli/right-arrow.png" title='Siguiente'/></a>
                        <div class="carrusel">
                            <g:each in="${imagenes}" var="im" status="i">
                                <div class="product" id="product_${i+1}">
                                    <img src="${createLink(controller: 'producto', action: 'getImage', params: [id: "${im.file}", pro: producto?.id] )}"  width="120" height="80" title="${im.file}"/>
                                </div>
                            </g:each>
                        </div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-md-12" style="margin-top: 40px">

                </div>
            </g:else>
        </g:if>

    </div>



</div>

<script type="text/javascript">


    $("#btnNuevoAtributo").click(function() {
        createEditRow();
        return false;
    });


    function submitForm() {
        var $form = $("#frmAtributo");
        if ($form.valid()) {
            var r = cargarLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'atributo', action:'saveAtributo_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    r.modal("hide");
                    var parts =  msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Atributo guardado correctamente","success");
                        setTimeout(function () {
                            location.reload(true)
                        }, 1000);
                    }else{
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i> El número de orden ya se encuentra ingresado")
                        }else{
                            log("Error al guardar el atributo", "error")
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el atributo seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var v = cargarLoader("Eliminando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'deleteAtributo_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                if(msg == 'ok'){
                                    log("Atributo borrado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    log("Error al borrar el atributo","error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id} : {producto: '${producto?.id}'};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'atributo', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Atributo",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit


    function createContextMenu(node) {
        var $tr = $(node);
        var items = {
            header: {
                label: "Acciones",
                header: true
            }
        };

        var id = $tr.data("id");

        var editar = {
            label: "Editar",
            icon: "fa fa-edit",
            separator_before : true,
            action : function ($element) {
                var id = $element.data("id");
                createEditRow(id)
            }
        };

        var eliminar = {
            label: "Eliminar",
            icon: "fa fa-trash",
            separator_before : true,
            action : function ($element) {
                var id = $element.data("id");
                deleteRow(id);
            }
        };

        items.editar = editar;
        items.eliminar = eliminar;


        return items
    }

    $("tr").contextMenu({
        items  : createContextMenu,
        onShow : function ($element) {
            $element.addClass("trHighlight");
        },
        onHide : function ($element) {
            $(".trHighlight").removeClass("trHighlight");
        }
    });


</script>

</body>
</html>