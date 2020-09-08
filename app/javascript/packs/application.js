// CSS
import 'stylesheets/application'

// Images
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

// Rails UJS
import Rails from '@rails/ujs'
window.Rails = Rails
Rails.start()

// Rails
require("@rails/activestorage").start()
require("turbolinks").start()

// jQuery
// We assign window.jQuery so that the asset pipeline can use it
import jQuery from 'jquery'
window.jQuery = window.$ = jQuery;

// Bootstrap
import 'popper.js'
import 'bootstrap'

// Cocoon
require("@nathanvda/cocoon")

// ActionCable
// import 'channels'

// Stimulus and StimulusReflex
// import 'controllers'
