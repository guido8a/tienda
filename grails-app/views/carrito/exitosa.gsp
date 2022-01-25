<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 25/01/22
  Time: 11:13
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
        <h3>Compra Exitosa!</h3>
    </div>
</div>
<!-- //banner -->
<!-- check out -->
<div class="checkout">
    <div class="container" style="text-align: center">

        <i class="fa fa-hand-peace fa-3x text-success"></i> Gracias por comprar con nosotros! </br>
        <i class="fa fa-check fa-3x text-warning"></i>  Su compra está siendo procesada y será aprobada muy pronto.


        <div style="margin-top: -20px">
            <div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
                <a href="${createLink(controller: 'principal', action: 'index')}"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Página principal</a>
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

</script>


</body>
</html>
