<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/01/22
  Time: 9:55
--%>

<div class="" style="width: 99.7%;height: 410px; overflow-y: auto;float: right; margin-top: -20px">
<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <tbody>
    <g:each in="${proveedores}" var="proveedor">
        <tr>
            <td style="width: 40px">${proveedor?.ruc}</td>
            <td style="width: 250px">${proveedor?.nombre}</td>
            <td style="width: 40px">${proveedor?.tipoProveedor?.descripcion}</td>
%{--            <td style="width: 80px">${proveedor?.tipoIdentificacion?.descripcion}</td>--}%
            <td style="width: 80px">${proveedor?.tipoPersona?.descripcion}</td>
            <td style="width: 150px">${proveedor?.direccion}</td>
            <td style="width: 90px; text-align: center">
                <a href="#" class="btn btn-info btn-sm btn-show" data-id="${proveedor?.id}"><i class="fa fa-search"></i></a>
                <a href="#" class="btn btn-success btn-sm btn-edit" data-id="${proveedor?.id}"><i class="fa fa-edit"></i></a>
                <a href="#" class="btn btn-danger btn-sm btn-delete" data-id="${proveedor?.id}"><i class="fa fa-trash"></i></a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
</div>

<script type="text/javascript">
    $(".btn-show").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Proveedor",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>