import http from 'k6/http';
import { sleep } from 'k6';

const headers = { 'Content-Type': 'application/json' };

export let options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  var host = __ENV.HOST;
  if (host.length == 0) {
    host = "http://localhost:8080";
  }
  var url = host+`/api/v1/ping`;
  http.get(url,{ headers: headers });
}

