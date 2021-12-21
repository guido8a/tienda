<%@ page import="sri.CuentaBanco" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 16/12/21
  Time: 12:13
--%>



<g:if test="${!cuentaInstance}">
    <elm:notFound elem="Cuenta" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCuenta" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${cuentaInstance?.id}"/>
        <g:hiddenField name="padre.id" value="${cuentaInstance?.padreId}"/>
        <g:hiddenField name="nivel.id" value="${cuentaInstance?.nivelId}"/>
%{--        <g:hiddenField name="band" value="${band}"/>--}%

        <g:if test="${cuentaInstance?.padre }">
            <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'padre', 'error')} ">
                <span class="grupo">
                    <label class="col-md-3 control-label text-info">
                        Cuenta padre
                    </label>

                    <div class="col-md-9">
                        <p class="form-control-static">${cuentaInstance?.padre ?: "No tiene padre"}</p>
                    </div>

                </span>
            </div>
        </g:if>

            <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'nivel', 'error')} required">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        Nivel
                    </label>

                    <div class="col-md-2">
                        <g:if test="${cuentaInstance?.id}">
                            <g:hiddenField name="nivel" value="${cuentaInstance?.nivel?.id}"/>
                            <p class="form-control-static">${cuentaInstance?.nivel?.descripcion ?: "Sin nivel - error"}</p>
                        </g:if>
                        <g:else>
                            <g:hiddenField name="nivel" value="${sri.Nivel.findById(nivel.toInteger().plus(1)).id}"/>
                            <p class="form-control-static">${sri.Nivel.findById(nivel.toInteger().plus(1)).descripcion ?: ''}</p>
                        </g:else>
                    </div>
                </span>
            </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'numero', 'error')} required">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Número
                </label>
                <div class="col-md-5">
                    <g:textField onfocus="this.value = this.value;" name="numero" maxlength="20" required=""
                                 class="allCaps form-control required"
                                 value="${cuentaInstance?.numero ?: cuentaInstance?.padre?.numero}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-9">
                    <g:textArea name="descripcion" maxlength="127" style="resize: none" required=""
                                class="allCaps form-control required" value="${cuentaInstance?.descripcion}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'auxiliar', 'error')} ${hasErrors(bean: cuentaInstance, field: 'movimiento', 'error')}">
            <span class="grupo">
                <label for="movimiento" class="col-md-2 control-label text-info">
                    Movimiento
                </label>

                <div class="col-md-2">
                    <g:if test="${hijos == 0}">
                        <g:select name="movimiento" from="${['1' : 'SI', '0' : 'NO']}"
                                  class="form-control" value="${cuentaInstance?.movimiento ?: '0'}" optionValue="value" optionKey="key"
                                  valueMessagePrefix="cuenta.movimiento"/>
                    </g:if>
                    <g:else>
                       ${cuentaInstance.movimiento == '1' ? 'SI' : 'NO'}
                    </g:else>
                </div>
            </span>

            <span class="grupo">
                <label for="auxiliar" class="col-md-4 control-label text-info">
                    Auxiliar de Cliente/Proveedor
                </label>
                <div class="col-md-2">
                    <g:if test="${hijos == 0}">
                        <g:select name="auxiliar" from="${['S' : 'SI', 'N' : 'NO']}" optionKey="key" optionValue="value" class="form-control"
                                  value="${cuentaInstance?.auxiliar ?: 'N'}" valueMessagePrefix="cuenta.auxiliar"/>
                    </g:if>
                    <g:else>
                        ${cuentaInstance.auxiliar == 'S' ? 'SI' : 'NO'}
                    </g:else>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'retencion', 'error')} ">

            <span class="grupo">
                <label for="retencion" class="col-md-8 control-label text-info">
                    Genera Retención
                </label>

                <div class="col-md-2">
                    <g:select name="retencion" from="${['S' : 'SI','N' : 'NO']}" optionKey="key" optionValue="value" class="form-control" value="${cuentaInstance?.retencion ?: 'N'}"
                              valueMessagePrefix="cuenta.retencion" />
                </div>
            </span>

        </div>

        <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'cuentaBanco', 'error')} ">
            <span class="grupo">
                <label for="cuentaBanco" class="col-md-2 control-label text-info">
                    Cuenta Banco
                </label>

                <div class="col-md-9">
                    <g:select id="cuentaBanco" name="cuentaBanco.id" from="${sri.CuentaBanco.list()}" optionKey="id" value="${cuentaInstance?.cuentaBanco?.id}"
                              class="many-to-one form-control" noSelection="['': 'Seleccione..']"/>
                </div>

            </span>
        </div>

        <g:if test="${hijos == 0}">
            <div class="form-group ${hasErrors(bean: cuentaInstance, field: 'impuesto', 'error')} ">
                <span class="grupo">
                    <label for="impuesto" class="col-md-2 control-label text-info">
                        Impuesto
                    </label>

                    <div class="col-md-9">
                        <g:select id="impuesto" name="impuesto.id" from="${sri.Impuesto.list([sort: 'codigo'])}"
                                  optionKey="id" value="${cuentaInstance?.impuesto?.id}" class="many-to-one form-control" noSelection="['': 'Seleccione']"
                                  optionValue="${{
                                      it.nombre + ' (' + it.porcentaje + '%, ret. ' + it.retencion + '%' + (it.sri == 'BNS' ? ', bienes' : it.sri == 'SRV' ? ', servicios' : '') + ')'
                                  }}"/>
                    </div>
                </span>
            </div>
        </g:if>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCuenta").validate({
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
                numero : {
                    remote : {
                        url  : "${createLink(action: 'validarNumero_ajax')}",
                        type : "post",
                        data : {
                            id : "${cuentaInstance.id}"
                        }
                    }
                }
            },
            messages       : {
                numero : {
                    remote : "Número de cuenta ya ingresado"
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

</g:else>