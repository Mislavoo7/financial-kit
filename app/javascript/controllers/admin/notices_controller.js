import { Controller } from "@hotwired/stimulus";

export default class NoticesController extends Controller {
  static targets = [ "message" ];

  connect() {
    console.log("NoticesController connected");
    this.message = this.messageTarget;

    const myTimeout = setTimeout(() => {
      this.hideMessage()
    }, 5000);
  }

  hideMessage() {
    // Add a class that triggers the transition
    this.message.classList.add("fade-out");

    // Optional: remove the element from DOM after animation
    this.message.addEventListener("transitionend", () => {
      this.message.remove();
    }, { once: true });
  }

  close(event) {
    this.hideMessage()
  }
}
