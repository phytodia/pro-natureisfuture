import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = [ "slide","slidemobile" ]
  // concerne mobile + desktop
  initialize() {
    this.index = 0
    //this.indexCarousel = 0
    this.showCurrentSlide()
    this.showmobileCurrentSlide()
  }
  // fin initialize

  next() {
    //sizeCarousel-=1
    if (this.index < (this.slideTargets.length-=1)){
      this.index++
      console.log(`this index: ${this.index}`)
      //this.indexCarousel++
      console.log(`index Carousel : ${this.slideTargets.length}`)
      this.showCurrentSlide()
    }
    else {
    }
  }

  previous() {
    if (this.index <= (this.slideTargets.length) && this.index > 0){
      this.index--
      console.log(`this index: ${this.index}`)
      //this.indexCarousel++
      console.log(`index Carousel : ${this.slideTargets.length}`)
      this.showCurrentSlide()
    }
    else {
    }
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.index
      console.log(this.index)
    })
  }

  nextmobile() {
    //sizeCarousel-=1
    if (this.index < (this.slidemobileTargets.length-=1)){
      this.index++
      console.log(`this index: ${this.index}`)
      //this.indexCarousel++
      console.log(`index Carousel : ${this.slidemobileTargets.length}`)
      this.showmobileCurrentSlide()
    }
    else {
    }
  }

  prevmobile() {
    if (this.index <= (this.slidemobileTargets.length) && this.index > 0){

      this.index--
      console.log(`this index: ${this.index}`)
      //this.indexCarousel++
      console.log(`index Carousel : ${this.slidemobileTargets.length}`)
      this.showmobileCurrentSlide()
    }
    else {

    }
  }

  showmobileCurrentSlide() {

    this.slidemobileTargets.forEach((element, index) => {
      element.hidden = index !== this.index
      console.log(this.index)
    })
  }


}
