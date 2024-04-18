import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="espace-pro"
export default class extends Controller {
  static targets = ["mobilemenu","tab","tabContent","form"]
  connect() {
    console.log("espace pro")
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

  send(event){
    event.preventDefault()
    console.log("TODO: send request in AJAX 3")
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values

          //this.resultTarget.querySelector("ul").remove()
          this.resultTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        //this.formTarget.outerHTML = data.form
      })
  }
}
