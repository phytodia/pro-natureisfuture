import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets= ["content"]
  connect() {
  }
  toggleAccordion(event){
    console.log("toggle accordion");
    event.currentTarget.querySelector(".accordion-hidden").classList.toggle("visible");
  }
}
