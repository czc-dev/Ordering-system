import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  select(event) {
    const set_id = event.target.value;
    const request_uri = `/ajax/inspection_details?set_id=${set_id}`;

    axios.get(request_uri)
      .then(response => response.data)
      .then(html => document.querySelector('#inspection-details').innerHTML = html);
  }
}
