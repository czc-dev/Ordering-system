/* eslint no-console: 0 */

import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  click(event) {
    const csrf_token = document.querySelector('meta[name=csrf-token]').content;
    const resource_path = this.data.get('resourcePath');
    console.log(resource_path);

    const agree = confirm('この作業は取り消せません。よろしいですか?');

    if (agree) {
      axios.delete(resource_path, {
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': csrf_token
        }
      })
      .then(response => {
        // redirect
        window.location = response.data;
      })
      .catch(error => {
        console.log(error);
      });
    } else {
      event.preventDefault();
    }
  }
}
