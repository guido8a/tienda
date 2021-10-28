<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 9:59
--%>

<g:if test="${categoria?.orden}">
    <div class="row">
        <div class="col-md-2 text-info">
            Orden
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${categoria}" field="orden"/>
        </div>
    </div>
</g:if>

<g:if test="${categoria?.descripcion}">
    <div class="row">
        <div class="col-md-2 text-info">
            Descripción
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${categoria}" field="descripcion"/>
        </div>
    </div>
</g:if>