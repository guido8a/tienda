<%@ page import="seguridad.Prfl; seguridad.Persona" %>


<style type="text/css">

option[selected]{
    background-color: yellow;
}

</style>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
    <g:form class="form-horizontal" name="frmPersona" role="form" controller="persona" action="savePersona_ajax" method="POST">
        <g:hiddenField name="empresa" value="${empresa?.id}"/>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label">
                    Nombre
                </label>

                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="40" required="" class="form-control input-sm required" value="${personaInstance?.nombre}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
            <span class="grupo">
                <label for="apellido" class="col-md-2 control-label">
                    Apellido
                </label>

                <div class="col-md-8">
                    <g:textField name="apellido" maxlength="40" required="" class="form-control input-sm required" value="${personaInstance?.apellido}"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'cedula', 'error')}">
            <span class="grupo">
                <label for="cedula" class="col-md-2 control-label">
                    Cédula
                </label>

                <div class="col-md-6">
                    <g:textField name="cedula" maxlength="10" class="form-control input-sm required digits" value="${personaInstance?.cedula}"/>
                </div>
            </span>

            <span class="grupo">

                <label for="activo" class="col-md-1 control-label">
                    Activo
                </label>

                <div class="col-md-2">
                    <g:select name="activo" value="${personaInstance.activo}" class="form-control input-sm required" required=""
                              from="${[1: 'Sí', 0: 'No']}" optionKey="key" optionValue="value"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} required">
            %{--                <div class="col-md-6">--}%
            <span class="grupo">
                <label for="mail" class="col-md-2 control-label">
                    E-mail
                </label>

                <div class="col-md-6">
                    <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                    </span><g:field type="email" name="mail" maxlength="63" class="form-control input-sm unique noEspacios required" value="${personaInstance?.mail}"/>
                    </div>
                </div>
            </span>

            <span class="grupo">
                <label for="sexo" class="col-md-1 control-label">
                    Sexo
                </label>

                <div class="col-md-3">
                    <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" required="" optionKey="key" optionValue="value"
                              class="form-control input-sm required" value="${personaInstance?.sexo}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-2 control-label">
                    Teléfono
                </label>

                <div class="col-md-6">
                    <g:textField name="telefono" maxlength="31" class="form-control input-sm digits" value="${personaInstance?.telefono}"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'direccion', 'error')} ">
            <span class="grupo">
                <label for="direccion" class="col-md-2 control-label">
                    Dirección
                </label>

                <div class="col-md-10">
                    <g:textArea name="direccion" cols="80" rows="1" maxlength="255" class="form-control input-sm" value="${personaInstance?.direccion}" style="resize: none"/>
                </div>
            </span>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'referencia', 'error')} ">
            <span class="grupo">
                <label for="referencia" class="col-md-2 control-label">
                    Referencia
                </label>
                <div class="col-md-10">
                    <g:textArea name="referencia" cols="80" rows="1" maxlength="255" class="form-control input-sm" value="${personaInstance?.referencia}" style="resize: none"/>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'login', 'error')} required">
            <g:hiddenField name="id" value="${personaInstance?.id}"/>

            <span class="grupo">
                <label for="password" class="col-md-2 control-label">
                    Usuario
                </label>
                <div class="col-md-6">
                    <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-user"></i>
                    </span><g:textField name="login"  maxlength="255" class="form-control input-sm noEspacios required" value="${personaInstance?.login ?: ''}"/>
                    </div>
                </div>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'password', 'error')} required">

            <span class="grupo">
                <label for="password" class="col-md-2 control-label">
                    Password
                </label>
                <div class="col-md-6">
                    <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-key"></i>
                    </span><g:field type="password" name="password"  maxlength="63" class="form-control input-sm noEspacios required" value="${personaInstance?.password ?: ''}"/>
                    </div>
                </div>
            </span>
        </div>
        </div>
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPersona").validate({
            errorClass    : "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success       : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            },
            rules         : {
                mail : {
                    remote: {
                        url : "${createLink(action: 'validarMail_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                },
                login: {
                    remote: {
                        url : "${createLink(action: 'validarLogin_ajax')}",
                        type: "post",
                        data: {
                            id: "${personaInstance?.id}"
                        }
                    }
                }
            },
            messages      : {
                mail : {
                    remote: "Ya existe Mail"
                },
                login: {
                    remote: "Ya existe Login"
                }
            }
        });

        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormPersona();
                return false;
            }
            return true;
        });

        // $("#btn-addPerfil").click(function () {
        //     var $perfil = $("#perfil");
        //     var idPerfilAdd = $perfil.val();
        //     $(".perfiles").each(function () {
        //         if ($(this).data("id") == idPerfilAdd) {
        //             $(this).remove();
        //         }
        //     });
        //     var $tabla = $("#tblPerfiles");
        //
        //     var $tr = $("<tr>");
        //     $tr.addClass("perfiles");
        //     $tr.data("id", idPerfilAdd);
        //     var $tdNombre = $("<td>");
        //     $tdNombre.text($perfil.find("option:selected").text());
        //     var $tdBtn = $("<td>");
        //     $tdBtn.attr("width", "35");
        //     var $btnDelete = $("<a>");
        //     $btnDelete.addClass("btn btn-danger btn-xs");
        //     $btnDelete.html("<i class='far fa-trash-alt'></i> ");
        //     $tdBtn.append($btnDelete);
        //
        //     $btnDelete.click(function () {
        //         $tr.remove();
        //         return false;
        //     });
        //
        //     $tr.append($tdNombre).append($tdBtn);
        //
        //     $tabla.prepend($tr);
        //     $tr.effect("highlight");
        //
        //     return false;
        // });
        //
        // $(".btn-deletePerfil").click(function () {
        //     $(this).parents("tr").remove();
        //     return false;
        // });

        $("input[maxlength]").maxlength( {
            alwaysShow: true,
            threshold: 10,
            warningClass: "label label-success",
            limitReachedClass: "label label-danger"
        });
        $("textarea[maxlength]").maxlength();

    </script>

</g:else>