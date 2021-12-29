<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/12/21
  Time: 12:19
--%>



<g:form class="form-horizontal" name="frmParametrosAuxiliares" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${parametrosAuxiliaresInstance?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'iva', 'error')} required">
        <span class="grupo">
            <label for="iva" class="col-md-3 control-label text-info">
                IVA
            </label>
            <div class="col-md-3">
                <g:textField name="iva" class="number form-control required" value="${fieldValue(bean: parametrosAuxiliaresInstance, field: 'iva')}" required="" maxlength="2"/>
            </div>
        </span>
    </div>
    <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaInicio', 'error')} required">
        <span class="grupo">
            <label for="fechaInicio" class="col-md-3 control-label text-info">
                Fecha Desde
            </label>

            <div class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control required" value="${parametrosAuxiliaresInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>
%{--                <elm:datepicker name="fechaInicio" title="Fecha de Inicio" class="datepicker form-control required" maxDate="-5y"--}%
%{--                                value="${parametrosAuxiliaresInstance?.fechaInicio}"/>--}%
            </div>

        </span>
    </div>
    <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label for="fechaFin" class="col-md-3 control-label text-info">
                Fecha Hasta
            </label>

            <div class="col-md-4">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${parametrosAuxiliaresInstance?.fechaFin?.format("dd-MM-yyyy")}"/>

%{--                <elm:datepicker name="fechaFin" title="Fecha de Fin" class="datepicker form-control"--}%
%{--                                value="${parametrosAuxiliaresInstance?.fechaFin}"/>--}%
            </div>

        </span>
    </div>


</g:form>

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


    var validator = $("#frmParametrosAuxiliares").validate({
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
</script>

