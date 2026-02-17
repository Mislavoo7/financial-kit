import { Controller } from "@hotwired/stimulus"

export default class NameWizardController extends Controller {
  static targets = ["progress", "progressBar", "step", "results", "aiResults", "spinner", "resetBtn", "waitBtn", "pagination", "pageInfo"]

  static values = {
    locale: String,
    url: String,
    saveText: String,
    savedText: String,
    readMoreText: String,
    itemsPerPage: { type: Number, default: 10 }
  }

  wizardData = {
    gender: null,
    region: null,
  }

  currentStep = 1
  currentPage = 1
  allResults = []

  connect() {
    this.updateProgress()
    window.addEventListener('name-wizard:unsave', this.handleUnsaveEvent.bind(this))
  }

  disconnect() {
    window.removeEventListener('name-wizard:unsave', this.handleUnsaveEvent.bind(this))
  }

  handleUnsaveEvent(event) {
    const nameToUnsave = event.detail?.name
    if (nameToUnsave) {
      this.unsaveName(nameToUnsave)
    }
  }

  updateProgress() {
    const progress = (this.currentStep / 3) * 100
    this.progressTarget.textContent = this.currentStep
    this.progressTarget
    this.progressBarTarget.style.width = `${progress}%`
  }

  showStep(step) {
    this.stepTargets.forEach(el => el.classList.add('hidden'))
    const targetStep = this.stepTargets.find(el => el.classList.contains(`wizard-step-${step}`))
    if (targetStep) {
      targetStep.classList.remove('hidden')
    }
    this.currentStep = step
    this.updateProgress()
  }

  selectOption(event) {
    const button = event.currentTarget
    const step = button.closest('.wizard-step')
    const value = button.dataset.value

    step.querySelectorAll('.wizard-option').forEach(opt => {
      opt.classList.remove('border-primary-500', 'bg-primary-50')
    })
    button.classList.add('border-primary-500', 'bg-primary-50')

    if (step.classList.contains('wizard-step-1')) {
      this.wizardData.gender = value
      setTimeout(() => this.showStep(2), 300)
    } else if (step.classList.contains('wizard-step-2')) {
      this.wizardData.region = value
      setTimeout(() => this.showStep(3), 300)
      setTimeout(() => this.showResults(), 300)
    }
  }

  goBack(event) {
    const currentStepEl = event.currentTarget.closest('.wizard-step')
    if (currentStepEl.classList.contains('wizard-step-2')) {
      this.showStep(1)
    } else if (currentStepEl.classList.contains('wizard-step-3')) {
      this.showStep(2)
    }
  }

  async showResults() {
    this.stepTargets.forEach(el => el.classList.add('hidden'))
    this.resultsTarget.classList.remove('hidden')
    const token = document.querySelector('meta[name="csrf-token"]').content
    const locale = this.localeValue || 'en'
    const url = this.urlValue;

    const response = await fetch(`${url}?region=${this.wizardData.region}&gender=${this.wizardData.gender}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      }
    })
    const data = await response.json()
    let parsed = this.parseResults(data)

    console.log(data)

    // Store all results and reset to first page
    this.allResults = parsed
    this.currentPage = 1
    this.renderCurrentPage()
  }

  parseResults(data) {
    try {
      if (Array.isArray(data)) {
        return data
      } else if (typeof data === 'string') {
        return JSON.parse(data)
      } else {
        throw new Error("Unexpected data format")
      }
    } catch (e) {
      console.error("Could not parse JSON:", e, data)
      return [{ name: "Error", description: "Failed to parse response. Please try again." }]
    }
  }

  renderCurrentPage() {
    const itemsPerPage = this.itemsPerPageValue
    const startIndex = (this.currentPage - 1) * itemsPerPage
    const endIndex = startIndex + itemsPerPage
    const currentItems = this.allResults.slice(startIndex, endIndex)

    this.spinnerTarget.classList.add('hidden')
    this.resetBtnTarget.classList.remove('hidden')
    this.waitBtnTarget.classList.add('hidden')

    this.renderResults(currentItems)
    this.renderPagination()
  }

  renderResults(items) {
    this.aiResultsTarget.innerHTML = ""

    // Get saved names from localStorage once
    const saved = JSON.parse(localStorage.getItem("savedNames") || "[]")

    items.forEach(item => {
      const el = document.createElement("div")
      el.className = "name-card pb-5"

      const saveButton = document.createElement('span')
      saveButton.className = "flex items-center bg-gray-200 rounded-xl px-2 py-1 gap-1 cursor-pointer hover:bg-gray-300 transition-colors"
      saveButton.id = `js-save-${item.id}`
      saveButton.dataset.action = "click->name-wizard#saveName"
      saveButton.dataset.name = item.name
      saveButton.dataset.description = item.description

      // Check if this name is already saved
      const isSaved = saved.some(savedItem => savedItem.name === item.name)

      const iconSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg")
      iconSvg.setAttribute("class", `size-4 shrink-0 ${isSaved ? 'text-green-600' : ''}`)
      iconSvg.setAttribute("fill", "currentColor")
      iconSvg.setAttribute("viewBox", "0 0 256 256")

      if (isSaved) {
        // Checkmark icon for saved names
        iconSvg.innerHTML = '<path d="M229.66,77.66l-128,128a8,8,0,0,1-11.32,0l-56-56a8,8,0,0,1,11.32-11.32L96,188.69,218.34,66.34a8,8,0,0,1,11.32,11.32Z"></path>'
      } else {
        // Copy icon for unsaved names
        iconSvg.innerHTML = '<path d="M216,32H88a8,8,0,0,0-8,8V80H40a8,8,0,0,0-8,8V216a8,8,0,0,0,8,8H168a8,8,0,0,0,8-8V176h40a8,8,0,0,0,8-8V40A8,8,0,0,0,216,32ZM160,208H48V96H160Zm48-48H176V88a8,8,0,0,0-8-8H96V48H208Z"></path>'
      }

      const text = document.createElement('small')
      text.textContent = isSaved ? this.savedTextValue : this.saveTextValue

      saveButton.appendChild(iconSvg)
      saveButton.appendChild(text)

      if (item.description == null) {
        // Create Read More button
        var readMoreButton = document.createElement('span')
        readMoreButton.className = "flex items-center bg-blue-100 rounded-xl px-2 py-1 gap-1 cursor-pointer hover:bg-blue-200 transition-colors"
        readMoreButton.dataset.action = "click->name-wizard#readMore"
        readMoreButton.dataset.nameId = item.id
        readMoreButton.dataset.name = item.name

        const readMoreIcon = document.createElementNS("http://www.w3.org/2000/svg", "svg")
        readMoreIcon.setAttribute("class", "size-4 shrink-0")
        readMoreIcon.setAttribute("fill", "currentColor")
        readMoreIcon.setAttribute("viewBox", "0 0 256 256")
        readMoreIcon.innerHTML = '<path d="M229.66,109.66l-48,48a8,8,0,0,1-11.32-11.32L204.69,112H128a88.1,88.1,0,0,0-88,88,8,8,0,0,1-16,0A104.11,104.11,0,0,1,128,96h76.69L170.34,61.66a8,8,0,0,1,11.32-11.32l48,48A8,8,0,0,1,229.66,109.66Z"></path>'

        const readMoreText = document.createElement('small')
        readMoreText.textContent = this.readMoreTextValue || 'Read More'

        readMoreButton.appendChild(readMoreIcon)
        readMoreButton.appendChild(readMoreText)
      }

      el.innerHTML = `
<div class="grid grid-cols-3 md:grid-cols-5 gap-2 pb-4 items-center js-button-container"> 
  <h3 class="col-start-1 md:col-start-2">${this.escapeHtml(item.name)}</h3>

</div>
<div class="grid grid-cols-3 md:grid-cols-5 gap-2 pb-4 items-center">
<p class='col-start-1 md:col-start-2 col-span-4 text-gray-600' data-name-id="${item.id}">${this.escapeHtml(item.description || '')}</p>
        </div>`

      var buttonContainer = el.querySelector('.js-button-container')
      if (item.description == null) {
        buttonContainer.appendChild(readMoreButton)
      }
      buttonContainer.appendChild(saveButton)

      this.aiResultsTarget.appendChild(el)
    })
  }

  async readMore(event) {
    const button = event.currentTarget
    const nameId = button.dataset.nameId
    const name = button.dataset.name
    const locale = this.localeValue || 'en'

    // Find the description paragraph
    const descriptionP = this.element.querySelector(`p[data-name-id="${nameId}"]`)
    if (!descriptionP) return

    // Show loading state
    const originalText = button.querySelector('small').textContent
    button.querySelector('small').textContent = '...'
    button.classList.add('opacity-50', 'pointer-events-none')

    try {
      const token = document.querySelector('meta[name="csrf-token"]').content
      const response = await fetch(`${this.urlValue}/${nameId}?locale=${locale}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": token
        }
      })

      if (!response.ok) {
        throw new Error('Failed to fetch description')
      }

      const data = await response.json()

      if (data.description) {
        descriptionP.textContent = data.description

        // Update the item in allResults so pagination preserves the description
        const itemIndex = this.allResults.findIndex(item => item.id === parseInt(nameId))
        if (itemIndex !== -1) {
          this.allResults[itemIndex].description = data.description
        }

        var saveButton = document.querySelector(`#js-save-${data.id}`)
        saveButton.dataset.description = data.description

        // Hide the Read More button after successful fetch
        button.classList.add('invisible')
      }
    } catch (error) {
      console.error('Error fetching description:', error)
      button.querySelector('small').textContent = originalText
      button.classList.remove('opacity-50', 'pointer-events-none')
      alert('Failed to load description. Please try again.')
    }
  }

  renderPagination() {
    const totalPages = Math.ceil(this.allResults.length / this.itemsPerPageValue)

    if (totalPages <= 1) {
      if (this.hasPaginationTarget) {
        this.paginationTarget.innerHTML = ""
      }
      return
    }

    const paginationHTML = `
      <div class="flex items-center justify-center flex-wrap gap-2 mt-6 pt-6 border-t border-gray-200">
        ${this.getPageButtons(totalPages)}
      </div>
    `

    if (this.hasPaginationTarget) {
      this.paginationTarget.innerHTML = paginationHTML
    } else {
      const paginationDiv = document.createElement('div')
      paginationDiv.dataset.nameWizardTarget = "pagination"
      paginationDiv.innerHTML = paginationHTML
      this.aiResultsTarget.parentElement.appendChild(paginationDiv)
    }
  }

  getPageButtons(totalPages) {
    const pages = []
    const maxVisible = 4

    if (totalPages <= maxVisible) {
      for (let i = 1; i <= totalPages; i++) {
        pages.push(this.createPageButton(i))
      }
    } else {
      if (this.currentPage <= 3) {
        for (let i = 1; i <= 4; i++) pages.push(this.createPageButton(i))
        pages.push(this.createEllipsis())
        pages.push(this.createPageButton(totalPages))
      } else if (this.currentPage >= totalPages - 2) {
        pages.push(this.createPageButton(1))
        pages.push(this.createEllipsis())
        for (let i = totalPages - 3; i <= totalPages; i++) {
          pages.push(this.createPageButton(i))
        }
      } else {
        pages.push(this.createPageButton(1))
        pages.push(this.createEllipsis())
        pages.push(this.createPageButton(this.currentPage - 1))
        pages.push(this.createPageButton(this.currentPage))
        pages.push(this.createPageButton(this.currentPage + 1))
        pages.push(this.createEllipsis())
        pages.push(this.createPageButton(totalPages))
      }
    }

    return pages.join('')
  }

  createPageButton(page) {
    const isActive = this.currentPage === page
    return `
      <button
        data-action="click->name-wizard#goToPage"
        data-page="${page}"
        class="px-4 py-2 rounded-lg font-medium transition-colors ${
          isActive
            ? 'bg-primary-600 text-white'
            : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
        }">
        ${page}
      </button>
    `
  }

  createEllipsis() {
    return `<span class="px-3 py-2 text-gray-400">...</span>`
  }


  goToPage(event) {
    const page = parseInt(event.currentTarget.dataset.page)
    this.currentPage = page
    this.renderCurrentPage()
    this.scrollToResults()
  }

  scrollToResults() {
    this.resultsTarget.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }

  saveName(event) {
    const button = event.currentTarget
    let saved = JSON.parse(localStorage.getItem("savedNames") || "[]")

    const name = button.dataset.name
    const description = button.dataset.description

    const alreadyExists = saved.some(item => item.name === name)

    if (!alreadyExists) {
      saved.push({ name, description })
      localStorage.setItem("savedNames", JSON.stringify(saved))

      window.dispatchEvent(new CustomEvent('name-list:update'))

      const iconSvg = button.querySelector('svg')
      iconSvg.classList.add('text-green-600')
      iconSvg.innerHTML = '<path d="M229.66,77.66l-128,128a8,8,0,0,1-11.32,0l-56-56a8,8,0,0,1,11.32-11.32L96,188.69,218.34,66.34a8,8,0,0,1,11.32,11.32Z"></path>'

      button.querySelector('small').textContent = this.savedTextValue
    } else {
      this.unsaveName(name)
    }
  }

  unsaveName(name) {
    let saved = JSON.parse(localStorage.getItem("savedNames") || "[]")

    const updated = saved.filter(item => item.name !== name)
    localStorage.setItem("savedNames", JSON.stringify(updated))

    const buttons = this.element.querySelectorAll(`[data-name="${name}"]`)
    buttons.forEach(button => {
      const iconSvg = button.querySelector('svg')
      iconSvg.classList.remove('text-green-600')
      iconSvg.innerHTML = '<path d="M216,32H88a8,8,0,0,0-8,8V80H40a8,8,0,0,0-8,8V216a8,8,0,0,0,8,8H168a8,8,0,0,0,8-8V176h40a8,8,0,0,0,8-8V40A8,8,0,0,0,216,32ZM160,208H48V96H160Zm48-48H176V88a8,8,0,0,0-8-8H96V48H208Z"></path>'

      const label = button.querySelector('small')
      if (label) label.textContent = this.saveTextValue
    })

    window.dispatchEvent(new CustomEvent('name-list:update'))
  }

  reset() {
    window.location.reload()
  }

  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
}
