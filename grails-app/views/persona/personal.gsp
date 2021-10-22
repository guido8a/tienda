<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Configuración</title>

    <style type="text/css">
    .auth {
        width : 155px !important;
    }

    </style>

</head>

<body>

%{--<div>--}%
    <!-- Nav tabs -->
    <ul class="nav nav-pills" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Datos de la cuenta</a></li>
        <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">
            Datos del contacto para ventas</a></li>
        <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Cambiar contraseña</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="home">

            <div class="panel panel-warning" style="margin-top: 10px">
                <div class="panel-heading" role="tab" id="headerInfo">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#info" aria-expanded="true" aria-controls="info">
                            Datos de la cuenta
                        </a>
                    </h4>
                </div>
                <div id="info" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headerInfo">
                    <div class="panel-body">

                        <g:form class="form-horizontal" name="frmInfo" role="form" controller="persona" action="savePersona_ajax" method="POST">

                            <g:hiddenField name="id" value="${persona?.id}"/>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'tipoPersona', 'error')} required" style="margin-top: 20px">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="tipoPersona" class="col-md-3 control-label">
                                            Tipo Persona
                                        </label>
                                        <div class="col-md-6">
                                            <g:select name="tipoPersona" from="${['N': 'Natural', 'J':'Jurídica']}" optionKey="key"
                                                      optionValue="value" class="form-control" value="${persona?.tipoPersona}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'nombre', 'error')} required">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="nombre" class="col-md-3 control-label">
                                            Nombre
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="nombre" maxlength="31" required="" class="form-control input-sm required" value="${persona?.nombre}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether  ${hasErrors(bean: persona, field: 'apellido', 'error')}" id="divApellido">
                                <div class="col-md-12" >
                                    <span class="grupo">
                                        <label for="apellido" class="col-md-3 control-label">
                                            Apellido
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="apellido" maxlength="31" class="form-control input-sm" value="${persona?.apellido}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether  ${hasErrors(bean: persona, field: 'cedula', 'error')}" >
                                <div class="col-md-12" >
                                    <span class="grupo">
                                        <label for="cedula" class="col-md-3 control-label">
                                            Cédula/RUC
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="cedula" maxlength="13" class="form-control input-sm" value="${persona?.cedula}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'telefono', 'error')}">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="telefono" class="col-md-3 control-label">
                                            Teléfono
                                        </label>

                                        <div class="col-md-3">
                                            <g:textField name="telefono" maxlength="31" class="form-control input-sm noEspacios " value="${persona?.telefono}"/>
                                        </div>
                                        <label for="telefono" class="col-md-1 control-label">
                                            Sexo
                                        </label>

                                        <div class="col-md-2">
                                            <g:select name="sexo" from="${['F':'Femenino', 'M':'Masculino']}" value="${persona?.sexo}" class="form-control" optionKey="key" optionValue="value"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'mail', 'error')} required">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="mail" class="col-md-3 control-label">
                                            E-mail
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="mail" maxlength="63" required="" class="email form-control input-sm unique noEspacios required" value="${persona?.mail}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'direccion', 'error')}">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="direccion" class="col-md-3 control-label">
                                            Dirección
                                        </label>
                                        <div class="col-md-6">
                                            <g:textArea name="direccion" maxlength="255" class="form-control input-sm " value="${persona?.direccion}" style="resize: none"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'referencia', 'error')}">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="referencia" class="col-md-3 control-label">
                                            Referencia
                                        </label>
                                        <div class="col-md-6">
                                            <g:textArea name="referencia" maxlength="255" class="form-control input-sm " value="${persona?.referencia}" style="resize: none"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'canton', 'error')} ">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="provincia" class="col-md-3 control-label">
                                            Provincia
                                        </label>
                                        <div class="col-md-6">
                                            <g:select name="provincia" from="${geografia.Provincia?.list().sort{it.nombre}}" optionKey="id"
                                                      optionValue="nombre" class="form-control" value="${persona?.canton?.provincia?.id}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'canton', 'error')} ">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label class="col-md-3 control-label">
                                            Cantón
                                        </label>
                                        <div class="col-md-6" id="divCanton">

                                        </div>
                                    </span>
                                </div>
                            </div>

                        </g:form>

                        <div class="col-md-6">
                            <a href="#" id="btnSaveInfo" class="btn btn-rojo" style="float: right">
                                <i class="fa fa-save"></i> Guardar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div role="tabpanel" class="tab-pane" id="messages">

            <div class="panel panel-warning" style="margin-top: 10px">
                <div class="panel-heading" role="tab" id="headerContacto">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#contacto" aria-expanded="true" aria-controls="contacto">
                            Datos del contacto para Ventas
                        </a>
                    </h4>
                </div>
                <div id="contacto" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headerContacto">
                    <div class="panel-body">

                        <g:form class="form-horizontal" name="frmContacto" role="form" controller="persona" action="savePersona_ajax" method="POST">

                            <g:hiddenField name="id" value="${persona?.id}"/>


                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'contacto', 'error')} required">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="contacto" class="col-md-3 control-label">
                                            Nombre de contacto
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="contacto" maxlength="63" required="" class="form-control input-sm required" value="${persona?.contacto}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'telefono', 'error')}">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="telefonoContacto" class="col-md-3 control-label">
                                            Teléfono de contacto
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="telefonoContacto" maxlength="63" class="form-control input-sm noEspacios " value="${persona?.telefonoContacto}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'mailContacto', 'error')} required">
                                <div class="col-md-12">
                                    <span class="grupo">
                                        <label for="mailContacto" class="col-md-3 control-label">
                                            E-mail
                                        </label>

                                        <div class="col-md-6">
                                            <g:textField name="mailContacto" maxlength="63" required="" class="email form-control input-sm unique noEspacios required" value="${persona?.mailContacto}"/>
                                        </div>
                                    </span>
                                </div>
                            </div>

                        </g:form>

                        <div class="col-md-12" style="text-align: center">
                            <a href="#" id="btnSaveContacto" class="btn btn-rojo">
                                <i class="fa fa-save"></i> Guardar
                            </a>
                        </div>

                        <div class="col-md-12">
                            <div class="text-primary"><strong>Nota</strong>: Se le enviarán al <strong>mail del Contacto</strong> las preguntas que se hagan sobre su anuncio y los datos de quienes
                            deseen contactar con el anunciante.</div>
                        </div>



                    </div>
                </div>
            </div>

        </div>


%{--        <div role="tabpanel" class="tab-pane" id="messages">--}%
            <div role="tabpanel" class="tab-pane" id="settings">

                <div class="panel panel-warning" style="margin-top: 10px">
                    <div class="panel-heading" role="tab" id="headerPass">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                                Cambiar la contraseña de ingreso al sistema
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headerPass">
                        <div class="panel-body">
                            <g:form class="form-inline" name="frmPass" action="savePass_ajax">
                                <g:hiddenField name="id" value="${persona?.id}"/>
                                <div class="form-group" style="margin-left: 40px;">
                                    <label for="nuevoPass">Nueva contraseña</label>

                                    <div class="input-group">
                                        <g:passwordField name="nuevoPass" class="form-control required auth"/>
                                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                    </div>
                                </div>

                                <div class="form-group" style="margin-left: 40px;">
                                    <label for="passConfirm">Confirme la contraseña nueva</label>

                                    <div class="input-group">
                                        <g:passwordField name="passConfirm" class="form-control required auth"/>
                                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                    </div>
                                </div>
                                <a href="#" id="btnSavePass" class="btn btn-rojo" style="margin-left: 40px;">
                                    <i class="fa fa-save"></i> Guardar
                                </a>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
%{--        </div>--}%
    </div>

%{--</div>--}%

<script type="text/javascript">

    cargarCanton($("#provincia").val());

    $("#provincia").change(function () {
        var id = $(this).val();
        cargarCanton(id)
    });

    function cargarCanton(id){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'persona', action: 'canton_ajax')}',
            data:{
                id: id,
                persona: '${persona?.id}'
            },
            success: function (msg) {
                $("#divCanton").html(msg)
            }
        })
    }

    cargarTipo($("#tipoPersona").val());


    $("#tipoPersona").change(function () {
        var tipo = $(this).val();
        cargarTipo(tipo)
    });

    function cargarTipo(tipo){
        if(tipo == 'J'){
            $("#divApellido").hide()
        }else{
            $("#divApellido").show()
        }
    }

    $("#btnSaveInfo").click(function () {
        var $frmInfo = $("#frmInfo");
        if ($frmInfo.valid()) {
            var b = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $frmInfo.attr("action"),
                data    : $frmInfo.serialize(),
                success : function (msg) {
                    b.modal("hide")
                    if(msg == 'ok'){
                        log("Guardado correctamente","success")
                    }else{
                        log("Error al guardar la información")
                    }
                }
            });
        }
    });

    $("#btnSaveContacto").click(function () {
        var $frmContacto = $("#frmContacto");
        if ($frmContacto.valid()) {
            var a = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $frmContacto.attr("action"),
                data    : $frmContacto.serialize(),
                success : function (msg) {
                    a.modal("hide")
                    if(msg == 'ok'){
                        log("Guardado correctamente","success")
                    }else{
                        log("Error al guardar la información")
                    }
                }
            });
        }
    });


    $(function () {
        var $frmPass = $("#frmPass");

        $("#btnSavePass").click(function () {

            if ($frmPass.valid()) {
                $.ajax({
                    type    : "POST",
                    url     : $frmPass.attr("action"),
                    data    : $frmPass.serialize(),
                    success : function (msg) {
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            bootbox.alert(parts[1]);
                            setTimeout(function () {
                                location.href = "${createLink(controller: "login", action: "logout" )}"
                            }, 1000);
                        }else{
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i>"  + parts[1])
                        }
                    }
                });
            }
            return false;
        });
    });
</script>

</body>
</html>