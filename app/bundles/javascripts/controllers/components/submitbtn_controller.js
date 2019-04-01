import { Controller } from 'stimulus';

export default class extends Controller {
  click() {
    this.element.className += ' is-loading';
  }
}
