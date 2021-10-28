<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 28/10/21
  Time: 10:32
--%>

<util:renderHTML html="${msg}"/>

<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}

.superior {
    background-color: #fffff4;
}
.completo {
    color: #000;
}
.conHoja {
    color: #004;
}
.centrado {
    text-align: center;
    font-weight: bold;
}

</style>

<div class="" style="width: 99.7%;height: ${msg == '' ? 600 : 575}px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="1060px">
        <g:each in="${data}" var="dato" status="z">
            <g:set var="clase" value="${''}"/>
            <g:if test="${dato.nved__id > 3}">
                <g:set var="clase" value="${'superior'}"/>
            </g:if>
            <g:if test="${dato.prtchjvd == 'S'}">
                <g:set var="clase" value="${clase + ' completo'}"/>
            </g:if>
            <g:if test="${dato.prtchjvd == 'S'}">
                <g:set var="clase" value="${clase + ' conHoja'}"/>
            </g:if>

            <tr id="${dato.prtc__id}" class="${clase}" title="Haga clic derecho y seleccione una opción">
                <td width="15%">
                    ${dato?.prtcnmbr}
                </td>

                <td width="12%">
                    ${dato?.prtcnved}
                </td>

                <td width="8%">
                    ${dato?.prtcgret}
                </td>
                <td width="8%">
                    ${dato.prtcartb}
                </td>

                <td width="5%" class="centrado">
                    ${dato?.prtchjvd}
                </td>

                <td width="5%" class="centrado">
                    ${dato.prtcetdo}
                </td>

                <td width="6%" class="centrado">
                    ${dato?.prtcpart}
                </td>
                <td width="20%">
                    ${dato?.prtcorsc}
                </td>
                <td width="20%">
                    ${dato?.prtcmvpl}
                </td>

            </tr>
        </g:each>
    </table>
</div>


<script type="text/javascript">

    $(".btnRevisarPago").click(function () {
        var id = $(this).data("anun");
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'anuncio', action:'revisarPago_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgRevisaPago",
                    title   : "Ver comprobante de Pago",
                    message : msg,
                    // class : "modal-lg",
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });


    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

        $(".btnVerPago").click(function () {
            var id = $(this).data("id");
            console.log('anuncio-pago', id)
            verPago(id);
        });

        $(".btnRevisar").click(function () {
            var id = $(this).data("id");
            var anun = $(this).data("anun");
            location.href="${createLink(controller: 'ver', action: 'carrusel')}?id=" + id + "&anun=" + anun + "&tipo=" + 4;
        });

        $(".btnPreguntas").click(function () {
            var id = $(this).data("id");
            location.href="${createLink(controller: 'pregunta', action: 'list')}";
        });

        $(".btnAceptar").click(function () {
            var id = $(this).data("id");
            aceptarAnuncio(id)
        });

        $(".btnNegar").click(function () {
            var id = $(this).data("id");
            negarProducto(id)
        });

        $(".btnQuitarAnuncio").click(function () {
            var id = $(this).data("id");
            var prod = $(this).data("titulo");
            // console.log('prod', prod, 'id', id)
            quitarAnuncio(id, prod)
        });
    });

</script>
