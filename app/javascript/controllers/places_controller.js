import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['search', 'submit']

  autocomplete() {
    if (this._autocomplete !== undefined) {
      return this._autocomplete
    }

    const autocompleteOptions = {
      componentRestrictions: { country: 'us' },
      fields: ['address_components', 'geometry', 'place_id'],
      types: ['address'],
    }

    this._autocomplete = new google.maps.places.Autocomplete(
      this.searchTarget, autocompleteOptions
    )

    this._autocomplete.addListener(
      'place_changed',
      this.locationChanged.bind(this)
    )

    return this._autocomplete
  }

  connect() {
    if (typeof google !== 'undefined') {
      this.initializeAutocomplete()
    }
  }

  disableSubmit(event) {
    // Allow the `Enter` key to select a Place and submit the form
    if (event.key === 'Enter') {
      if (!this.submitTarget.hasAttribute('disabled')) {
        this.submit()
      }

      return
    }

    this.submitTarget.setAttribute('disabled', 'disabled')
  }

  initializeAutocomplete() {
    this.autocomplete()
  }

  locationChanged() {
    const place = this.autocomplete().getPlace()
    const postalCode = place.address_components?.find((component) =>
      component.types?.find((type) => type === 'postal_code')
    )

    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert(`No location found for input: ${this.searchTarget.value}`)
      return
    }

    if (!postalCode) {
      window.alert('Please be more specific to determine a postal code')
      return
    }

    this.submitTarget.removeAttribute('disabled')
  }

  submit() {
    console.log('SUBMIT')
  }
}
