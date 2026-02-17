import { Controller } from "@hotwired/stimulus";

export default class TabsController extends Controller {
  static targets = ["trigger", "content", "select"];

  connect() {
    this.init();
  }

  init() {
    if (this.triggerTargets.length > 0) {
      const firstTabIndex = this.initOpenCertainTab() || this.triggerTargets[0].dataset.index;
      this.openTab(firstTabIndex);
      this.activateTab(firstTabIndex);
      if (this.hasSelectTarget) {
        this.activateSelect(firstTabIndex);
        this.initSelectEvent();
      }
    }
    this.initTriggerEvents();
  }

  initTriggerEvents() {
    this.triggerTargets.forEach((target) => {
      target.addEventListener("click", () => {
        const index = target.dataset.index;
        this.openTab(index);
        this.activateTab(index);
        if (this.hasSelectTarget) {
          this.activateSelect(index);
        }
      });
    });
  }

  initSelectEvent() {
    this.selectTarget.addEventListener("change", () => {
      const selectedIndex = this.selectTarget.value;
      this.openTab(selectedIndex);
      this.activateTab(selectedIndex);
    });
  }

  initOpenCertainTab() {
    // Find tab that should be opened
    let currentUrl = window.location.href;
    let tabToOpen = currentUrl.split("#")[1] //.indexOf('#');
    let indexToOpen = false;
    if (tabToOpen) {
      this.triggerTargets.forEach((target) => {
        if (target.id == tabToOpen) {
          indexToOpen = target.dataset.index 
        }
      });
    } 
    return indexToOpen
  }

  replaceUrl(slug) {
    if (!slug.length) { return false };

    let currentUrl = window.location.href;
    let hashIndex = currentUrl.indexOf('#');
    // Check if "#" exists in the URL
    if (hashIndex !== -1) {
      // Create the new URL by keeping everything before "#" and adding the new hash
      let newUrl = currentUrl.substring(0, hashIndex) + `#${slug}`;
      window.history.pushState({}, '', newUrl);
    } else {
      let newUrl = currentUrl + `#${slug}`;
      window.history.pushState({}, '', newUrl);
    }
  }

  openTab(index) {
    const contentHiddenClass = "hidden";

    this.contentTargets.forEach((target) => {
      const isActive = target.dataset.index == index;
      isActive ? target.classList.remove(contentHiddenClass) : target.classList.add(contentHiddenClass);
    });
  }

  activateTab(index) {
    const activeClasses = this.data.get("tabActive").split(" ");
    const inactiveClasses = this.data.get("tabInactive").split(" ");

    this.triggerTargets.forEach((target) => {
      const isActive = target.dataset.index == index;
      if (isActive) { this.replaceUrl(target.id) };

      const classesToAdd = isActive ? activeClasses : inactiveClasses;
      const classesToRemove = isActive ? inactiveClasses : activeClasses;

      target.classList.add(...classesToAdd);
      target.classList.remove(...classesToRemove);
    });
  }

  activateSelect(index) {
    this.selectTarget.value = index;
  }
}

/* 
<div data-controller="tabs" data-tabs-tab-active="active text-primary-600 border-primary-600" data-tabs-tab-inactive="hover:text-gray-600 hover:border-gray-200 border-transparent">
  <%= select_tag :tabs_select,
    options_for_select((1..3).map.each_with_index{ |tab, index| ["Tab #{tab}", index] }),
    include_blank: false,
    class: 'sm:hidden page-navigation-tabs',
    data: { tabs_target: 'select' }
  %>

  <div class="hidden sm:block text-sm font-medium text-center text-gray-500 mb-4">
    <ul class="flex flex-wrap gap-4 border-b border-gray-200 -mb-px">
      <% (1..3).each_with_index do |tab, index| %>
        <li data-tabs-target="trigger" data-index="<%= index %>" class="select-none inline-block p-4 border-b-2 cursor-pointer" id="slug">
          <%= "Tab #{tab}" %>
        </li>
      <% end %>
    </ul>
  </div>

  <% (1..3).each_with_index do |tab, index| %>
    <div data-tabs-target="content" data-index="<%= index %>" class="hidden sm:p-4">
      <%= "Tab #{tab} content" %>
    </div>
  <% end %>
</div>
*/
