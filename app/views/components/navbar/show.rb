module Components
  module Navbar
    class Show < React::Component::Base

      def say_hello
        alert "Hello!"
      end

      def render
        div {
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
              }
            }
          }
        }
      end
    end
  end
end
