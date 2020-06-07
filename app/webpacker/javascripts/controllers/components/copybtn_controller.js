/* eslint no-undef: 0 */

// https://developer.mozilla.org/en-US/docs/Web/API/Navigator/clipboard

import { Controller } from 'stimulus';

export default class extends Controller {
  click() {
    const invitationUrl = this.data.get('invitationUrl');

    navigator.clipboard.writeText(invitationUrl)
      .then(() => {
        alert('コピーしました。');
      })
      .catch((e) => {
        console.error(e);
      });
  }
}
