import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="espace-pro"
export default class extends Controller {
  static targets = ["mobilemenu","tab","tabContent","result","messagelist"]
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
    event.preventDefault();
    let formtarget = event.currentTarget;
    console.log(formtarget);
    fetch(formtarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(formtarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values
          this.messagelistTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        formtarget.outerHTML = data.form
      })
  }

}
