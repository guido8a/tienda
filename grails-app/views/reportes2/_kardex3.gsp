<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/10/17
  Time: 13:33
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Existencias</title>

    <rep:estilos orientacion="p" pagTitle="${"Existencias"}"/>

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

<rep:headerFooter title="${'Existencias'}" subtitulo="${'Datos'}" empresa="${empresa}"/>

<div>
    <table border="1">
        <thead>
        <tr style="font-size: 11px; width: 700px">
            <th align="center" style="width: 80px">Código</th>
            <th align="center" style="width: 370px">Item</th>
            <th align="center" style="width: 50px;">Cantidad</th>
            <g:if test="${valor == 'true'}">
            <th align="center" style="width: 100px">P. Unitario</th>
            <th align="center" style="width: 100px">Total</th>
            </g:if>
        </tr>
        </thead>

        <tbody>
        <g:each in="${items}" var="item" status="j">
            <tr style="width: 700px">
                <td style="width: 80px">${item?.itemcdgo}</td>
                <td style="width: 370px">${item?.itemnmbr}</td>
                <td class="derecha" style="width: 50px"><g:formatNumber number="${item?.exstcntd}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
                <g:if test="${valor == 'true'}">
                <td class="derecha" style="width: 100px">${item?.exstpcun}</td>
                <td class="derecha" style="width: 100px">${item?.exstvlor}</td>
                </g:if>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>