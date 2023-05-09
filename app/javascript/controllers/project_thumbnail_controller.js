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
    console.log("onDragEnd called");
    if (this.isLoggedIn()) {
      const projects = Array.from(this.element.querySelectorAll('[data-project-id]'));
      const newProjectIds = projects.map(element => element.dataset.projectId);

      this.updatePositions(newProjectIds);
    }
  }

  updatePositions(newProjectIds) {
    console.log("New project order:");
    newProjectIds.forEach((projectId, index) => {
      console.log(`Project ID: ${projectId}, New position: ${index}`);
    });

    const url = `/projects/update_positions`;
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch(url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ project_ids: newProjectIds }),
    }).catch((error) => {
      console.error("Error updating positions:", error);
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
