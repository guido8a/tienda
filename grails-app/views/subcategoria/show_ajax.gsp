<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/10/21
  Time: 13:01
--%>

<g:if test="${subcategoria?.orden}">
    <div class="row">
        <div class="col-md-2 text-info">
            Orden
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${subcategoria}" field="orden"/>
        </div>
    </div>
</g:if>

<g:if test="${subcategoria?.descripcion}">
    <div class="row">
        <div class="col-md-2 text-info">
            Descripción
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${subcategoria}" field="descripcion"/>
        </div>
    </div>
</g:if>