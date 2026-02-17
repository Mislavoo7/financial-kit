import { Application } from "@hotwired/stimulus"
import NoticesController from "./notices_controller";
import TranslateableTabsController from "./translateable_tabs_controller";
import TabsController from "./tabs_controller"
import Rails from "@rails/ujs"
import ToastController from "./toast_controller"
import ToastFlashController from "./toast_flash_controller"
import SortWithUpdateController from "./sort_with_update_controller"

Rails.start()

export function startAdmin() {
  const application = Application.start()
  application.debug = false
  window.AdminStimulus = application

  application.register("notices", NoticesController);
  application.register("tabs", TabsController)
  application.register("translateable-tabs", TranslateableTabsController);
  application.register("toast", ToastController)
  application.register("toast-flash", ToastFlashController)
  application.register("sort-with-update", SortWithUpdateController)
}
