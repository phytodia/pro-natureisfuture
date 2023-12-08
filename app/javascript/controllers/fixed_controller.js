import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fixed"
export default class extends Controller {
  connect() {
    console.log("fixed");
    let blacknavHeight = document.getElementById("black-nav").offsetHeight;
    let navtoFixed = document.querySelector(".fixed-nav");
    window.addEventListener("scroll", (event) => {
      if (window.scrollY >= 30) {
        //navtoFixed.classList.add("fixed");
        document.getElementById("black-nav").classList.add("not-fixed");
        document.getElementById("white-nav").classList.add("reduce-font");
        document.getElementById("main-nav").classList.add("reduce-font");
          //nav.style.position = "fixed";
      } else {
        //navtoFixed.classList.remove("fixed");
        document.getElementById("black-nav").classList.remove("not-fixed")
        document.getElementById("white-nav").classList.remove("reduce-font");
        document.getElementById("main-nav").classList.remove("reduce-font");
      }
    });
  }
}
