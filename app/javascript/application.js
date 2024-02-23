import "@fortawesome/fontawesome-free"
import 'flowbite'
import "trix"
import "@rails/actiontext"
import './htmx.js';
import "htmx.org/dist/ext/response-targets"

const validStatusCodes = [200, 201, 303];

document.body.addEventListener('htmx:beforeSwap', function(evt) {
  if (!validStatusCodes.includes(evt.detail.xhr.status)) {
    evt.detail.shouldSwap = true;
    evt.detail.target = htmx.find("#form-errors");
    evt.detail.isError = false;
  }
});

document.body.addEventListener('htmx:afterSwap', function(evt) {
  if (validStatusCodes.includes(evt.detail.xhr.status) && evt.target.hasAttribute("data-note")) {
    let modalEL = htmx.find("#note-modal");
    const modalFlowbite = new Modal(modalEL);
    modalFlowbite.hide();
    initModals();
  }
});

