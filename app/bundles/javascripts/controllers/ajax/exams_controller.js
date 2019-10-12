import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  index(event) {
    const canceled = event.target.value;
    const order_id = this.data.get('orderId');
    const page = this.data.get('page');

    axios.get('/ajax/exams', {
        params: { order_id, canceled, page }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#exams-listup').innerHTML = html);
  }

  edit(event) {
    event.preventDefault();
    const id = this.data.get('id');

    axios.get(`/ajax/exams/${id}/edit`)
      .then(response => response.data)
      .then(html => document.querySelector('#exam-edit-modal').innerHTML = html);
  }
}
