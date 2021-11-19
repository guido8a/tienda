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

    <asset:javascript src="/apli/jquery-2.1.4.min.js"/>
    <asset:javascript src="/apli/simpleCart.min.js"/>
    <asset:javascript src="/apli/bootstrap-3.1.1.min.js"/>
    <asset:javascript src="/apli/jquery.easing.min.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/js/jquery.validate.min.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/js/jquery.validate.js"/>
    <asset:javascript src="/jquery-validation-1.11.1/localization/messages_es.js"/>
    <asset:javascript src="/apli/functions.js"/>
    <asset:javascript src="/apli/bootbox.js"/>

    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    %{--    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />--}%
    %{--    <link href="css/pignose.layerslider.css" rel="stylesheet" type="text/css" media="all" />--}%
    %{--    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />--}%

    <!-- js -->
    %{--    <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>--}%
    %{--    <script src="js/simpleCart.min.js"></script>--}%
    %{--    <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>--}%
    <!-- //for bootstrap working -->
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
    %{--    <script src="js/jquery.easing.min.js"></script>--}%
</head>
<body>
<!-- header -->
<div class="header">
    <div class="container">
        <ul>
            <li><span class="glyphicon glyphicon-time" aria-hidden="true"></span>Envios a nivel nacional</li>
            %{--            <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>Entrega gratuita de su orden</li>--}%
            <li><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:info@example.com">Contáctenos</a></li>
            <g:if test="${cliente}">
                <li><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span><a href="#" class="use1" ><span>Cerrar sesión ${cliente?.nombre}</span></a></li>
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
            <h1><a href="index.html">
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
                            <option value="${tp.id}" data-dscr="${tp.descripcion}" ${tp.id == grpo? 'selected' : ''}>
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
                %{--                <li><a href="#" class="use1" data-toggle="modal" data-target="#myModal4"><span>Login</span></a>--}%
                %{--                </li>--}%
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
                            <li class="active menu__item menu__item--current"><a class="menu__link" href="index.html">Home <span class="sr-only">(current)</span></a></li>
                            <li class="dropdown menu__item">
                                <a href="#" class="dropdown-toggle menu__link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">men's wear <span class="caret"></span></a>
                                <ul class="dropdown-menu multi-column columns-3">
                                    <div class="row">
                                        <div class="col-sm-6 multi-gd-img1 multi-gd-text ">
                                            <a href="mens.html">
                                                <img alt="" src="${request.contextPath}/principal/getImgnProd?ruta=woo1.jpg&tp=v&id=0"/></a>
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
                                            <a href="womens.html">
                                                <img alt="" src="${request.contextPath}/principal/getImgnProd?ruta=woo.jpg&tp=v&id=0"/></a>
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
        <g:if test="${cliente}">
            <div class="top_nav_right">
                <div class="cart box_1">
                    <a href="${createLink(controller: 'carrito', action: 'carrito')}">
                        <h3> <div class="total">
                            <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
                            <span class="simpleCart_total"></span> (<span id="simpleCart_quantity" class="simpleCart_quantity"></span> items)</div>

                        </h3>
                    </a>
                    <p><a href="${createLink(controller: 'carrito', action: 'carrito')}" id="btnCarrito" class="simpleCart_empty">Empty Cart</a></p>
                </div>
            </div>
        </g:if>
        <div class="clearfix"></div>
    </div>
</div>
<!-- //banner-top -->
<!-- banner -->
<div class="banner-grid">
    <div id="visual">
        <div class="slide-visual">
            <!-- Slide Image Area (1000 x 424) -->
            <ul class="slide-group">
                %{--                 <li><img class="img-responsive" src="images/ba1.jpg" alt="Dummy Image" /></li>--}%
                <li><img class="img-responsive" alt="Imagen de promoción 1"
                         src="${request.contextPath}/principal/getImgnProd?ruta=ba1.jpg&tp=v&id=0"/></li>
                <li><img class="img-responsive" alt="Imagen de promoción 1"
                         src="${request.contextPath}/principal/getImgnProd?ruta=ba2.jpg&tp=v&id=0"/></li>
                <li><img class="img-responsive" alt="Imagen de promoción 1"
                         src="${request.contextPath}/principal/getImgnProd?ruta=ba3.jpg&tp=v&id=0"/></li>
            </ul>

            <!-- Slide Description Image Area (316 x 328) -->
            <div class="script-wrap">
                <ul class="script-group">
                    <li><div class="inner-script">
                        %{--                        <img class="img-responsive" src="images/baa1.jpg" alt="Dummy Image" />--}%
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=baa1.jpg&tp=v&id=0"/>
                    </div></li>
                    <li><div class="inner-script">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=baa2.jpg&tp=v&id=0"/>
                    <li><div class="inner-script">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=baa3.jpg&tp=v&id=0"/>
                    </div></li>
                </ul>
                <div class="slide-controller">
                    <a href="#" class="btn-prev">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=btn_prev.png&tp=v&id=0"/></a>
                    <a href="#" class="btn-play">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=btn_play.png&tp=v&id=0"/></a>
                    <a href="#" class="btn-pause">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=btn_pause.png&tp=v&id=0"/></a>
                    <a href="#" class="btn-next">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=btn_next.png&tp=v&id=0"/></a>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
    </div>
    <asset:javascript src="/apli/pignose.layerslider.js"/>
    %{--    <script type="text/javascript" src="js/pignose.layerslider.js"></script>--}%
    <script type="text/javascript">
        //<![CDATA[
        $(window).load(function() {
            $('#visual').pignoseLayerSlider({
                play    : '.btn-play',
                pause   : '.btn-pause',
                next    : '.btn-next',
                prev    : '.btn-prev'
            });
        });
        //]]>
    </script>

</div>
<!-- //banner -->
<!-- content -->

<div class="new_arrivals">
    <div class="container">
        <h3><span>Nuevos </span>productos</h3>
        <p>Nuevos productos exclusivos de nuestra tienda en línea </p>
        <div class="new_grids">
            <div class="col-md-4 new-gd-left">
                <img class="img-responsive" alt="Imagen de promoción 1"
                     src="${request.contextPath}/principal/getImgnProd?ruta=wed1.jpg&tp=v&id=0"/>
                <div class="wed-brand simpleCart_shelfItem">
                    <h4>Colección Novias</h4>
                    <h5>50% de descuento</h5>
                    <p><i>$500</i> <span class="item_price">$250</span><a class="item_add hvr-outline-out button2" href="#">Añadir al carrito</a></p>
                </div>
            </div>
            <div class="col-md-4 new-gd-middle">
                <div class="new-levis">
                    <div class="mid-img">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=levis1.png&tp=v&id=0"/>
                    </div>
                    <div class="mid-text">
                        <h4>up to 40% <span>off</span></h4>
                        <a class="hvr-outline-out button2" href="product.html">Comprar </a>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="new-levis">
                    <div class="mid-text">
                        <h4>up to 50% <span>off</span></h4>
                        <a class="hvr-outline-out button2" href="product.html">Comprar </a>
                    </div>
                    <div class="mid-img">
                        <img class="img-responsive" alt="Imagen de promoción 1"
                             src="${request.contextPath}/principal/getImgnProd?ruta=levis1.png&tp=v&id=0"/>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="col-md-4 new-gd-left">
                <img class="img-responsive" alt="Imagen de promoción 1"
                     src="${request.contextPath}/principal/getImgnProd?ruta=wed2.jpg&tp=v&id=0"/>
                <div class="wed-brandtwo simpleCart_shelfItem">
                    <h4>Spring / Summer</h4>
                    <p>Shop Men</p>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!-- //content -->

<!-- content-bottom -->

<div class="content-bottom">
    <div class="col-md-7 content-lgrid">
        <div class="col-sm-6 content-img-left text-center">
            <div class="content-grid-effect slow-zoom vertical">
                <div class="img-box">
                    <img class="img-responsive zoom-img" alt="Imagen de promoción 1"
                         src="${request.contextPath}/principal/getImgnProd?ruta=p1.jpg&tp=v&id=0"/>
                    %{--                    <img src="images/p1.jpg" alt="image" class="img-responsive zoom-img">--}%
                </div>
                <div class="info-box">
                    <div class="info-content simpleCart_shelfItem">
                        <h4>Mobiles</h4>
                        <span class="separator"></span>
                        <p><span class="item_price">$500</span></p>
                        <span class="separator"></span>
                        <a class="item_add hvr-outline-out button2" href="#">Añadir al carrito </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 content-img-right">
            <h3>Special Offers and 50%<span>Discount On</span> Mobiles</h3>
        </div>

        <div class="col-sm-6 content-img-right">
            <h3>Buy 1 get 1  free on <span> Branded</span> Watches</h3>
        </div>
        <div class="col-sm-6 content-img-left text-center">
            <div class="content-grid-effect slow-zoom vertical">
                <div class="img-box">
                    <img class="img-responsive zoom-img" alt="Imagen de promoción 1"
                         src="${request.contextPath}/principal/getImgnProd?ruta=p2.jpg&tp=v&id=0"/>
                </div>
                <div class="info-box">
                    <div class="info-content simpleCart_shelfItem">
                        <h4>Watches</h4>
                        <span class="separator"></span>
                        <p><span class="item_price">$250</span></p>
                        <span class="separator"></span>
                        <a class="item_add hvr-outline-out button2" href="#">Añadir al carrito </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <div class="col-md-5 content-rgrid text-center">
        <div class="content-grid-effect slow-zoom vertical">
            <div class="img-box">
                <img class="img-responsive zoom-img" alt="Imagen de promoción 1"
                     src="${request.contextPath}/principal/getImgnProd?ruta=p4.jpg&tp=v&id=0"/>
            </div>
            <div class="info-box">
                <div class="info-content simpleCart_shelfItem">
                    <h4>Shoes</h4>
                    <span class="separator"></span>
                    <p><span class="item_price">$150</span></p>
                    <span class="separator"></span>
                    <a class="item_add hvr-outline-out button2" href="#">Añadir al carrito </a>
                </div>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
</div>
<!-- //content-bottom -->
<!-- product-nav -->

<div class="product-easy">
    <div class="container">

        <asset:javascript src="/apli/easyResponsiveTabs.js"/>
        %{--        <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>--}%
        <script type="text/javascript">
            $(document).ready(function () {
                $('#horizontalTab').easyResponsiveTabs({
                    type: 'default', //Types: default, vertical, accordion
                    width: 'auto', //auto or any width like 600px
                    fit: true   // 100% fit in a container
                });
            });

        </script>
        <div class="sap_tabs">
            <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
                <ul class="resp-tabs-list">
                    <li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>Últimos diseños</span></li>
                    <li class="resp-tab-item" aria-controls="tab_item-1" role="tab"><span>Ofertas especiales</span></li>
                    <li class="resp-tab-item" aria-controls="tab_item-2" role="tab"><span>Coleciones</span></li>
                </ul>
                <div class="resp-tabs-container">
                    <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a1.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a1.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="${createLink(controller: 'ver', action: 'producto',  params: [prod: 1])}" class="link-product-add-cart">Ver</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Air Tshirt Black</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a8.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a8.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">1+1 Offer</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Next Blue Blazer</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$99.99</span>
                                        <del>$109.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a3.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a3.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Air Tshirt Black </a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$119.99</span>
                                        <del>$120.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a4.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=a4.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Maroon Puma Tshirt</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$79.99</span>
                                        <del>$120.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/a5.png" alt="" class="pro-image-front">
                                    <img src="images/a5.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">Combo Pack</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Multicoloured TShirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$129.99</span>
                                        <del>$150.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/a6.png" alt="" class="pro-image-front">
                                    <img src="images/a6.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Air Tshirt Black </a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$129.99</span>
                                        <del>$150.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/a7.png" alt="" class="pro-image-front">
                                    <img src="images/a7.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Dresses</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$129.99</span>
                                        <del>$150.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/a2.png" alt="" class="pro-image-front">
                                    <img src="images/a2.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Wedding Blazers</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$129.99</span>
                                        <del>$150.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/g1.png" alt="" class="pro-image-front">
                                    <img src="images/g1.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Dresses</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/g2.png" alt="" class="pro-image-front">
                                    <img src="images/g2.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html"> Shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/g3.png" alt="" class="pro-image-front">
                                    <img src="images/g3.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/mw2.png" alt="" class="pro-image-front">
                                    <img src="images/mw2.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">T shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-1">
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=w1.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=w1.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Wedges</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=w2.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=w2.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Sandals</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/mw1.png" alt="" class="pro-image-front">
                                    <img src="images/mw1.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Casual Shoes</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/mw3.png" alt="" class="pro-image-front">
                                    <img src="images/mw3.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Sport Shoes</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/ep2.png" alt="" class="pro-image-front">
                                    <img src="images/ep2.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Watches</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/ep3.png" alt="" class="pro-image-front">
                                    <img src="images/ep3.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Watches</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                    <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-2">
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=g1.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=g1.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Dresses</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img alt="" class="pro-image-front"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=g2.png&tp=v&id=0"/>
                                    <img alt="" class="pro-image-back"
                                         src="${request.contextPath}/principal/getImgnProd?ruta=g2.png&tp=v&id=0"/>
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html"> Shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/g3.png" alt="" class="pro-image-front">
                                    <img src="images/g3.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/mw2.png" alt="" class="pro-image-front">
                                    <img src="images/mw2.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">T shirts</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/w4.png" alt="" class="pro-image-front">
                                    <img src="images/w4.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Air Tshirt Black Domyos</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 product-men yes-marg">
                            <div class="men-pro-item simpleCart_shelfItem">
                                <div class="men-thumb-item">
                                    <img src="images/w3.png" alt="" class="pro-image-front">
                                    <img src="images/w3.png" alt="" class="pro-image-back">
                                    <div class="men-cart-pro">
                                        <div class="inner-men-cart-pro">
                                            <a href="single.html" class="link-product-add-cart">Quick View</a>
                                        </div>
                                    </div>
                                    <span class="product-new-top">New</span>

                                </div>
                                <div class="item-info-product ">
                                    <h4><a href="single.html">Hand Bags</a></h4>
                                    <div class="info-product-price">
                                        <span class="item_price">$45.99</span>
                                        <del>$69.71</del>
                                    </div>
                                    <a href="#" class="item_add single-item hvr-outline-out button2">Añadir al carrito</a>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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
%{--        <div class="col-md-3 footer-left">--}%
%{--            <h2><a href="index.html"><img src="images/logo3.jpg" alt=" " /></a></h2>--}%
%{--            <p>Neque porro quisquam est, qui dolorem ipsum quia dolor--}%
%{--            sit amet, consectetur, adipisci velit, sed quia non--}%
%{--            numquam eius modi tempora incidunt ut labore--}%
%{--            et dolore magnam aliquam quaerat voluptatem.</p>--}%
%{--        </div>--}%
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
%{--                <div class="col-md-4 sign-gd">--}%
%{--                    <h4>Information</h4>--}%
%{--                    <ul>--}%
%{--                        <li><a href="index.html">Home</a></li>--}%
%{--                        <li><a href="mens.html">Men's Wear</a></li>--}%
%{--                        <li><a href="womens.html">Women's Wear</a></li>--}%
%{--                        <li><a href="electronics.html">Electronics</a></li>--}%
%{--                        <li><a href="codes.html">Short Codes</a></li>--}%
%{--                        <li><a href="contact.html">Contact</a></li>--}%
%{--                    </ul>--}%
%{--                </div>--}%

                <div class="col-md-6 sign-gd-two">
                    <h4>Información de la tienda</h4>
                    <ul>
                        <li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>Dirección : Amazonas..., <span>Quito - Ecuador.</span></li>
                        <li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>Email : <a href="mailto:info@example.com">info@example.com</a></li>
                        <li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>Teléfono : +1234 567 567</li>
                    </ul>
                </div>
%{--                <div class="col-md-4 sign-gd flickr-post">--}%
%{--                    <h4>Flickr Posts</h4>--}%
%{--                    <ul>--}%
%{--                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>--}%
%{--                    </ul>--}%
%{--                </div>--}%
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>
        <p class="copy-right">&copy 2021. Tienda en Línea | <a href="http://www.tedein.com.ec/">TEDEIN S.A:</a></p>
    </div>
</div>
<!-- //footer -->
<!-- login -->
%{--<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--}%
%{--    <div class="modal-dialog" role="document">--}%
%{--        <div class="modal-content modal-info">--}%
%{--            <div class="modal-header">--}%
%{--                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--}%
%{--            </div>--}%
%{--            <div class="modal-body modal-spa">--}%
%{--                <div class="login-grids">--}%
%{--                    <div class="login">--}%
%{--                        <div class="login-bottom">--}%
%{--                            <h3>Sign up for free</h3>--}%
%{--                            <form>--}%
%{--                                <div class="sign-up">--}%
%{--                                    <h4>Email :</h4>--}%
%{--                                    <input type="text" value="Type here" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Type here';}" required="">--}%
%{--                                </div>--}%
%{--                                <div class="sign-up">--}%
%{--                                    <h4>Password :</h4>--}%
%{--                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">--}%

%{--                                </div>--}%
%{--                                <div class="sign-up">--}%
%{--                                    <h4>Re-type Password :</h4>--}%
%{--                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">--}%

%{--                                </div>--}%
%{--                                <div class="sign-up">--}%
%{--                                    <input type="submit" value="REGISTER NOW" >--}%
%{--                                </div>--}%

%{--                            </form>--}%
%{--                        </div>--}%
%{--                        <div class="login-right">--}%
%{--                            <h3>Sign in with your account</h3>--}%
%{--                            <form>--}%
%{--                                <div class="sign-in">--}%
%{--                                    <h4>Email :</h4>--}%
%{--                                    <input type="text" value="Type here" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Type here';}" required="">--}%
%{--                                </div>--}%
%{--                                <div class="sign-in">--}%
%{--                                    <h4>Password :</h4>--}%
%{--                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">--}%
%{--                                    <a href="#">Forgot password?</a>--}%
%{--                                </div>--}%
%{--                                <div class="single-bottom">--}%
%{--                                    <input type="checkbox"  id="brand" value="">--}%
%{--                                    <label for="brand"><span></span>Remember Me.</label>--}%
%{--                                </div>--}%
%{--                                <div class="sign-in">--}%
%{--                                    <input type="submit" value="SIGNIN" >--}%
%{--                                </div>--}%
%{--                            </form>--}%
%{--                        </div>--}%
%{--                        <div class="clearfix"></div>--}%
%{--                    </div>--}%
%{--                    <p>By logging in you agree to our <a href="#">Terms and Conditions</a> and <a href="#">Privacy Policy</a></p>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--</div>--}%
%{--<!-- //login -->--}%


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
                                    %{--                                    <input type="text" id="nombreCliente" value="Ingrese su nombre" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su nombre';}" required="">--}%
                                </div>
                                <div class="sign-up">
                                    <h4>Apellido :</h4>
                                    <g:textField name="apellido" minlength="3" maxlength="31" class="form-control required"/>
                                    %{--                                    <input type="text" id="apellidoCliente" value="Ingrese su apellido" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su apellido';}" required="">--}%
                                </div>
                                <div class="sign-up">
                                    <h4>Email :</h4>
                                    <g:textField name="mail" maxlength="63" required="" class="email form-control unique noEspacios required"/>
                                    %{--                                    <input type="text" id="mailCliente" class="mail email" value="Ingrese su dirección de correo" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su dirección de correo';}" required="">--}%
                                </div>

                                <div class="sign-up" style="text-align: center">
                                    %{--                                <div>--}%
                                    %{--                                    <input type="submit" id="btnRegistrarse" value="Registrarse" >--}%

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
                                    %{--                                    <input type="text" value="Ingrese su usuario" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su usuario';}" required="">--}%
                                </div>
                                <div class="sign-in">
                                    <h4>Password :</h4>
                                    %{--                                    <g:textField name="password" required="" type="password" class="noEspacios form-control input-sm required"/>--}%
                                    <input type="password" name="password" class="required" value="Ingrese su clave" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Ingrese su clave';}" required="">
                                    ¿Olvidó su contraseña? <a href="#" class="" id="btnOlvidoPass"> <i class="fa fa-user-secret"></i> Recuperar contraseña </a>
                                </div>
                                <div class="single-bottom" style="margin-bottom: 34px">
                                    %{--                                    <input type="checkbox"  id="brand" value="">--}%
                                    %{--                                    <label for="brand"><span></span>Remember Me.</label>--}%
                                </div>
                                <div  style="text-align: center">
                                    %{--                                    <input type="submit" value="Ingresar" >--}%
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


    $("#btnIngresar").click(function () {
        ingresoCliente();
    });

    function ingresoCliente(){
        var p = $("#password").val();
        var $form = $("#frmIngreso");
        if ($form.valid()) {
            // if(p == '' || p == null){
            //     bootbox.alert("Ingrese la contraseña!")
            // }else{
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
                        // bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i>" + "Ingreso correcto", function(){
                        //     d.modal('hide');
                        // })
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
            // }

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