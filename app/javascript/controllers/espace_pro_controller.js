import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="espace-pro"
export default class extends Controller {
  static targets = ["mobilemenu","tab","tabContent","result"]
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
    console.log("TODO: send request in AJAX 23")
    let formSelected = event.currentTarget
    debugger
    fetch(formSelected.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(formSelected)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {

          // beforeend could also be dynamic with Stimulus values
          //this.itemsTarget.querySelector("ul").remove()
          //this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        //this.formTarget.outerHTML = data.form
      })
  }

}
