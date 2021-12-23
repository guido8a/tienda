<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/12/21
  Time: 14:21
--%>

<g:if test="${!fuenteInstance}">
    <elm:notFound elem="Fuente" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmFuente" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${fuenteInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: fuenteInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="40" required="" class="form-control required"
                                 value="${fuenteInstance?.descripcion}"/>
                </div>
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmFuente").validate({
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