<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 03/05/17
  Time: 12:40
--%>

<div class="row" style="margin-bottom: 10px">
    <div class="col-xs-1 negrilla">
        C&oacute;digo:
    </div>
    <div class="col-md-3">
        <input type="text" class=" form-control label-shared" name="codigo" id="codigoBus"/>
    </div>
    <div class="col-xs-1 negrilla">
        Nombre:
    </div>
    <div class="col-md-3">
        <input type="text" class=" form-control label-shared" name="nombreBus" id="nombreBus"/>
    </div>
    <div class="col-xs-4 negrilla">
        <input type="hidden" name="movimientos" value="1"/>
        <a href="#" class="btn btn-azul btnBuscar" id="buscarM">
            <i class="fa fa-search"></i>
            Buscar
        </a>
        <a href="#" class="btn btn-warning btnBuscar" id="limpiar">
            <i class="fa fa-eraser"></i>
            Limpiar
        </a>
    </div>
</div>
<div class="row" style="width: 100%; margin-left: 4px">
    <table class="table table-bordered table-hover table-condensed">
        <thead>
        <tr>
            <th style="width: 15%">C&oacute;digo</th>
            <th style="width: 54%">Nombre</th>
            <th style="width: 10%">Nivel</th>
            <th style="width: 21%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divTablaMovimientos" style="min-height: 250px"></div>
</div>

<script type="text/javascript">

    $("#limpiar").click(function () {
        $("#codigoBus").val('');
        $("#nombreBus").val('');
        buscarCuenta( $("#codigoBus").val(), $("#nombreBus").val());
    });

    buscarCuenta( $("#codigoBus").val(), $("#nombreBus").val());

    $("#buscarM").click(function (){
        var cod = $("#codigoBus").val();
        var nom = $("#nombreBus").val();
        buscarCuenta(cod, nom);
    });

    function buscarCuenta (cod, nom) {
        openLoader("Buscando");
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'gestor', action: 'tablaBuscar_ajax')}",
            data:{
                empresa: '${empresa?.id}',
                codigo: cod,
                nombre: nom,
                gestor: '${gestor?.id}',
                tipo: '${tipo?.id}'
            },
            success: function (msg){
                closeLoader();
                $("#divTablaMovimientos").html(msg)
            }
        });
    }

    $("input").keydown(function (ev) {
        if (ev.keyCode == 13) {
            var cod = $("#codigoBus").val();
            var nom = $("#nombreBus").val();
            buscarCuenta(cod, nom);
            return false;
        }
        return true;
    });

</script>