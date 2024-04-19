import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="espace-pro"
export default class extends Controller {
  static targets = ["mobilemenu","tab","tabContent","form","result"]
  connect() {
    console.log("espace pro")
    console.log(this.formTargets.action)
  }
  reduce(){
  }
  mobile(){
    this.mobilemenuTarget.classList.toggle("visible")
  }
  selectTab(event){
    this.tabTargets.forEach((element)=>{
      element.classList.remove("selected")
    })
    event.currentTarget.classList.add("selected")
    let tabIndex = this.tabTargets.indexOf(event.currentTarget)
    this.tabContentTargets.forEach((element)=>{
      element.classList.remove("visible")
    })
    this.tabContentTargets[tabIndex].classList.add("visible")
  }

}
