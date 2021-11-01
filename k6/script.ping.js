import http from 'k6/http';
import { sleep } from 'k6';

const headers = { 'Content-Type': 'application/json' };

export let options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  var url2 = `http://localhost:8080/api/v1/ping`;
  http.get(url2,{ headers: headers });
}

