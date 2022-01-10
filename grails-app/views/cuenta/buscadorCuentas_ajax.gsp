<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/09/17
  Time: 11:07
--%>


<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-4 negrilla">
        Número:
        <input type="text" class=" form-control label-shared validacionNumeroSinPuntos"  name="numero_name" id="numeroCuenta"/>
    </div>
    <div class="col-xs-4 negrilla">
        Descripción:
        <input type="text" class=" form-control label-shared"  name="desc_name" id="descCuenta"/>
    </div>
    <div class="col-xs-3 negrilla" style="margin-top: 18px">
        <a href="#" class="btn btn-primary btnBuscarCuenta">
            <i class="fa fa-search"></i>
            Buscar
        </a>
        <a href="#" class="btn btn-warning btnLimpiar" title="Limpiar Búsqueda">
            <i class="fa fa-eraser"></i>
        </a>
    </div>
</div>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr>
        <th style="width: 20%">Número</th>
        <th style="width: 65%">Descripción</th>
        <th style="width: 15%">Seleccionar</th>
    </tr>
    </thead>
</table>

<div class="span12">
    <div id="divTablaCuentas" style="width: 100%; height: 250px;"></div>
</div>

<script type="text/javascript">

    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39 );
    }


    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

    $(".btnLimpiar").click(function () {
        $("#numeroCuenta").val('');
        $("#descCuenta").val('');
        tablaCuentas(null, null);
    });

    tablaCuentas(null, null);

    $(".btnBuscarCuenta").click(function () {
        var numero = $("#numeroCuenta").val();
        var desc = $("#descCuenta").val();
        tablaCuentas(numero, desc);
    });

    function tablaCuentas (numero, desc){
        openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'cuenta', action: 'tablaCuentas_ajax')}',
            data:{
                numero: numero,
                desc: desc
            },
            success: function (msg) {
                closeLoader();
                $("#divTablaCuentas").html(msg)
            }
        });
    }

    $("#numeroCuenta, #descCuenta").keyup(function (ev) {
        if (ev.keyCode == 13) {
            var numero = $("#numeroCuenta").val();
            var desc = $("#descCuenta").val();
            tablaCuentas(numero, desc);
        }
    });



</script>

