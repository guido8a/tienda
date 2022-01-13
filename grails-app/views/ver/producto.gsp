<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
    <title>Tienda en Línea</title>
    <asset:link rel="icon" href="favicon.png" type="image/x-ico"/>
    <title>Tienda en Línea</title>

    <asset:stylesheet src="/apli/bootstrap.css"/>
    <asset:stylesheet src="/apli/pignose.layerslider.css"/>
    <asset:stylesheet src="/apli/style.css"/>
    <asset:stylesheet src="/fonts/fontawesome-webfont.woff"/>
    <asset:stylesheet src="/flexslider/flexslider.css"/>

    <asset:javascript src="/apli/jquery-2.1.4.min.js"/>
    <asset:javascript src="/apli/simpleCart.min.js"/>
    <asset:javascript src="/apli/bootstrap-3.1.1.min.js"/>
    <asset:javascript src="/apli/jquery.easing.min.js"/>
    <asset:javascript src="/flexslider/jquery.flexslider.js"/>
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
        /*background: url(../images/ba2.jpg) no-repeat center;*/
        background: url("${request.contextPath}/principal/getImgnProd?ruta=ba2.jpg&tp=v&id=1") no-repeat center;
        background-size: cover;
        -webkit-background-size: cover;
        -o-background-size: cover;
        -ms-background-size: cover;
        -moz-background-size: cover;
        min-height: 217px;
        padding-top: 85px;
    }

    .borde{
        border: solid 1px;
        border-color: #eeb51f;
    }

    .borde2{
        border: solid 1px;
        border-color: #797979;
    }

    .naranja{
        color: #eeb51f !important;
    }

    .relleno{
        background-color: #eeb51f !important;
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
<!-- header-bot -->
<div class="header-bot">
    <div class="container">
        <div class="col-md-3 header-left">
            <h1><a href="${appUrl}">
                <asset:image src="apli/logo3.jpg"/>
            </a></h1>
        </div>
        <div class="col-md-6 header-middle">
            <form>
                <div class="search">
                    <input type="search" value="Buscar" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Buscar';}" required="">
                </div>
                <div class="section_room">
                    <select id="categoría" class="frm-field required" style="color: #4F1B00; border-bottom-style: solid; border-color: #AF5B00; font-size: 12pt">
                        <g:each in="${ctgr}" var="tp">
                            <option value="${tp.id}" data-dscr="${tp.descripcion}" ${tp.id == grpo? 'selected=\"selected\"' : ''}>
                                ${tp.descripcion}</option>
                        </g:each>
                    </select>
                </div>
                <div class="sear-sub">
                    <input type="submit" value=" ">
                </div>
                <div class="clearfix"></div>
            </form>
        </div>
        <div class="col-md-3 header-right footer-bottom">
            <ul>
                <li><a class="fb" href="#"></a></li>
                <li><a class="twi" href="#"></a></li>
                <li><a class="insta" href="#"></a></li>
                <li><a class="you" href="#"></a></li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<!-- //header-bot -->
<!-- banner -->
<div class="ban-top">
    <div class="container">
        <div class="top_nav_left">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse menu--shylock" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav menu__list">
                            <li class="active menu__item "><a class="menu__link" href="index.html">Home <span class="sr-only">(current)</span></a></li>
                            <li class="dropdown menu__item">
                                <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">men's wear <span class="caret"></span></a>
                                <ul class="dropdown-menu multi-column columns-3">
                                    <div class="row">
                                        <div class="col-sm-6 multi-gd-img1 multi-gd-text ">
                                            <a href="mens.html"><img src="images/woo1.jpg" alt=" "/></a>
                                        </div>
                                        <div class="col-sm-3 multi-gd-img">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="mens.html">Clothing</a></li>
                                                <li><a href="mens.html">Wallets</a></li>
                                                <li><a href="mens.html">Footwear</a></li>
                                                <li><a href="mens.html">Watches</a></li>
                                                <li><a href="mens.html">Accessories</a></li>
                                                <li><a href="mens.html">Bags</a></li>
                                                <li><a href="mens.html">Caps & Hats</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-3 multi-gd-img">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="mens.html">Jewellery</a></li>
                                                <li><a href="mens.html">Sunglasses</a></li>
                                                <li><a href="mens.html">Perfumes</a></li>
                                                <li><a href="mens.html">Beauty</a></li>
                                                <li><a href="mens.html">Shirts</a></li>
                                                <li><a href="mens.html">Sunglasses</a></li>
                                                <li><a href="mens.html">Swimwear</a></li>
                                            </ul>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </ul>
                            </li>
                            <li class="dropdown menu__item">
                                <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">women's wear <span class="caret"></span></a>
                                <ul class="dropdown-menu multi-column columns-3">
                                    <div class="row">
                                        <div class="col-sm-3 multi-gd-img">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="womens.html">Clothing</a></li>
                                                <li><a href="womens.html">Wallets</a></li>
                                                <li><a href="womens.html">Footwear</a></li>
                                                <li><a href="womens.html">Watches</a></li>
                                                <li><a href="womens.html">Accessories</a></li>
                                                <li><a href="womens.html">Bags</a></li>
                                                <li><a href="womens.html">Caps & Hats</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-3 multi-gd-img">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="womens.html">Jewellery</a></li>
                                                <li><a href="womens.html">Sunglasses</a></li>
                                                <li><a href="womens.html">Perfumes</a></li>
                                                <li><a href="womens.html">Beauty</a></li>
                                                <li><a href="womens.html">Shirts</a></li>
                                                <li><a href="womens.html">Sunglasses</a></li>
                                                <li><a href="womens.html">Swimwear</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-6 multi-gd-img multi-gd-text ">
                                            <a href="womens.html"><img src="images/woo.jpg" alt=" "/></a>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </ul>
                            </li>
                            <li class=" menu__item"><a class="menu__link" href="electronics.html">Electronics</a></li>
                            <li class=" menu__item"><a class="menu__link" href="codes.html">Short Codes</a></li>
                            <li class=" menu__item"><a class="menu__link" href="contact.html">contact</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <div class="top_nav_right">
            <div class="cart box_1" id="divCarrito">

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<!-- //banner-top -->
<!-- banner -->
<div class="page-head">
    <div class="container">
        <h3>${publ.publtitl}</h3>
    </div>
</div>
<!-- //banner -->
<!-- single -->
<div class="single">
    <div class="container">
        <div class="col-md-6 single-right-left animated wow slideInUp animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInUp;">
            <!-- FlexSlider http://flexslider.woothemes.com/asnavfor-rtl.html -->
            <script>
                // Can also be used with $(document).ready()
                $(window).load(function() {
                    $('.flexslider').flexslider({
                        animation: "slide",
                        controlNav: "thumbnails"
                    });
                });
            </script>


            <div class="flexslider">
                <ul class="slides">
                    <g:each in="${carrusel}" var="p" status="i">
                        <li>
                            <img src="${request.contextPath}/principal/getImgnProd?ruta=${p.ruta}&tp=c"/>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>
        <div class="col-md-6 single-right-left simpleCart_shelfItem animated wow slideInRight animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInRight;">
            <h3>${publ.publtitl}</h3>
            <h3>${publ.publsbtl}</h3>
            <p><span class="item_price">
                Precio : &nbsp;
                ${g.formatNumber(number: publ.publpcun, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span>
                (${g.formatNumber(number: publ.publpcmy*1.1, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)} - Al por mayor)</p>

            <p style="font-size: 11px">* Precio al por mayor se aplica a partir de 10 productos en adelante.</p>
            <div class="rating1">
                <strong>Opinión : &nbsp;</strong>
                <span class="starRating">
                    <input id="rating5" type="radio" name="rating" value="5" ${estrellas == 5 ? 'checked' : ''}>
                    <label for="rating5">5</label>
                    <input id="rating4" type="radio" name="rating" value="4" ${estrellas == 4 ? 'checked' : ''}>
                    <label for="rating4">4</label>
                    <input id="rating3" type="radio" name="rating" value="3" ${estrellas == 3 ? 'checked' : ''}>
                    <label for="rating3">3</label>
                    <input id="rating2" type="radio" name="rating" value="2" ${estrellas == 2 ? 'checked' : ''}>
                    <label for="rating2">2</label>
                    <input id="rating1" type="radio" name="rating" value="1" ${estrellas == 1 ? 'checked' : ''}>
                    <label for="rating1">1</label>
                </span>
            </div>
            <div class="occasional">
                <h5>Tipo de empacado :</h5>
                <div class="colr ert">
                    <label class="radio"><input type="radio" name="radio" checked=""><i></i>Empaque de lujo</label>
                </div>
                <div class="colr">
                    <label class="radio"><input type="radio" name="radio"><i></i>Empaque normal</label>
                </div>
                <div class="colr">
                    <label class="radio"><input type="radio" name="radio"><i></i>Sin empaque</label>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="occasion-cart">
                <a href="#" class="item_add hvr-outline-out button2" data-id="${publ.publ__id}">Añadir al carrito</a>
            </div>

        </div>
        <div class="clearfix"> </div>

        <div class="bootstrap-tab animated wow slideInUp animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInUp;">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">Descripción</a></li>
                    <li role="presentation"><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">Opiniones del producto(${comentarios?.size() ?: 0})</a></li>
                    <li role="presentation" class="dropdown">
                        <a href="#adicional" role="tab" id="adicional-tab" data-toggle="tab" aria-controls="adicional">Información adicional</a>
                        %{--                        <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown" aria-controls="myTabDrop1-contents">Información adicional <span class="caret"></span></a>--}%
                        %{--                        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1" id="myTabDrop1-contents">--}%
                        %{--                            <li><a href="#dropdown1" tabindex="-1" role="tab" id="dropdown1-tab" data-toggle="tab" aria-controls="dropdown1">Forma de lavar</a></li>--}%
                        %{--                            <li><a href="#dropdown2" tabindex="-1" role="tab" id="dropdown2-tab" data-toggle="tab" aria-controls="dropdown2">Almacenamiento</a></li>--}%
                        %{--                        </ul>--}%
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active bootstrap-tab-text" id="home" aria-labelledby="home-tab">
                        <h5>Descripción</h5>
                        <p>
                            <span>${raw(publ.publtxto)}</span>
                        </p>
                    </div>
                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="profile" aria-labelledby="profile-tab">
                        <div class="bootstrap-tab-text-grids">


                            <g:if test="${comentarios}">
                                <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
                                    <thead style="width: 100%">
                                    <tr>
                                        <th style="width: 15%; font-size: 18px !important;" class="naranja">Calificación</th>
                                        <th style="width: 85%; font-size: 18px !important;" class="naranja">Comentario</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${comentarios}" var="comentario">
                                        <tr>
                                            <td style="font-weight: bold; font-size: 16px !important;">${comentario?.calificacion} estrellas</td>
                                            <td>${comentario?.descripcion}</td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                            <g:else>
                                <div class="add-review">
                                    <h4> * No existe ningún comentario para el producto</h4>
                                </div>
                            </g:else>

                            <g:if test="${cliente}">
                                <g:if test="${existe == '1'}">
                                    <div class="add-review">
                                        <h4>Añadir comentario</h4>
                                        <form>
                                            <div class="col-md-2">
                                                <g:select class="form-control" name="calificacion" from="${[5: '5 Estrellas', 4: '4 Estrellas', 3: '3 Estrellas', 2: '2 Estrellas', 1: '1 Estrella']}"
                                                          optionKey="key" optionValue="value"/>
                                            </div>
                                            <div class="col-md-12">
                                                <textarea type="text" id="textoComentario" maxlength="255" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Comentario...';}" required="">Comentario...</textarea>
                                            </div>

                                            <div class="occasion-cart">
                                                <a href="#"  class="btnEnviarComentario hvr-outline-out btn btn-lg" data-id="${publ.publ__id}">Enviar</a>
                                            </div>
                                        </form>
                                    </div>
                                </g:if>
                                <g:else>
                                    <g:if test="${existe == '2'}">
                                        <div class="add-review">
                                            <h4> Para ingresar un comentario debe primero haber adquirido este producto</h4>
                                        </div>
                                    </g:if>
                                </g:else>
                            </g:if>
                            <g:else>
                                <div class="add-review">
                                    <h4>Para ingresar un comentario debe primero ingresar al sistema</h4>
                                </div>
                            </g:else>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="adicional" aria-labelledby="adicional-tab">
                        <div class="bootstrap-tab-text-grids">
                            %{--                            <g:each in="${atributos}" var="atributo">--}%
                            %{--                                <div class="bootstrap-tab-text-grid">--}%
                            %{--                                    <div class="bootstrap-tab-text-grid-left borde2" style="text-align: center">--}%
                            %{--                                        <strong>${atributo?.descripcion}</strong>--}%
                            %{--                                    </div>--}%
                            %{--                                    <div class="bootstrap-tab-text-grid-right borde">--}%
                            %{--                                        <p>${atributo?.valor}</p>--}%
                            %{--                                    </div>--}%
                            %{--                                    <div class="clearfix"> </div>--}%
                            %{--                                </div>--}%
                            %{--                            </g:each>--}%


                            <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
                                <thead style="width: 100%">
                                <tr>
                                    <th style="width: 30%; font-size: 18px !important;" class="naranja">Característica</th>
                                    <th style="width: 70%; font-size: 18px !important;" class="naranja">Descripción</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${atributos}" var="atributo">
                                    <tr>
                                        <td style="font-weight: bold; font-size: 14px !important;">${atributo?.descripcion}</td>
                                        <td>${atributo?.valor}</td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>



                        </div>
                    </div>
                    %{--                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="dropdown1" aria-labelledby="dropdown1-tab">--}%
                    %{--                        <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>--}%
                    %{--                    </div>--}%
                    %{--                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="dropdown2" aria-labelledby="dropdown2-tab">--}%
                    %{--                        <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>--}%
                    %{--                    </div>--}%
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //single -->
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
<!-- //footer -->
<!-- login -->
<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content modal-info">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body modal-spa">
                <div class="login-grids">
                    <div class="login">
                        <div class="login-bottom">
                            <h3>Registrarse</h3>
                            <form id="frmRegistro">
                                <div>
                                    <h4>Nombre :</h4>
                                    <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required"/>
                                </div>
                                <div class="sign-up">
                                    <h4>Apellido :</h4>
                                    <g:textField name="apellido" minlength="3" maxlength="31" class="form-control required"/>
                                </div>
                                <div class="sign-up">
                                    <h4>Email :</h4>
                                    <g:textField name="mail" maxlength="63" required="" class="email form-control unique noEspacios required"/>
                                </div>

                                <div class="sign-up" style="text-align: center">
                                    <a href="#" id="btnRegistrarse" class="btn btn-warning btn-lg" title="Registrar nuevo cliente">
                                        <i class="fa fa-file"></i> Registrarse
                                    </a>
                                </div>
                            </form>
                        </div>
                        <div class="login-right">
                            <h3>Ingrese con su cuenta</h3>
                            <form id="frmIngreso">
                                <div class="sign-in">
                                    <h4>Usuario :</h4>
                                    <g:textField name="login" required="" class="email form-control required"/>
                                </div>
                                <div class="sign-in">
                                    <h4>Password :</h4>
                                    <input type="password" name="password" class="required" value="Ingrese su clave" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su clave';}" required="">
                                    ¿Olvidó su contraseña? <a href="#" class="" id="btnOlvidoPass"> <i class="fa fa-user-secret"></i> Recuperar contraseña </a>
                                </div>
                                <div class="single-bottom" style="margin-bottom: 34px">
                                </div>
                                <div  style="text-align: center">
                                    <a href="#" id="btnIngresar" class="btn btn-warning btn-lg" title="Ingreso de clientes">
                                        <i class="fa fa-file"></i> Ingresar
                                    </a>
                                </div>
                            </form>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <p>Al registrarse en el sistema la clave de acceso será enviada a su <strong>correo electrónico</strong>
                    <p>Al ingresar al sistema usted acepta nuestros <a href="#">Términos y Condiciones</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //login -->


<script type="text/javascript">

    $(".btnEnviarComentario").click(function (){
        var d = cargarLoader("Procesando...");
        var pub = $(this).data("id");
        var cal = $("#calificacion option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'producto', action: 'agregarComentario_ajax')}',
            data:{
                id: pub,
                texto: $("#textoComentario").val(),
                calificacion: cal
            },
            success: function(msg){
                d.modal("hide");
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    bootbox.alert("<i class='fa fa-check text-success fa-2x'></i> Comentario agregado correctamente");
                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                }else{
                    if(parts[0] == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-2x'></i>" + parts[1])
                    }else{
                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-2x'></i> Error al agregar el comentario")
                    }

                }
            }
        });
    });

    $(".item_add").click(function () {
        var prod = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'carrito', action: 'agregarProducto_ajax')}',
            data:{
                id: prod
            },
            success: function(msg){
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    bootbox.alert("<i class='fa fa-check text-success fa-2x'></i> Producto agregado correctamente");
                    cargarBannerCarrito();
                }else{
                    if(parts[0] == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-2x'></i> " + parts[1])
                    }else{
                        bootbox.alert("<i class='fa fa-exclamation-triangle text-danger fa-2x'></i> Error al agregar el producto")
                    }
                }
            }
        });
    });

    $("#btnOlvidoPass").click(function () {
        cargarPassword();
    });

    function cargarPassword() {
        bootbox.hideAll();
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'cliente', action: 'password_ajax')}",
            data: {},
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgPassword",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Salir",
                            className: "btn-gris",
                            callback: function () {
                            }
                        },
                        guardar: {
                            id: "btnSave",
                            label: "<i class='fa fa-check'></i> Aceptar",
                            className: "btn-rojo",
                            callback: function () {
                                return submitFormPassword();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormPassword() {
        var $form = $("#frmPassword");
        if ($form.valid()) {
            var d = cargarLoader("Procesando...");
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'cliente', action:'recuperarPassword_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    $("#myModal4").modal('hide');
                    var parts = msg.split("_");
                    if (parts[0] == 'ok') {
                        bootbox.alert("<i class='fa fa-envelope fa-2x text-warning'></i> Un mail con su contraseña ha sido enviado a su correo " +
                            "<br> <i class='fa fa-exclamation-circle fa-2x text-warning'></i> Si no ha recibido el correo, revise su bandeja de spam", function(){
                            d.modal('hide');
                            // bootbox.hideAll()
                        })
                    }else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + parts[1], function(){
                                d.modal('hide');
                            })
                        }else{
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + "Error al recuperar el password", function(){
                                d.modal('hide');
                            })
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    cargarBannerCarrito();

    function cargarBannerCarrito(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'principal', action: 'carrito_ajax')}',
            data:{
            },
            success: function (msg){
                $("#divCarrito").html(msg)
            }
        });
    }


    $("#btnIngresar").click(function () {
        ingresoCliente();
    });

    function ingresoCliente(){
        var p = $("#password").val();
        var $form = $("#frmIngreso");
        if ($form.valid()) {
            var d = cargarLoader("Ingresando...");
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'cliente', action:'ingreso_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("_");
                    $("#myModal4").modal('hide');
                    if (parts[0] == 'ok') {
                        location.reload(true);
                    }else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + parts[1], function(){
                                d.modal('hide');
                            })
                        }else{
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + "Error al ingresar", function(){
                                d.modal('hide');
                            })
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    $("#btnRegistrarse").click(function () {
        submitFormRegistro();
    });

    function submitFormRegistro() {

        var $form = $("#frmRegistro");
        if ($form.valid()) {
            var d = cargarLoader("Guardando...");
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'cliente', action:'saveRegistro_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("_");
                    $("#myModal4").modal('hide')
                    if (parts[0] == 'ok') {
                        bootbox.alert("<i class='fa fa-envelope fa-2x text-warning'></i> Un mail de verificación ha sido enviado a su correo " +
                            "<br> <i class='fa fa-exclamation-circle fa-2x text-warning'></i> Si no ha recibido el correo, revise su bandeja de spam", function(){
                            d.modal('hide');
                            // bootbox.hideAll()
                        })
                    }else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + parts[1], function(){
                                d.modal('hide');
                            })
                        }else{
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + "Error al crear el usuario", function(){
                                d.modal('hide');
                            })
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
    }

</script>


</body>
</html>