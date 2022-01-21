<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 21/01/22
  Time: 10:18
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Preguntas del producto: ${publicacion?.producto?.titulo}</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-top: 10px">
    <div class="btn-group">
        <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="producto" action="list"><i class="fa fa-arrow-left"></i> Regresar</g:link>
    </div>
</div>

<table class="table table-condensed table-bordered">
    <thead>
    <tr>
        <th>Pregunta</th>
        <th>Respuesta</th>
        <th>Fecha</th>
        <th>Estado</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${preguntas}" status="i" var="pregunta">
        <tr data-id="${pregunta.id}" data-etdo="${pregunta?.estado}">
            <td style="width: 40%">${pregunta?.texto}</td>
            <td style="width: 40%">${pregunta?.respuesta}</td>
            <td style="width: 10%">${pregunta?.fecha?.format("dd-MM-yyyy")}</td>
            <td style="width: 10%">${pregunta?.estado == 'A' ? 'Aprobado' : (pregunta?.estado == 'R' ? 'Ingresado' : 'Negado')}</td>
        </tr>
    </g:each>
    </tbody>
</table>

%{--<elm:pagination total="${empresaInstanceCount}" params="${params}"/>--}%

<script type="text/javascript">

    function responderPregunta(id) {
        // var v = cargarLoader("Procesando...");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'pregunta', action:'respuesta_ajax')}",
            data    : {id: id},
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Respuesta",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return guardarRespuesta(id);
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    }

    function guardarRespuesta(id) {
        var rs = $("#respuesta").val()
        var v = cargarLoader("Procesando...");
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'pregunta' ,action:'guardarRespuesta_ajax')}',
            data    : {
                id : id,
                respuesta: rs
            },
            success : function (msg) {
                v.modal("hide");
                if(msg == 'ok'){
                    log("Pregunta guardada correctamente","success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 1000);
                }else{
                    log("Error al guardar la pregunta","error")
                }
            }
        });
    }


    function activarPregunta(id) {
        var v = cargarLoader("Procesando...");
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'pregunta' ,action:'activar_ajax')}',
            data    : {
                id : id
            },
            success : function (msg) {
                v.modal("hide");
                if(msg == 'ok'){
                    log("Pregunta activada correctamente","success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 1000);
                }else{
                    log("Error al activar la pregunta","error")
                }
            }
        });
    }

    function negarPregunta(id) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea negar esta pregunta?.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                negar : {
                    label     : "<i class='fa fa-trash'></i> Negar",
                    className : "btn-danger",
                    callback  : function () {
                        var v = cargarLoader("Procesando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'pregunta' ,action:'negar_ajax')}',
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                v.modal("hide");
                                if(msg == 'ok'){
                                    log("Pregunta negada correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    log("Error al negar la pregunta","error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

        function createContextMenu(node) {
            var $tr = $(node);
            var etdo = $tr.data("etdo");
            var id = $tr.data("id");

            var items = {
                header: {
                    label: "Acciones",
                    header: true
                }
            };

            var responder = {
                label: "Responder",
                icon: "fa fa-comment-dots",
                action : function ($element) {
                    responderPregunta(id)
                }
            };

            var aceptar = {
                label: "Activar",
                icon: "fa fa-check",
                separator_before : true,
                action : function ($element) {
                    activarPregunta(id)
                }
            };

            var negar = {
                label: "Negar",
                icon: "fa fa-ban",
                separator_before : true,
                action : function ($element) {
                    negarPregunta(id);
                }
            };

            if(etdo == 'A' || etdo == 'R') items.responder = responder;
            if(etdo == 'N' || etdo == 'R') items.aceptar = aceptar;
            if(etdo == 'A' || etdo == 'R') items.negar = negar;

            return items
        }

        $(function () {
            $("tr").contextMenu({
                items: createContextMenu,
                onShow: function ($element) {
                    $element.addClass("trHighlight");
                },
                onHide: function ($element) {
                    $(".trHighlight").removeClass("trHighlight");
                }
            });
        });


    });
</script>

</body>
</html>
