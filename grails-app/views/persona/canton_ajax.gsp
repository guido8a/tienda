<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 19/03/21
  Time: 11:00
--%>

<g:select name="canton" from="${cantones}" optionKey="id"
          optionValue="nombre" class="form-control" value="${persona?.canton?.id}"/>