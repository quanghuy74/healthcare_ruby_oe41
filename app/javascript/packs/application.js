import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "jquery"
require("chartkick")
require("chart.js")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
