import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notices"
export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.messageTargets.forEach((el) => {
      // Hide after 3 seconds
      setTimeout(() => {
        el.classList.add("fade-out")
        // Remove from DOM after transition
        setTimeout(() => el.remove(), 500)
      }, 3000)
    })
  }
}
