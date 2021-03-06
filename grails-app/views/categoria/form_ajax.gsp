<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/10/21
  Time: 10:13
--%>

<g:form class="form-horizontal" name="frmCategoria" role="form" action="saveCategoria_ajax" method="POST">
    <g:hiddenField name="id" value="${categoria?.id}" />

    <div class="form-group ${hasErrors(bean: categoria, field: 'orden', 'error')} required">
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <div class="col-md-2">
                <g:textField name="orden" maxlength="2" required="" class="form-control required rucId" value="${categoria?.orden}"/>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: categoria, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-6">
                <g:textField name="descripcion" maxlength="31" required="" class="form-control required" value="${categoria?.descripcion}"/>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $(function () {
        $("#orden").blur(function () {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'categoria', action: 'validarOrden_ajax')}',
                data:{
                    orden: $("#orden").val(),
                    id: "${categoria?.id}"
                },
                success: function (msg) {
                    if(msg == "false"){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i> Número de orden ya ingresado")
                        $("#orden").val('')
                    }
                }
            });
        });
    });

    var validator = $("#frmCategoria").validate({
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
        },
        rules          : {
            ruc : {
                remote : {
                    url  : "${createLink(controller: 'categoria' , action: 'validarOrden_ajax')}",
                    type : "post",
                    data : {
                        id : "${categoria.id}",
                        orden: $("#orden").val()
                    }
                }
            }
        },
        messages       : {
            ruc : {
                remote : "Número de orden ya ingresado"
            }
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
