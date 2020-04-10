import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  new(event) {
    event.preventDefault();
    const selected_options = document.querySelector('#exam-sets select').selectedOptions;
    const exam_set_ids = [...selected_options].map(e => e.value);
    const resource_field = this.data.get('resourceField');

    axios.get('/ajax/select_exam_sets/new', {
        params: { exam_set_ids, resource_field }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#selected-exams').innerHTML += html);
  }
}
