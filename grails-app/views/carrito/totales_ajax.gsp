<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/11/21
  Time: 11:56
--%>
<h4>Totales</h4>
<ul>
    <g:set var="valor" value="${0}"/>
    <g:each in="${productos}" var="det">
%{--        <li>${det?.publicacion?.producto?.titulo} <i></i> <span>$ ${g.formatNumber(number: det?.subtotal, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span></li>--}%
        <li>${det?.publtitl} <i></i> <span>$ ${g.formatNumber(number: det?.dtcrsbtt, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span></li>
%{--        <g:set var="valor" value="${valor += (det?.subtotal?.toDouble() ?: 0)}"/>--}%
        <g:set var="valor" value="${valor += (det.dtcrsbtt?.toDouble() ?: 0)}"/>
    </g:each>
    <li><strong style="color: #000000">Total <i></i> <span>$ ${g.formatNumber(number: valor, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span></strong></li>
</ul>