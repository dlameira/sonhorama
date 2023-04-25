import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["content"]

  connect() {
    console.log("Controller connected")
    console.log(this.contentTarget)
  }

  show(event) {
    event.stopImmediatePropagation()
    this.contentTarget.classList.toggle("hide-credits")
    this.contentTarget.classList.toggle("show-credits")
  }
}
