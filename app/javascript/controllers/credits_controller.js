import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["plus"]

  connect() {
    console.log("Hello from our first Stimulus controller")
  }
  show() {
    console.log('test')
  }
}
