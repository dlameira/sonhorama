import { Controller } from "stimulus";
import Sortable from "sortablejs";

export default class extends Controller {

  static targets = ["container", "project"];

  connect() {
    if (this.hasBeenConnected) return;

    console.log("connect called");
    if (this.isLoggedIn()) {
      this.sortable = Sortable.create(this.element, {
        animation: 150,
        draggable: "[data-project-id]",
        onEnd: this.onDragEnd.bind(this),
      });
    }

    this.hasBeenConnected = true;
  }

  isLoggedIn() {
    return this.data.get("loggedIn") === "true";
  }

  onDragEnd(event) {
    console.log("onDragEnd called"); // Add this line
    if (this.isLoggedIn()) {
      const itemId = event.item.dataset.projectId;
      const newPosition = this.getNewPosition(event.item);

      this.updatePosition(itemId, newPosition);
    }
  }


  updatePosition(itemId, newPosition) {
    console.log("New position:", newPosition);

    const url = `/projects/${itemId}/update_position`;
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ project: { position: newPosition } }),
    }).catch((error) => {
      console.error("Error updating position:", error);
    });
  }

  getNewPosition(item) {
    const projectIds = Array.from(this.element.querySelectorAll('[data-project-id]'))
      .map(element => element.dataset.projectId);
    const newPosition = projectIds.indexOf(item.dataset.projectId);
    return newPosition;
  }


  disconnect() {
    this.sortable.destroy();
  }
}
