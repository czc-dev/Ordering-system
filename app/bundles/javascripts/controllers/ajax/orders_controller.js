import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  initialize() {
    this.loadPatientOrders();
  }

  index(event) {
    const canceled = event.target.value;
    this.loadPatientOrders(canceled);
  }

  loadPatientOrders(canceled = 0) {
    const patient_id = this.data.get('patientId');

    axios.get('/ajax/orders', {
        params: { patient_id, canceled }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#orders-listup').innerHTML = html);
  }
}
