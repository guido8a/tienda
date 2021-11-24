<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
<head>
    <title>Smart Shop a Ecommerce Online Shopping Category Flat Bootstrap Responsive Website Template | Single :: w3layouts</title>
    <asset:link rel="icon" href="favicon.png" type="image/x-ico"/>
    <title>Tienda en Línea</title>

    <asset:stylesheet src="/apli/bootstrap.css"/>
    <asset:stylesheet src="/apli/pignose.layerslider.css"/>
    <asset:stylesheet src="/apli/style.css"/>

    <asset:stylesheet src="/flexslider/flexslider.css"/>

    <asset:javascript src="/apli/jquery-2.1.4.min.js"/>
    <asset:javascript src="/apli/simpleCart.min.js"/>
    <asset:javascript src="/apli/bootstrap-3.1.1.min.js"/>
    <asset:javascript src="/apli/jquery.easing.min.js"/>
    <asset:javascript src="/flexslider/jquery.flexslider.js"/>

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
    </style

</head>
<body>
<!-- header -->
<div class="header">
    <div class="container">
        <ul>
            <li><span class="glyphicon glyphicon-time" aria-hidden="true"></span>Entrega inmediata gratis</li>
            <li><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>Entrega gratuita de su orden</li>
            <li><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span><a href="mailto:info@example.com">Contáctenos</a></li>
            <li><a href="${createLink(controller: 'login', action: 'login')}"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>Admin</a></li>
        </ul>
    </div>
</div>
<!-- //header -->
<!-- header-bot -->
<div class="header-bot">
    <div class="container">
        <div class="col-md-3 header-left">
            <h1><a href="index.html"><asset:image src="apli/logo3.jpg"/></a></h1>
        </div>
        <div class="col-md-6 header-middle">
            <form>
                <div class="search">
                    <input type="search" value="Search" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Search';}" required="">
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
                <li><a href="#" class="use1" data-toggle="modal" data-target="#myModal4"><span>Login</span></a>

                </li>
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
            <div class="cart box_1">
                <a href="checkout.html">
                    <h3> <div class="total">
                        <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
                        <span class="simpleCart_total"></span> (<span id="simpleCart_quantity" class="simpleCart_quantity"></span> items)</div>

                    </h3>
                </a>
                <p><a href="javascript:;" class="simpleCart_empty">Empty Cart</a></p>

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
%{--        <h3>Producto</h3>--}%
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
            <h3>${publ.publsbtl}</h3>
            <p><span class="item_price">
                ${g.formatNumber(number: publ.publpcun, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span>
                <del>${g.formatNumber(number: publ.publpcun*1.1, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</del></p>
            <div class="rating1">
                <span class="starRating">
                    <input id="rating5" type="radio" name="rating" value="5">
                    <label for="rating5">5</label>
                    <input id="rating4" type="radio" name="rating" value="4">
                    <label for="rating4">4</label>
                    <input id="rating3" type="radio" name="rating" value="3" checked="">
                    <label for="rating3">3</label>
                    <input id="rating2" type="radio" name="rating" value="2">
                    <label for="rating2">2</label>
                    <input id="rating1" type="radio" name="rating" value="1">
                    <label for="rating1">1</label>
                </span>
            </div>
            <div class="color-quality">
                <div class="color-quality-right">
                    <h5>Cantidad :</h5>
                    <select id="country1" onchange="change_country(this.value)" class="frm-field required sect">
                        <option value="null">1 Unidad</option>
                        <option value="null">2 Unidades</option>
                        <option value="null">3 Unidades</option>
                        <option value="null">4 Unidades</option>
                    </select>
                </div>
            </div>
            <div class="occasional">
                <h5>Tipos :</h5>
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
                <a href="#" class="item_add hvr-outline-out button2">Añadir al carrito</a>
            </div>

        </div>
        <div class="clearfix"> </div>

        <div class="bootstrap-tab animated wow slideInUp animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInUp;">
            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
                <ul id="myTab" class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">Descripción</a></li>
                    <li role="presentation"><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile">Opiniones del producto(1)</a></li>
                    <li role="presentation" class="dropdown">
                        <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown" aria-controls="myTabDrop1-contents">Información adicional <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1" id="myTabDrop1-contents">
                            <li><a href="#dropdown1" tabindex="-1" role="tab" id="dropdown1-tab" data-toggle="tab" aria-controls="dropdown1">Forma de lavar</a></li>
                            <li><a href="#dropdown2" tabindex="-1" role="tab" id="dropdown2-tab" data-toggle="tab" aria-controls="dropdown2">Almacenamiento</a></li>
                        </ul>
                    </li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active bootstrap-tab-text" id="home" aria-labelledby="home-tab">
                        <h5>Descripción</h5>
                        <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.
                            <span>${raw(publ.publtxto)}</span></p>
                    </div>
                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="profile" aria-labelledby="profile-tab">
                        <div class="bootstrap-tab-text-grids">
                            <div class="bootstrap-tab-text-grid">
                                <div class="bootstrap-tab-text-grid-left">
                                    <img src="images/men3.jpg" alt=" " class="img-responsive">
                                </div>
                                <div class="bootstrap-tab-text-grid-right">
                                    <ul>
                                        <li><a href="#">Admin</a></li>
                                        <li><a href="#"><span class="glyphicon glyphicon-share" aria-hidden="true"></span>Reply</a></li>
                                    </ul>
                                    <p>Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis
                                    suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem
                                    vel eum iure reprehenderit.</p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>

                            <div class="add-review">
                                <h4>add a review</h4>
                                <form>
                                    <input type="text" value="Name" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Name';}" required="">
                                    <input type="email" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}" required="">

                                    <textarea type="text" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Message...';}" required="">Message...</textarea>
                                    <input type="submit" value="SEND">
                                </form>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="dropdown1" aria-labelledby="dropdown1-tab">
                        <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork. Williamsburg banh mi whatever gluten-free, carles pitchfork biodiesel fixie etsy retro mlkshk vice blog. Scenester cred you probably haven't heard of them, vinyl craft beer blog stumptown. Pitchfork sustainable tofu synth chambray yr.</p>
                    </div>
                    <div role="tabpanel" class="tab-pane fade bootstrap-tab-text" id="dropdown2" aria-labelledby="dropdown2-tab">
                        <p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater. Lomo wolf viral, mustache readymade thundercats keffiyeh craft beer marfa ethical. Wolf salvia freegan, sartorial keffiyeh echo park vegan.</p>
                    </div>
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
                <h3>Buy your product in a simple way</h3>
            </div>
            <div class="col-md-3 coupons-gd">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                <h4>LOGIN TO YOUR ACCOUNT</h4>
                <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                sit amet, consectetur.</p>
            </div>
            <div class="col-md-3 coupons-gd">
                <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
                <h4>SELECT YOUR ITEM</h4>
                <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                sit amet, consectetur.</p>
            </div>
            <div class="col-md-3 coupons-gd">
                <span class="glyphicon glyphicon-credit-card" aria-hidden="true"></span>
                <h4>MAKE PAYMENT</h4>
                <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
                sit amet, consectetur.</p>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<!-- footer -->
<div class="footer">
    <div class="container">
        <div class="col-md-3 footer-left">
            <h2><a href="index.html"><img src="images/logo3.jpg" alt=" " /></a></h2>
            <p>Neque porro quisquam est, qui dolorem ipsum quia dolor
            sit amet, consectetur, adipisci velit, sed quia non
            numquam eius modi tempora incidunt ut labore
            et dolore magnam aliquam quaerat voluptatem.</p>
        </div>
        <div class="col-md-9 footer-right">
            <div class="col-sm-6 newsleft">
                <h3>SIGN UP FOR NEWSLETTER !</h3>
            </div>
            <div class="col-sm-6 newsright">
                <form>
                    <input type="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}" required="">
                    <input type="submit" value="Submit">
                </form>
            </div>
            <div class="clearfix"></div>
            <div class="sign-grds">
                <div class="col-md-4 sign-gd">
                    <h4>Information</h4>
                    <ul>
                        <li><a href="index.html">Home</a></li>
                        <li><a href="mens.html">Men's Wear</a></li>
                        <li><a href="womens.html">Women's Wear</a></li>
                        <li><a href="electronics.html">Electronics</a></li>
                        <li><a href="codes.html">Short Codes</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div>

                <div class="col-md-4 sign-gd-two">
                    <h4>Store Information</h4>
                    <ul>
                        <li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>Address : 1234k Avenue, 4th block, <span>Newyork City.</span></li>
                        <li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>Email : <a href="mailto:info@example.com">info@example.com</a></li>
                        <li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>Phone : +1234 567 567</li>
                    </ul>
                </div>
                <div class="col-md-4 sign-gd flickr-post">
                    <h4>Flickr Posts</h4>
                    <ul>
                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b16.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b17.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b18.jpg" alt=" " class="img-responsive" /></a></li>
                        <li><a href="single.html"><img src="images/b15.jpg" alt=" " class="img-responsive" /></a></li>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>
        <p class="copy-right">&copy 2016 Smart Shop. All rights reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
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
                            <h3>Sign up for free</h3>
                            <form>
                                <div class="sign-up">
                                    <h4>Email :</h4>
                                    <input type="text" value="Type here" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Type here';}" required="">
                                </div>
                                <div class="sign-up">
                                    <h4>Password :</h4>
                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">

                                </div>
                                <div class="sign-up">
                                    <h4>Re-type Password :</h4>
                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">

                                </div>
                                <div class="sign-up">
                                    <input type="submit" value="REGISTER NOW" >
                                </div>

                            </form>
                        </div>
                        <div class="login-right">
                            <h3>Sign in with your account</h3>
                            <form>
                                <div class="sign-in">
                                    <h4>Email :</h4>
                                    <input type="text" value="Type here" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Type here';}" required="">
                                </div>
                                <div class="sign-in">
                                    <h4>Password :</h4>
                                    <input type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}" required="">
                                    <a href="#">Forgot password?</a>
                                </div>
                                <div class="single-bottom">
                                    <input type="checkbox"  id="brand" value="">
                                    <label for="brand"><span></span>Remember Me.</label>
                                </div>
                                <div class="sign-in">
                                    <input type="submit" value="SIGNIN" >
                                </div>
                            </form>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <p>By logging in you agree to our <a href="#">Terms and Conditions</a> and <a href="#">Privacy Policy</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //login -->
</body>
</html>