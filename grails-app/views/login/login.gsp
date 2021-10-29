<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="login">

    <title>Login</title>

</head>

<body>

<div style="text-align: center; margin-top: 22px; height: ${(flash.message) ? '640' : '570'}px;" class="well">

    <h1 class="titl" style="font-size: 32px; color: #06a">Tienda en Línea</h1>

    <elm:flashMessage tipo="${flash.tipo}" icon="${flash.icon}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

    <div class="dialog ui-corner-all" style="height: 295px;padding: 10px;width: 910px;margin: auto;margin-top: 5px">
        <a href= "${createLink(controller:'principal', action: 'index', id:1)}" style="text-decoration: none">
            <div>
                <asset:image src="apli/portada.png" style="padding: 10px;"/>
            </div>
        </a>

        <div>
            <a href="#" id="ingresar" class="btn btn-primary btn-sm" style="width: 160px;" title="Ingresar al sistema">
                Ingresar <i class="fas fa-user-check"></i>
            </a>

            <a href="#" id="registro" class="btn btn-info btn-sm"  style="width: 160px;" title="Registrarse en el sistema">
                Registrarse <i class="fas fa-user-plus"></i>
            </a>
        </div>

        <p class="text-info" style="font-size: 10px; margin-top: 5px; float: right">
            <a href="http://www.tedein.com.ec">Desarrollado por: <strong>Tedein S.A.</strong>
                <asset:image src="logo tedein pq.jpeg" style="height: 22px; width: 22px; margin-left: 10px"/>
            </a>
        </p>
        <p class="text-info pull-left" style="font-size: 10px; margin-top: 5px; float: left">
            Versión ${message(code: 'version', default: '1.1.0x')}
        </p>
    </div>

    <div class="modal fade" id="modal-ingreso" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
        <div class="modal-dialog" id="modalBody" style="width: 380px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Ingreso al Sistema</h4>
                </div>

                <div class="modal-body" style="width: 280px; margin: auto">
                    <g:form name="frmLogin" action="validar" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-md-5" for="login">Usuario</label>
                            <div class="controls col-md-5">
                                <input name="login" id="login" type="text" class="form-control required"
                                       placeholder="Usuario" required autofocus style="width: 160px;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-5" for="pass">Contraseña</label>

                            <div class="controls col-md-5">
                                <input name="pass" id="pass" type="password" class="form-control required"
                                       placeholder="Contraseña" required style="width: 160px;">
                            </div>
                        </div>

                        <div class="divBtn" style="width: 100%">
                            <a href="#" class="btn btn-primary btn-lg btn-block" id="btn-login"
                               style="width: 140px; margin: auto">
                                <i class="fa fa-lock"></i> Validar
                            </a>
                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>

%{--    <div class="modal fade" id="modal-registro" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">--}%
%{--        <div class="modal-dialog" id="modalBodyRegistro" style="width: 380px;">--}%
%{--            <div class="modal-content">--}%
%{--                <div class="modal-header">--}%
%{--                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
%{--                    <h4 class="modal-title">Registro en el Sistema</h4>--}%
%{--                </div>--}%

%{--                <div class="modal-body" style="width: 280px; margin: auto">--}%

%{--                    <g:form class="form-horizontal" name="frmRegistro" role="form" controller="persona" action="saveRegistro_ajax" method="POST">--}%
%{--                        <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'tipoPersona', 'error')} required">--}%
%{--                            <div class="col-md-6">--}%
%{--                                <span class="grupo">--}%
%{--                                    <label for="tipoPersona" class="col-md-4 control-label">--}%
%{--                                        Tipo Persona--}%
%{--                                    </label>--}%
%{--                                    <div class="col-md-8">--}%
%{--                                        <g:select name="tipoPersona" from="${[0: 'Natural', 1:'Jurídica']}" optionKey="key" optionValue="value" class="form-control"/>--}%
%{--                                    </div>--}%
%{--                                </span>--}%
%{--                            </div>--}%
%{--                        </div>--}%

%{--                        <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'nombre', 'error')} ${hasErrors(bean: persona, field: 'apellido', 'error')} required">--}%
%{--                            <div class="col-md-6">--}%
%{--                                <span class="grupo">--}%
%{--                                    <label for="nombre" class="col-md-4 control-label">--}%
%{--                                        Nombre--}%
%{--                                    </label>--}%

%{--                                    <div class="col-md-8">--}%
%{--                                        <g:textField name="nombre" maxlength="40" required="" class="form-control input-sm required"/>--}%
%{--                                    </div>--}%
%{--                                </span>--}%
%{--                            </div>--}%

%{--                            <div class="col-md-6" id="divApellido">--}%
%{--                                <span class="grupo">--}%
%{--                                    <label for="apellido" class="col-md-4 control-label">--}%
%{--                                        Apellido--}%
%{--                                    </label>--}%

%{--                                    <div class="col-md-8">--}%
%{--                                        <g:textField name="apellido" maxlength="40" required="" class="form-control input-sm"/>--}%
%{--                                    </div>--}%
%{--                                </span>--}%
%{--                            </div>--}%
%{--                        </div>--}%

%{--                        <div class="form-group keeptogether ${hasErrors(bean: persona, field: 'mail', 'error')} required">--}%
%{--                            <div class="col-md-6">--}%
%{--                                <span class="grupo">--}%
%{--                                    <label for="mail" class="col-md-4 control-label">--}%
%{--                                        E-mail--}%
%{--                                    </label>--}%

%{--                                    <div class="col-md-8">--}%
%{--                                        <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>--}%
%{--                                        </span><g:field type="email" name="mail" maxlength="63" class="form-control input-sm unique noEspacios"/>--}%
%{--                                        </div>--}%
%{--                                    </div>--}%
%{--                                </span>--}%
%{--                            </div>--}%
%{--                        </div>--}%
%{--                    </g:form>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%


    <div id="cargando" class="text-center hidden">
        <img src="${resource(dir: 'images', file: 'spinner32.gif')}" alt='Cargando...' width="32px" height="32px"/>
    </div>

    <script type="text/javascript">

        $("#registro").click(function () {
            regis();
        });

        function regis(){
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'persona', action: 'registro_ajax')}",
                data    : {},
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgReg",
                        // class   : "long",
                        title   : "Registro de usuarios",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-save'></i> Guardar",
                                className : "btn-success",
                                callback  : function () {
                                    // return submitForm();
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                } //success
            }); //ajax
        } //createEdit

        var $frm = $("#frmLogin");
        var recargar = true;

        function timedRefresh(timeoutPeriod) {
            if(recargar) {
                setTimeout("location.reload(true);",timeoutPeriod);
            }
            recargar = false
        }

        function doLogin() {
            if ($frm.valid()) {
                // $("#cargando").removeClass('hidden');
                cargarLoader("Cargando...");
                $(".btn-login").replaceWith($("#cargando"));
                $("#frmLogin").submit();
            }
        }

        function doPass() {
            if ($("#frmPass").valid()) {
                $("#btn-pass").replaceWith(spinner);
                $("#frmPass").submit();
            }
        }

        $(function () {

            $("#ingresar").click(function () {
                var initModalHeight = $('#modal-ingreso').outerHeight();
                //alto de la ventana de login: 270
                // console.log("ventana")
                $("#modalBody").css({'margin-top': ($(document).height() / 2 - 135)}, {'margin-left': $(window).width() / 2});
                // console.log("antes modeal")
                $("#modal-ingreso").modal('show');
                // console.log("luego modeal")
                setTimeout(function () {
                    $("#login").focus();
                }, 500);

            });

            $("#btnOlvidoPass").click(function () {
                $("#recuperarPass-dialog").modal("show");
                $("#modal-ingreso").modal("hide");
            });

            $("#btn-login").click(function () {
                doLogin();
            });

            $("#btn-pass").click(function () {
                doPass();
            });

            $("input").keyup(function (ev) {
                if (ev.keyCode == 13) {
                    doLogin();
                }
            })

        });
    </script>
</body>
</html>