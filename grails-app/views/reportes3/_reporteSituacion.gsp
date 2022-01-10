<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Situación</title>
    <rep:estilos orientacion="p" pagTitle="${"Estado de Situación al " + periodo}"/>

    <style type="text/css">

    .nivel0{
        float: left;
        font-weight: bold;
    }
    .nivel1{
        width: 10%;
        float: left;
        font-weight: bold;
        text-align: right;
    }
    .nivel2{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 30px;
        color: #1a7031;
    }
    .nivel3{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 60px;
        color: #702213;
    }
    .nivel4{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 90px;
        color: #136670;
    }
    .nivel5{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 120px;
        color: #702e4c;
    }
    .nivel6{
        width: 10%;
        float: left;
        text-align: right;
        margin-left: 150px;
        color: #606060;
    }
</style>

</head>

<body>

<rep:headerFooter title="${"Estado de Situación al " + periodo}" subtitulo="${sri.Contabilidad.get(contabilidad?.id)?.descripcion ?: ''}" empresa="${empresa}"/>

<g:each in="${cuentas}" var="cuenta" status="i">

    <div style="width: 100%; display: inline-block">

        <g:if test="${cuenta.nvel == 1}">
            <div style="height: 20px;"></div>
            <div style="width: 12%" class="nivel0">${cuenta.cntanmro}</div>
            <div style="width: 55%" class="nivel0">${cuenta.cntadscr}</div>
        </g:if>
        <g:else>
            <div style="float: left; width: 12%;">${cuenta.cntanmro}</div>
            <div style="float: left; width: 55%;">${cuenta.cntadscr}</div>
        </g:else>

    <g:if test="${cuenta.nvel == 1}">
        <div class="nivel1">${cuenta.sldo}</div>
    </g:if>
    <g:if test="${cuenta.nvel == 2}">
        <div class="nivel2">${cuenta.sldo}</div>
    </g:if>
    <g:if test="${cuenta.nvel == 3}">
        <div class="nivel3">${cuenta.sldo}</div>
    </g:if>
    <g:if test="${cuenta.nvel == 4}">
        <div class="nivel4">${cuenta.sldo}</div>
    </g:if>
    <g:if test="${cuenta.nvel == 5}">
        <div class="nivel5">${cuenta.sldo}</div>
    </g:if>
    <g:if test="${cuenta.nvel == 6}">
        <div class="nivel6">${cuenta.sldo}</div>
    </g:if>
    </div>

</g:each>

</body>
</html>