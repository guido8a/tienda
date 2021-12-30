<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/10/21
  Time: 10:05
--%>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Empresa</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="index"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:if test="${band == 1}">
            <g:link action="form" class="btn btn-info btnCrear">
                <i class="fa fa-file"></i> Nueva empresa
            </g:link>
        </g:if>
    </div>
</div>

<table class="table table-condensed table-bordered">
    <thead>
    <tr>
        <th>RUC</th>
        <th>Nombre</th>
        <th>Sigla</th>
        <th>Email</th>
        <th>Teléfono</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${empresas}" status="i" var="empresa">
        <tr data-id="${empresa.id}">
            <td>${empresa?.ruc}</td>
            <td>${empresa?.nombre}</td>
            <td>${empresa?.sigla}</td>
            <td>${empresa?.mail}</td>
            <td>${empresa?.telefono}</td>
        </tr>
    </g:each>
    </tbody>
</table>

%{--<elm:pagination total="${empresaInstanceCount}" params="${params}"/>--}%

<script type="text/javascript">

    var id = null;
    function submitForm() {
        var $form = $("#frmEmpresa");
        if ($form.valid()) {
            var r = cargarLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'empresa', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    r.modal("hide");
                    var parts =  msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Empresa guardada correctamente","success");
                        setTimeout(function () {
                            location.reload(true)
                        }, 1000);
                    }else{
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i> El número de RUC ya se encuentra ingresado")
                        }else{
                            log("Error al guardar la empresa", "error")
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
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la empresa seleccionada? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                v.modal("hide");
                                if(msg == 'ok'){
                                    log("Empresa borrada correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    log("Error al borrar la empresa","error")
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
            // crossDomain: true,
            // dataType:'jsonp',
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Empresa",
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

    function cargarImagenesEmpresa(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'imagenesEmpresa_ajax')}",
            data    : {
                id:id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgImas",
                    title   : "Imágenes de la empresa",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {

                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function createEditRowCont(id) {

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'formContabilidad')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditCont",
                    title   : "Datos de contabilidad de la empresa",
                    class: "modal-lg",
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
                                return submitFormCont();
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

    function sucursalesForm(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'sucursales_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditSuc",
                    title   : "Sucursales de la empresa",
                    class: "modal-lg",
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
                                return submitFormSuc();
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

    function submitFormCont() {
        var $form = $("#frmEmpresaCont");
        if ($form.valid()) {
            var r = cargarLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'empresa', action:'saveFormCont_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    r.modal("hide");
                    var parts =  msg.split("_");
                    if(parts[0] == 'ok'){
                        log("Datos guardados correctamente","success");
                        setTimeout(function () {
                            location.reload(true)
                        }, 1000);
                    }else{
                        log("Error al guardar los datos", "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
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

            var ver = {
                label: " Ver",
                icon: "fa fa-search",
                action: function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller: 'empresa', action:'show_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Empresa",
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

            var editar = {
                label: " Editar",
                icon: "fa fa-edit",
                action: function () {
                    createEditRow(id)
                }
            };

            var contabilidad = {
                label: " Contabilidad",
                icon: "fa fa-book",
                separator_before : true,
                action: function () {
                    createEditRowCont(id)
                }
            };

            var sucursales = {
                label: " Establecimientos",
                icon: "fa fa-building",
                separator_before : true,
                action: function () {
                    sucursalesForm(id)
                }
            };

            var documentos = {
                label: " Secuenciales de facturas",
                icon: "fa fa-envelope",
                separator_before : true,
                action: function () {
                    location.href="${createLink(controller: 'documentoEmpresa', action: 'list')}/" + id;
                }
            };

            var usuarios = {
                label: " Usuarios",
                icon: "fa fa-user",
                separator_before : true,
                action: function () {
                    location.href="${createLink(controller: 'persona', action: 'list')}/" + id;

                }
            };

            var imagenes = {
                label: " Imágenes",
                icon: "fa fa-images",
                separator_before : true,
                action: function () {
                    cargarImagenesEmpresa(id);
                }
            };

            var eliminar = {
                label: " Eliminar",
                icon: "fa fa-trash",
                separator_before : true,
                action: function () {
                    deleteRow(id);
                }
            };

            items.ver = ver;
            items.editar = editar;
            items.contabilidad = contabilidad;
            items.sucursales = sucursales;
            items.documentos = documentos;
            items.usuarios = usuarios;
            items.imagenes = imagenes;

            <g:if test="${band == 1}">
            items.eliminar = eliminar;
            </g:if>

            return items
        }


        $(function () {
            $("tr").contextMenu({
                items  : createContextMenu,
                onShow : function ($element) {
                    $element.addClass("trHighlight");
                },
                onHide : function ($element) {
                    $(".trHighlight").removeClass("trHighlight");
                }
            });
        });

    });
</script>

</body>
</html>
