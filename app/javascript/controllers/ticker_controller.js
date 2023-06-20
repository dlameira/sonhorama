// app/javascript/controllers/ticker_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    this.startTicker();
  }

  // startTicker() {
  //   setInterval(() => {
  //     this.nextMessage();
  //   }, 10000);
  // }

  // nextMessage() {
  //   const activeMessages = this.containerTargets.filter((container) =>
  //     container.classList.contains("active")
  //   );

  //   activeMessages.forEach((container) => {
  //     const currentIndex = this.containerTargets.indexOf(container);
  //     const nextIndex = (currentIndex + 1) % this.containerTargets.length;

  //     container.classList.remove("active");
  //     this.containerTargets[nextIndex].classList.add("active");
  //   });

  //   setTimeout(() => {
  //     this.containerTargets.forEach((container) =>
  //       container.classList.remove("active")
  //     );
  //     this.containerTargets[0].classList.add("active");
  //   }, 1000);

  //   this.animateTicker();
  // }

  // animateTicker() {
  //   this.element.style.animation = "none";
  //   void this.element.offsetWidth;
  //   this.element.style.animation = null;
  // }

  // get containerTargets() {
  //   return this.targets.find("container");
  // }
}
