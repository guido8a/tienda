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

.aprobado {
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
            <g:if test="${dato.prodetdo == 'A'}">
                <g:set var="clase" value="${'aprobado'}"/>
            </g:if>

            <tr id="${dato.prod__id}" data-etdo="${dato.prodetdo}" class="${clase}" title="Haga clic derecho y seleccione una opción">
                <td style="width: 10%">
                    <img class="img-fluid imag-item" alt="First slide" style="max-width: 100px"
                         src="${request.contextPath}/principal/getImgnProd?id=${dato.prod__id}&tp=P"/>
                </td>

                <td width="25%">
                    ${dato?.prodtitl}
                </td>

                <td width="40%">
                    ${dato?.prodsbtl}
                </td>

                <td width="20%">
                    ${dato?.grpodscr}
                </td>
                <td width="5%">
                    ${dato.prodetdo}
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
