import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="contact"
export default class extends Controller {
  static targets = ["soin", "hiddenSoin"]
  connect() {
    console.log("data controller contact")
  }
  selectValue(){
    //this.soinTarget.value = this.soinTarget.options[this.soinTarget.selectedIndex].innerText
    this.hiddenSoinTarget.value = this.soinTarget.options[this.soinTarget.selectedIndex].innerText
  }
}
