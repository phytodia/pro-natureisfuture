import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cours"
export default class extends Controller {
  connect() {
  }
  dropdown(event){
    event.currentTarget.classList.toggle("open")
    event.currentTarget.nextElementSibling.classList.toggle("open")
  }
}
