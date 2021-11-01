import http from 'k6/http';
import { SharedArray } from "k6/data";
import { sleep } from 'k6';

var payload = new SharedArray("gcloudrun.user", function () {
  var f = JSON.parse(open("../json/post.k6.json"));
  //console.log(JSON.stringify(f));
  return f;
});

export let options = {
  vus: 10,
  duration: '1m',
  summaryTrendStats: ['avg', 'min', 'med', 'max', 'p(95)', 'p(99)', 'p(99.99)', 'count'],

  thresholds: {
    http_req_duration: ['avg<100', 'p(95)<200'],
    'http_req_connecting{cdnAsset:true}': ['p(95)<100'],
  },

};

export default function () {
  var host = __ENV.HOST;
  if (host.length == 0) {
    host = "http://localhost:8080";
  }
  var url = host+`/api/v1/user`;  
  var params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  http.post(url,  JSON.stringify(payload), params);
}

