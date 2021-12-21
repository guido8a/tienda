<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Parámetros</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 600px;
    }

    .tab-content {
        /*background  : #EFE4D1;*/
        background    : #EEEEEE;
        border-left   : solid 1px #DDDDDD;
        border-bottom : solid 1px #DDDDDD;
        border-right  : solid 1px #DDDDDD;
        padding-top   : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 600px;
        text-align: justify;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 20px;
        padding: 20px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    </style>

</head>

<body>

<g:set var="iconGen" value="fa fa-cog"/>
<g:set var="iconEmpr" value="fa fa-building-o"/>
<g:set var="iconAct" value="fa fa-laptop"/>
<g:set var="iconNom" value="fa fa-users"/>

<!-- Nav tabs -->
<ul class="nav nav-tabs">
    <li class="active"><a href="#generales" data-toggle="tab">Generales</a></li>
    <li><a href="#empresa" data-toggle="tab">Empresa</a></li>
    <li><a href="#activos" data-toggle="tab">Artículos de inventario y facturación</a></li>
    <li><a href="#nomina" data-toggle="tab">Nómina</a></li>
    <li><a href="#sri" data-toggle="tab">SRI / ATS</a></li>
</ul>

<!-- Tab panes -->
<div class="tab-content ui-corner-bottom">
    <div class="tab-pane active" id="generales">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="nivel">
                        <g:link controller="nivel" action="list">Nivel</g:link> de detalle de las cuentas contables y de
                        presupuesto (partidas)
                    </span>

                    <div class="descripcion hide">
                        <h4>Nivel</h4>

                        <p>Nivel de detalle de las cuentas contables y de las partidas presupuestarias.</p>

                        <p>Se aplica al plan o catálogo de cuentas y al catálogo presupuestario</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoPago">
                        <g:link controller="tipoPago" action="list">Tipo de pago</g:link> o forma de pago
                        que se acuerda con los proveedores, puede ser contado, crédito, o mediante un tiempo de espera antes
                        de realizar la efectivización del pago, ejemplo tarjetas de crédito con fechas de corte prefijadas
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Pago</h4>

                        <p>Es la forma de pago que se acuerda con los proveedores, puede ser contado, a crédito, o mediante un
                        tiempo de espera o fecha prefijada para la realización del pago, ejemplo tarjetas de crédito con fechas
                        de corte a inicio o fin de mes</p>

                        <p>Finix ha dejado abierta la posibilidad de manejar cortes y políticas de pago para aplicars a productos
                        como tarjetas de crédito</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="fuente">
                        <g:link controller="fuente" action="list">Fuente de transacciones</g:link> nombre de los módulos
                        del sistema que pueden generar transacciones contables
                    </span>

                    <div class="descripcion hide">
                        <h4>Fuente de Transacciones</h4>

                        <p>Define el origen de la transacción que genera el registro contable. Cada fuente está ligada a una
                        operación bancaria o a un módulo finix</p>

                        <p>Se aplica al registro contable de transacciones bancarias y a los módulos administrativos que puede
                        tener finix</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoDocPago">
                        <g:link controller="tipoDocumentoPago" action="list">Forma de Pago</g:link> para
                        el registro de la forma de pago a proveedores y clientes.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Documento de Pago</h4>

                        <p>Documento de pago de obligaciones de cuentas por pagar o cuentas por cobrar. Forma de
                        pago.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoComprobante">
                        <g:link controller="tipoComprobante" action="list">Tipos de comprobante contable</g:link> usualmente
                        se trata de ingresos, egresos y diarios
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Comprobante</h4>

                        <p>En forma general los comprobantes contables son ingresos, egresos y diarios</p>

                        <p>Se deja abierta la posibilida de aplicar otros tipos de comprobantes de acuerdo a los requerimientos
                        que pueda hacer la Superintendencia de Bancos y Seguros</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoCuenta">
                        <g:link controller="tipoCuenta" action="list">Tipo de cuenta bancaria</g:link> que puede estar
                        asociada a una cuenta contable, por ejemplo caja bancos está asociada a una cuenta corriente
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Cuenta Bancaria</h4>

                        <p>Se refiere al tipo de cuenta bancaria que puede tener la institución financiera en otros bancos locales
                        o internacionales, no se trata de sus propios productos bancarios</p>

                        <p>Se aplica al control de cuentas contables como libro bancos</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoRelacion">
                        <g:link controller="tipoRelacion" action="list">Tipo de Relación</g:link> predominante con la persona
                        natural o jurídica, ya sea como Proveedor, Cliente o los dos roles.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Relaci&oacute;n</h4>

                        <p>Tipos de relación que puede darse con una persona natural o jurídica, como un proveedor o como un cliente.</p>

                        <p>Si una persona posee los dos roles, se requiere que se indique se debe indicar los dos roles
                        o promoverlo al tipo Proveedor/Cliente.</p>

                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoPersona">
                        <g:link controller="tipoPersona" action="list">Tipo de Persona</g:link> natural o jurídica
                        de un Proveedor o Cliente.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Persona</h4>

                        <p>Tipos de persona: natural o jurídica que posee un proveedor o un cliente.</p>

                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoProv">
                        <g:link controller="tipoProveedor" action="list">Tipo de Proveedor</g:link> como contribuyentes
                        normales, especiales y el estado.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Proveedor</h4>

                        <p>Sirve para distinguir los varios tipos de proveedores como contribuyentes especiales, particulares y el fisco.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="paramsAux">
                        <g:link controller="parametrosAuxiliares" action="list">IVA</g:link> para definir
                        valores del IVA.
                    </span>

                    <div class="descripcion hide">
                        <h4>Parámetros de Funcionamiento</h4>

                        <p>Parámetros de funcionamiento generales como el valor del IVA.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="conceptoIR">
                        <a href="#" id="btnCR">Concepto de Retención IR</a>
                    </span>

                    <div class="descripcion hide">
                        <h4>Concepto de Retención IR</h4>

                        <p>Concepto de Retención IR</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="anio">
                        <g:link controller="anio" action="list">Año</g:link>

                    </span>

                    <div class="descripcion hide">
                        <h4>Año</h4>

                        <p>Año</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="valorAnual">
                        <g:link controller="valorAnual" action="list">Valor Anual</g:link>

                    </span>

                    <div class="descripcion hide">
                        <h4>Valor Anual</h4>

                        <p>Valor Anual</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="rolPagos">
                        <g:link controller="rolPagos" action="list">Rol de Pagos</g:link>

                    </span>

                    <div class="descripcion hide">
                        <h4>Rol de Pagos</h4>

                        <p>Rol de Pagos</p>
                    </div>
                </li>


            </ul>
        </div>

        <div class="generales right pull-right">
        </div>
    </div>

    <div class="tab-pane" id="empresa">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconEmpr}"></i>
                    <span id="paramsEmp">
                        <g:link controller="empresa" action="list">Parámetros de la Empresa</g:link> para definir la forma de
                        funcionamiento de la contabilidad, centros de costos y control de inventarios.
                    </span>

                    <div class="descripcion hide">
                        <h4>Parámetros de la Empresa</h4>

                        <p>Parámetros de funcionamiento de la contabilidad, control de costos y valores del IVA, en la Empresa,</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconEmpr}"></i>
                    <span id="tipoEmpresa">
                        <g:link controller="tipoEmpresa" action="list">Tipo de Empresa</g:link>, clasificación para registro
                        y control de empresas que reciben el servicio
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Empresa</h4>

                        <p>Sirve para distinguir de entre los distinctos tipos de empresas beneficiarios del servicio.</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="empresa right pull-right">
        </div>
    </div>

    <div class="tab-pane" id="activos">
        <div class="left pull-left">
            <ul class="fa-ul">
                %{--<li>--}%
                %{--<i class="fa-li ${iconAct}"></i>--}%
                %{--<span id="unidad">--}%
                %{--<g:link controller="unidad" action="list">Unidades</g:link> de conteo o control de los los items.--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Unidad de Medida</h4>--}%

                %{--<p>Unidad de control o conteo de obras para el plan anual de adquisiciones (PAC) y para fijar las metas.</p>--}%

                %{--<p>Pueden ser: kil&oacute;metros, metros, escuelas, unidades, etc.</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                %{--<li>--}%
                %{--<i class="fa-li ${iconAct}"></i>--}%
                %{--<span id="marca">--}%
                %{--<g:link controller="marca" action="list">Marcas</g:link> de los distintos items que se posee como--}%
                %{--inventarios o como activos fijos.--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Marcas</h4>--}%

                %{--<p>Marca de los artículos d einventario y de los activos fijos de la Empresa.</p>--}%

                %{--<p>Se de be crear un "Sin Marca" para aquellos bienes que no tienen marca</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                <li>
                    <i class="fa-li ${iconAct}"></i>
                    <span id="grupos">
                        <g:link controller="grupo" action="list">Grupos</g:link> de ítems, sirve para clasificar y controlar
                        los ítems clasificados por grupos.
                    </span>

                    <div class="descripcion hide">
                        <h4>Grupo de Ítems</h4>

                        <p>Los grupos de ítems, sirven para clasificar y controlar los ítems clasificados por características.</p>

                        <p>El manejo de grupos permite obtener estadísticas de ventas, adquisiciones y transferencias.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconAct}"></i>
                    <span id="tipoTarjeta">
                        <g:link controller="tipoTarjeta" action="list">Tipo de tarjeta</g:link> de crédito para el pago
                        de las facturas
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Tarjeta</h4>

                        <p>Se trata de los difentes tipos de tarjeta de crédito existentes.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconAct}"></i>
                    <span id="tipoFactura">
                        <g:link controller="tipoFactura" action="list">Tipo de Factura</g:link> para discriminar entre
                        facturas, notas de venta y proformas
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Factura</h4>

                        <p>Maneja los difernetes tipos de facturas que pueden existir, tales como Facturas, proformas, notas de venta.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconAct}"></i>
                    <span id="formaPago">
                        <g:link controller="formaDePago" action="list">Forma de pago</g:link> de la factura
                        puede ser en efectivo, con tarjeta de crédito o con cheque.
                    </span>

                    <div class="descripcion hide">
                        <h4>Forma de pago de la Factura</h4>

                        <p>Se trata de si el pago se realiza en efectivo, cheque o tarjeta de crédito.</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="activos right pull-right">
        </div>
    </div>

    <div class="tab-pane" id="nomina">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="tipoContrato">
                        <g:link controller="tipoContrato" action="list">Tipos de contrato</g:link> que se aplican a sus
                        empleados para la generación de la nómina
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Contrato</h4>

                        <p>Tipos de contrato para el cálculo de la nómina de cada empleado. Cada tiṕo de contrato posee
                        un conjunto específico de rubros de ingresos, egresos y provisiones</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="tipoRubro">
                        <g:link controller="tipoRubro" action="list">Tipo de rubro</g:link> que componen los ingresos y
                        egresos de nómina de un empleado
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Rubro</h4>

                        <p>Tipo de rubro de nómina.</p>

                        <p>Pueden ser Ingresos, egresos y provisiones.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="rubro">
                        <g:link controller="rubro" action="list">Rubro de nómina</g:link> que pueden ser ingresos, egresos y provisiones.
                    </span>

                    <div class="descripcion hide">
                        <h4>Rubros de la Nómina</h4>

                        <p>Rubros o conceptos por los que se hacen pagos o retenciones al empleado.</p>

                        <p>Existen tambien rubros que pueden ser de valores fijos en proporción al sueldo base, y otros cuyo valor
                        se ingrese mes a mes.</p>
                    </div>
                </li>
                %{--<li>--}%
                %{--<i class="fa-li ${iconNom}"></i>--}%
                %{--<span id="cargo">--}%
                %{--<g:link controller="cargo" action="list">Cargos</g:link> que puede tener un empleado.--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Cargos de la Empresa</h4>--}%

                %{--<p>Cargos que existen en la Empresa.</p>--}%

                %{--<p>Cada empleado de la Empresa será asociado a un cargo.</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="estadoCivil">
                        <g:link controller="estadoCivil" action="list">Estado civil</g:link> de la persona.
                    </span>

                    <div class="descripcion hide">
                        <h4>Estado Civil</h4>

                        <p>Valores de Estado civil que se pueden aceptar del personal de la empresa.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="profesion">
                        <g:link controller="profesion" action="list">Profesión</g:link> del empleado, o título académico
                        principal.
                    </span>

                    <div class="descripcion hide">
                        <h4>Profesión de la Persona</h4>

                        <p>Profesiones con sus respectivas abreviaciones del personal de la empresa.</p>

                        <p class="info">Por ejemplopara ingeniero, la abrviatura es "Ing".</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="nacionalidad">
                        <g:link controller="nacionalidad" action="list">Nacionalidad</g:link> del empelado.
                    </span>

                    <div class="descripcion hide">
                        <h4>Nacionalidad</h4>

                        <p>Nacionalidad de la persona de la empresa.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="meses">
                        <g:link controller="mes" action="list">Meses del año</g:link> para generar la nómina.
                    </span>

                    <div class="descripcion hide">
                        <h4>Meses del año</h4>

                        <p>Meses de año para usarse en los reportes.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconNom}"></i>
                    <span id="base">
                        <g:link controller="base" action="list">Tabla de valores para declarar el impuesto a la renta</g:link>
                        de acuerdo al SRI, definida año por año.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tabla del Impuesto a la Renta</h4>

                        <p>Valores de fracción básica, impuesto, % de excedente, etc.</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="nomina right pull-right">
        </div>
    </div>


    <div class="tab-pane" id="sri">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoId">
                        <g:link controller="tipoIdentificacion" action="list">Tipo de Identificación</g:link> de la persona
                        natural o jurídica, puede ser RUC, Cédula, pasaporte, etc.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Identificaci&oacute;n</h4>

                        <p>Tipos de identificación que posee la persona natural o jurídica, como por ejempla RUC, cédula, pasaporte, etc.</p>

                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>
                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoTra">
                        <g:link controller="tipoTransaccion" action="list">Tipo de Transacción</g:link> Compra, venta, etc.
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Transacción</h4>

                        <p>Tipos de Transacción del proceso.</p>

                        <p class="info">No se debe editar este parámetro.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoCom">
                        <g:link controller="tipoComprobanteSri" action="list">Tipo de Comprobante SRI</g:link>
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Comprobante SRI</h4>

                        <p>Tipo de Comprobante SRI.</p>
                    </div>
                </li>

                <li>
                    <i class="fa-li ${iconGen}"></i>
                    <span id="tipoST">
                        <g:link controller="sustentoTributario" action="list">Tipo de Sustento Tributario</g:link>
                    </span>

                    <div class="descripcion hide">
                        <h4>Tipo de Sustento Tributario</h4>

                        <p>Tipo de Sustento Tributario</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="sri right pull-right">
        </div>
    </div>


</div>

<script type="text/javascript">

    $("#btnCR").click(function () {
        location.href='${createLink(controller: 'conceptoRetencionImpuestoRenta', action: 'list')}?max=' + 10 + "&offset=" + 0
    });

    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });
    });
</script>

</body>
</html>