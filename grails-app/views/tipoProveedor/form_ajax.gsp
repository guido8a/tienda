<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/12/21
  Time: 11:17
--%>


    <g:form class="form-horizontal" name="frmTipoProveedor" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoProveedorInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoProveedorInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="1" required="" class="allCaps form-control required"
                                 value="${tipoProveedorInstance?.codigo}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoProveedorInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="40" required="" class="form-control required"
                                 value="${tipoProveedorInstance?.descripcion}"/>
                </div>
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoProveedor").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
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
