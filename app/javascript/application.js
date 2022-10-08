// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'

window.initGoogleApi = (...args) => {
  const options = { bubbles: true, cancelable: true }
  const event = new Event('google-api-callback', options, ...args)

  window.dispatchEvent(event)
}
