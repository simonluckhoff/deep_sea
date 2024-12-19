import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggleable"]

  fire() {
    console.log(this.toggleableTarget)
    this.toggleableTarget.classList.toggle("d-none")
  }
}
