     <table class="table table-bordered table-hover table-condensed">
    <tbody>
    <g:if test="${planCuentas != null}">
        <g:each var="cuenta" in="${planCuentas}">
            <tr>
                <td>${cuenta.numero}</td>
                <td>${cuenta.descripcion}</td>
                <td>${cuenta.nivel.descripcion}</td>
                <td><select class="span-3 ui-widget-content ui-corner-all" name="razon" id="${'dh_'+cuenta.id}" >
                    <option id="1">Debe</option>
                    <option id="0">Haber</option>
                </select>
                </td>
                <td >
                    <a href="#" class="btn btn-success agregarCuenta" id="agregar_${cuenta.numero}" cuenta="${cuenta.id}">
                        <i class="fa fa-plus"></i>
                        Agregar
                    </a>
                </td>
            </tr>
        </g:each>
    </g:if>
    </tbody>
</table>


<script type="text/javascript">
    $(function(){
        $(".agregarCuenta").click(function() {
            $.ajax({
                type: "POST",
                url: "${g.createLink(controller: 'gestor',action: 'agregarCuenta')}",
                data: "id="+$(this).attr("cuenta")+"&razon="+$("#dh_"+$(this).attr("cuenta")).val()+"&tc="+$("#tipo").val(),
                success: function(msg){
                    $("#agregarCuentas").html(msg)
                }
            });

        });
    });
</script>