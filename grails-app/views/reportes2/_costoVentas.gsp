<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/10/17
  Time: 12:22
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Costo de Ventas</title>

    <rep:estilos orientacion="p" pagTitle="${"Costo de ventas"}"/>

    <style type="text/css">

    html {
        font-family: Verdana, Arial, sans-serif;
        font-size: 15px;
    }

    h1, h2, h3 {
        text-align: center;
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        vertical-align: middle;
    }

    th {
        background: #bbb;
    }

    .derecha{
        text-align: right;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Costo de Ventas'}" subtitulo="${sri.Contabilidad.get(contabilidad?.id)?.descripcion ?: ''}" empresa="${empresa}"/>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>

<div>
    <table border="1">
        <thead>
        <tr style="font-size: 11px; width: 700px">
            <th align="center" style="width: 80px">Código</th>
            <th align="center" style="width: 370px">Item</th>
            <th align="center" style="width: 50px;">Cantidad</th>
            <th align="center" style="width: 100px">P. Unitario</th>
            <th align="center" style="width: 100px">P. Costo</th>
            <th align="center" style="width: 100px">Utilidad</th>
            <th align="center" style="width: 100px">Porcentaje</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${items}" var="item" status="j">
            <tr style="width: 700px">
                <td style="width: 80px">${item?.itemcdgo}</td>
                <td style="width: 370px">${item?.itemnmbr}</td>
                <td class="derecha" style="width: 50px"><g:formatNumber number="${item?.cntd}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <td class="derecha" style="width: 100px">${item?.pcun ?: 0}</td>
                <td class="derecha" style="width: 100px">${item?.pccs ?: 0}</td>
                <td class="derecha" style="width: 100px">${item?.util ?: 0}</td>
                <td class="derecha" style="width: 100px">${item?.pcnt ?: 0}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>