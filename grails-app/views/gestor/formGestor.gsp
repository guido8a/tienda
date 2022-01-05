<%@ page import="sri.TipoProceso; sri.TipoComprobante; sri.Fuente" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>${titulo}</title>

    <style type="text/css">
    .fila {
        width: 100%;
        min-height: 40px;
    }

    .label {
        width: 80px;
        float: left;
        height: 30px;
        line-height: 30px;
        color: #000000;
        font-size: inherit;
        text-align: left;
        margin-left: 0px;
    }

    .campo {
        width: 670px;
        float: right;
        min-height: 40px;
    }

    .letraP {
        font-size: 10px;
    }
    </style>

    <asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

</head>

<body>

<g:if test="${flash.message}">
    <div class="alert ${flash.tipo == 'error' ? 'alert-danger' : flash.tipo == 'success' ? 'alert-success' : 'alert-info'} ${flash.clase}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:if test="${flash.tipo == 'error'}">
            <i class="fas fa-exclamation-triangle fa-2x pull-left"></i>
        </g:if>
        <g:elseif test="${flash.tipo == 'success'}">
            <i class="fa fa-check-square fa-2x pull-left"></i>
        </g:elseif>
        <g:elseif test="${flash.tipo == 'notFound'}">
            <i class="icon-ghost fa-2x pull-left"></i>
        </g:elseif>
        <p>
            ${flash.message}
        </p>
    </div>
</g:if>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="gestor" action="buscarGstr"><i class="fa fa-arrow-left"></i> Gestores</g:link>

        <g:if test="${band}">
            <g:if test="${gestorInstance?.estado != 'R'}">
                <a href="#" id="btnGuardar" class="btn btn-success">
                    <i class="fa fa-save"></i>
                    Guardar
                </a>
                <a href="#" id="btnRegistrar" class="btn btn-info hidden">
                    <i class="fa fa-check"></i>
                    Registrar
                </a>
                <g:link action="deleteGestor" id="${gestorInstance?.id}" class="btn btn-danger" name="eliminarGestor">
                    <i class="fa fa-trash"></i>
                    Eliminar
                </g:link>
            </g:if>
            <g:else>
                <g:if test="${gestorInstance?.estado == 'R'}">
                    <a href="#" id="btnDesRegistrar" class="btn btn-info">
                        <i class="fa fa-times"></i>
                        Desregistrar
                    </a>
                </g:if>
            </g:else>
        </g:if>
    </div>
</div>

<div class="vertical-container" style="margin-top: 25px;color: black">
    <p class="css-vertical-text">Gestor</p>

    <div class="linea"></div>
    <div id="contenido">

        <div class="fila">
            <div class="col-xs-2 negrilla">
                Nombre:
            </div>

            <div class="col-xs-10 negrilla">
                <input name="nombre_name" id="nombre" type="text" value="${gestorInstance?.nombre}" maxlength="127"
                       class="form-control required"/>
            </div>
        </div>

        <div class="fila">
            <div class="col-xs-2 negrilla">
                Observaciones:
            </div>

            <div class="col-xs-10 negrilla">
                <input name="observaciones_name" id="observaciones" type="textArea" class="form-control"
                       value="${gestorInstance?.observaciones}"
                       maxlength="125"/>
            </div>
        </div>

        <div class="fila">
            <div class="col-xs-2 negrilla">
                Fuente:
            </div>

            <div class="col-xs-3 negrilla" style="margin-left: 0">
                <g:select name="fuente.id" type="select" campo="fuente"
                          from="${sri.Fuente.list([sort: 'descripcion'])}"
                          label="Fuente: " value="${gestorInstance?.fuente?.id}" optionKey="id"
                          optionValue="descripcion"
                          class="form-control required col-md-3" id="fuenteGestor" />
            </div>

            <div class="col-xs-1 negrilla">
            </div>
            <div class="col-xs-2 negrilla">
                Tipo de detalle:
            </div>

            <div class="col-xs-2 negrilla" style="margin-left: 0">
                <g:select class="form-control required tipoD" from="${tipo}" optionValue="value" optionKey="key"
                          name="tipoD_name" value="${gestorInstance?.tipo?:-1}"
                          disabled="${gestorInstance?.estado == 'R'}" title="Tipo de Detalle"/>
            </div>

        </div>

        <div class="fila">
            <div class="col-xs-2 negrilla">
                Tipo de proceso:
            </div>

            <div class="col-xs-3 negrilla">
                <g:select class="form-control required cmbRequired tipoProcesoSel" name="tipoProceso" id="tipoProceso"
                          from="${sri.TipoProceso.list(sort: 'codigo')}" label="Proceso tipo: "
                          value="${gestorInstance?.tipoProceso?.id}" optionKey="id"
                          optionValue="descripcion" title="Tipo de proceso o transacción"
                          disabled="${gestorInstance?.estado == 'R'}"/>
            </div>

            <g:if test="${!gestorInicial || gestorInicial.id == gestorInstance?.id}">
                <div class="col-xs-3 negrilla hidden" id="divS">
                    Gestor para saldos iniciales:
                </div>
                <div class="col-xs-2 negrilla hidden" id="divSI">
                    <g:checkBox name="saldoIni_name" id="saldoIni" class="form-control salIni" data-on-Label="Si" checked="${gestorInstance?.codigo == 'SLDO' ?: false}"/>
                </div>
            </g:if>
        </div>
    </div>
</div>

<g:if test="${gestorInstance?.id}">
    <div class="vertical-container" style="margin-top: 25px;color: black; height: 500px">
        <p class="css-vertical-text">Comprobantes y Asientos a generarse</p>

        <div class="linea"></div>

        <div class="contenido">

            <div class="col-md-12" style="margin-bottom: 10px">
                <div class="label col-md-3">
                    Tipo de comprobante:
                </div>

                <div class="col-md-3">
                    <span class="grupo">
                        <g:select name="tipoCom" campo="tipo"
                                  from="${sri.TipoComprobante.list([sort: 'descripcion'])}"
                                  label="Tipo comprobante: " value="${''}" optionKey="id" id="tipo"
                                  class="form-control required col-md-2"
                                  optionValue="descripcion" style="margin-left: 80px; font-weight: bold"/>
                    </span>
                </div>
                <span class="col-md-1">

                </span>

                <g:if test="${gestorInstance}">
                <strong> Genera comprobantes de: </strong>  ${tieneAsientos?.sort{it?.tipoComprobante?.descripcion}?.tipoComprobante?.descripcion?.unique() ?: ''}
                </g:if>

                <g:if test="${(gestorInstance?.estado != 'R') && band}">
                    <div class="btn-group col-md-3">
                        <a href="#" id="btnAgregarMovimiento" class="btn btn-info" title="Agregar una cuenta al gestor">
                            <i class="fa fa-plus"></i> Agregar Cuenta
                        </a>
                    </div>
                </g:if>
            </div>
            <table class="table table-bordered table-hover table-condensed" width="1060">
                <thead>
                <tr>
                    <th style="width: 420px;" class="letraP">Código (Cuenta)</th>
                    <th style="width: 90px" class="letraP">% B. Imponible</th>
                    <th style="width: 90px" class="letraP">% B.I. Sin IVA</th>
                    <th style="width: 90px" class="letraP">Impuestos</th>
                    <th style="width: 90px" class="letraP">ICE</th>
                    <th style="width: 90px" class="letraP">Flete</th>
                    <th style="width: 80px" class="letraP">Valor</th>
                    <th style="width: 50px" class="letraP">D / H</th>
                    <th style="width: 110px" class="letraP"><i class="fa fa-pencil"></i></th>
                </tr>
                </thead>
            </table>


            <div class="row-fluid" style="width: 99.7%;height: 410px;overflow-y: auto;float: right; margin-top: -10px">
                <div class="span12">
                    <div id="cuentaAgregada" style="width: 1070px; height: 280px;"></div>
                </div>
            </div>
        </div>
    </div>
</g:if>



<script type="text/javascript">

    function revisarAsientos () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'gestor', action: 'revisarAsiento_ajax')}',
            data:{
                gestor: '${gestorInstance?.id}'
            },
            success: function (msg){
                if(msg == 'ok'){
                    $("#btnRegistrar").removeClass('hidden')
                }else{
                    $("#btnRegistrar").addClass('hidden')
                }
            }
        });
    }

    cargarCheck($(".tipoProcesoSel option:selected").val())

    $(".tipoProcesoSel").change(function () {
        var sel = $(this).val()
        cargarCheck(sel)
    });

    function cargarCheck (seleccionado) {
        if(seleccionado == '3'){
            $("#divS").removeClass('hidden')
            $("#divSI").removeClass('hidden')
        }else{
            $("#divS").addClass('hidden')
            $("#divSI").addClass('hidden')
        }

    }

    $(function() {
        $("#saldoIni").checkboxpicker({
        });
    });


    $("#btnRegistrar").click(function () {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-check fa-3x pull-left text-warning text-shadow'></i><p>¿Está seguro que desea registrar el gestor contable? </br> Una vez registrado, la información NO podrá ser cambiada.</p>",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-check'></i> Registrar",
                    className: "btn-success",
                    callback: function () {
                        openLoader("Registrando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'gestor', action: 'registrar_ajax')}',
                            data: {
                                id: '${gestorInstance?.id}'
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    log(parts[1], "success");
                                    setTimeout(function () {
                                        location.href = "${createLink(controller: 'gestor', action: 'formGestor')}/" + '${gestorInstance?.id}'
                                    }, 1000);
                                } else {
                                    log(parts[1], "error");
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    $("#btnDesRegistrar").click(function () {
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i><p>¿Está seguro que desea quitar el registro al gestor contable?",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='fa fa-times'></i> Desregistrar",
                    className: "btn-success",
                    callback: function () {
                        openLoader("Quitando Registro..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'gestor', action: 'desRegistrar_ajax')}',
                            data: {
                                id: '${gestorInstance?.id}'
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    log(parts[1], "success");
                                    setTimeout(function () {
                                        location.href = "${createLink(controller: 'gestor', action: 'formGestor')}/" + '${gestorInstance?.id}'
                                    }, 1000);
                                } else {
                                    log(parts[1], "error");
                                    closeLoader();
                                }
                            }
                        });
                    }
                }
            }
        });
    });

    $("#btnAgregarMovimiento").click(function () {
        var tipo = $("#tipo").val();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'gestor', action:'buscarMovimiento_ajax')}",
            data: {
                empresa: '${session.empresa.id}',
                id: '${gestorInstance?.id}',
                tipo: tipo
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgBuscar",
                    title: "Buscar cuenta",
                    class: "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });


    if ('${gestorInstance?.id}') {
        var tipoC = $("#tipo").val();
        cargarMovimientos('${gestorInstance?.id}', tipoC);
        cargarTotales('${gestorInstance?.id}', tipoC);
        revisarAsientos();
    }

    $("#tipo").change(function () {
        var tipoVal = $(this).val();
        cargarMovimientos('${gestorInstance?.id}', tipoVal);
        cargarTotales('${gestorInstance?.id}', tipoVal);
    });

    function cargarMovimientos(idGestor, idTipo) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'gestor', action: 'tablaGestor_ajax')}',
            data: {
                id: idGestor,
                tipo: idTipo
            },
            success: function (msg) {
                $("#cuentaAgregada").html(msg)
            }
        });
    }

    function cargarTotales(idGestor, idTipo) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'gestor', action: 'totales_ajax')}',
            data: {
                id: idGestor,
                tipo: idTipo
            },
            success: function (msg) {
                $("#totales").html(msg)
            }
        });
    }

    $("#btnGuardar").click(function () {
        var gestor = '${gestorInstance?.id}';
        var nombreGestor = $("#nombre").val();
        var descripcion = $("#descripcion").val();
        var observacion = $("#observaciones").val();
        var fuente = $("#fuenteGestor").val();
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'gestor', action: 'guardarGestor')}",
            data: {
                gestor: gestor,
                nombre: nombreGestor,
                descripcion: descripcion,
                observacion: observacion,
                fuente: fuente,
                tipoProceso:  $(".tipoProcesoSel option:selected").val(),
                tipo:  $(".tipoD option:selected").val(),
                saldoInicial: $(".salIni").prop('checked')
            },
            success: function (msg) {
                var parts = msg.split("_");
                if (parts[0] == 'ok') {
                    log("Información del gestor guardada correctamente", "success");
                    setTimeout(function () {
                        location.href = "${createLink(controller: 'gestor', action: 'formGestor')}/" + parts[1]
                    }, 800);
                } else {
                    log("Error al guardar la información del gestor", "error")
                }
            }

        });
    });


</script>

</body>
</html>