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
//        get "/"(controller: "login", view:"/login")
//        "/token/token"(controller: "token", action:"/creatoken")
//        post "/login/saludo"(controller: "login", action:"/saludo")
//        get "/saludo"(controller: "login", action:"/saludo")
//        get "/saludo2"(controller: "login", action:"/saludo")
        "500"(view:'/error')
        "404"(view:'/notFound')

    }
}
