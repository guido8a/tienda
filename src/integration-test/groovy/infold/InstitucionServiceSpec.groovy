package tienda

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InstitucionServiceSpec extends Specification {

    InstitucionService institucionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Institucion(...).save(flush: true, failOnError: true)
        //new Institucion(...).save(flush: true, failOnError: true)
        //Institucion institucion = new Institucion(...).save(flush: true, failOnError: true)
        //new Institucion(...).save(flush: true, failOnError: true)
        //new Institucion(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //institucion.id
    }

    void "test get"() {
        setupData()

        expect:
        institucionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Institucion> institucionList = institucionService.list(max: 2, offset: 2)

        then:
        institucionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        institucionService.count() == 5
    }

    void "test delete"() {
        Long institucionId = setupData()

        expect:
        institucionService.count() == 5

        when:
        institucionService.delete(institucionId)
        sessionFactory.currentSession.flush()

        then:
        institucionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Institucion institucion = new Institucion()
        institucionService.save(institucion)

        then:
        institucion.id != null
    }
}
