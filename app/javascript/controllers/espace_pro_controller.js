import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="espace-pro"
export default class extends Controller {
  static targets = ["mobilemenu"]
  connect() {
    console.log("espace pro")
  }
  reduce(){
  }
  mobile(){
    this.mobilemenuTarget.classList.toggle("visible")
  }
}
