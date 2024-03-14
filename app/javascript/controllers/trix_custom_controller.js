import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="trix-custom"
export default class extends Controller {
  connect() {
    Trix.config.blockAttributes.default.tagName = "p"
    Trix.config.blockAttributes.default.breakOnReturn = true

    Trix.config.blockAttributes.heading2 = {
      tagName: "h2",
      terminal: true,
      breakOnReturn: true,
      group: false
    }
    var h2ButtonHTML = '<button type="button" data-trix-attribute="heading2" title="Subheading">H2</button>'
    let groupElement = document.querySelector("trix-toolbar .trix-button-group")
    //var groupElement = Trix.config.toolbar.content.querySelector(".block_tools")
    groupElement.insertAdjacentHTML("beforeend", h2ButtonHTML)
  }
}
