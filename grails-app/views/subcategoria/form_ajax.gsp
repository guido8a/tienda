<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/10/21
  Time: 13:00
--%>


<g:form class="form-horizontal" name="frmSubcategoria" role="form" action="saveSubcategoria_ajax" method="POST">
    <g:hiddenField name="id" value="${subcategoria?.id}" />

    <div class="form-group">
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Categoría
            </label>
            <div class="col-md-4">
                <g:hiddenField name="categoria" value="${categoria?.id}" />
                <g:textField name="categoria_name" readonly="true" class="form-control" value="${categoria?.descripcion}"/>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: subcategoria, field: 'orden', 'error')} required">
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <div class="col-md-2">
                <g:textField name="orden" maxlength="2" required="" class="form-control required rucId" value="${subcategoria?.orden}"/>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: subcategoria, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <div class="col-md-6">
                <g:textField name="descripcion" maxlength="63" required="" class="form-control required" value="${subcategoria?.descripcion}"/>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $(function () {
        $("#orden").blur(function () {
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'subcategoria', action: 'validarOrdenSub_ajax')}',
                data:{
                    categoria: '${categoria?.id}',
                    orden: $("#orden").val(),
                    id: "${subcategoria?.id}"
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

    var validator = $("#frmSubcategoria").validate({
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
                    url  : "${createLink(controller: 'subcategoria' , action: 'validarOrdenSub_ajax')}",
                    type : "post",
                    data : {
                        categoria: '${categoria?.id}',
                        id : "${subcategoria.id}",
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
