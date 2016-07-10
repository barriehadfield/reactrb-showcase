module Components
  module Navbar
    class Show < React::Component::Base

      before_mount do
        state.show_modal! false
      end

      def say_hello
        alert "Hello!"
      end

      def render_modal
        Bs.Modal(show: state.show_modal, backdrop: 'static', onHide: lambda { close }) {
            Bs.ModalHeader {
              div.col_md_8 {
                h4 { "And a heading for our Modal" }
                }
              }
              div.col_md_4 {
                span.pull_right {
                  Bs.ButtonToolbar(key: 1) {
                    Bs.Button(key: 3) { 'Close' }.on(:click) { state.show_modal! false }
                  }
                }
              }
            }
            Bs.ModalBody {
              "and the body".span
          }

      end

      def render
        div {
          render_modal
          div(id: "main-navbar") {
            Bs.Navbar(bsStyle: :inverse) {
              Bs.Nav {
                Bs.NavbarBrand { a(href: '#') {"Reactrb Showcase"} }
                Bs.NavDropdown(eventKey: 1, title: "Things", id: :drop_down) {
                  (1..5).each do |n|
                    Bs.MenuItem(key: n, eventKey: "1.#{n.to_s}", href: '#' ) {
                      "Number #{n.to_s}"
                    }.on(:click) { say_hello }
                  end
                }
                Bs.MenuItem(key: 2, href: '#' ) { "Show Modal" }.on(:click) { state.show_modal! true }
              }
            }
          }
        }
      end
    end
  end
end
