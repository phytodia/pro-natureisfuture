import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="institut"
export default class extends Controller {
  //static targets = [ "imgcover","imgselect"]
  static targets = ["imgcover", "imgselect","contentHide"]
  connect() {
    console.log("hello from institut stimulus")
    console.log(this.imgcoverTarget)
    this.imgcoverTarget.querySelector("img").classList.add("visible")
    this.imgselectTarget.querySelector("img").classList.add("selected")
    //this.imgselectTarget.

    //this.imgcoverTarget.querySelector(".pdt-img-main").classList.add("visible")
    //console.log(this.imgselectTarget)
    //this.imgselectTarget.querySelector(".pdt-img-select").classList.add("selected")
  }
  carrouselSelect(event){
    let imgsCarrousel = Array.from(this.imgselectTarget.querySelectorAll("img"))
    let imgIndex = imgsCarrousel.indexOf(event.currentTarget)
    let imgsCover = Array.from(this.imgcoverTarget.querySelectorAll("img"))
    imgsCarrousel.forEach((element)=>{
      element.classList.remove("selected")
    })
    imgsCarrousel[imgIndex].classList.add("selected")
    imgsCover.forEach((element)=>{
      element.classList.remove("visible")
    })
    imgsCover[imgIndex].classList.add("visible")
  }
  accordionToggle(event){
    console.log("open hide element")
    //this.contentHideTarget.classList.toggle("open")
    event.currentTarget.parentElement.nextElementSibling.classList.toggle("open")
  }
}
