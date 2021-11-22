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
	<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
	<link href='//fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,900,900italic,700italic' rel='stylesheet' type='text/css'>
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

<div class="page-head">
	<div class="container">
		<h3>Carrito de compras</h3>
	</div>
</div>
<!-- //banner -->
<!-- check out -->
<div class="checkout">
	<div class="container">
		<h3>Productos en mi carrito de compras</h3>
		<div class="table-responsive checkout-right animated wow slideInUp" data-wow-delay=".5s">
			<table class="timetable_sub">
				<thead>
				<tr>
					<th>Quitar</th>
					<th>Imagen</th>
					<th>Cantidad</th>
					<th>Nombre del Producto</th>
					<th>Precio</th>
				</tr>
				</thead>

				<g:each in="${productos}" var="detalle">
					<tr class="rem1">
						<td class="invert-closeb">
							<div class="rem">
								<div class="close1"> </div>
							</div>
							<script>$(document).ready(function(c) {
								$('.close1').on('click', function(c){
									$('.rem1').fadeOut('slow', function(c){
										$('.rem1').remove();
									});
								});
							});
							</script>
						</td>
						<td class="invert-image">
							<a href="#">
								<img alt="Sin Imagen" style="width: 100px; height: 100px" class="pro-image-front"
									 src="${request.contextPath}/principal/getImgnProd?ruta=${tienda.Imagen.findByProductoAndPrincipal(detalle.publicacion.producto, '1').ruta}&tp=P&id=${detalle?.publicacion?.producto?.id}"/>
							</a>
						</td>
						<td class="invert">
							<div class="quantity">
								<div class="quantity-select">
									<div class="entry value-minus">&nbsp;</div>
									<div class="entry value"><span>1</span></div>
									<div class="entry value-plus active">&nbsp;</div>
								</div>
							</div>
						</td>
						<td class="invert">${detalle?.publicacion?.producto?.titulo}</td>
						<td class="invert">${detalle?.subtotal}</td>
					</tr>
				</g:each>



%{--				<tr class="rem1">--}%
%{--					<td class="invert-closeb">--}%
%{--						<div class="rem">--}%
%{--							<div class="close1"> </div>--}%
%{--						</div>--}%
%{--						<script>$(document).ready(function(c) {--}%
%{--							$('.close1').on('click', function(c){--}%
%{--								$('.rem1').fadeOut('slow', function(c){--}%
%{--									$('.rem1').remove();--}%
%{--								});--}%
%{--							});--}%
%{--						});--}%
%{--						</script>--}%
%{--					</td>--}%
%{--					<td class="invert-image"><a href="single.html"><img src="images/w4.png" alt=" " class="img-responsive" /></a></td>--}%
%{--					<td class="invert">--}%
%{--						<div class="quantity">--}%
%{--							<div class="quantity-select">--}%
%{--								<div class="entry value-minus">&nbsp;</div>--}%
%{--								<div class="entry value"><span>1</span></div>--}%
%{--								<div class="entry value-plus active">&nbsp;</div>--}%
%{--							</div>--}%
%{--						</div>--}%
%{--					</td>--}%
%{--					<td class="invert">Hand Bag</td>--}%
%{--					<td class="invert">$45.99</td>--}%
%{--				</tr>--}%
%{--				<tr class="rem2">--}%
%{--					<td class="invert-closeb">--}%
%{--						<div class="rem">--}%
%{--							<div class="close2"> </div>--}%
%{--						</div>--}%
%{--						<script>$(document).ready(function(c) {--}%
%{--							$('.close2').on('click', function(c){--}%
%{--								$('.rem2').fadeOut('slow', function(c){--}%
%{--									$('.rem2').remove();--}%
%{--								});--}%
%{--							});--}%
%{--						});--}%
%{--						</script>--}%
%{--					</td>--}%
%{--					<td class="invert-image"><a href="single.html"><img src="images/ep3.png" alt=" " class="img-responsive" /></a></td>--}%
%{--					<td class="invert">--}%
%{--						<div class="quantity">--}%
%{--							<div class="quantity-select">--}%
%{--								<div class="entry value-minus">&nbsp;</div>--}%
%{--								<div class="entry value"><span>1</span></div>--}%
%{--								<div class="entry value-plus active">&nbsp;</div>--}%
%{--							</div>--}%
%{--						</div>--}%
%{--					</td>--}%
%{--					<td class="invert">Watches</td>--}%
%{--					<td class="invert">$45.99</td>--}%

%{--				</tr>--}%
%{--				<tr class="rem3">--}%
%{--					<td class="invert-closeb">--}%
%{--						<div class="rem">--}%
%{--							<div class="close3"> </div>--}%
%{--						</div>--}%
%{--						<script>$(document).ready(function(c) {--}%
%{--							$('.close3').on('click', function(c){--}%
%{--								$('.rem3').fadeOut('slow', function(c){--}%
%{--									$('.rem3').remove();--}%
%{--								});--}%
%{--							});--}%
%{--						});--}%
%{--						</script>--}%
%{--					</td>--}%
%{--					<td class="invert-image"><a href="single.html"><img src="images/w2.png" alt=" " class="img-responsive" /></a></td>--}%
%{--					<td class="invert">--}%
%{--						<div class="quantity">--}%
%{--							<div class="quantity-select">--}%
%{--								<div class="entry value-minus">&nbsp;</div>--}%
%{--								<div class="entry value"><span>1</span></div>--}%
%{--								<div class="entry value-plus active">&nbsp;</div>--}%
%{--							</div>--}%
%{--						</div>--}%
%{--					</td>--}%
%{--					<td class="invert">Sandals</td>--}%
%{--					<td class="invert">$45.99</td>--}%

%{--				</tr>--}%
%{--				<tr class="rem4">--}%
%{--					<td class="invert-closeb">--}%
%{--						<div class="rem">--}%
%{--							<div class="close4"> </div>--}%
%{--						</div>--}%
%{--						<script>$(document).ready(function(c) {--}%
%{--							$('.close4').on('click', function(c){--}%
%{--								$('.rem4').fadeOut('slow', function(c){--}%
%{--									$('.rem4').remove();--}%
%{--								});--}%
%{--							});--}%
%{--						});--}%
%{--						</script>--}%
%{--					</td>--}%
%{--					<td class="invert-image"><a href="single.html"><img src="images/w1.png" alt=" " class="img-responsive" /></a></td>--}%
%{--					<td class="invert">--}%
%{--						<div class="quantity">--}%
%{--							<div class="quantity-select">--}%
%{--								<div class="entry value-minus">&nbsp;</div>--}%
%{--								<div class="entry value"><span>1</span></div>--}%
%{--								<div class="entry value-plus active">&nbsp;</div>--}%
%{--							</div>--}%
%{--						</div>--}%
%{--					</td>--}%
%{--					<td class="invert">Wedges</td>--}%
%{--					<td class="invert">$45.99</td>--}%

%{--				</tr>--}%

				<!--quantity-->
				<script>
					$('.value-plus').on('click', function(){
						var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10)+1;
						divUpd.text(newVal);
					});

					$('.value-minus').on('click', function(){
						var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10)-1;
						if(newVal>=1) divUpd.text(newVal);
					});
				</script>
				<!--quantity-->
			</table>
		</div>
		<div class="checkout-left">

			<div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
				<a href="${createLink(controller: 'principal', action: 'index')}"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Seguir comprando</a>
			</div>
			<div class="checkout-left-basket animated wow slideInLeft" data-wow-delay=".5s">
				<h4>Totales</h4>
				<ul>
					<li>Hand Bag <i>-</i> <span>$45.99</span></li>
					<li>Watches <i>-</i> <span>$45.99</span></li>
					<li>Sandals <i>-</i> <span>$45.99</span></li>
					<li>Wedges <i>-</i> <span>$45.99</span></li>
					<li>Total <i>-</i> <span>$183.96</span></li>
				</ul>
			</div>
			<div class="clearfix"> </div>
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

</body>
</html>
