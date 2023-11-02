import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["submenu"]
  connect() {
    console.log("navbar stimulus")

  }
  mouseOver(event) {

    //this.submenuTarget.style.background = "red";
    event.currentTarget.querySelector("ul").style.visibility = "visible";
  }
  mouseOut(event) {
    event.currentTarget.querySelector("ul").style.visibility = "hidden";
  }
}
