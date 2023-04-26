import { Controller } from "stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      draggable: ".thumbs-projetinhos",
      onEnd: this.end.bind(this),
    });
  }

  end(event) {
    let projectIds = this.sortable.toArray();
    fetch("/projects/update_order", {
      method: "PUT",
      body: JSON.stringify({ order: projectIds }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
    });
  }

  disconnect() {
    this.sortable.destroy();
  }
}
