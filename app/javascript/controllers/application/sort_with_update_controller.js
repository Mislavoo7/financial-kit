import { Controller } from "@hotwired/stimulus";
import Sortable from 'sortablejs';

export default class SortWithUpdateController extends Controller {
  connect() {
    const updatePath = this.element.dataset.sortableUpdatePath;
    Sortable.create(this.element, {
      dataIdAttr: 'data-sortable-id',
      handle: "[data-sortable-handle]",
      ghostClass: "sortable-ghost",
      dragClass: "sortable-drag",
      draggable: "[data-sortable-id]",
      animation: 150,
      onUpdate: (evt) => {
        this.updateSortOrder(evt, updatePath);
      }
    });
  }

  updateSortOrder(evt, updatePath) {
    const itemIds = [...evt.item.closest('[data-controller="sort-with-update"]').querySelectorAll('[data-sortable-id]')].map(item => item.dataset.sortableId);
    fetch(updatePath, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken()
      },
      body: JSON.stringify({ ids: itemIds })
    });

  }

  csrfToken() {
    const token = document.querySelector('meta[name="csrf-token"]');
    return token ? token.content : null;
  }
}
