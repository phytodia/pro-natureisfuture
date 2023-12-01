import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbarmobile"
export default class extends Controller {
  static targets = ["primarymenuMobile","voletMenu","submenuMobile"]
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
  voletSubmenu(event){
    //this.menuprimaryMobileTarget.classList.remove("visible")
    event.currentTarget.parentElement.parentElement.parentElement.classList.remove("visible")

    let volets = Array.from(document.querySelectorAll(".mobile-full-main"))
    volets.forEach((element)=>{element.classList.remove("visible")})
    volets[event.currentTarget.dataset.index].classList.add("visible")
    //this.voletMenuTargets[event.currentTarget.dataset.index].classList.add("actif")
  }
  previousPanel(event){
    let volets = Array.from(document.querySelectorAll(".mobile-full-main"))
    volets.forEach((element)=>{element.classList.remove("visible")})
    volets[event.currentTarget.dataset.index].classList.add("visible")
  }
}
