<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/11/21
  Time: 10:18
--%>

<g:form class="form-horizontal" name="frmAtributo" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${atributo?.id}" />
    <g:hiddenField name="producto" value="${producto?.id}" />

    <div class="form-group ${hasErrors(bean: atributo, field: 'orden', 'error')} required">
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <div class="col-md-4">
                <g:textField name="orden" maxlength="2" required="" class="digits form-control required allCaps" value="${atributo?.orden}"/>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: atributo, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-6">
                <g:textArea name="descripcion" maxlength="63" required="" style="height: 80px; width: 400px; resize: none" class="form-control required" value="${atributo?.descripcion}"/>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    $(function () {
        $("#orden").blur(function () {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'atributo', action: 'validarOrden_ajax')}',
                data:{
                    orden: $("#orden").val(),
                    id: "${atributo?.id}"
                },
                success: function (msg) {
                    if(msg == "false"){
                        $("#orden").val('')
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i> El número de orden ya se encuentra ingresado")
                    }
                }
            });
        });
    });


    var validator = $("#frmAtributo").validate({
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
                    url  : "${createLink(action: 'validarOrden_ajax')}",
                    type : "post",
                    data : {
                        id : "${atributo.id}",
                        ruc: $("#orden").val()
                    }
                }
            }
        },
        messages       : {
            ruc : {
                remote : "Orden ya ingresado"
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
