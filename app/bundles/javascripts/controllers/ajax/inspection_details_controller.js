import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  connect() {
    this.loadInspectionDetails();
  }

  select(event) {
    this.loadInspectionDetails(event.target.value);
  }

  loadInspectionDetails(set_id = '') {
    let request_uri = '/ajax/inspection_details';
    if(set_id.length !== 0) {
      request_uri += `?set_id=${set_id}`;
    }

    axios.get(request_uri)
      .then(response => response.data)
      .then(html => document.querySelector('#inspection-details').innerHTML = html);
  }
}
