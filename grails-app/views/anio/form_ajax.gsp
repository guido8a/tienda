<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/12/21
  Time: 15:24
--%>


    <g:form class="form-horizontal" name="frmAnio" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${anioInstance?.id}" />

        <div class="form-group ${hasErrors(bean: anioInstance, field: 'anio', 'error')} ">
            <span class="grupo">
                <label for="anio" class="col-md-3 control-label text-info">
                    Año
                </label>
                <div class="col-md-4">
%{--                    <g:textField name="anio" required="" maxlength="4" minlength="4" class="digits allCaps form-control required" value="${anioInstance?.anio}"/>--}%
                    <input name="anio" id='datetimepicker1' type='text' class="digits form-control required" value="${anioInstance?.anio}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: anioInstance, field: 'sueldoBasico', 'error')} ">
            <span class="grupo">
                <label for="sueldoBasico" class="col-md-3 control-label text-info">
                    Sueldo Básico
                </label>
                <div class="col-md-4">
                    <g:textField name="sueldoBasico" required="" class="number form-control required" value="${anioInstance?.sueldoBasico}"/>
                </div>
            </span>
        </div>
    </g:form>

    <script type="text/javascript">

        $(function () {
            $('#datetimepicker1').datetimepicker({
                locale: 'es',
                format: 'YYYY',
                showClose: true,
                icons: {
                    close: 'closeText'
                }
            });
        });

        var validator = $("#frmAnio").validate({
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
