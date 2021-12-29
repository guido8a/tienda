<%@ page import="sri.TipoEmpresa" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/12/21
  Time: 10:20
--%>


<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<div class="col2">
    <g:form class="form-horizontal" name="frmEmpresaCont" role="form" action="saveFormCont_ajax" method="POST">
        <g:hiddenField name="id" value="${empresaInstance?.id}"/>
        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-xs-4 control-label text-info">
                    Nombre Comercial
                </label>

                <div class="col-xs-8">
                    <g:textField name="nombre" maxlength="63" required="" class="form-control required" value="${empresaInstance?.nombre}"/>
                </div>
            </span>
        </div>
%{--        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'ruc', 'error')} required">--}%
%{--            <span class="grupo">--}%
%{--                <label for="ruc" class="col-xs-4 control-label text-info">--}%
%{--                    R.U.C.--}%
%{--                </label>--}%

%{--                <div class="col-xs-4">--}%
%{--                    <g:textField name="ruc" maxlength="13" required="" class="form-control validaLista required" value="${empresaInstance?.ruc}"/>--}%
%{--                </div>--}%
%{--            </span>--}%
%{--        </div>--}%



        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'razonSocial', 'error')} ">
            <span class="grupo">
                <label for="razonSocial" class="col-xs-4 control-label text-info">
                    Razón Social
                </label>

                <div class="col-xs-8">
                    <g:textField name="razonSocial" maxlength="255" class="form-control" value="${empresaInstance?.razonSocial}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'tipoIdentificacion', 'error')} required">
            <span class="grupo">
                <label for="tipoIdentificacion" class="col-xs-4 control-label text-info">
                    Tipo de Identificación
                </label>

                <div class="col-xs-8">
                    <g:select id="tipoIdentificacion" name="tipoIdentificacion.id" from="${['1':'Registro Único Contribuyente']}" optionValue="value" optionKey="key" value="${empresaInstance?.tipoIdentificacion?.id}" class="many-to-one form-control required"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'tipoEmpresa', 'error')} required">
            <span class="grupo">
                <label for="tipoEmpresa" class="col-xs-4 control-label text-info">
                    Tipo Empresa
                </label>

                <div class="col-xs-8">
                    <g:select id="tipoEmpresa" name="tipoEmpresa.id" from="${sri.TipoEmpresa.list()}" optionValue="descripcion" optionKey="id" value="${empresaInstance?.tipoEmpresa?.id}" class="many-to-one form-control required"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')} required">
            <span class="grupo">
                <label for="direccion" class="col-xs-4 control-label text-info">
                    Dirección de la matriz:
                </label>

                <div class="col-xs-8">
                    <g:textArea name="direccion" style="resize: none" maxlength="127" required="" class="form-control required" value="${empresaInstance?.direccion}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'contribuyenteEspecial', 'error')} ">
            <span class="grupo">
                <label for="contribuyenteEspecial" class="col-xs-4 control-label text-info">
                    Contribuyente Especial
                </label>
                <div class="col-xs-4">
%{--                    <g:textField name="contribuyenteEspecial" maxlength="13" class="form-control validaLista" value="${empresaInstance?.contribuyenteEspecial}"/>--}%
                    <g:checkBox name="contribuyenteEspecial_name" id="contribuyenteEspecial" class="form-control" data-on-Label="Si" checked="${empresaInstance?.contribuyenteEspecial == 'S' ?: false}"/>
                </div>
            </span>
        </div>

%{--        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'telefono', 'error')} required ">--}%
%{--            <span class="grupo">--}%
%{--                <label for="telefono" class="col-xs-4 control-label text-info">--}%
%{--                    Teléfono--}%
%{--                </label>--}%

%{--                <div class="col-xs-6">--}%
%{--                    <div class="input-group">--}%
%{--                        <span class="input-group-addon"><i class="fa fa-phone"></i></span>--}%
%{--                        <g:textField name="telefono" maxlength="63" class="form-control required" value="${empresaInstance?.telefono}"/>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--            </span>--}%
%{--        </div>--}%

%{--        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">--}%
%{--            <span class="grupo">--}%
%{--                <label for="email" class="col-xs-4 control-label text-info">--}%
%{--                    E-mail--}%
%{--                </label>--}%

%{--                <div class="col-xs-6">--}%
%{--                    <div class="input-group">--}%
%{--                        <span class="input-group-addon"><i class="fa fa-envelope"></i></span>--}%
%{--                        <g:field type="email" name="email" maxlength="63" class="form-control" value="${empresaInstance?.mail}"/>--}%
%{--                    </div>--}%
%{--                </div>--}%

%{--            </span>--}%
%{--        </div>--}%


        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-xs-4 control-label text-info">
                    Fecha Inicio
                </label>

                <div class="col-xs-4">
%{--                    <elm:datepicker name="fechaInicio" title="Fecha de inicio" class="datepicker form-control" value="${empresaInstance?.fechaInicio}"/>--}%
                    <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control required" value="${empresaInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'fechaFin', 'error')} ">
            <span class="grupo">
                <label for="fechaFin" class="col-xs-4 control-label text-info">
                    Fecha Fin
                </label>

                <div class="col-xs-4">
%{--                    <elm:datepicker name="fechaFin" title="Fecha de fin" class="datepicker form-control" value="${empresaInstance?.fechaFin}"/>--}%
                    <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${empresaInstance?.fechaFin?.format("dd-MM-yyyy")}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteDiario', 'error')} ">
            <span class="grupo">
                <label for="numeroComprobanteDiario" class="col-xs-6 control-label text-info">
                    Número Comprobante Diario
                </label>

                <div class="col-xs-2">
                    <g:textField name="numeroComprobanteDiario" maxlength="20" class="number form-control" value="${empresaInstance?.numeroComprobanteDiario}" type="number"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteIngreso', 'error')} ">
            <span class="grupo">
                <label for="numeroComprobanteIngreso" class="col-xs-6 control-label text-info">
                    Número Comprobante Ingreso
                </label>

                <div class="col-xs-2">
                    <g:textField name="numeroComprobanteIngreso" maxlength="20" class="number form-control" value="${empresaInstance?.numeroComprobanteIngreso}" type="number"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'numeroComprobanteEgreso', 'error')} ">
            <span class="grupo">
                <label for="numeroComprobanteEgreso" class="col-xs-6 control-label text-info">
                    Número Comprobante Egreso
                </label>

                <div class="col-xs-2">
                    <g:textField name="numeroComprobanteEgreso" maxlength="20" class="number form-control" value="${empresaInstance?.numeroComprobanteEgreso}" type="number"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoDiario', 'error')} ">
            <span class="grupo">
                <label for="prefijoDiario" class="col-xs-6 control-label text-info">
                    Prefijo Diario
                </label>

                <div class="col-xs-3">
                    <g:textField name="prefijoDiario" maxlength="20" class="form-control" value="${empresaInstance?.prefijoDiario}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoEgreso', 'error')} ">
            <span class="grupo">
                <label for="prefijoEgreso" class="col-xs-6 control-label text-info">
                    Prefijo Egreso
                </label>

                <div class="col-xs-3">
                    <g:textField name="prefijoEgreso" maxlength="20" class="form-control" value="${empresaInstance?.prefijoEgreso}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'prefijoIngreso', 'error')} ">
            <span class="grupo">
                <label for="prefijoIngreso" class="col-xs-6 control-label text-info">
                    Prefijo Ingreso
                </label>

                <div class="col-xs-3">
                    <g:textField name="prefijoIngreso" maxlength="20" class="form-control" value="${empresaInstance?.prefijoIngreso}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'obligadaContabilidad', 'error')} ">
            <span class="grupo">
                <label for="obligadaContabilidad" class="col-xs-6 control-label text-info">
                    Obligado a llevar contabilidad
                </label>

                <div class="col-xs-6">
                    <g:checkBox name="obligadaContabilidad_name" id="obligadaContabilidad" class="form-control" data-on-Label="Si" checked="${empresaInstance?.obligadaContabilidad == '1' ?: false}"/>
                </div>

            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'establecimientos', 'error')} ">
            <span class="grupo">
                <label for="tipoEmision" class="col-xs-6 control-label text-info">
                    Emisión Física o Electrónica
                </label>

                <div class="col-xs-6">
%{--                    <g:select class="form-control required tipoD" from="${['F': 'Física', 'E':'Electrónica']}" optionValue="value" optionKey="key"--}%
%{--                              name="tipoEmision" value="${empresaInstance?.tipoEmision?:'F'}"--}%
%{--                              title="Tipo de Emisión de Facturas"/>--}%

                    <g:checkBox name="tipoEmision_name" id="tipoEmision" class="form-control" data-on-Label="Electrónica" data-off-Label="Física" checked="${empresaInstance?.tipoEmision == 'E' ?: false}"/>



                </div>

            </span>
        </div>



        <div class="form-group keeptogether ${hasErrors(bean: empresaInstance, field: 'ambiente', 'error')} ">
            <span class="grupo">
                <label for="ambiente" class="col-xs-6 control-label text-info">
                    Ambiente de trabajo
                </label>

                <div class="col-xs-6">
                    <g:checkBox name="ambiente_name" id="ambiente" class="form-control" data-on-Label="Producción" data-off-Label="Pruebas" checked="${empresaInstance?.ambiente == '2' ?: false}"/>
                </div>

            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    $(function () {
        $('#datetimepicker1, #datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'closeText'
            }
        });
    });

    $(function() {
        $("#obligadaContabilidad").checkboxpicker({
        });

        $("#ambiente, #contribuyenteEspecial, #tipoEmision").checkboxpicker({
        });
    });


    var validator = $("#frmEmpresa").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });




    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });

    function validarLista(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 188);
    }


    $(".validaLista").keydown(function (ev) {
        return validarLista(ev);
    }).keyup(function () {
    });



</script>
