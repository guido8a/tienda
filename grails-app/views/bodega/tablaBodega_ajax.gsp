<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/01/22
  Time: 9:59
--%>


<table class="table table-bordered table-hover table-condensed" style="width: 100%">
    <thead>
    <tr>

        <th style="width: 30%">Nombre</th>
        <th style="width: 15%">Teléfono</th>
        <th style="width: 20%">Descripción</th>
        <th style="width: 23%">Dirección</th>
        <th style="width: 12%">Acciones</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${bodegas}" var="bodega">
        <tr>
            <td>${bodega?.nombre}</td>
            <td>${bodega?.telefono}</td>
            <td>${bodega?.descripcion}</td>
            <td>${bodega?.direccion}</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-sm btn-success btnEditar" data-id="${bodega?.id}"
                   data-tel="${bodega?.telefono}" data-nom="${bodega?.nombre}" data-dir="${bodega?.direccion}" data-tip="${bodega?.tipo}" data-des="${bodega?.descripcion}"><i class="fa fa-edit"></i></a>
                <a href="#" class="btn btn-sm btn-danger btnBorrar" data-id="${bodega?.id}"><i class="fa fa-trash"></i></a>
            </td>
        </tr>
    </g:each>

    </tbody>
</table>

<script type="text/javascript">

    $(".btnEditar").click(function (){
        var id = $(this).data('id');
        var telefono = $(this).data('tel');
        var nombre = $(this).data('nom');
        var direccion = $(this).data('dir');
        var descripcion = $(this).data('des');
        var tipo = $(this).data('tip');
        $("#id").val(id);
        $("#telefono").val(telefono);
        $("#nombre").val(nombre);
        $("#direccion").val(direccion);
        $("#descripcion").val(descripcion);
        $("#tipo").val(tipo);
    });

    $(".btnBorrar").click(function () {
        var id = $(this).data('id');


        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la bodega seleccionada? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'bodega', action: 'delete_ajax')}',
                            data:{
                                id: id
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    log("Bodega borrada correctamente!","success");
                                    limpiar();
                                    cargarTablaBodegas();
                                }else{
                                    log("Error al borrar la bodega","error");
                                }
                            }
                        });
                    }
                }
            }
        });
    });

</script>
