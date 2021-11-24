<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/11/21
  Time: 15:30
--%>

<a href="${createLink(controller: 'carrito', action: 'carrito')}">
    <h3>
        <div class="total">
            <i class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></i>
            <g:if test="${cliente}">
                <g:if test="${carrito}">
                    <span class=""> $ ${g.formatNumber(number: carrito?.subtotal, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)}</span> (${carrito?.cantidad} items)
                </g:if>
                <g:else>
                    <span class=""> $ 0.00</span> (0 items)
                </g:else>
            </g:if>
            <g:else>
                <span class="">$ 0.00</span> (0 items)
            </g:else>
        </div>
    </h3>
</a>
<p><a href="${createLink(controller: 'carrito', action: 'carrito')}" id="btnCarrito" class="simpleCart_empty">Carrito de Compras</a></p>