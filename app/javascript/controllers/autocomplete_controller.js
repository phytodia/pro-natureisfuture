import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete"
export default class extends Controller {
  connect() {
    console.log("autocomplete")
  }
  initialize(){
    let inputs = document.getElementById("horaires").querySelectorAll("input");

    ["lundi","mardi","mercredi","jeudi","vendredi","samedi","dimanche"].forEach((element)=>{
      let datas = JSON.parse(this.data.get("horaires"));
      //let inputId = `institut_horaires_${element}_am_1`;
      document.getElementById(`institut_horaires_${element}_am_1`).value = datas[element].am_1
      document.getElementById(`institut_horaires_${element}_am_2`).value = datas[element].am_2
      document.getElementById(`institut_horaires_${element}_pm_1`).value = datas[element].pm_1
      document.getElementById(`institut_horaires_${element}_pm_2`).value = datas[element].pm_2
    })

      //debugger;
      //document.getElementById(`institut_horaires_${element}_am_1`).value = datas.day.am_1

  }
}
