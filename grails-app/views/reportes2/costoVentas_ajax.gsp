<%@ page import="sri.Contabilidad; inventario.Bodega" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/10/17
  Time: 12:12
--%>

<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<style type="text/css">

.letra{
    font-size: 11px;
    font-weight: bold;
}

</style>


<div class="fila">
    <div class="col-md-1">
        <label class="letra">Categoría: </label>
    </div>
    <div class="col-md-3">
        <g:select name="grupo_name" id="grupo2"
                  from="${tienda.Categoria.list([sort: 'orden'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione el categoría']"
                  class="form-control"/>
    </div>

    <div class="col-md-1">
        <label class="letra">Subcategoría: </label>
    </div>
    <div class="col-md-3" id="divSubgrupo">
    </div>

    <div class="col-md-1">
        <label class="letra">Grupo: </label>
    </div>
    <div class="col-md-3" id="divDepartamento">
    </div>
</div>


<div class="fila" style="margin-bottom: 15px">
    <div class="col-md-2">
        <label class="uno">Contabilidad:</label>
    </div>
    <div class="col-md-4">
        <g:select name="contK2" id="contK3"
                  from="${sri.Contabilidad.findAllByInstitucion(empresa, [sort: 'fechaInicio'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                  class="form-control dos"/>
    </div>
    <div class="col-md-2">
        <label class="uno">Bodega:</label>
    </div>
    <div class="col-md-2">
        <g:select name="bode_name" id="bode3"
                  from="${inventario.Bodega.findAllByEmpresa(empresa, [sort: 'nombre'])}"
                  optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la bodega']"
                  class="form-control dos"/>
    </div>
</div>

<div class="fila">
    <div class="col-md-1">
        <label>Desde: </label>
    </div>
    <div class="col-md-2">
        <input name="fechaDesde"  id='datetimepicker1' type='text' required="" class="form-control fechaDeK3 required"/>
%{--        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDK3" class="datepicker form-control fechaDeK3"--}%
%{--                        maxDate="new Date()"/>--}%
    </div>

    <div class="col-md-1">
        <label>Hasta: </label>
    </div>
    <div class="col-md-2">
        <input name="fechaHasta"  id='datetimepicker2' type='text' required="" class="form-control fechaHaK3 required"/>
%{--        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHK3" class="datepicker form-control fechaHaK3"--}%
%{--                        maxDate="new Date()"/>--}%
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-success" id="btnImprimir">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>


<script type="text/javascript">

    $(function () {
        $('#datetimepicker1, #datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'closeText'
            }
        });
    });

    $(function() {
        $("#valores").checkboxpicker({
        });
    });

    $("#btnImprimir").click(function () {
        var cont = $("#contK3").val();
        var fechaDesde = $(".fechaDeK3").val();
        var fechaHasta = $(".fechaHaK3").val();
        var bodega = $("#bode3").val();
        var departamento = $("#departamento2").val();

        if (cont == '-1') {
            bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
        } else {
            if(bodega == '-1'){
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una bodega!")
            }else{
                if(fechaDesde == '' || fechaHasta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                }else{
                    if(departamento == '-1'){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione el departamento!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    location.href = "${g.createLink(controller:'reportes2' , action: '_costoVentas')}?cont=" + cont + "&emp=${empresa.id}" + "&desde=" + fechaDesde + "&hasta=" + fechaHasta + "&bodega=" + bodega + "&departamento=" + departamento;
                                    %{--location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=kardex.pdf"--}%
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        }
    });


    cargarComboSubgrupo($("#grupo2").val());

    function cargarComboSubgrupo(grupo) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes2', action: 'subgrupoItems_ajax')}',
            data:{
                grupo : grupo
            },
            success: function (msg) {
                $("#divSubgrupo").html(msg)
            }
        }) ;
    }

    $("#grupo2").change(function () {
        var grupo = $(this).val()
        cargarComboSubgrupo(grupo)
    });

</script>

