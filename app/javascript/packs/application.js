import Rails from "@rails/ujs"
require popper
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"

require jquery
require jquery-ujs

Rails.start()
Turbolinks.start()
ActiveStorage.start()
