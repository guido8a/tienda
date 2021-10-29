<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 11:53
--%>
<g:if test="${tipo != '1'}">
    <b>Grupos: </b>
</g:if>
<g:select name="grupo" from="${grupos}" optionKey="id" optionValue="descripcion" class="form-control" value="${gru?.id ?: ''}"/>