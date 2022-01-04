<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/01/22
  Time: 11:17
--%>

<!DOCTYPE html>
<html>
<head>
    <title>Tienda en Línea</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Smart Shop Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

    <asset:link rel="icon" href="favicon.png" type="image/x-ico"/>
    <title>Tienda en Línea</title>

    <!-- Bootstrap core CSS -->
    <asset:stylesheet src="/apli/bootstrap.css"/>
    <asset:stylesheet src="/apli/pignose.layerslider.css"/>
    <asset:stylesheet src="/apli/style.css"/>
    <asset:stylesheet src="/fonts/fontawesome-webfont.woff"/>

    <asset:javascript src="/apli/jquery-2.1.4.min.js"/>
    <asset:javascript src="/apli/simpleCart.min.js"/>
    <asset:javascript src="/apli/bootstrap-3.1.1.min.js"/>
    <asset:javascript src="/apli/jquery.easing.min.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/js/jquery.validate.min.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/js/jquery.validate.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/localization/messages_es.js"/>
    <asset:javascript src="/apli/functions.js"/>
    <asset:javascript src="/apli/bootbox.js"/>
    <asset:javascript src="/apli/fontawesome.all.min.js"/>
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>

    <style type="text/css">
    .page-head {
        background: url("${request.contextPath}/principal/getImgnProd?ruta=ba2.jpg&tp=v&id=1") no-repeat center;
        background-size: cover;
        -webkit-background-size: cover;
        -o-background-size: cover;
        -ms-background-size: cover;
        -moz-background-size: cover;
        min-height: 217px;
        padding-top: 85px;
    }

    .textoColor{
        color: #000000 !important;
    }

    .espa{
        margin-top: 5px;
        margin-bottom: 5px;
    }

    </style>

</head>
<body>
<!-- header -->
<div class="header">
    <div class="container">
        <ul>
            <li><span class="glyphicon glyphicon-time" aria-hidden="true"></span>Envios a nivel nacional</li>
            %{--            <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>Entrega gratuita de su orden</li>--}%
            <li><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:info@example.com">Contáctenos</a></li>
            <g:if test="${session.cliente}">
                <li><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span><a href="${createLink(controller: 'cliente', action: 'logout')}" class="use1" ><span>Cerrar sesión ${cliente?.nombre}</span></a></li>
            </g:if>
            <g:else>
                <li><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span><a href="#" class="use1" data-toggle="modal" data-target="#myModal4"><span>Cliente</span></a></li>
            </g:else>

            <li><a href="${createLink(controller: 'login', action: 'login')}"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>Admin</a></li>
        </ul>
    </div>
</div>
<!-- //header -->

<div class="page-head">
    <div class="container">
        <h3>Datos del cliente</h3>
    </div>
</div>
<!-- //banner -->
<!-- check out -->
<div class="checkout">
    <div class="container">
        %{--        <h3>Datos del cliente</h3>--}%
        <div class="table-responsive checkout-right animated wow slideInUp" data-wow-delay=".5s">
            <form id="frmCliente">
                <div class="login-grids">
                    <div class="login">
                        <div class="login-bottom">
                            <h3>Datos personales</h3>

                            <div>
                                <h4>Nombre :</h4>
                                <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required textoColor" value="${cliente?.nombre}"/>
                            </div>
                            <div class="sign-up">
                                <h4>Apellido :</h4>
                                <g:textField name="apellido" minlength="3" maxlength="31" class="form-control required textoColor" value="${cliente?.apellido}"/>
                            </div>
                            <div class="sign-up">
                                <h4>Email :</h4>
                                <g:textField name="mail" maxlength="63" required="" class="email form-control unique noEspacios required textoColor" value="${cliente?.mail}"/>
                            </div>
                            <div class="sign-up">
                                <h4>Teléfono :</h4>
                                <g:textField name="telefono" maxlength="15" required="" class="digits form-control noEspacios required textoColor" value="${cliente?.telefono}"/>
                            </div>
                            <div class="sign-up">
                                <h4>Dirección :</h4>
                                <g:textArea name="direccion" maxlength="255" required="" class="form-control required textoColor" value="${cliente?.direccion}" style="resize: none;"/>
                            </div>
                            %{--                        </form>--}%
                        </div>
                        <div class="login-right">
                            <h3>Datos Factura</h3>
                            %{--                        <form id="frmIngreso">--}%
                            <div>
                                <h4>Tipo de cliente:</h4>
                                <g:select name="tipoPersona" from="${sri.TipoPersona.list()}" class="form-control espa" optionValue="descripcion" optionKey="id" value="${cliente?.tipoPersona?.id}"/>
                            </div>

                            <div style="margin-top: 18px">
                                <h4>Tipo :</h4>
                                <g:select name="tipoIdentificacion" from="${sri.TipoIdentificacion.list()}" class="form-control espa" optionValue="descripcion" optionKey="id" value="${cliente?.tipoIdentificacion?.id}"/>
                            </div>

                            <div style="margin-top: 16px">
                                <h4>RUC/Cédula :</h4>
                                <g:textField name="ruc" required="" class="form-control required textoColor" value="${cliente?.ruc}"/>
                            </div>

                            <div style="margin-top: 16px">
                                <h4>País:</h4>
                                <g:select name="pais" from="${retenciones.Pais.list().sort{it.nombre}}" class="form-control espa" optionValue="nombre" optionKey="id" value="${cliente?.pais?.id ?: 239}"/>
                            </div>

                            <div style="margin-top: 16px">
                                <h4>Usted es empleado o accionista de esta tienda?:</h4>
                                <g:select name="relacion" from="${['N': 'NO', 'S' : 'SI']}" class="form-control espa" optionValue="value" optionKey="key" value="${cliente?.relacion}"/>
                            </div>

                        </div>
                    </div>
                </div>
            </form>
            %{--            <div class="clearfix"></div>--}%
        </div>


        <div class="sign-up" style="text-align: center; margin-top: 20px">
            <a href="#" id="btnGuardarDatos" class="btn btn-warning btn-lg" title="Registrar nuevo cliente">
                <i class="fa fa-file"></i> Guardar
            </a>
        </div>


        %{--                <p>Al registrarse en el sistema la clave de acceso será enviada a su <strong>correo electrónico</strong>--}%
        %{--                <p>Al ingresar al sistema usted acepta nuestros <a href="#">Términos y Condiciones</a></p>--}%

        <div style="margin-top: -20px">
            <div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
                <a href="${createLink(controller: 'carrito', action: 'carrito')}"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Regresar</a>
                <a href="#">Siguiente paso <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span> </a>
            </div>
            %{--            <div class="clearfix"> </div>--}%
        </div>
    </div>
</div>


<!-- //check out -->
<!-- //product-nav -->
<div class="coupons">
    <div class="container">
        <div class="coupons-grids text-center">
            <div class="col-md-3 coupons-gd">
                <h3>Comprar es simple</h3>
            </div>
            <div class="col-md-3 coupons-gd">
                <a href="#">
                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    <h4>Ingresar</h4>
                </a>
                <p>Ingresa al sistema con tus datos</p>
            </div>
            <div class="col-md-3 coupons-gd">
                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                <h4>Seleccionar un Item</h4>
                <p>Busca lo que desea comprar y compare alternativas</p>
            </div>
            <div class="col-md-3 coupons-gd">
                <span class="glyphicon glyphicon-credit-card" aria-hidden="true"></span>
                <h4>Pagar</h4>
                <p>Tenemos varias formas de apgo para tu comodidad y seguridad</p>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<!-- footer -->
<div class="footer">
    <div class="container">
        <div class="col-md-9 footer-right">
            <div class="col-sm-6 newsleft">
                <h3>INGRESE SU EMAIL PARA RECIBIR NUESTRAS NOTIFICACIONES !</h3>
            </div>
            <div class="col-sm-6 newsright">
                <form>
                    <input type="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}" required="">
                    <input type="submit" value="Enviar">
                </form>
            </div>
            <div class="clearfix"></div>
            <div class="sign-grds">

                <div class="col-md-6 sign-gd-two">
                    <h4>Información de la tienda</h4>
                    <ul>
                        <li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>Dirección : Amazonas..., <span>Quito - Ecuador.</span></li>
                        <li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>Email : <a href="mailto:info@example.com">info@example.com</a></li>
                        <li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>Teléfono : +1234 567 567</li>
                    </ul>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>
        <p class="copy-right">&copy 2021. Tienda en Línea | <a href="http://www.tedein.com.ec/">TEDEIN S.A:</a></p>
    </div>
</div>


<script type="text/javascript">

    $("#btnGuardarDatos").click(function () {
        guardarCliente();
    });

    var validator = $("#frmCliente").validate({
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
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });

    function guardarCliente() {

        var $form = $("#frmCliente");

        if ($form.valid()) {
            var d = cargarLoader("Guardando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'carrito', action: 'guardarCliente_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    d.modal('hide');
                    if(msg == 'ok'){
                        bootbox.alert("<i class='fa fa-check text-success fa-2x'></i> Datos del cliente guardados correctamente");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1500);
                    }else{
                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-2x'></i> Error al guardar los datos del cliente")
                    }
                }
            })
        }else{
            return false
        }
    }

</script>


</body>
</html>
