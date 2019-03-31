import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  index(event) {
    const canceled = event.target.value;
    const order_id = this.data.get('orderId');

    axios.get('/ajax/inspections', {
        params: { order_id, canceled }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#inspections-listup').innerHTML = html);
  }

  edit(event) {
    event.preventDefault();
    const request_uri = this.data.get('editUri');

    axios.get(request_uri)
    .then(response => response.data)
    .then(html => document.querySelector('#inspection-edit-modal').innerHTML = html);
  }
}
