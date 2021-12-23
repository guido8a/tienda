<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/12/21
  Time: 11:31
--%>

<g:if test="${!tipoPagoInstance}">
    <elm:notFound elem="TipoPago" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoPago" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoPagoInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoPagoInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>

                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="2" required="" class="allCaps form-control required"
                                 value="${tipoPagoInstance?.codigo}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoPagoInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="63" class="allCaps form-control required"
                                 value="${tipoPagoInstance?.descripcion}"/>
                </div>
            </span>
        </div>
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoPago").validate({
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

</g:else>