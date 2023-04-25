import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["content", "credits"]

  connect() {
    console.log("Controller connected")
    console.log(this.contentTarget)
  }

  show(event) {
    event.stopImmediatePropagation()
    this.contentTarget.classList.toggle("hide-credits")
    this.contentTarget.classList.toggle("show-credits")
    if (this.contentTarget.classList.contains("show-credits")) {
      this.creditsTarget.innerHTML = "<p><strong>Credits -</strong></p>"
    } else {
      this.creditsTarget.innerHTML = "<p><strong>Credits +</strong></p>"
    }
  }
}
