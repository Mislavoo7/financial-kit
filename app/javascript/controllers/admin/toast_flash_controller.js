import { Controller } from "@hotwired/stimulus";
import iziToast from "izitoast";

export default class ToastFlashController extends Controller {
  connect() {
    const message = this.data.get("message");
    let type = this.data.get("type");
    let color, textColor;

    switch (type) {
      case "success":
        color = "#10B981"; // TailwindCSS green-500
        textColor = "#FFFFFF"; // TailwindCSS white
        break;
      case "warning":
        color = "#F59E0B"; // TailwindCSS yellow-500
        textColor = "#FFFFFF"; // TailwindCSS white
        break;
      case "alert":
        color = "#EF4444"; // TailwindCSS red-500
        textColor = "#FFFFFF"; // TailwindCSS white
        break;
      default:
        type = "info";
        color = "#3B82F6"; // TailwindCSS blue-500
        textColor = "#FFFFFF"; // TailwindCSS white
        break;
    }

    iziToast.show({
      title: "",
      message: message,
      backgroundColor: color,
      icon: "",
      titleColor: textColor,
      messageColor: textColor,
      transitionIn: "bounceInUp",
      transitionOut: "fadeOutRight",
      theme: "dark",
    });
  }
}
