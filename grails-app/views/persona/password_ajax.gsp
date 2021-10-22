<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/04/21
  Time: 12:15
--%>


<div class="modal-header">
    <h4 class="modal-title" style="text-align: center">Recuperación de password</h4>
</div>

<g:form class="form-horizontal" name="frmPassword" role="form" controller="persona" action="recuperarPassword_ajax" method="POST">
    <div class="form-group keeptogether required" style="margin-top: 20px">
        <div class="row form-group">
            <label for="mail" class="col-md-2 control-label">
                E-mail
            </label>

            <div class="col-md-8 input-group">
                <span class="input-group-text" id="basic-addon4"><i class="fa fa-envelope"></i></span>
                <g:textField name="mail" maxlength="63" required="" class="email form-control input-sm unique required"/>
            </div>
        </div>
    </div>
%{--    <br/>--}%
    <br><i class="fa fa-exclamation-circle text-warning"></i> La contraseña será enviada a su <strong>correo electrónico</strong>
</g:form>
%{--</div>--}%

<script type="text/javascript">



</script>