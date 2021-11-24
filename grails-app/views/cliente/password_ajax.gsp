<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 24/11/21
  Time: 10:12
--%>

<div class="modal-header">
    <h4 class="modal-title" style="text-align: center">Recuperación de password</h4>
</div>

<g:form class="form-horizontal" name="frmPassword" role="form" controller="cliente" action="recuperarPassword_ajax" method="POST">
    <div class="form-group keeptogether required" style="margin-top: 20px">
        <div class="row form-group">
            <label for="mail" class="col-md-2 control-label">
                E-mail <i class="fa fa-envelope"></i>
            </label>

            <div class="col-md-7 input-group">
                <g:textField name="mail" maxlength="63" required="" class="email form-control input-sm unique required"/>
            </div>
        </div>
    </div>
    <div style="text-align: center">
        <i class="fa fa-exclamation-circle text-warning"></i> La contraseña será enviada a su <strong>correo electrónico</strong>
    </div>
    <br>
</g:form>
