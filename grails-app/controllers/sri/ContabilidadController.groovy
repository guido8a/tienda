package sri

import seguridad.Empresa
import seguridad.Persona


class ContabilidadController {

    def list(){

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa

       if(params.id == '-1') {
            flash.message = "No se ha creado aún una contabilidad, por favor cree una para registrar transacciones"
            flash.tipo = "error"
        }
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        params.sort = 'fechaInicio'

        def contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params)
        def contabilidadInstanceCount = Contabilidad.count()
        if (contabilidadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        contabilidadInstanceList = Contabilidad.findAllByInstitucion(session.empresa, params).sort{it.descripcion}
        def cuentas = Cuenta.countByNivelAndEmpresa(Nivel.get(1), empresa)

        return [contabilidadInstanceList: contabilidadInstanceList, contabilidadInstanceCount: contabilidadInstanceCount, cuentas: cuentas]
    }

    def crear_ajax () {

    }

    def form_ajax() {
        def contabilidadInstance = new Contabilidad(params)
        def empresa = Empresa.get(session.empresa.id)
        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            if (!contabilidadInstance) {
                notFound_ajax()
                return
            }
        }

        def cuentas = Cuenta.withCriteria {
            ilike("numero", '3%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaCredito = Cuenta.withCriteria {
            ilike("numero", '1%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaRetencion = Cuenta.withCriteria {
            ilike("numero", '2%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaCosto = Cuenta.withCriteria {
            ilike("numero", '5%')
            eq("empresa", empresa)
            order("numero","asc")
        }
        def cntaInvt = Cuenta.withCriteria {
            ilike("numero", '1%')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaBanco = Cuenta.withCriteria {
            ilike("numero", '1%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaPorPagar = Cuenta.withCriteria {
            ilike("numero", '2%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        def cntaPorCobrar = Cuenta.withCriteria {
            ilike("numero", '1%')
            ilike("movimiento", '0')
            eq("empresa", empresa)
            order("numero","asc")
        }

        return [contabilidadInstance: contabilidadInstance, cuentas: cuentas, cntacr: cntaCredito, cntart: cntaRetencion,
                cntacsto: cntaCosto, cntainvt: cntaInvt, banco: cntaBanco, pagar: cntaPorPagar, cobrar: cntaPorCobrar]
    } //form para cargar con ajax en un dialog

    protected void notFound_ajax() {
        render "NO_No se encontró la Contabilidad."
    } //notFound para ajax


}
