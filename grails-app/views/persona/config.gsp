<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Perfiles de Usuario</title>

    <style type="text/css">

    @keyframes glowing {
        0% { box-shadow: 0 0 -10px #ff4517; }
        40% { box-shadow: 0 0 20px #ff4517; }
        60% { box-shadow: 0 0 20px #ff4517; }
        100% { box-shadow: 0 0 -10px #ff4517; }
    }

    .button-glow {
        animation: glowing 1000ms infinite;
    }

    </style>

</head>

<body>

<div class="btn-group" style="margin-bottom: 15px">
    <g:link class="btn btn-default col-md-2" style="width: 100px;" controller="persona" action="list" id="${usuario?.empresa?.id}"><i class="fa fa-arrow-left"></i> Regresar</g:link>
</div>

<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                Configuración de perfiles del usuario: <strong>${usuario.nombre} ${usuario.apellido}</strong>
            </h4>
        </div>

        <div id="collapsePerfiles" class="panel-collapse collapse in">
            <div class="panel-body">
                <p>
                    <a href="#" class="btn btn-warning " id="nonePerf"><i class="fa fa-exclamation-triangle"></i> Quitar todos los perfiles</a>
                    <a href="#" class="btn btn-success glow-on-hover" id="btnPerfiles">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </p>
                <g:form name="frmPerfiles" action="savePerfiles_ajax">
                    <ul class="fa-ul">
                        <g:each in="${seguridad.Prfl.list([sort: 'nombre'])}" var="perfil">
                            <li class="perfil">
                                <g:checkBox class="c2" name="c1" data-id="${perfil?.id}" value="${perfilesUsu.contains(perfil.id)}" checked="${perfilesUsu.contains(perfil.id) ? 'true' : 'false'}"/>
                                <span>${perfil.nombre} ${perfil.observaciones ? '(' + perfil.observaciones + ')' : ''}</span>
                            </li>
                        </g:each>
                    </ul>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    $("#btnPerfiles").click(function () {
        verificarPerfiles();
    });

    function verificarPerfiles () {
        var usuario = '${usuario?.id}';
        var perfiles = [];

        $(".c2").each(function () {
            var id = $(this).data("id");

            if($(this).is(':checked')){
                perfiles += parseInt(id) + "_"
            }
        });

        if(perfiles != ''){
            guardarPerfiles(usuario, perfiles)
        }else{
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i><p style='font-size: 12px'>No ha seleccionado ningún perfil. El usuario no podrá ingresar al sistema. ¿Desea continuar?.</p>", function (result) {
                if (result) {
                    guardarPerfiles(usuario, perfiles)
                }
            })
        }
    }

    function guardarPerfiles (id, perfiles) {
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'persona', action: 'guardarPerfiles_ajax')}',
            data:{
                perfiles: perfiles,
                id: id
            },
            success:function (msg) {
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] == 'ok'){
                    log("Perfiles guardados correctamente","success");
                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                }else{
                    if(parts[0] == 'er'){
                        bootbox.alert({
                            message: '<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 12px">' + parts[1] + '</strong>',
                            callback: function () {
                                var dialog2 = cargarLoader("Cargando...");
                                location.reload(true);
                            }
                        });
                        return false;
                    }else{
                        log("Error al guardar los perfiles","error")
                    }
                }
            }
        });
    }

    $("#nonePerf").click(function () {
        $(".c2").attr('checked', false);
        $("#btnPerfiles").addClass("button-glow");
        return false;
    });
</script>

</body>
</html>