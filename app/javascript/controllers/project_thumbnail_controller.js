import { Controller } from "stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    if (this.isLoggedIn()) {
      this.sortable = Sortable.create(this.element, {
        animation: 150,
        draggable: ".thumbs-projetinhos",
        onEnd: this.onDragEnd.bind(this),
      });
    }
  }

  isLoggedIn() {
    return this.data.get("loggedIn") === "true";
  }

  onDragEnd(event) {
    if (this.isLoggedIn()) {
      const itemId = event.item.id;
      const newPosition = this.getNewPosition(event.item);

      this.updatePosition(itemId, newPosition);
    }
  }

  updatePosition(itemId, newPosition) {
    const url = `/projects/${itemId}/update_position`;
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ position: newPosition }),
    }).catch((error) => {
      console.error("Error updating position:", error);
    });
  }

  getNewPosition(item) {
    const projectIds = this.sortable.toArray();
    const newPosition = projectIds.indexOf(item.id);
    return newPosition;
  }

  disconnect() {
    this.sortable.destroy();
  }
}
