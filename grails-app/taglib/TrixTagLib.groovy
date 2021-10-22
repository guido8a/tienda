class TrixTagLib {
    static namespace = 'trix'
    static defaultEncodeAs = [taglib: 'text']

    def editor = { attrs, body ->
        def id = attrs.id ?: attrs.name
        def height = ""
        def html = ""
        println "editor --> $attrs"
//        out << "\$('#${id}').remove();"
        html += "<input id=\"${id}\" type=\"hidden\" name=\"${attrs.name}\""
        if ( attrs.value ) {
            html += " value=\"${attrs.value.encodeAsHTML()}\""
        }
        if ( attrs.height ) {
            println ".. pone height a ${attrs.height.encodeAsHTML()}"
            height = " height=\"${attrs.height.encodeAsHTML()}\""
        }
        html += ' />'
        html += "<trix-editor input=\"${id}\" $height></trix-editor>"
//        println "-->$html"
        out << html
    }
}
