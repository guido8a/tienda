<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/12/21
  Time: 11:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="seguridad.Persona" %>

<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>Tienda en Línea</title>
    <meta name="layout" content="main"/>
    <style type="text/css">
    @page {
        size: 8.5in 11in;  /* width height */
        margin: 0.25in;
    }

    .item {
        width: 260px;
        height: 225px;
        float: left;
        margin: 4px;
        font-family: 'open sans condensed';
        background-color: #e7f5f1;
        border: 1px;
        border-color: #5c6e80;
        border-style: solid;
    }

    .item2 {
        width: 660px;
        height: 160px;
        float: left;
        margin: 4px;
        font-family: 'open sans condensed';
        background-color: #eceeff;
        border: 1px;
        border-color: #5c6e80;
        border-style: solid;
    }

    .imagen {
        width: 200px;
        height: 140px;
        margin: auto;
        margin-top: 10px;
    }

    .imagen2 {
        width: 180px;
        height: 130px;
        margin: auto;
        margin-top: 10px;
        margin-right: 40px;
        float: right;
    }

    .texto {
        width: 90%;
        /*height: 50px;*/
        padding-top: 0px;
        margin: auto;
        margin: 8px;
        font-size: 16px;
        font-style: normal;
    }

    .fuera {
        margin-left: 15px;
        margin-top: 20px;
        /*background-color: #317fbf; */
        background-color: rgba(114, 131, 147, 0.9);
        border: none;
    }

    .titl {
        font-family: 'open sans condensed';
        font-weight: bold;
        text-shadow: -2px 2px 1px rgba(0, 0, 0, 0.25);
        color: #0070B0;
        margin-top: 20px;
    }

    body {
        background: #e5e4e7;
    }

    .color1 {
        background: #e7f5f1;
    }

    .color2 {
        background: #FFF;
    }


    section {
        padding-top: 4rem;
        padding-bottom: 5rem;
        background-color: #f1f4fa;
    }

    .wrap {
        display: flex;
        background: white;
        padding: 1rem 1rem 1rem 1rem;
        border-radius: 0.5rem;
        box-shadow: 7px 7px 30px -5px rgba(0, 0, 0, 0.1);
        margin-bottom: 1rem;
        width: 553px;
        height: 115px
    }

    .wrap:hover {
        background: linear-gradient(135deg, #ffbb70 0%, #662500 100%);
        color: white;
    }

    .ico-wrap {
        margin: auto;
    }

    .mbr-iconfont {
        font-size: 4.5rem !important;
        color: #313131;
        margin: 1rem;
        padding-right: 1rem;
    }

    .vcenter {
        margin: auto;
    }

    .mbr-section-title3 {
        text-align: left;
    }

    h2 {
        margin-top: 0.5rem;
        margin-bottom: 0.5rem;
    }

    .display-5 {
        font-family: 'Source Sans Pro', sans-serif;
        font-size: 1.4rem;
    }

    .mbr-bold {
        font-weight: 700;
    }

    p {
        padding-top: 0.5rem;
        padding-bottom: 0.5rem;
        line-height: 25px;
    }

    .display-6 {
        font-family: 'Source Sans Pro', sans-serif;
        font-size: 1rem;
    }


    </style>
</head>

<body>
<div class="dialog">
    <g:set var="inst" value="${utilitarios.Parametros.get(1)}"/>

    <div style="text-align: center;margin-bottom: 20px"><h2 class="titl">
        <p class="text-warning">Sistema contable</p>
    </h2>
    </div>

    <div class="row mbr-justify-content-center">

        <a href="${createLink(controller: 'contabilidad', action: 'list')}" style="text-decoration: none">
            <div class="col-lg-6 mbr-col-md-10">
                <div class="wrap">
                    <div style="width: 200px; height: 120px">
                        <asset:image src="apli/portada.png" title="Contabilidad"
                                     width="80%" height="80%"/>
                    </div>

                    <div style="width: 450px; height: 120px">
                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5">
                            <span>Contabilidad</span></h2>

                        <p class="mbr-fonts-style text1 mbr-text display-6">Contabilidad</p>
                    </div>
                </div>
            </div>
        </a>

        <a href="${createLink(controller: 'cuenta', action: 'list')}" style="text-decoration: none">
            <div class="col-lg-6 mbr-col-md-10">
                <div class="wrap">
                    <div style="width: 200px; height: 120px">
                        <asset:image src="apli/cursos.png" title="Plan de cuentas" width="80%"
                                     height="80%"/>
                    </div>

                    <div style="width: 450px; height: 120px">
                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>Cuentas</span>
                        </h2>

                        <p class="mbr-fonts-style text1 mbr-text display-6">Plan de cuentas</p>
                    </div>
                </div>
            </div>
        </a>

        <a href="${createLink(controller: 'gestor', action: 'buscarGstr')}" style="text-decoration: none">
            <div class="col-lg-6 mbr-col-md-10">
                <div class="wrap">
                    <div style="width: 200px; height: 120px">
                        <asset:image src="apli/cursos.png" title="Plan de cuentas" width="80%"
                                     height="80%"/>
                    </div>

                    <div style="width: 450px; height: 120px">
                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>Gestores</span>
                        </h2>

                        <p class="mbr-fonts-style text1 mbr-text display-6">Gestores contables</p>
                    </div>
                </div>
            </div>
        </a>

        <a href="${createLink(controller: 'inicio', action: 'parametros')}" style="text-decoration: none">
            <div class="col-lg-6 mbr-col-md-10">
                <div class="wrap">
                    <div style="width: 200px; height: 120px">
                        <asset:image src="apli/cursos.png" title="Plan de cuentas" width="80%"
                                     height="80%"/>
                    </div>

                    <div style="width: 450px; height: 120px">
                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>Parámetros</span>
                        </h2>

                        <p class="mbr-fonts-style text1 mbr-text display-6">Parámetros del sistema</p>
                    </div>
                </div>
            </div>
        </a>


%{--        <a href="${createLink(controller: 'admnParticipante', action: 'index')}" style="text-decoration: none">--}%
%{--            <div class="col-lg-6 mbr-col-md-10">--}%
%{--                <div class="wrap">--}%
%{--                    <div style="width: 200px; height: 120px">--}%
%{--                        <asset:image src="apli/proyecto.png" title="Instructores" width="80%"--}%
%{--                                     height="80%"/>--}%
%{--                    </div>--}%

%{--                    <div style="width: 450px; height: 120px">--}%
%{--                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>--}%
%{--                            Instructores del Instituto</span></h2>--}%

%{--                        <p class="mbr-fonts-style text1 mbr-text display-6">Adminsitración de Instructores del Instituto</p>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </a>--}%


%{--        <a href="${createLink(controller: 'admnParticipante', action: 'index')}" style="text-decoration: none">--}%
%{--            <div class="col-lg-6 mbr-col-md-10">--}%
%{--                <div class="wrap">--}%
%{--                    <div style="width: 200px; height: 120px">--}%
%{--                        <asset:image src="apli/proyecto.png" title="Participantes registrados" width="80%"--}%
%{--                                     height="80%"/>--}%
%{--                    </div>--}%

%{--                    <div style="width: 450px; height: 120px">--}%
%{--                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>--}%
%{--                            Participantes Registrados</span></h2>--}%

%{--                        <p class="mbr-fonts-style text1 mbr-text display-6">Administración de Participantes registrados</p>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </a>--}%

%{--        <a href="${createLink(controller: 'contabilidad', action: 'list')}" style="text-decoration: none">--}%
%{--            <div class="col-lg-6 mbr-col-md-10">--}%
%{--                <div class="wrap">--}%
%{--                    <div style="width: 200px; height: 120px">--}%
%{--                        <asset:image src="apli/proyecto.png" title="Contabilidad" width="80%" height="80%"/>--}%
%{--                    </div>--}%

%{--                    <div style="width: 450px; height: 120px">--}%
%{--                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>Contabilidad</span>--}%
%{--                        </h2>--}%

%{--                        <p class="mbr-fonts-style text1 mbr-text display-6">Registros contables</p>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </a>--}%

%{--        <a href="${createLink(controller: 'canton', action: 'arbol')}" style="text-decoration: none">--}%
%{--            <div class="col-lg-6 mbr-col-md-10">--}%
%{--                <div class="wrap">--}%
%{--                    <div style="width: 200px; height: 120px">--}%
%{--                        <asset:image src="apli/proyecto.png" title="Cantones" width="80%" height="80%"/>--}%
%{--                    </div>--}%

%{--                    <div style="width: 450px; height: 120px">--}%
%{--                        <h2 class="mbr-fonts-style mbr-bold mbr-section-title3 display-5"><span>División política</span>--}%
%{--                        </h2>--}%

%{--                        <p class="mbr-fonts-style text1 mbr-text display-6">División política</p>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--            </div>--}%
%{--        </a>--}%

    </div>
    <script type="text/javascript">


        $("#btnRegistroParticipantes").click(function () {
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'participante', action:'seleccion_ajax')}",
                data: {},
                success: function (msg) {
                    var b = bootbox.dialog({
                        id: "dlgSeleccion",
                        title: "Seleccione el tipo",
                        message: msg
                    }); //dialog
                } //success
            }); //ajax
        });

        $(".fuera").hover(function () {
            var d = $(this).find(".imagen,.imagen2")
            d.width(d.width() + 10)
            d.height(d.height() + 10)

        }, function () {
            var d = $(this).find(".imagen, .imagen2")
            d.width(d.width() - 10)
            d.height(d.height() - 10)
        })


        $(function () {
            $(".openImagenDir").click(function () {
                openLoader();
            });

            $(".openImagen").click(function () {
                openLoader();
            });
        });



    </script>
</body>
</html>
