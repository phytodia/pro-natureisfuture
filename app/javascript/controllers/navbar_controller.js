import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["submenu", "menugreen", "logo","menuMobile", "submenuMobile","menuprimaryMobile"]
  connect() {
    console.log("navbar stimulus")

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
    //debbuger;
    console.log("mobile click");
    //debugger;
    this.menuMobileTarget.classList.toggle("visible");
    this.submenuMobileTargets.forEach(element=>{element.classList.remove("visible")});
    document.querySelectorAll(".submenu-items").forEach(element=>{element.classList.remove("visible")});
  }
  toggleSubmenu(event){
    event.currentTarget.querySelector("ul").classList.toggle("visible");
  }
  voletSubmenu(event){
    //debugger;
    let indexMenu = Array.from(event.currentTarget.parentElement.children).indexOf(event.currentTarget);
    this.menuprimaryMobileTarget.classList.remove("visible");
    this.submenuMobileTargets[indexMenu].classList.add("visible");
  }


}
