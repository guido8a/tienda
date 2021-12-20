

<g:if test="${!cuentaInstance}">
    <elm:notFound elem="Cuenta" genero="a"/>
</g:if>
<g:else>

    <g:if test="${cuentaInstance?.padre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Padre
            </div>

            <div class="col-md-9">
                ${cuentaInstance?.padre?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${cuentaInstance?.nivel}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nivel
            </div>

            <div class="col-md-3">
                ${cuentaInstance?.nivel?.descripcion ?: ''}
            </div>

        </div>
    </g:if>

    <g:if test="${cuentaInstance?.numero}">
        <div class="row">
            <div class="col-md-2 text-info">
                Número
            </div>

            <div class="col-md-3">
                <g:fieldValue bean="${cuentaInstance}" field="numero"/>
            </div>

        </div>
    </g:if>

    <g:if test="${cuentaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>

            <div class="col-md-9">
                <g:fieldValue bean="${cuentaInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>

    <div class="row">
        <div class="col-md-2 text-info">
            Auxiliar
        </div>

        <div class="col-md-3">
           ${cuentaInstance.auxiliar == 'N' ? 'NO' : 'SI'}
        </div>

    </div>

    <div class="row">
        <div class="col-md-2 text-info">
            Movimiento
        </div>

        <div class="col-md-3">
           ${cuentaInstance.movimiento == '0' ? 'NO' : 'SI'}
        </div>

    </div>

    <g:if test="${cuentaInstance?.retencion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Genera Retención
            </div>

            <div class="col-md-3">
              ${cuentaInstance.retencion == 'N' ? 'NO' : 'SI'}
            </div>

        </div>
    </g:if>

    <g:if test="${cuentaInstance?.cuentaBanco}">
        <div class="row">
            <div class="col-md-2 text-info">
                Cuenta Banco
            </div>

            <div class="col-md-3">
                ${cuentaInstance?.cuentaBanco?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${cuentaInstance?.impuesto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Impuesto
            </div>

            <div class="col-md-3">
                ${cuentaInstance?.impuesto?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

</g:else>