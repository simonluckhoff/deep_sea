// import { Controller } from "@hotwired/stimulus"
// import Typed from "typed.js"

// // Connects to data-controller="typed"
// export default class extends Controller {
//   static values = { strings: Array }
//   connect() {
//     new Typed(this.element, {
//       strings: this.stringsValue,
//       typeSeed: 50
//     })
//   }
// }


import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed"
export default class extends Controller {
  static values = { strings: Array }

  connect() {
    // Ensure strings is an array of strings (e.g. handle single string case)
    const strings = Array.isArray(this.stringsValue) ? this.stringsValue : [this.stringsValue]

    new Typed(this.element, {
      strings: strings,
      typeSpeed: 50
    })
  }
}
