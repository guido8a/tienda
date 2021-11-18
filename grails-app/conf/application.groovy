

// Added by the Audit-Logging plugin:
grails.plugin.auditLog.auditDomainClassName = 'audit.Audit'

environments {
    development {
        //grails.logging.jul.usebridge = true
//        grails.plugin.springsecurity.debug.useFilter = true
        grails {
            mail {
                host = "smtp.gmail.com"
                port = 465
                username = "tedein.sa.ecuador@gmail.com"
                password = "tedein2016"
                props = ["mail.smtp.auth":"true",
                         "mail.smtp.socketFactory.port":"465",
                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                         "mail.smtp.socketFactory.fallback":"false"]
            }
        }
        grails.mail.default.from="tedein.sa.ecuador@gmail.com"

    }
    production {
        grails {
            mail {
                host = "smtp.gmail.com"
                port = 465
                username = "tedein.sa.ecuador@gmail.com"
                password = "tedein2016"
                props = ["mail.smtp.auth":"true",
                         "mail.smtp.socketFactory.port":"465",
                         "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                         "mail.smtp.socketFactory.fallback":"false"]
            }
        }
        grails.mail.default.from="tedein.sa.ecuador@gmail.com"
    }
}

