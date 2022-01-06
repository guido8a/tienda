<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/01/22
  Time: 9:59
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 29/12/21
  Time: 10:28
--%>

<div class="row">
    <div class="col-xs-12">
        <g:textField name="empresa_name" value="Empresa: ${empresa?.nombre}" readonly="" class="form-control" style="text-align: center"/>
    </div>
</div>

<div class="row">
    <g:hiddenField name="id" value="${bodega?.id}"/>

    <div class="col-xs-1 negrilla text-info">
        Nombre:
    </div>

    <div class="col-xs-6">
        <g:textField name="nombre" maxlength="63" class="form-control" value="${bodega?.nombre}"/>
    </div>


    <div class="col-xs-1 negrilla text-info">
        Tipo de bodega:
    </div>

    <div class="col-xs-4">
        <g:select from="${['O' : 'Operativo', 'T' : 'Transferencias']}" optionValue="value" optionKey="key" name="tipo" class="form-control" value="${bodega?.tipo}"/>
    </div>

</div>

<div class="row">
    <div class="col-xs-1 negrilla text-info">
        Descripción:
    </div>

    <div class="col-xs-6">
        <g:textField name="descripcion" maxlength="255" class="form-control" value="${bodega?.descripcion}"/>
    </div>


    <div class="col-xs-1 negrilla text-info">
        Teléfono:
    </div>

    <div class="col-xs-4">
        <g:textField name="telefono" maxlength="127" class="form-control digits" value="${bodega?.telefono}"/>
    </div>

</div>

<div class="row">
    <div class="col-xs-1 negrilla text-info" >
        Dirección:
    </div>

    <div class="col-xs-9">
        <g:textArea name="direccion" class="form-control" value="" maxlength="255" style="width: 100%; height: 55px; resize: none"/>
    </div>

    <a href="#" class="btn btn-success btnAgregarBodega" title="Agregar bodega"><i class="fa fa-plus"></i> Guardar</a>
    <a href="#" class="btn btn-primary btnLimpiarCampos" title="Limpiar campos de texto"><i class="fa fa-eraser"></i></a>
</div>

<div class="row" id="divTablaBodegas">

</div>

<script type="text/javascript">

    cargarTablaBodegas();

    function cargarTablaBodegas () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'bodega', action: 'tablaBodega_ajax')}',
            data:{
                id: '${empresa?.id}'
            },
            success: function (msg){
                $("#divTablaBodegas").html(msg)
            }
        })
    }

    $(".btnAgregarBodega").click(function () {
        var telefono = $("#telefono").val();
        var nombre = $("#nombre").val();
        var direccion = $("#direccion").val();
        var descripcion = $("#descripcion").val();
        var idBodega = $("#id").val();
        var tipo = $("#tipo option:selected").val();

        if(nombre == ''){
            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> Ingrese el nombre!")
        }else{
            if(descripcion == ''){
                bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> Ingrese una descripción!")
            }else{
                openLoader("Guardando...");
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'bodega', action: 'save_ajax')}',
                    data:{
                        id: idBodega,
                        empresa: '${empresa?.id}',
                        telefono: telefono,
                        nombre: nombre,
                        direccion: direccion,
                        descripcion: descripcion,
                        tipo: tipo
                    },
                    success: function (msg){
                        closeLoader();
                        if(msg == 'ok'){
                            log("Bodega guardada correctamente","success");
                            limpiar();
                            cargarTablaBodegas();
                        }else{
                            log("Error al guardar la bodega","error")
                        }
                    }
                })
            }
        }

    });

    $(".btnLimpiarCampos").click(function () {
        limpiar();
    });

    function limpiar(){
        $("#id").val("");
        $("#telefono").val("");
        $("#nombre").val("");
        $("#direccion").val("");
        $("#descripcion").val("");
        $("#tipo").val("O");
    }


</script>