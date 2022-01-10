<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 19/10/17
  Time: 10:38
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Kardex por item</title>

    <rep:estilos orientacion="l" pagTitle="${"Kardex 2"}"/>

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
    .centro{
        text-align: center;
    }
    .izquierda{
        text-align: left;
    }

    </style>

</head>

<body>

<rep:headerFooter title="${'Kardex por item'}" subtitulo="${sri.Contabilidad.get(contabilidad?.id)?.descripcion ?: ''}" empresa="${empresa}"/>

<h1>
   ITEM: ${item?.codigo + " - " + item?.titulo}
</h1>

<h2>
    PERÍODO DEL <g:formatDate date="${desde}" format="dd-MM-yyyy"/>
    AL <g:formatDate date="${hasta}" format="dd-MM-yyyy"/>
</h2>

<div>
    <table border="1">
        <thead>
        <tr>
            <th colspan="1" rowspan="2" class="centro">Fecha</th>
            <th colspan="1" rowspan="2" class="centro">Documento</th>
            <th colspan="1" rowspan="2" class="centro">Detalle</th>
            <th colspan="2" class="centro">INGRESOS</th>
            <th colspan="2" class="centro">EGRESOS</th>
            <th colspan="3" class="centro">SALDOS</th>
        </tr>
        <tr style="font-size: 11px; width: 100%">
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">Valor</th>
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">Valor</th>
            <th align="center" style="width: 8%">Cant.</th>
            <th align="center" style="width: 8%">P. Unitario</th>
            <th align="center" style="width: 8%">Total</th>
        </tr>
        </thead>

        <tbody>
        <g:each in="${res}" var="kardex" status="j">
            <tr style="width: 100%">
                <td class="izquierda" style="width: 7%"><g:formatDate date="${kardex?.krdxfcha}" format="dd-MM-yyyy"/></td>
                <td class="izquierda" style="width: 13%">${kardex?.prcsdcmt}</td>
                <td class="izquierda" style="width: 24%; font-size: 10px">${kardex?.prcsdscr}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrcntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.ingrvlor}</td>
                <td class="derecha" style="width: 8%">${kardex?.egrscntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.egrsvlor}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstcntd}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstpcun}</td>
                <td class="derecha" style="width: 8%">${kardex?.exstvlor}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>
</html>