<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/10/21
  Time: 14:42
--%>

<g:if test="${grupo?.orden}">
    <div class="row">
        <div class="col-md-2 text-info">
            Orden
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${grupo}" field="orden"/>
        </div>
    </div>
</g:if>

<g:if test="${grupo?.descripcion}">
    <div class="row">
        <div class="col-md-2 text-info">
            Descripción
        </div>
        <div class="col-md-3">
            <g:fieldValue bean="${grupo}" field="descripcion"/>
        </div>
    </div>
</g:if>