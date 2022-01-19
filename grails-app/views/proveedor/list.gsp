<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/01/22
  Time: 9:55
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Proveedores</title>
</head>
<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="index"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo Proveedor
        </g:link>
    </div>
</div>

<div style="margin-top: 25px;" class="vertical-container">
    <p class="css-icono" style="margin-bottom: -10px"><i class="fa fa-truck"></i></p>

    <div class="linea45"></div>

    <div class="row" style="margin-bottom: 10px;">

        <div class="col-md-3" style="text-align: center">
            <div class="col-md-2">
                <b>RUC:</b>
            </div>
            <div class="col-md-3">
                <g:textField name="ruc_name" id="rucProveedor" class="form-control" value="" style="width: 150px"/>
            </div>
        </div>

        <div class="col-md-3" style="margin-left: -70px">
            <div class="col-md-3">
                <b>Nombre:</b>
            </div>
            <div class="col-md-3">
                <g:textField name="nombre_name" id="nombreProveedor" class="form-control" value="" style="width: 300px"/>
            </div>
        </div>

        <div class="btn-group col-md-2" style="margin-left: 140px">
            <a href="#" name="busqueda" class="btn btn-info btnBusquedaP btn-ajax">
                <i class="fa fa-search"></i> Buscar</a>

            <a href="#" name="limpiarBus" class="btn btn-warning btnLimpiarBusquedaP btn-ajax" title="Borrar criterios de búsqueda" style="height: 34px">
                <i class="fa fa-eraser"></i></a>
        </div>

    </div>
</div>

<div style="margin-top: 30px; min-height: 450px" class="vertical-container">
    <p class="css-vertical-text">Proveedores</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 100%">
        <thead>
        <tr>
            <th style="width: 13%">Ruc</th>
            <th style="width: 33%">Nombre</th>
            <th style="width: 11%">Tipo</th>
            <th style="width: 10%">Identificación</th>
            <th style="width: 20%">Dirección</th>
            <th style="width: 13%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divProveedores">
    </div>
</div>


<script type="text/javascript">

    cargarProveedores();

    $(".btnBusquedaP").click(function () {
        cargarProveedores();
    });

    function cargarProveedores(){
        var ruc = $("#rucProveedor").val();
        var nombre = $("#nombreProveedor").val();
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proveedor', action: 'tablaProveedor_ajax')}',
            data:{
                ruc: ruc,
                nombre: nombre
            },
            success: function (msg){
                $("#divProveedores").html(msg)
            }
        });
    }

    $(".btnLimpiarBusquedaP").click(function (msg) {
        $("#nombreProveedor").val('');
        $("#rucProveedor").val('');
        cargarProveedores();
    });


    function submitForm() {
        var $form = $("#frmProveedor");
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
                        log("Proveedor guardado correctamente","success");
                        cargarProveedores();
                    } else {
                        log("Error al guardar el proveedor","error");
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
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
                    title   : title + " Proveedor",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
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

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Proveedor seleccionado? Esta acción no se puede deshacer.</p>",
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
                                    log("Proveedor borrado correctamente","success");
                                    cargarProveedores();
                                } else {
                                    log("Error al borrar el proveedor","error");
                                    spinner.replaceWith($btn);
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

    });


</script>

</body>
</html>


