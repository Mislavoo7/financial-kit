import { Controller } from "@hotwired/stimulus"

export default class NameListController extends Controller {
  static targets = ["container"]

  connect() {
    this.updateNameList()
    this.boundStorageHandler = this.handleStorageEvent.bind(this)
    this.boundCustomHandler = this.handleCustomEvent.bind(this)
    
    // listen to external events
    window.addEventListener('storage', this.boundStorageHandler)
    window.addEventListener('name-list:update', this.boundCustomHandler) // Add this
  }

  disconnect() {
    window.removeEventListener('storage', this.boundStorageHandler)
    window.removeEventListener('name-list:update', this.boundCustomHandler) // Add this
  }

  handleStorageEvent(e) {
    if (e.key === 'savedNames') {
      this.updateNameList()
    }
  }

  handleCustomEvent() {
    this.updateNameList()
  }

  updateNameList() {
    const savedNames = JSON.parse(localStorage.getItem('savedNames') || '[]')
    
    if (!this.hasContainerTarget) {
      console.error('Container target not found')
      return
    }

    this.containerTarget.innerHTML = ''

    // check if there are any names
    if (savedNames.length === 0) {
      this.containerTarget.innerHTML = `<p class="empty-message">${this.emptyMessage}</p>`
      return
    }

    // create cards for each name
    savedNames.forEach((item) => {
      const card = this.createNameCard(item)
      this.containerTarget.appendChild(card)
    })

    //console.log('Display updated with', savedNames.length, 'names')
  }

  createNameCard(item) {
    // Box with name name, X and name description
    const card = document.createElement('div')
    card.className = 'name-card'
    card.innerHTML = `
      <dl class="rounded-xl rounded-lgi sm:p-2 bg-white dark:bg-gray-800/75 dark:inset-ring dark:inset-ring-white/10">
        <div class="flex items-center justify-between p-3">
          <dd class="text-xl font-semibold tracking-tight text-gray-900 dark:text-white"> ${this.escapeHtml(item.name)} </dd>
          <button class="remove-btn text-gray-400 hover:text-gray-400 dark:text-gray-300 dark:hover:text-gray-300 leading-none p-1 transition-colors"
            data-action="click->name-list#removeName"
            data-name="${this.escapeHtml(item.name)}">
              X
          </button>
        </div>

        <dt class="m-2 text-sm font-medium text-gray-500 dark:text-gray-400">${this.escapeHtml(item.description)}</dt>
      </dl>
    `
    return card
  }

  removeName(event) {
    const name = event.currentTarget.dataset.name
    window.dispatchEvent(new CustomEvent('name-wizard:unsave', { detail: { name: name } }))
    // update will be called in name_wizard
  }

  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }

  get emptyMessage() {
    return this.element.dataset.emptyMessage || 'No names saved yet'
  }
}
