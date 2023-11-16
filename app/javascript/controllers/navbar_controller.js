import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["submenu", "menugreen", "logo"]
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

}
