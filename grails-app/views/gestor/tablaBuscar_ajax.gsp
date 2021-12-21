<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 03/05/17
  Time: 13:11
--%>
<div class="" style="width: 99.7%;height: 280px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table table-bordered table-hover table-condensed">
        <tbody>
        <g:each in="${cuentas}" var="cuenta">
            <tr>
                <td style="width: 15%">${cuenta.numero}</td>
                <td style="width: 55%">${cuenta.descripcion}</td>
                <td style="width: 10%">${cuenta.nivel.descripcion}</td>
                <td style="width: 20%">
                    <a href="#" class="btn btn-success agregarDebe" cuenta="${cuenta.id}" title="Agregar cuenta como Debe">
                        <i class="fa fa-chevron-up"></i>
                        Debe
                    </a>
                    <a href="#" class="btn btn-info agregarHaber" cuenta="${cuenta.id}" title="Agregar cuenta como Haber">
                        <i class="fa fa-chevron-down"></i>
                        Haber
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>


<script type="text/javascript">

    $(".agregarDebe").click(function () {
            var gestor = '${gestor?.id}';
            var tipo = '${tipo?.id}';
            var cuenta = $(this).attr('cuenta');

            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'gestor', action: 'agregarDebeHaber_ajax')}",
                data:{
                    gestor: gestor,
                    tipo: tipo,
                    cuenta: cuenta,
                    dif: 'D'
                },
                success:function (msg) {
                    if(msg == 'ok'){
                        bootbox.hideAll();
                        cargarMovimientos(gestor, tipo);
                        revisarAsientos();
                    }else{

                    }
                }
            })
    });

    $(".agregarHaber").click(function () {
        var gestor = '${gestor?.id}';
        var tipo = '${tipo?.id}';
        var cuenta = $(this).attr('cuenta');

        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'gestor', action: 'agregarDebeHaber_ajax')}",
            data:{
                gestor: gestor,
                tipo: tipo,
                cuenta: cuenta,
                dif: 'H'
            },
            success:function (msg) {
                if(msg == 'ok'){
                    bootbox.hideAll();
                    cargarMovimientos(gestor, tipo);
                    revisarAsientos();
                }else{

                }
            }
        })
    });


</script>