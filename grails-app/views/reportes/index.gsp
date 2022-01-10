<%@ page import="sri.TipoComprobante; sri.Contabilidad" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/01/22
  Time: 14:33
--%>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reportes</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 600px;
    }

    .tab-content {
        /*background  : #EFE4D1;*/
        background  : #EEEEEE;
        border      : solid 1px #DDDDDD;
        padding-top : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 710px;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 40px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .uno {

        float      : left;
        width      : 150px;
        margin-top : 10px;
    }

    .dos {

        float      : left;
        width      : 250px;
        margin-top : 10px;
    }

    .fila {
        height : 40px;
    }

    .textoUno {
        float : left;
        width : 250px;

    }

    .textoDos {
        float : left;

    }


    .btn-sq-lg {
        width: 150px !important;
        height: 150px !important;
    }

    .btn-sq {
        width: 100px !important;
        height: 100px !important;
        font-size: 10px;
    }

    .btn-sq-sm {
        width: 50px !important;
        height: 50px !important;
        font-size: 10px;
    }

    .btn-sq-xs {
        width: 25px !important;
        height: 25px !important;
        padding:2px;
    }

    </style>

</head>

<body>

<div class="row">
    <div class="col-lg-12">
        <p>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#planCuentas" title="Plan de cuentas o catálogo de cuentas de la contabilidad">
                <i class="fa  fa-sitemap fa-5x"></i><br/>
                Plan de Cuentas
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#gestorContable">
                <i class="fa fa-building fa-5x"></i><br/>
                Gestor Contable
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#libroDiario">
                <i class="fa fa-pen fa-5x"></i><br/>
                Libro Diario
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#libroMayor">
                <i class="fa fa-book-open fa-5x"></i><br/>
                Libro Mayor
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#situacionN">
                <i class="fa fa-money-bill-alt fa-5x"></i><br/>
                Estado de Situación
            </a>
        </p>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <p>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#balance" title="Muestra el balance de comprobación en detalle a todos los niveles">
                <i class="fa fa-balance-scale fa-5x"></i><br/>
                Balance de Comprobación
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#integral" title="Reporte de Estado de Pérdidas y Ganancias">
                <i class="fa fa-list-ul fa-5x"></i><br/>
                Estado del Resultado Integral
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-target="#retenciones" data-toggle="modal">
                <i class="fa fa-clipboard  fa-5x"></i><br/>
                Retenciones
            </a>
            <a href="#" class="link btn btn-info btn-ajax" data-target="#retencionesCodigo" data-toggle="modal">
                <i class="fa fa-clipboard fa-5x"></i><br/>
                Retenciones por Código
            </a>
            <a href="#" class="link btn btn-primary btn-ajax" data-toggle="modal" disabled="" data-target="#modalAts" title="Permite la generació del ATS en un período determinado">
                <i class="fa fa-file-alt fa-5x"></i><br/>
                ATS
            </a>
        </p>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <p>
            <a href="#" class="link btn btn-success btn-ajax" data-target="#kardex" data-toggle="modal">
                <i class="fa fa-book fa-5x"></i><br/>
                Kardex
            </a>
            <a href="#" class="link btn btn-success btn-ajax btnKardex2" data-toggle="modal">
                <i class="fa fa-parking fa-5x"></i><br/>
                Kardex por producto
            </a>
            <a href="#" class="link btn btn-success btn-ajax btnKardex3" data-toggle="modal">
                <i class="fa fa-chart-bar fa-5x"></i><br/>
                Existencias
            </a>
            <a href="#" class="link btn btn-success btn-ajax btnKardex4" data-toggle="modal">
                <i class="fa fa-chart-bar fa-5x"></i><br/>
                Existencias por producto
            </a>
            <a href="#" class="link btn btn-success btn-ajax btnCostoVentas" data-toggle="modal">
                <i class="fa fa-file-invoice-dollar fa-5x"></i><br/>
                Costo de Ventas
            </a>
            <a href="#" class="link btn btn-warning btn-ajax" data-target="#compras" data-toggle="modal">
                <i class="fa fa-shopping-cart fa-5x"></i><br/>
                Compras
            </a>
            <a href="#" class="link btn btn-warning btn-ajax" data-target="#ventas" data-toggle="modal">
                <i class="fa fa-truck fa-5x"></i><br/>
                Ventas
            </a>
        </p>
    </div>
</div>


<!-------------------------------------------- MODALES ----------------------------------------------------->
%{--//dialog de contabilidad--}%
<div class="modal fade" id="planCuentas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Plan de Cuentas</h4>
            </div>

            <div class="modal-body fila" style="margin-bottom: 30px">
                <label class="uno">Contabilidad:</label>
                <g:select name="contCuentas" id="contCuentas"
                          from="${contabilidad}"
                          optionKey="id" optionValue="descripcion"
                          class="form-control dos"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarPlanExcel btn-success"><i class="fa fa-print"></i> Excel
                </button>
                <button type="button" class="btn btnAceptarPlan btn-success"><i class="fa fa-print"></i> Imprimir
                </button>
%{--                <g:link controller="reportes" action="rep">To PDF</g:link>--}%

            </div>
        </div>
    </div>
</div>

%{--dialog de gestor contable--}%
<div class="modal fade" id="gestorContable" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalGestor">Gestor Contable</h4>
            </div>

            <div class="modal-body fila" style="margin-bottom: 30px">
                <label class="uno">Contabilidad:</label>
                <g:select name="contContable" id="contContable"
                          from="${contabilidad}"
                          optionKey="id" optionValue="descripcion"
                          class="form-control dos"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarGestor btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog comprobante--}%
<div class="modal fade" id="comprobante" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalComprobante">Comprobante</h4>
            </div>

            <div class="modal-body">
                <div class="fila" style="margin-bottom: 10px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contComp" id="contComp"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion"
                              class="form-control dos"/>
                </div>

                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Tipo:</label>
                    <g:select class="form-control dos" name="compTipo" from="${sri.TipoComprobante.list()}" optionKey="id" optionValue="descripcion"/>
                </div>

                <div class="fila">
                    <label class="uno">Número:</label>
                    <div class="col-md-2" id="divNumComp" style="margin-left: -10px"></div>
                    <g:textField type="text" class="form-control dos number" name="compNum" maxlength="25" style="width: 200px; margin-top: -1px"/>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarComprobante btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog libro diario--}%
<div class="modal fade" id="libroDiario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalLibroDiario">Libro Diario</h4>
            </div>

            <div class="modal-body" id="bodyLibro">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP11" id="contP11"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo11" class="fila">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarLibro btn-success"><i class="fa fa-print"></i> Imprimir
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog ATS--}%
<div class="modal fade" id="modalAts" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Generar ATS</h4>
            </div>

            <div class="modal-body">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contAts" id="contP20"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos" value="-1"/>
                </div>

                <div class="fila" id="divPeriodo20">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarAts btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog situación--}%
<div class="modal fade" id="situacionN" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalSituacionN">Situación</h4>
            </div>

            <div class="modal-body" id="bodySituacionN">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP15" id="contP15"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo15" class="fila" style="margin-bottom: 20px">
                    <label class="uno">Período:</label>
                </div>

                <div id="divNivel" class="fila">
                    <label class="uno">Nivel:</label>
                    <g:select name="nivel_name" from="${niveles}" optionKey="key" optionValue="value" id="nivelSituacion" class="form-control col-md-2" style="width: 100px"/>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarSituacionN btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog balance--}%
<div class="modal fade" id="balance" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalBalance">Balance</h4>
            </div>

            <div class="modal-body" id="bodyBalance">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP" id="contP"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo" class="fila">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarBalance btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog situacion financiera--}%
<div class="modal fade" id="situacion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalSituacion">Situación Financiera</h4>
            </div>

            <div class="modal-body" id="bodySituacion">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP8" id="contP8"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos" />
                </div>

                <div id="divPeriodo8" class="fila">
                    <label class="uno">Período:</label>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarSituacion btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog resultado Integral--}%
<div class="modal fade" id="integral" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalIntegral">Estado del Resultado Integral</h4>
            </div>

            <div class="modal-body" id="bodyIntegral">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contP9" id="contP9"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo9" class="fila">
                    <label class="uno">Período:</label>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarIntegral btn-success"><i class="fa fa-print"></i> Imprimir
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog libro mayor--}%
<div class="modal fade" id="libroMayor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalAuxiliar">Libro Mayor</h4>
            </div>

            <div class="modal-body" id="bodyAuxiliar">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contP3" id="contP3"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker1' type='text' required="" class="form-control fechaDe required"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaHasta"  id='datetimepicker2' type='text' required="" class="form-control fechaHa required"/>
                    </div>
                </div>

                <div id="divCuenta3" class="fila">

                    <div class="col-md-3">
                        <label class="uno">Cuenta:</label>
                    </div>

                    <g:hiddenField name="idCntaLibro" value="" />
                    <div class="col-md-6">
                        <g:textField name="cntaLibro" value="" class="form-control" />
                    </div>

                    <div class="col-md-2">
                        <a href="#" class="link btn btn-info btn-ajax" id="buscarCuenta">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarAuxiliar btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


%{--dialog retenciones--}%
<div class="modal fade" id="retenciones" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalRetenciones">Retenciones</h4>
            </div>

            <div class="modal-body" id="bodyRetenciones">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contR" id="contR"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker3' type='text' required="" class="form-control fechaDeR required"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaHasta"  id='datetimepicker4' type='text' required="" class="form-control fechaHaR required"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarRetenciones btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

%{--dialog kardex--}%
<div class="modal fade" id="kardex" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalKardex">Kardex</h4>
            </div>

            <div class="modal-body" id="bodyKardex">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contK" id="contK"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Bodega:</label>
                    <g:select name="bode_name" id="bode"
                              from="${inventario.Bodega.list().sort{it.descripcion}}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la bodega']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker7' type='text' required="" class="form-control fechaDeK required"/>
%{--                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDK" class="datepicker form-control fechaDeK"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaHasta"  id='datetimepicker8' type='text' required="" class="form-control fechaHaK required"/>
%{--                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHK" class="datepicker form-control fechaHaK"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarKardex btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

%{--dialog retenciones por codigo--}%
<div class="modal fade" id="retencionesCodigo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalRetCod">Retenciones por Código</h4>
            </div>

            <div class="modal-body" id="bodyRetCod">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contRC" id="contRC"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker5' type='text' required="" class="form-control fechaDeRC required"/>
%{--                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDRC" class="datepicker form-control fechaDeRC"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker6' type='text' required="" class="form-control fechaHaRC required"/>
%{--                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHRC" class="datepicker form-control fechaHaRC"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarRetCod btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

%{--dialog compras--}%
<div class="modal fade" id="compras" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalCompras">Compras</h4>
            </div>

            <div class="modal-body" id="bodyCompras">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contRC" id="contC"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>


                <div class="fila">
                    <div class="col-md-3">
                        <label>Tipo: </label>
                    </div>
                    <div class="col-md-5">
                        <g:select name="tipo" from="${[1: 'Gasto', 2: 'Inventario']}" optionKey="key" optionValue="value" class="form-control"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker9' type='text' required="" class="form-control fechaDeC required"/>
%{--                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDC" class="datepicker form-control fechaDeC"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaHasta"  id='datetimepicker10' type='text' required="" class="form-control fechaHaC required"/>
%{--                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHC" class="datepicker form-control fechaHaC"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarCompras btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

%{--dialog ventas--}%
<div class="modal fade" id="ventas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalVentas">Ventas</h4>
            </div>

            <div class="modal-body" id="bodyVentas">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contV" id="contV"
                              from="${contabilidad}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaDesde"  id='datetimepicker11' type='text' required="" class="form-control fechaDeV required"/>
%{--                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDV" class="datepicker form-control fechaDeV"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <input name="fechaHasta"  id='datetimepicker12' type='text' required="" class="form-control fechaHaV required"/>
%{--                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHV" class="datepicker form-control fechaHaV"--}%
%{--                                        maxDate="new Date()"/>--}%
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarVentas btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-------------------------------------------- MODALES ----------------------------------------------------->

<script type="text/javascript">

    $(function () {
        $('#datetimepicker1, #datetimepicker2, #datetimepicker3, #datetimepicker4, #datetimepicker5, #datetimepicker6, #datetimepicker7, #datetimepicker8, #datetimepicker9, #datetimepicker10').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'closeText'
            }
        });
        $('#datetimepicker11, #datetimepicker12').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'closeText'
            }
        });
    });

    $(".btnCostoVentas").click(function () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'reportes2', action: 'costoVentas_ajax')}',
            data:{  },
            success: function (msg){
                var b = bootbox.dialog({
                    id      : "dlgKardex3",
                    title   : "Costo de ventas",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });


    $(".btnKardex4").click(function () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'reportes3', action: 'kardex4_ajax')}',
            data:{  },
            success: function (msg){
                var b = bootbox.dialog({
                    id      : "dlgKardex4",
                    title   : "Existencias por Producto",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });

    $(".btnKardex3").click(function () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'reportes2', action: 'kardex3_ajax')}',
            data:{},
            success: function (msg){
                var b = bootbox.dialog({
                    id      : "dlgKardex3",
                    title   : "Existencias",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });

    $(".btnKardex2").click(function () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'reportes2', action: 'kardex2_ajax')}',
            data:{ },
            success: function (msg){
                var b = bootbox.dialog({
                    id      : "dlgKardex2",
                    title   : "Kardex por Producto",
                    class: "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });

    $("#cntaLibro").dblclick(function () {
        buscarCuentas();
    });

    $("#buscarCuenta").click(function () {
        buscarCuentas();
    });

    function buscarCuentas () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'cuenta', action: 'buscadorCuentas_ajax')}',
            data:{ },
            success: function (msg){
                bootbox.dialog({
                    title: 'Buscar cuenta',
                    message: msg,
                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                })
            }
        });
    }

    cargarSelComprobante($("#compTipo option:selected").val());

    $("#compTipo").change(function () {
        var tipo = $("#compTipo option:selected").val();
        cargarSelComprobante(tipo)
    });

    function cargarSelComprobante (sel) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'prefijo_ajax')}',
            data:{
                tipo: sel
            },
            success: function (msg){
                $("#divNumComp").html(msg)
            }
        });
    }

    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    var actionUrl = "";

    function updateCuenta() {
        var per = $("#periodo2").val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reportes2', action:'updateCuenta')}",
            data    : {
                per : per
            },
            success : function (msg) {
                $("#divCuenta").html(msg);
            }
        });
    }

    function updatePeriodo(cual) {
        var cont = $("#contP" + cual).val();

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'updatePeriodo')}",
            data    : {
                cont : cont,
                cual : cual
            },
            success : function (msg) {
                $("#divPeriodo" + cual).html(msg);
            }
        });
    }

    function updatePeriodoSinTodo(cual) {
        var cont = $("#contP" + cual).val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'updatePeriodoSinTodo')}",
            data    : {
                cont : cont,
                cual : cual
            },
            success : function (msg) {
                $("#divPeriodo" + cual).html(msg);
            }
        });

    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });

        /* ******************************** DIALOGS ********************************************* */


        $("#contP").change(function () {
            updatePeriodoSinTodo("");
        });
        $("#contP2").change(function () {
            updatePeriodoSinTodo("2");
        });

        $("#contP5").change(function () {
            updatePeriodoSinTodo("5");
        });
        $("#contP6").change(function () {
            updatePeriodoSinTodo("6");
        });

        $("#contP7").change(function () {
            updatePeriodoSinTodo("7");
        });
        $("#contP8").change(function () {
            updatePeriodoSinTodo("8");
        });
        $("#contP9").change(function () {
            updatePeriodoSinTodo("9");
        });

        $("#contP0").change(function () {
            updatePeriodoSinTodo("0");
        });

        $("#contP3").change(function () {
            updatePeriodo("3");
        });
        $("#contP4").change(function () {
            updatePeriodo("4");
        });
        $("#contP11").change(function () {
            updatePeriodoSinTodo("11");
        });

        $("#contP15").change(function () {
            updatePeriodoSinTodo("15");
        });

        $("#contP20").change(function () {
            updatePeriodoSinTodo("20");
        });

        $(".btnAceptarPlan").click(function () {
            var cont = $("#contCuentas").val();
            location.href = "${g.createLink(controller:'reportes' , action: '_planDeCuentas')}?cont=" + cont + "&empresa=${empresa?.id}";
        });

        $(".btnAceptarPlanExcel").click(function () {
            var cont = $("#contCuentas").val();
            location.href = "${g.createLink(controller:'reportes3' , action: 'excelPlan')}?cont=" + cont + "&empresa=${empresa.id}";
        });

        $(".btnAceptarGestor").click(function () {
            var cont = $("#contContable").val();
            location.href = "${g.createLink(controller:'reportes' , action: '_gestorContable')}?cont=" + cont + "&empresa=${empresa?.id}";
        });

        $(".btnAceptarComprobante").click(function () {
            var cont = $("#contComp").val();
            var tipo = $("#compTipo").val();
            var url
            console.log("tipo " + tipo)
            var num = $("#compNum").val();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'reportes3', action: 'reporteComprobante')}",
                data    : {
                    cont : cont,
                    tipo : tipo,
                    num  : num
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] != "NO") {
                        switch (tipo) {
                            case '1':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteIngreso.pdf";
                                break;
                            case '2':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteEgreso.pdf";
                                break;
                            case '3':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteDiario.pdf";
                                break;
                        }
                    } else {
                        bootbox.alert(parts[1])
                    }
                }
            });
        });

        $(".btnAceptarBalance").click(function () {
            var cont = $("#contP").val();
            var per = $("#periodo").val();
            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                location.href = "${g.createLink(controller:'reportes2' , action: '_balanceComprobacion')}?cont=" + cont + "&emp=${empresa.id}" + "&periodo=" + per;
            }
        });

        $(".btnAceptarSituacion").click(function () {
            var cont = $("#contP8").val();
            var per = $("#periodo8").val();

            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                url = "${g.createLink(controller:'reportes2' , action: 'situacionFinanciera')}?cont=" + cont + "Wempresa=${empresa.id}" + "Wper=" + per;
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=situacionFinanciera.pdf"
            }
        });

        $(".btnAceptarIntegral").click(function () {
            var cont = $("#contP9").val();
            var per = $("#periodo9").val();

            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                location.href = "${g.createLink(controller:'reportes3' , action: '_resultadoIntegral')}?cont=" + cont + "&empresa=${empresa.id}" + "&per=" + per;
            }
        });

        $(".btnAceptarAuxiliar").click(function () {
            var cont = $("#contP3").val();
            var per = $("#periodo3").val();
            var cnta = $("#idCntaLibro").val();
            var fechaDesde = $(".fechaDe").val();
            var fechaHasta = $(".fechaHa").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(cnta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una cuenta!")
                }else{
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    location.href = "${g.createLink(controller:'reportes2' , action: '_libroMayor')}?cont=" + cont + "&emp=${empresa.id}" + "&cnta=" + cnta + "&desde=" + fechaDesde + "&hasta=" + fechaHasta;
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });

        $(".btnAceptarRetenciones").click(function () {
            var cont = $("#contR").val();
            var fechaDesde = $(".fechaDeR").val();
            var fechaHasta = $(".fechaHaR").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                        data:{
                            desde: fechaDesde,
                            hasta: fechaHasta
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                location.href = "${g.createLink(controller:'reportes2' , action: '_retenciones')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta;
                            }else{
                                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                return false;
                            }
                        }
                    });

                }
            }
        });

        $(".btnAceptarKardex").click(function () {
            var cont = $("#contK").val();
            var fechaDesde = $(".fechaDeK").val();
            var fechaHasta = $(".fechaHaK").val();
            var bodega = $("#bode").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(bode == '-1'){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una bodega!")
                }else{
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    location.href = "${g.createLink(controller:'reportes2' , action: '_kardexGeneral')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta + "&bodega=" + bodega;
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });

        $(".btnAceptarRetCod").click(function () {
            var cont = $("#contRC").val();
            var fechaDesde = $(".fechaDeRC").val();
            var fechaHasta = $(".fechaHaRC").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                        data:{
                            desde: fechaDesde,
                            hasta: fechaHasta
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                location.href = "${g.createLink(controller:'reportes2' , action: '_retencionesCodigo')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta;
                            }else{
                                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                return false;
                            }
                        }
                    });
                }
            }
        });

        $(".btnAceptarCompras").click(function () {
            var cont = $("#contC").val();
            var fechaDesde = $(".fechaDeC").val();
            var fechaHasta = $(".fechaHaC").val();
            var tipo = $("#tipo").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                        data:{
                            desde: fechaDesde,
                            hasta: fechaHasta
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                location.href = "${g.createLink(controller:'reportes2' , action: '_compras')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta + "&tipo=" + tipo;
                            }else{
                                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                return false;
                            }
                        }
                    });

                }
            }
        });

        $(".btnAceptarVentas").click(function () {
            var cont = $("#contV").val();
            var fechaDesde = $(".fechaDeV").val();
            var fechaHasta = $(".fechaHaV").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                        data:{
                            desde: fechaDesde,
                            hasta: fechaHasta
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                location.href = "${g.createLink(controller:'reportes2' , action: '_ventas')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta;
                            }else{
                                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                return false;
                            }
                        }
                    });
                }
            }
        });

        $("#btnTodosPrv").button().click(function () {
            $("#hidVal").val("-1");
            $("#txtValor").val("Todos");
            return false;
        });

        $(".btnAceptarLibro").click(function () {
            var cont = $("#contP11").val();
            var per = $("#periodo11").val();
            location.href = "${g.createLink(controller: 'reportes3', action: '_libroDiario')}?cont=" + cont + "&periodo=" + per + "&empresa=${empresa.id}";
        });

        $(".btnAceptarAts").click(function () {
            var cont = $("#contP20").val();
            var prms = $("#periodo20").val();
            // console.log('cont', cont, 'mes', prms)
            crearXML(prms, cont, 0);
        });

        $(".btnAceptarSituacionN").click(function () {
            var cont = $("#contP15").val();
            var per = $("#periodo15").val();
            var nivel = $("#nivelSituacion").val();
            location.href= "${g.createLink(controller: 'reportes3', action: '_reporteSituacion')}?cont=" + cont + "&periodo=" + per + "&empresa=${empresa.id}" + "&nivel=" + nivel;
            %{--location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=situacion.pdf";--}%
        });

        function crearXML(mes, anio, override) {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'xml', action: 'createXml')}",
                data    : {
                    mes      : mes,
                    anio     : anio,
                    override : override
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "NO") {
                        if (parts[1] == "1") {
                            var msgs = "Ya existe un archivo XML para el periodo " + mes + "-" + anio + "." +
                                "<ul><li>Si desea <strong>sobreescribir el archivo existente</strong>, haga click en el botón <strong>'Sobreescribir'</strong></li>" +
                                "<li>Si desea <strong>descargar el archivo previamente generado</strong>, haga click en el botón <strong>'Descargar'</strong></li>" +
                                "<li>Si desea <strong>ver la lista de archivos generados</strong>, haga cilck en el botón <strong>'Archivos'</strong></li></ul>";
                            bootbox.dialog({
                                title   : "Alerta",
                                message : msgs,
                                buttons : {
                                    sobreescribir : {
                                        label     : "<i class='fa fa-pencil'></i> Sobreescribir",
                                        className : "btn-primary",
                                        callback  : function () {
                                            crearXML(mes, anio, 1);
                                        }
                                    },
                                    descargar     : {
                                        label     : "<i class='fa fa-download'></i> Descargar",
                                        className : "btn-success",
                                        callback  : function () {
                                            location.href = "${createLink(controller: 'xml', action:'downloadFile')}?mes=" + mes;
                                        }
                                    },
                                    archivos      : {
                                        label     : "<i class='fa fa-files-o'></i> Archivos",
                                        className : "btn-default",
                                        callback  : function () {
                                            location.href = "${createLink(controller: 'xml', action:'downloads')}";
                                        }
                                    },
                                    cancelar      : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    } else if (parts[0] == "OK") {
                        bootbox.dialog({
                            title   : "Descargar archivo",
                            message : "Archivo generado exitosamente",
                            buttons : {
                                descargar : {
                                    label     : "<i class='fa fa-download'> Descargar",
                                    className : "btn-success",
                                    callback  : function () {
                                        location.href = "${createLink(controller: 'xml', action:'downloadFile')}?mes=" + mes;
                                    }
                                }
                            }
                        });
                    }
                }
            });
        }
    });
</script>

</body>
</html>