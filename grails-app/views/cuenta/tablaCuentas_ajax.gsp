<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 04/09/17
  Time: 11:09
--%>
<div class="row-fluid"  style="width: 99.7%;height: 250px;overflow-y: auto;float: right; margin-top: -20px">
<table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:each in="${cuentas}" var="cuenta">
        <tr>
            <td style="width: 20%">${cuenta?.numero}</td>
            <td style="width: 67%">${cuenta?.descripcion}</td>
            <td style="width: 13%; text-align: center">
                <a href="#" class="btn btn-success btnSeleccionarCuenta" nc="${cuenta?.numero}" dc="${cuenta?.descripcion}" idc="${cuenta?.id}">
                    <i class="fa fa-check"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
</div>

<script type="text/javascript">

    $(".btnSeleccionarCuenta").click(function () {
        var numero = $(this).attr('nc');
        var desc = $(this).attr('dc');
        var id = $(this).attr('idc');
        $("#cntaLibro").val(numero + " - " + desc);
        $("#idCntaLibro").val(id);
        bootbox.hideAll();
    })

</script>