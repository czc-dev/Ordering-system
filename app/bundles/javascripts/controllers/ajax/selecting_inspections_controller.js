import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  submit(event) {
    event.preventDefault();
    const selectedOptions = document.querySelector('#inspection-details select').selectedOptions;
    const detail_ids = [...selectedOptions].map(e => e.value);

    axios.get('/ajax/selecting_inspections/new', {
        params: { detail_ids }
      })
      .then(response => response.data)
      .then(html => document.querySelector('#selected-inspections').innerHTML += html);
  }
}
