import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  static targets = [ "imgcover","imgselect"]
  connect() {
    console.log("hello from product stimulus")
    console.log(this.imgcoverTarget)
    this.imgcoverTarget.querySelector(".pdt-img-main").classList.add("visible")
    console.log(this.imgselectTarget)
    this.imgselectTarget.querySelector(".pdt-img-select").classList.add("selected")
  }
  carrouselSelect(event){
    let imgsCarrousel = Array.from(this.imgselectTarget.querySelectorAll(".pdt-img-select"))
    let imgIndex = imgsCarrousel.indexOf(event.currentTarget)
    let imgsCover = Array.from(this.imgcoverTarget.querySelectorAll(".pdt-img-main"))
    imgsCarrousel.forEach((element)=>{
      element.classList.remove("selected")
    })
    imgsCarrousel[imgIndex].classList.add("selected")
    imgsCover.forEach((element)=>{
      element.classList.remove("visible")
    })
    imgsCover[imgIndex].classList.add("visible")
  }
}
