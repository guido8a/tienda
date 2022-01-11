<%@ page import="tienda.Producto" %>
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
					<th style="width: 15%">Quitar</th>
					<th style="width: 20%">Imagen</th>
					<th style="width: 17%">Cantidad</th>
					<th style="width: 38%">Producto</th>
					<th style="width: 10%">Precio</th>
				</tr>
				</thead>

				<g:if test="${productos}">
					<g:each in="${productos}" var="detalle">
%{--						<tr class="rem_${detalle?.id}">--}%
						<tr class="rem_${detalle.dtcr__id}">
							<td class="invert-closeb">
								<div class="rem">
%{--									<div class="close1" data-cl="rem_${detalle?.id}" data-id="${detalle?.id}"> </div>--}%
									<div class="close1" data-cl="rem_${detalle.dtcr__id}" data-id="${detalle.dtcr__id}"> </div>
								</div>
								%{--							<script>$(document).ready(function(c) {--}%
								%{--								$('.close1').on('click', function(c){--}%
								%{--									$('.rem1').fadeOut('slow', function(c){--}%
								%{--										$('.rem1').remove();--}%
								%{--									});--}%
								%{--								});--}%
								%{--							});--}%
								%{--							</script>--}%
							</td>
							<td class="invert-image">
%{--								<a href="${createLink(controller: 'ver', action: 'producto')}?publ=${detalle?.publicacion?.id}"}>--}%
								<a href="${createLink(controller: 'ver', action: 'producto')}?publ=${detalle.publ__id}"}>
									<img alt="Sin Imagen" style="width: 100px; height: 100px" class="pro-image-front"
%{--										 src="${request.contextPath}/principal/getImgnProd?ruta=${tienda.Imagen.findByProductoAndPrincipal(detalle.publicacion.producto, '1').ruta}&tp=P&id=${detalle?.publicacion?.producto?.id}"/>--}%
										 src="${request.contextPath}/principal/getImgnProd?ruta=${tienda.Imagen.findByProductoAndPrincipal(tienda.Producto.get(detalle.prod__id), '1').ruta}&tp=P&id=${detalle.prod__id}"/>
								</a>
							</td>
							<td class="invert">
								<div class="quantity">
									<div class="quantity-select">
%{--										<div class="entry value-minus" data-id="${detalle?.id}">&nbsp;</div>--}%
										<div class="entry value-minus" data-id="${detalle.dtcr__id}">&nbsp;</div>
%{--										<div class="entry value v_${detalle?.id}"><span>${detalle?.cantidad}</span></div>--}%
										<div class="entry value v_${detalle.dtcr__id}"><span>${detalle?.dtcrcntd}</span></div>
%{--										<div class="entry value-plus active" data-id="${detalle?.id}">&nbsp;</div>--}%
										<div class="entry value-plus active" data-id="${detalle.dtcr__id}">&nbsp;</div>
									</div>
								</div>
							</td>
%{--							<td class="invert">${detalle?.publicacion?.producto?.titulo}</td>--}%
							<td class="invert">${detalle.publtitl}</td>
%{--							<td class="invert sbt_${detalle?.id}" data-id="${detalle?.id}" data-valor="${detalle?.publicacion?.precioUnidad}" data-mayor="${detalle?.publicacion?.precioMayor}">--}%
%{--								${g.formatNumber(number: detalle?.subtotal, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</td>--}%

							<td class="invert sbt_${detalle.dtcr__id}" data-id="${detalle.dtcr__id}" data-valor="${detalle.publpcun}" data-mayor="${detalle.publpcmy}">
								${g.formatNumber(number: detalle.dtcrsbtt, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</td>
						</tr>
					</g:each>

				</g:if>
				<g:else>
						<div class="alert alert-warning">No tiene productos agregados a su carrito de compras!</div>
				</g:else>


			<!--quantity-->
				<script>
					$('.value-plus').on('click', function(){
						var idDiv = $(this).data("id");
						var divUpd = $(this).parent().find('.v_' +  idDiv), newVal = parseInt(divUpd.text(), 10)+1;
						divUpd.text(newVal);
						var s
						if(newVal >= 10){
							s = $(".sbt_" + idDiv).data("mayor");
						}else{
							s = $(".sbt_" + idDiv).data("valor");
						}
						guardarCantidad(idDiv, newVal);
						$('.sbt_' + idDiv).text( (Math.round((s * newVal) * 100) / 100).toFixed(2))
					});

					$('.value-minus').on('click', function(){
						var idDiv = $(this).data("id");
						var divUpd = $(this).parent().find('.v_' +  idDiv), newVal = parseInt(divUpd.text(), 10)-1;
						if(newVal>=1){
							divUpd.text(newVal);
							var s
							if(newVal >= 10){
								s = $(".sbt_" + idDiv).data("mayor");
							}else{
								s = $(".sbt_" + idDiv).data("valor");
							}
							guardarCantidad(idDiv, newVal);
							$('.sbt_' + idDiv).text( (Math.round((s * newVal) * 100) / 100).toFixed(2))
						}else{
							bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-danger'></i> No es posible colocar una cantidad igual a cero a un producto")
						}

					});
				</script>
				<!--quantity-->
			</table>

			<p style="font-size: 11px">* Precio al por mayor se aplica a partir de 10 productos en adelante.</p>
		</div>
		<div class="checkout-left">
			<div class="checkout-right-basket animated wow slideInRight" data-wow-delay=".5s">
				<a href="${createLink(controller: 'principal', action: 'index')}"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Seguir comprando</a>
				<a href="${createLink(controller: 'carrito', action: 'datos')}"> Siguiente paso <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span> </a>
			</div>
			<div class="checkout-left-basket animated wow slideInLeft" data-wow-delay=".5s" id="divTotales">

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


<script type="text/javascript">

	function guardarCantidad(id, cantidad) {
		var d = cargarLoader("Guardando...");
		$.ajax({
			type: 'POST',
			url: '${createLink(controller: 'carrito', action: 'guardarCantidad_ajax')}',
			data:{
				id:id,
				cantidad: cantidad
			},
			success: function (msg) {
				d.modal('hide');
				if(msg == 'ok'){
					cargarTotales();
				}else{
					log("Error al modificar la cantidad del producto", "error")
				}
			}
		})
	}

	cargarTotales();

	function cargarTotales(){
		$.ajax({
			type: 'POST',
			url: '${createLink(controller: 'carrito', action: 'totales_ajax')}',
			data:{
			},
			success: function (msg) {
				$("#divTotales").html(msg)
			}
		})
	}

	$(document).ready(function(c) {
		$('.close1').on('click', function(c){
			var d = $(this).data("cl");
			var id = $(this).data("id");

			bootbox.confirm("<i class='fa fa-exclamation-triangle fa-2x text-warning'></i> " +
					"Está seguro que desea remover el producto de su carrito de compras?", function (res) {
				if (res) {

					$.ajax({
						type: 'POST',
						url: '${createLink(controller: 'carrito', action: 'borrarDetalle_ajax')}',
						data:{
							id: id
						},
						success: function (msg) {
							if(msg == 'ok'){
								$('.' + d).fadeOut('slow', function(c){
									$('.' + d).remove();
									cargarTotales();
								});

							}else{
								log("Error al remover el producto", "error")
							}
						}
					});
				}
			});
		});
	});
</script>


</body>
</html>
