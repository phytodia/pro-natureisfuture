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
    let burger = document.querySelector(".menu-mobile");
    burger.classList.toggle("active");
    let volets = document.querySelectorAll(".mobile-full-main");
    if(burger.classList.contains('active') === true){
      //debugger;
      document.querySelector(".mobile-full-main").classList.toggle("visible")
      //this.primaryMobileTarget.classList.add("actif")
    }
    else {
      document.querySelector(".mobile-full-main").classList.remove("visible")
      volets.forEach((element)=>{
        element.classList.remove("visible")
      })
      volets.forEach((element)=>{
        element.classList.remove("visible")
      })
      document.querySelectorAll(".submenu-items").forEach((element)=>{
        element.classList.remove("visible")
      })
    }
    //
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
