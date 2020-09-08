// CSS
import 'stylesheets/application'

// Images
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// Rails Javascripts
require("@rails/ujs").start()
require("@rails/activestorage").start()

// jQuery
// We assign window.jQuery so that the asset pipeline (effective_gems) can use it
import jQuery from 'jquery'
window.jQuery = window.$ = jQuery;

// Bootstrap
import 'popper.js'
import 'bootstrap'

// ActionCable
// import 'channels'

// Stimulus and StimulusReflex
// import 'controllers'
