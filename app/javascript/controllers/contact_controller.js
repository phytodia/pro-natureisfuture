import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="contact"
export default class extends Controller {
  static targets = ["soin", "hiddenSoin","hiddenField"]
  connect() {
    console.log("data controller contact")
  }
  selectValue(){
    //this.soinTarget.value = this.soinTarget.options[this.soinTarget.selectedIndex].innerText
    this.hiddenSoinTarget.value = this.soinTarget.options[this.soinTarget.selectedIndex].innerText
  }
  objetSelect(event){
    debugger;
    if (event.currentTarget.value === "Devenir partenaire") {
      this.hiddenFieldTargets.forEach((element)=>{
        element.classList.remove("hidden-message")
      })
    }
    else {
      this.hiddenFieldTargets.forEach((element)=>{
        element.classList.add("hidden-message")
      })
    }
  }
}
