import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  index(event) {
    const canceled = event.target.value;
    const patient_id = this.data.get('patientId');

    axios.get('/ajax/orders', {
        params: { patient_id, canceled }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#orders-listup').innerHTML = html);
  }

  edit(event) {
    event.preventDefault();
    const request_uri = this.data.get('editUri');

    axios.get(request_uri)
    .then(response => response.data)
    .then(html => document.querySelector('#order-edit-modal').innerHTML = html);
  }
}
