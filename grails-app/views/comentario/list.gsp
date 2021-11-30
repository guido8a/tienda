<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/11/21
  Time: 9:11
--%>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Comentarios del producto: ${publicacion?.producto?.titulo}</title>
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
        <th>Cliente</th>
        <th>Comentario</th>
        <th>Calificación</th>
        <th>Fecha</th>
        <th>Estado</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${comentarios}" status="i" var="comentario">
        <tr data-id="${comentario.id}" data-etdo="${comentario?.estado}">
            <td style="width: 10%">${comentario?.cliente?.nombre + " " + comentario?.cliente?.apellido}</td>
            <td style="width: 66%">${comentario?.descripcion}</td>
            <td style="width: 8%">${comentario?.calificacion}</td>
            <td style="width: 8%">${comentario?.fecha?.format("dd-MM-yyyy")}</td>
            <td style="width: 8%">${comentario?.estado == 'A' ? 'Aprobado' : (comentario?.estado == 'I' ? 'Ingresado' : 'Negado')}</td>
        </tr>
    </g:each>
    </tbody>
</table>

%{--<elm:pagination total="${empresaInstanceCount}" params="${params}"/>--}%

<script type="text/javascript">


    function aceptarComentario(id) {
        var v = cargarLoader("Procesando...");
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'comentario' ,action:'aceptar_ajax')}',
            data    : {
                id : id
            },
            success : function (msg) {
                v.modal("hide");
                if(msg == 'ok'){
                    log("Comentario aprobado correctamente","success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 1000);
                }else{
                    log("Error al aprobar el comentario","error")
                }
            }
        });
    }

    function negarComentario(id) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea negar este comentario?.</p>",
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
                            url     : '${createLink(controller: 'comentario' ,action:'negar_ajax')}',
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                v.modal("hide");
                                if(msg == 'ok'){
                                    log("Comentario negado correctamente","success");
                                    setTimeout(function () {
                                        location.reload(true)
                                    }, 1000);
                                }else{
                                    log("Error al negar el comentario","error")
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

            var aceptar = {
                label: "Aceptar",
                icon: "fa fa-check",
                separator_before : true,
                action : function ($element) {
                    aceptarComentario(id)
                }
            };

            var negar = {
                label: "Negar",
                icon: "fa fa-ban",
                separator_before : true,
                action : function ($element) {
                    negarComentario(id);
                }
            };

            if(etdo == 'N' || etdo == 'I') items.aceptar = aceptar;
            if(etdo == 'A' || etdo == 'I') items.negar = negar;

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
