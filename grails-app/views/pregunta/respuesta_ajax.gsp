<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/01/22
  Time: 11:54
--%>

%{--<div class="row">--}%
<label>Pregunta:</label>
<g:textArea name="pregunta" class="form-control" readonly="" style="resize: none; height: 150px" value="${pregunta?.texto}"/>
%{--</div>--}%
<label>Respuesta:</label>
<g:textArea name="respuesta" class="form-control" maxlenght="255" style="resize: none; height: 150px" value="${pregunta?.respuesta}"/>