// app/javascript/controllers/ticker_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    this.startTicker();
  }

  startTicker() {
    setInterval(() => {
      this.nextMessage();
    }, 10000);
  }

  nextMessage() {
    const activeMessage = this.containerTargets.find((container) =>
      container.classList.contains("active")
    );
    const currentIndex = this.containerTargets.indexOf(activeMessage);
    const nextIndex = (currentIndex + 1) % this.containerTargets.length;

    activeMessage.classList.remove("active");
    this.containerTargets[nextIndex].classList.add("active");

    this.animateTicker();
  }

  animateTicker() {
    this.element.style.animation = "none";
    void this.element.offsetWidth;
    this.element.style.animation = null;
  }

  get containerTargets() {
    return this.targets.find("container");
  }
}
