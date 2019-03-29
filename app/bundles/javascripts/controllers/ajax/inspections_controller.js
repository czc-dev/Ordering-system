import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  initialize() {
    this.loadOrderInspections();
  }

  index(event) {
    const canceled = event.target.value;
    this.loadOrderInspections(canceled);
  }

  loadOrderInspections(canceled = 0) {
    const order_id = this.data.get('orderId');

    axios.get('/ajax/inspections', {
        params: { order_id, canceled }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#inspections-listup').innerHTML = html);
  }
}
