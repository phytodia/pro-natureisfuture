import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="popup"
export default class extends Controller {
  static targets = [ "content"]
  connect() {
  }
  close(){
    this.contentTarget.style.display = "none";
  }
}
