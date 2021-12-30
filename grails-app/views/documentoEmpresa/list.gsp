<%@ page import="sri.Proceso" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/12/21
  Time: 10:08
--%>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Libretines de Facturas</title>
    <style type="text/css">
    .centrado{
        text-align: center;
    }
    .derecha{
        text-align: right;
    }

    </style>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="inicio" action="parametros"><i class="fa fa-arrow-left"></i> Regresar</g:link>
        <g:link action="form" class="btn btn-info btnCrear">
            <i class="fa fa-file"></i> Nuevo libretín
        </g:link>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th>Tipo</th>
        <th>Autorización</th>
        <th>Establecimiento</th>
        <th>Emisión</th>
        <th>Número Desde</th>
        <th>Número Hasta</th>
        <th>Fecha Autorización</th>
        <th>Válido Hasta</th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${session.perfil.nombre == 'Administrador'}">
        <g:each in="${documentoEmpresaInstanceList}" status="i" var="documentoEmpresaInstance">
            <g:if test="${documentoEmpresaInstance.empresa.id == session.empresa.id}">
                <tr data-id="${documentoEmpresaInstance.id}" data-usado="${sri.Proceso.findByDocumentoEmpresa(documentoEmpresaInstance)?.id > 0}">
                    <td>${documentoEmpresaInstance?.tipo == 'F'? 'Factura' : (documentoEmpresaInstance?.tipo == 'R'? 'Retención' : (documentoEmpresaInstance?.tipo == 'ND'? 'Nota de Débito' : 'Nota de Cŕedito'))}</td>
                    <td>${fieldValue(bean: documentoEmpresaInstance, field: "autorizacion")}</td>
                    <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroEstablecimiento")}</td>
                    <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroEmision")}</td>
                    <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroDesde")}</td>
                    <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroHasta")}</td>
                    <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaAutorizacion}" format="dd-MM-yyyy" /></td>
                    <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaFin}" format="dd-MM-yyyy" /></td>
                </tr>
            </g:if>
        </g:each>
    </g:if>
    <g:else>
        <g:each in="${documentoEmpresaInstanceList}" status="i" var="documentoEmpresaInstance">
            <tr data-id="${documentoEmpresaInstance.id}">
                <td>${documentoEmpresaInstance?.tipo == 'F'? 'Factura' : (documentoEmpresaInstance?.tipo == 'R'? 'Retención' : (documentoEmpresaInstance?.tipo == 'ND'? 'Nota de Débito' : 'Nota de Cŕedito'))}</td>
                <td>${fieldValue(bean: documentoEmpresaInstance, field: "autorizacion")}</td>
                <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroEstablecimiento")}</td>
                <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroEmision")}</td>
                <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroDesde")}</td>
                <td class="derecha">${fieldValue(bean: documentoEmpresaInstance, field: "numeroHasta")}</td>
                <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaAutorizacion}" format="dd-MM-yyyy" /></td>
                <td class="centrado"><g:formatDate date="${documentoEmpresaInstance.fechaFin}" format="dd-MM-yyyy" /></td>
            </tr>
        </g:each>
    </g:else>
    </tbody>
</table>


<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmDocumentoEmpresa");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log(parts[1], 'success');
                        setTimeout(function () {
                            location.reload(true);
                        }, 1500);

                    } else {
                        if(parts[1] == '2'){
                            bootbox.alert(parts[2]);
                            return false;
                        }else{
                            log(parts[2],'error');
                            return false;
                        }
                        return false;
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
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el libretín seleccionado? Esta acción no se puede deshacer.</p>",
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
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] == "OK") {
                                    log(parts[1], 'success');
                                    setTimeout(function () {
                                        location.reload(true);
                                    }, 1500);

                                } else {
                                    log(parts[1],'error')
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
        var data = id ? { id: id, empresa: '${empresa?.id}' } : {empresa: '${empresa?.id}'};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Libretín de Facturas",
                    class: 'long',
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
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function verificar (id){
        var jqXHR =   $.ajax({
            type: 'POST',
            async: false,
            url: '${createLink(controller: 'documentoEmpresa', action: 'verificar_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                return msg
            }
        });

        return jqXHR.responseText
    }

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });


        function createContextMenu(node) {
            var $tr = $(node);
            var id = $tr.data("id");
            var usado = $tr.data("usado");

            var items = {
                header : {
                    label  : "Acciones",
                    header : true
                }
            };

            var ver = {
                label   : 'Ver',
                icon   : "fa fa-search",
                action : function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'show_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Ver Libretín de Facturas",
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
                label   : 'Editar',
                icon   : "fa fa-edit",
                action : function () {
                    createEditRow(id);
                }
            };

            var eliminar = {
                label  : 'Eliminar',
                icon   : "fa fa-trash",
                action: function () {
                    deleteRow(id);
                }
            };

            // items.ver = ver;

            if(verificar(id) == 'false'){
                items.editar = editar;
                items.eliminar = eliminar;
            }

            // if(!usado){
            //     items.editar = editar;
            //     items.eliminar = eliminar;
            // }

            return items

        }


    });
</script>

</body>
</html>
