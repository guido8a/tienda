<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/01/22
  Time: 15:03
--%>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Tipos de Proceso</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">

    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametros"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo tipo de Proceso
        </g:link>
    </div>
</div>

<div class="vertical-container vertical-container-list">
    <p class="css-vertical-text">Lista de Tipos de Proceso</p>

    <div class="linea"></div>
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th style="width: 15%">Código</th>
            <th style="width: 70%">Descripción</th>
            <th style="width: 15%">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tipoPagoInstanceList}" status="i" var="tipoPagoInstance">
            <tr data-id="${tipoPagoInstance.id}">

                <td>${fieldValue(bean: tipoPagoInstance, field: "codigo")}</td>
                <td>${fieldValue(bean: tipoPagoInstance, field: "descripcion")}</td>

                <td style="text-align: center">
                    <a href="#" data-id="${tipoPagoInstance.id}" class="btn btn-success btn-sm btn-edit btn-ajax" title="Editar">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a href="#" data-id="${tipoPagoInstance.id}" class="btn btn-danger btn-sm btn-delete btn-ajax" title="Eliminar">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmTipoProceso");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    closeLoader();
                    if (msg == "ok") {
                        log("Tipo de proceso guardado correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    } else {
                        if(msg == 'er'){
                            bootbox.alert("Código ya existente");
                        }else{
                            log("Error al guardar el tipo de proceso","error");
                            return false;
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
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Tipo de proceso seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                closeLoader();
                                if (msg == "ok") {
                                    log("Tipo de proceso borrado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1000);
                                } else {
                                    log("Error al borrar el tipo de proceso","error");
                                    return false;
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
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Tipo de proceso",
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

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

        $(".btn-edit").click(function () {
            var id = $(this).data("id");
            createEditRow(id);
        });
        $(".btn-delete").click(function () {
            var id = $(this).data("id");
            deleteRow(id);
        });

    });
</script>

</body>
</html>
