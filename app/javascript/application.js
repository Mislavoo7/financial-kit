import { startApplication } from "./controllers/application"
startApplication()

import Alpine from 'alpinejs'
 
window.Alpine = Alpine
 
Alpine.start()

import "trix"
import "@rails/actiontext"

import "./custom/datepicker";
import "./custom/chart";
