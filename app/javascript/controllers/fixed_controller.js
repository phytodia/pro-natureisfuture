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
        document.getElementById("black-nav").classList.add("not-fixed")
          //nav.style.position = "fixed";
      } else {
        //navtoFixed.classList.remove("fixed");
        document.getElementById("black-nav").classList.remove("not-fixed")
      }
    });
  }
}
