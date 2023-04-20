import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["content"]

  connect() {
    console.log(this.element)
  }

  show() {
    if (this.hasContentTarget) {
      this.contentTarget.classList.toggle("d-none")
    }
    console.log(this.contentTarget.classList)
  }
}
