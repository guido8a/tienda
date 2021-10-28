<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 11:25
--%>

<b>Subcategorías: </b>
<g:select name="subcategoria" from="${subcategorias}" optionKey="id" optionValue="descripcion" class="form-control"/>

<script type="text/javascript">
    cargarGrupos($("#subcategoria option:selected").val());

    $("#subcategoria").change(function () {
        var sub = $(this).val();
        cargarGrupos(sub)
    });
</script>