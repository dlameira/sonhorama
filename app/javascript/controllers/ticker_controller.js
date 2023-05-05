// ticker_controller.js
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['content'];

  initialize() {
    this.startTicker();
  }

  startTicker() {
    this.contentTargets.forEach((contentTarget, index) => {
      const tickerWidth = contentTarget.clientWidth;
      const viewportWidth = document.documentElement.clientWidth;
      const totalWidth = tickerWidth + viewportWidth;
      const speed = 50; // Adjust the speed by changing this value (smaller values = faster speed)
      const duration = (totalWidth / speed) * 1000;

      contentTarget.animate(
        [
          { transform: `translateX(${viewportWidth + index * tickerWidth}px)` },
          { transform: `translateX(-${tickerWidth}px)` },
        ],
        {
          duration,
          iterations: Infinity,
          easing: 'linear',
        }
      );
    });
  }
}
