import { Controller } from 'stimulus';

export default class extends Controller {
  click(event) {
    const message = this.data.get('message') || 'この操作は取り消せません。本当によろしいですか?';

    if (!confirm(message)) {
      event.preventDefault();
    }
  }
}
