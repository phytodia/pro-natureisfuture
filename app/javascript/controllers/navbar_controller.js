import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["submenu", "menugreen", "logo","menuMobile", "submenuMobile","menuprimaryMobile"]
  connect() {
    console.log("navbar stimulus")

  }

  removeVisible(event){
    document.querySelectorAll(".mobile-sous-menu").forEach((element) => {
      element.classList.remove("actif");
    });
  }
  mouseOver(event) {
    event.currentTarget.querySelector(".dropdown-nav").style.visibility = "visible";
    let heightList = event.currentTarget.querySelector(".dropdown-nav").offsetHeight;

    this.menugreenTarget.classList.add("visible");
    //document.querySelector("#menu-green").style.height = heightList;
  }
  mouseOut(event) {
    event.currentTarget.querySelector(".dropdown-nav").style.visibility = "hidden";
    this.menugreenTarget.classList.remove("visible");
  }
  toggleBurger(event){

    console.log("mobile click");
    //this.menuprimaryMobileTarget.classList.toggle()
    let burger = document.querySelector(".plate.plate5");

    if(burger.classList.contains('active') === true){
      this.menuprimaryMobileTarget.classList.add("actif")
    }
    else {
      this.menuprimaryMobileTarget.classList.remove("actif")
      this.submenuMobileTargets.forEach((element)=>{
        element.classList.remove("actif")
      })
      this.submenuMobileTargets.forEach((element)=>{
        element.classList.remove("actif")
      })
      document.querySelectorAll(".submenu-items").forEach((element)=>{
        element.classList.remove("visible")
      })
    }
  }
  voletSubmenu(event){
    this.menuprimaryMobileTarget.classList.remove("actif")
    this.submenuMobileTargets[event.currentTarget.dataset.index].classList.add("actif")
  }
  previousPanel(event){
    this.menuprimaryMobileTarget.classList.add("actif")
    this.submenuMobileTargets[event.currentTarget.dataset.index].classList.remove("actif")

  }

  toggleSubmenu(event){
    event.currentTarget.querySelector("ul").classList.toggle("visible");
  }


}
