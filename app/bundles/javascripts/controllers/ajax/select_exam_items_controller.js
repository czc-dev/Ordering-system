import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  index(event) {
    const exam_set_id = event.target.value;
    const request_uri = `/ajax/select_exam_items?exam_set_id=${exam_set_id}`;

    axios.get(request_uri)
      .then(response => response.data)
      .then(html => document.querySelector('#exam-items').innerHTML = html);
  }

  new(event) {
    event.preventDefault();
    const selected_options = document.querySelector('#exam-items select').selectedOptions;
    const exam_item_ids = [...selected_options].map(e => e.value);
    const resource_field = this.data.get('resourceField');

    axios.get('/ajax/select_exam_items/new', {
        params: { exam_item_ids, resource_field }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#selected-exams').innerHTML += html);
  }
}
