<%@ page import="retenciones.Retencion; sri.AsientoCentro" %>
<style type="text/css">
.colorAtras {
    background-color: #dfa58f;
    color: #0b0b0b;
    text-align: center;
    font-weight: bold;
}

.colorAsiento {
    color: #0b0b0b;
    background-color: #d6eeff;
}

.derecha {
    text-align: right;
}

.izquierda {
    text-align: left;
}

.dato {
    font-weight: normal;
    background-color: #fff3e1;
}
.total {
    /*font-weight: bold;*/
    background-color: #465570;
    color: #fdf5f0;
}

.rojo{
    background-color: #702213;

}

</style>


<div class="col-xs-6 etiqueta"><label>Comprobante:</label> ${comprobante?.descripcion}</div>
<div class="col-xs-2 etiqueta"><label>Tipo:</label> ${comprobante?.proceso?.tipoProceso?.descripcion}</div>
<div class="col-xs-2 etiqueta"><label>Número:</label> ${comprobante?.prefijo}${comprobante?.numero}</div>
<div class="col-xs-2 etiqueta"><label>Valor:</label>
    <g:formatNumber number="${comprobante?.tipo?.codigo == 'R' ? retenciones.Retencion.findByProceso(proceso)?.total : comprobante?.proceso?.valor}" maxFractionDigits="2" format="##,##0"/></div>

<g:if test="${comprobante?.registrado != 'S'}">
    <div class="btn-group" style="float: right; margin-top: -90px">
        <a href="#" class="btn btn-success btn-sm btnAgregarAsiento" comp="${comprobante?.id}"
           title="Agregar asiento contable">
            <i class="fa fa-plus"></i> Agregar Asiento
        </a>
        <a href="#" class="btn btn-sm btn-danger btnBorrarAsientos" comp="${comprobante?.id}"
           title="Borrar los asientos con valores en 0 al debe y al haber">
            <i class="fa fa-minus"></i> Borrar Asiento con valores en 0
        </a>
    </div>
</g:if>

<table class="table table-bordered table-hover table-condensed" width="1000px">
    <thead>
    <tr>
        <th width="100px">ASIENTO</th>
        <th width="527px">NOMBRE</th>
        <th width="50px">CC</th>
        <th width="100px">DEBE</th>
        <th width="100px">HABER</th>
        <th width="133px"><i class="far fa-edit"></i></th>
    </tr>
    </thead>
</table>

<div class="row-fluid" style="width: 100%; height: 500px; overflow-y: auto;float: right; margin-top: -20px">
    <div class="span12">
        <table class="table table-bordered table-condensed" width="980px">
            <tbody>
            <g:set var="sumadebe" value="${0.0}"/>
            <g:set var="sumahber" value="${0.0}"/>
            <g:each in="${asientos}" var="asiento">
                <g:set var="sumadebe" value="${sumadebe + asiento.debe}"/>
                <g:set var="sumahber" value="${sumahber + asiento.haber}"/>
                <tr class="colorAsiento">
                    <td width="100px">${asiento?.cuenta?.numero}</td>
                    <td width="520px">${asiento?.cuenta?.descripcion}</td>
                    <td width="50px">${sri.AsientoCentro.findAllByAsiento(asiento) ? sri.AsientoCentro.findAllByAsiento(asiento)?.first()?.centroCosto?.codigo : ''}</td>
                    <td width="100px"
                        class="derecha">${asiento.debe ? g.formatNumber(number: asiento.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                    <td width="100px"
                        class="derecha">${asiento.haber ? g.formatNumber(number: asiento.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                    <td width="130px" style="text-align: center">
                        <div class="btn-group">
                            <g:if test="${asiento?.comprobante?.registrado != 'S'}">
                                <a href="#" class="btn btn-success btn-xs btnEditarAsiento" idAs="${asiento?.id}"
                                   title="Editar asiento">
                                    <i class="far fa-edit"></i>
                                </a>
                            </g:if>
                            <a href="#" class="btn btn-azul btn-xs btnCentroCostos" idAs="${asiento?.id}" nomAs="${asiento?.cuenta?.descripcion}"
                               title="Centro de Costos">
                                <i class="far fa-money-bill-alt"></i>
                            </a>
                            <g:if test="${asiento?.comprobante?.registrado != 'S'}">
                                <a href="#" class="btn btn-warning btn-xs btnAgregarAuxiliar" idAs="${asiento?.id}"
                                   title="Agregar auxiliar">
                                    <i class="fa fa-plus"></i>
                                </a>
                                <a href="#" class="btn btn-danger btn-xs btnEliminarAsiento" idAs="${asiento?.id}"
                                   title="Eliminar asiento">
                                    <i class="fa fa-times"></i>
                                </a>
                            </g:if>
                        </div>
                    </td>
                </tr>
                <g:if test="${sri.Auxiliar.findAllByAsiento(asiento)}">
                    <g:set var="auxiliares1" value="${sri.Auxiliar.findAllByAsiento(asiento).sort{it.proveedor.nombre}}"/>
                    <g:set var="cabecera" value="N"/>
                    <g:each in="${auxiliares1}" var="auxiliar">
                        <g:if test="${cabecera != 'S'}">
                            <tr>
                                <td class="colorAtras">Fecha</td>
                                <td class="colorAtras">Proveedor</td>
                                <td class="colorAtras"></td>
                                <td class="colorAtras">Debe</td>
                                <td class="colorAtras">Haber</td>
                                <td class="colorAtras"><i class="far fa-edit"></i></td>
                                <g:set var="cabecera" value="S"/>
                            </tr>
                        </g:if>
                        <tr class="colorAtras">
                            <g:set var="dcmt" value="${auxiliar?.documento? ' - Doc: ' + auxiliar?.documento : ''}"/>
                            <td class="dato">${auxiliar?.fechaPago?.format("dd-MM-yyyy")}</td>
                            <td class="dato izquierda">${auxiliar?.proveedor?.nombre} ${dcmt}</td>
                            <td class="dato izquierda"></td>
                            <td class="dato derecha">${auxiliar?.debe ? g.formatNumber(number: auxiliar.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                            <td class="dato derecha">${auxiliar.haber ? g.formatNumber(number: auxiliar.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2) : 0.00}</td>
                            <td class="dato" style="text-align: center; width: 100px">
                                <g:if test="${auxiliar?.asiento?.comprobante?.registrado != 'S'}">
                                    <div class="btn-group">
                                        <a href="#" class="btn btn-success btn-xs btnEditarAuxiliar"
                                           idAu="${auxiliar?.id}" title="Editar auxiliar">
                                            <i class="far fa-edit"></i>
                                        </a>
                                        <a href="#" class="btn btn-danger btn-xs btnEliminarAuxiliar"
                                           idAu="${auxiliar?.id}" title="Eliminar auxiliar">
                                            <i class="far fa-trash-alt"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="btn-group">
                                        <a href="#" class="btn btn-info btn-xs btnVerAuxiliar"
                                           idAuxi="${auxiliar?.id}" title="Ver auxiliar">
                                            <i class="fa fa-search"></i>
                                        </a>
                                    </div>
                                </g:else>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </g:each>
            <tr class="colorAsiento">
                <td colspan="3" class="total derecha">Totales del asiento</td>
                <td class="total derecha ${Math.round(sumadebe*100)/100 != (comprobante?.tipo?.codigo == 'R' ? retenciones.Retencion.findByProceso(proceso)?.total : proceso?.valor) ? 'rojo' : ''}"><g:formatNumber number="${Math.round(sumadebe*100)/100}" format="##,##0" maxFractionDigits="2" minFractionDigits="2"/> </td>
                <td class="total derecha ${Math.round(sumahber*100)/100 != (comprobante?.tipo?.codigo == 'R' ? retenciones.Retencion.findByProceso(proceso)?.total : proceso?.valor) ? 'rojo' : ''}"><g:formatNumber number="${Math.round(sumahber*100)/100}" format="##,##0" maxFractionDigits="2" minFractionDigits="2"/> </td>
                <td class="total derecha" ${Math.round((sumadebe - sumahber)*100)/100 != 0 ? 'rojo' : ''}>Dif: ${Math.round((sumadebe - sumahber)*100)/100}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">


    $(".btnVerAuxiliar").click(function () {
        var aux = $(this).attr('idAuxi');
        $.ajax({
            type :'POST',
            url: '${createLink(controller: 'proceso', action: 'verAuxiliar_ajax')}',
            data:{
                auxiliar: aux,
                comprobante: '${comprobante?.id}'
            },
            success: function (msg){
                bootbox.dialog({
                    title: "Auxiliar",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                });
            }
        });
    });


    $(".btnBorrarAsientos").click(function (){
        var comprobante = $(this).attr('comp');
        bootbox.confirm("<i class='far fa-trash-alt fa-3x pull-left text-danger text-shadow'></i> Está seguro de borrar todos los asientos con valor 0.00 ?", function (result) {
            if (result) {
                openLoader("Borrando...")
                $.ajax({
                    type:'POST',
                    url: '${createLink(controller: 'proceso', action: 'borrarCeros_ajax')}',
                    data:{
                        comprobante: comprobante
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            log("Asientos borrados correctamente","success");
                            cargarComprobanteP('${proceso?.id}');
                            closeLoader();
                        }else{
                            log("Error al borrar los asientos","error");
                            closeLoader();
                        }
                    }
                });
            }
        })
    });


    $(".btnCentroCostos").click(function (){
        var asiento = $(this).attr('idAs');
        var nombreAs = $(this).attr('nomAs');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso', action: 'centroCostos_ajax')}',
            data:{
                asiento: asiento
            },
            success: function (msg){
                bootbox.dialog({
                    title: 'Centro de Costos de ' + nombreAs,
                    message: msg,
//                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cerrar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                })
            }
        });
    });

    $(".btnAgregarAsiento").click(function () {
        agregar('${comprobante?.id}', null)
    });

    $(".btnEditarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        agregar(${comprobante?.id}, idAsiento)
    });

    $(".btnAgregarAuxiliar").click(function () {
        var idAsiento = $(this).attr('idAs');
        agregarAuxiliar(${comprobante?.id}, idAsiento, null)
    });

    $(".btnEditarAuxiliar").click(function () {
        var idAux = $(this).attr('idAu');
        agregarAuxiliar(${comprobante?.id}, null, idAux)
    });

    $(".btnEliminarAsiento").click(function () {
        var idAsiento = $(this).attr('idAs');
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='far fa-trash-alt fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el asiento contable?</p>",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='far fa-trash-alt'></i> Borrar",
                    className: "btn-danger",
                    callback: function () {
                        openLoader("Borrando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'borrarAsiento_ajax')}',
                            data: {
                                asiento: idAsiento,
                                comprobante: '${comprobante?.id}'
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    log(parts[1], "success");
                                    cargarComprobanteP('${proceso?.id}');
                                    closeLoader();
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

    function agregar(compro, idAsiento) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso',action: 'formAsiento_ajax')}',
            data: {
                comprobante: compro,
                asiento: idAsiento
            },
            success: function (msg) {
                bootbox.dialog({
                    title: idAsiento ? "Editar Asiento" : "Nuevo Asiento",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        eliminar: {
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                if ($("#valorAsientoDebe").val() == 0 && $("#valorAsientoHaber").val() == 0) {
                                    bootbox.alert("Ingrese un valor distinto a cero")
                                    return false;
                                } else {

                                    if($("#valorAsientoDebe").val().split('.').length - 1 > 1 || $("#valorAsientoHaber").val().split('.').length - 1 > 1) {
                                        bootbox.alert("El número ingresado no es válido!")
                                        return false;
                                    }

                                    if ($("#idCuentaNueva").val()) {
                                        openLoader("Guardando..");
                                        $.ajax({
                                            type: 'POST',
                                            url: '${createLink(controller: 'proceso', action: 'guardarAsiento_ajax')}',
                                            data: {
                                                asiento: idAsiento,
                                                cuenta: $("#idCuentaNueva").val(),
                                                debe: $("#valorAsientoDebe").val(),
                                                haber: $("#valorAsientoHaber").val(),
                                                proceso: '${proceso?.id}',
                                                comprobante: '${comprobante?.id}'
                                            },
                                            success: function (msg) {
                                                if (msg == 'ok') {
                                                    log("Asiento contable guardado correctamente", "success");
                                                    %{--cargarComprobante('${proceso?.id}');--}%
                                                    cargarComprobanteP('${proceso?.id}');
                                                    closeLoader();
                                                } else {
                                                    log("Error al guardar asiento contable", "error");
                                                    closeLoader();
                                                }
                                            }
                                        });
                                    } else {
                                        bootbox.alert("Seleccione una cuenta")
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    }


    $(".btnEliminarAuxiliar").click(function () {
        var idAuxiliar = $(this).attr('idAu');
        bootbox.dialog({
            title: "Alerta",
            message: "<i class='far fa-trash-alt fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el auxiliar contable?</p>",
            buttons: {
                cancelar: {
                    label: "<i class='fa fa-times'></i> Cancelar",
                    className: "btn-primary",
                    callback: function () {
                    }
                },
                eliminar: {
                    label: "<i class='far fa-trash-alt'></i> Borrar",
                    className: "btn-danger",
                    callback: function () {
                        openLoader("Borrando..");
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'borrarAuxiliar_ajax')}',
                            data: {
                                auxiliar: idAuxiliar,
                                comprobante: '${comprobante?.id}'
                            },
                            success: function (msg) {
                                var parts = msg.split("_");
                                if (parts[0] == 'ok') {
                                    log(parts[1], "success");
                                    %{--cargarComprobante('${proceso?.id}');--}%
                                    cargarComprobanteP('${proceso?.id}');
                                    closeLoader();
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


    function agregarAuxiliar(compro, idAsiento, idAuxiliar) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'proceso',action: 'formAuxiliar_ajax')}',
            data: {
                comprobante: compro,
                asiento: idAsiento,
                auxiliar: idAuxiliar
            },
            success: function (msg) {
                bootbox.dialog({
                    title: idAuxiliar ? "Editar Auxiliar" : "Nuevo Auxiliar",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        },
                        eliminar: {
                            label: "<i class='fa fa-save'></i> Guardar",
                            className: "btn-success",
                            callback: function () {
                                if ($("#valorPagar").val() == 0 && $("#valorCobrar").val() == 0) {
                                    bootbox.alert("Ingrese un valor distinto a cero");
                                    return false;
                                } else {

                                    if($("#valorPagar").val().split('.').length - 1 > 1 || $("#valorCobrar").val().split('.').length - 1 > 1) {
                                        bootbox.alert("El número ingresado no es válido!");
                                        return false;
                                    }else{
                                        if(!$("#facturaAuxiliar").val() && ${band2}){
                                            bootbox.alert("Ingrese un número de factura!");
                                            return false;
                                        }else{
                                            openLoader("Guardando..");
                                            $.ajax({
                                                type: 'POST',
                                                url: '${createLink(controller: 'proceso', action: 'guardarAuxiliar_ajax')}',
                                                data: {
                                                    asiento: idAsiento,
                                                    debe: $("#valorPagar").val(),
                                                    haber: $("#valorCobrar").val(),
                                                    comprobante: '${comprobante?.id}',
                                                    tipoPago: $("#tipoPago").val(),
                                                    fechaPago: $(".fechaPago").val(),
                                                    proveedor: $("#proveedor").val(),
                                                    descripcion: $("#descripcionAux").val(),
                                                    auxiliar: idAuxiliar,
                                                    documento: $("#referencia").val(),
                                                    factura: $("#facturaAuxiliar").val(),  /* com,probante que se paga */
                                                    dcmt: $("#facturaAuxiliar").data('dcmt'),  /* com,probante que se paga */
                                                    fctr: $("#factura").val()  /* documento por pagar */
                                                },
                                                success: function (msg) {
                                                    if (msg == 'ok') {
                                                        log("Auxiliar contable guardado correctamente", "success");
                                                        cargarComprobanteP('${proceso?.id}');
                                                        closeLoader();
                                                    } else {
                                                        log("Error al guardar el auxiliar contable", "error");
                                                        closeLoader();
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    }


</script>