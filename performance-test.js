import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  vus: 10, // usuários simultâneos
  duration: '10s', // duração do teste
};

export default function () {
  let res = http.get('https://blog.agibank.com.br/wp-json/wp/v2/posts?search=mercado');

  check(res, {
    'status é 200': (r) => r.status === 200,
    'resposta não vazia': (r) => r.body.length > 0,
  });

  sleep(1);
}