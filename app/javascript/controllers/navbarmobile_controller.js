import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbarmobile"
export default class extends Controller {
  connect() {
    console.log("new mobile navbar")
  }

  toggleSubmenu(event){
    event.currentTarget.querySelector("ul").classList.toggle("visible");
  }
  toggleMenu(){
    console.log("click sur menu mobile")
    document.querySelector(".mobile-full-main").classList.toggle("visible")
  }
}
