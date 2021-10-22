package inicio

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "principal", view:"/index")
//        "/"(controller: "login", view:"/login")
        "500"(view:'/error')
        "404"(view:'/notFound')

    }
}
