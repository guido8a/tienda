<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/01/22
  Time: 11:08
--%>

<g:select id="tipoPersona" name="tipoPersona.id" from="${lista}" optionKey="id"
          required="" value="${proveedorInstance?.tipoPersona?.id}" optionValue="descripcion" class="many-to-one form-control" disabled="${proveedorInstance?.id ? true : false}"/>