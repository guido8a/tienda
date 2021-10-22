<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/03/21
  Time: 11:18
--%>

<g:each in="${preguntas}" var="pregunta">
    <div class="container">
        <div class="row">
            <div class="col-6 align-self-start input-group">
                <span class="input-group-text">Pregunta</span>
                <g:textArea name="preguntaR" class="form-control" readonly="" style="resize: none; height: 80px; background-color: #ffffff" placeholder="pregunta...." value="${pregunta?.texto}"/>
            </div>
            <div class="col-6 align-self-center input-group">
                <span class="input-group-text">Respuesta</span>
                <g:textArea name="respuestaR" class="form-control " readonly="" style="resize: none; height: 80px; background-color: #ffffff" value="${pregunta?.respuesta}"/>
            </div>
        </div>
    </div>
</g:each>

