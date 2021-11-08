<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/11/21
  Time: 13:27
--%>


<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <meta name="layout" content="main">
    <title>Imágenes</title>

    <style type="text/css">

    .alinear {
        text-align: center !important;
    }
    .aviso{
        font-size: 16px;
        font-weight: normal;
    }
    .caja50{
        width: 100px !important;
        height: 70px;
        display: block;
    }

        .borde{
            border-color: #AF5B00;
            border-style: solid;
            border-width: 1px;
            border-radius: 4px;
        }

    </style>

</head>

<body>

<div class="btn-group">
    <a href="${createLink(controller: 'producto', action: 'form', id: producto?.id)}" id="btnRegresarForm"
       class="btn btn-sm btn-warning" title="Regresar al producto">
        <i class="fa fa-arrow-left"></i> Regresar
    </a>
</div>

<div style="text-align: center; margin-top: -20px;margin-bottom:20px">
    <h3>Administración de Imágenes del producto: ${producto?.titulo}</h3>
</div>

<div style="margin-top: 30px; min-height: ${tam < 5 ? 250 : (tam < 9 ? 350 : (tam < 13 ? 500 : (tam < 17 ? 600 : 700)))}px" class="vertical-container">
    <p class="css-vertical-text">Imágenes</p>

    <div class="linea"></div>

    <div class="col-md-12" style="margin-bottom: 10px">

        <a href="#" class="btn btn-rojo" id="btnImasProducto" title="Imágenes asociadas al producto">
            <i class="fa fa-images"></i> Agregar o Editar las imágenes
        </a>

        <g:if test="${producto?.id}">
            <g:if test="${tam > 0}">
                <div class="col-md-12">
                    <div class="row" style="height: ${tam < 5 ? 250 : (tam < 9 ? 350 : (tam < 13 ? 450 : (tam < 17 ? 550 : 650)))}px">
                        <g:each in="${imagenes}" var="im" status="i">
                            <div class="col-xs-3 col-md-3" style="height: 150px">
                                <div class="product" id="product_${i+1}">
                                    <a href="#" class="thumbnail ${im.pncp == '1' ? 'borde' : ''}">
                                        <img src="${createLink(controller: 'imagen', action: 'getImage', params: [id: "${im.file}", pro: producto?.id] )}"  width="120" height="80" title="${im.file}"/>
                                    </a>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-md-12" style="margin-top: 40px">
                </div>
            </g:else>
        </g:if>
    </div>
</div>

<script type="text/javascript">

    $("#btnImasProducto").click(function () {
        cargarImagenes('${producto?.id}')
    });

    function cargarImagenes(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'imagen', action:'imagenes_ajax')}",
            data    : {
                id:id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgImas",
                    title   : "Imágenes",
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                                location.href="${createLink(controller: 'imagen', action: 'list')}?id=" + '${producto?.id}'
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

</script>

</body>
</html>