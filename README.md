# Automação - Blog do Agi

## Objetivo

Validar a confiabilidade e o comportamento da funcionalidade de busca do blog do Agi, considerando diferentes tipos de entrada e possíveis variações de uso do usuário.

---

## Sistema testado

https://blogdoagi.com.br/

---

## Cenários automatizados

### Busca com termo válido

Valida que o sistema retorna artigos relacionados ao termo pesquisado.

### Busca com termo inexistente

Valida que o sistema exibe mensagem apropriada quando não há resultados para o termo pesquisado.

### Busca sem digitar nada

Valida o comportamento da aplicação ao realizar uma busca vazia, onde o sistema retorna uma listagem padrão de conteúdos.

### Busca com caracteres especiais

Valida que o sistema exibe mensagem apropriada quando não há resultados para o termo pesquisado com caracteres especiais.

### Busca digitando espaço vazio

Valida o comportamento da aplicação ao realizar uma busca digitando apenas espaços vazios, onde o sistema retorna uma listagem padrão de conteúdos.

---

## Estratégia de testes

Os cenários foram definidos com base na criticidade da funcionalidade de busca, cobrindo:

* Fluxo positivo (retorno esperado de resultados)
* Fluxo negativo (ausência de resultados)
* Comportamento alternativo (busca sem entrada)

A estratégia de testes foi baseada na análise de comportamento da funcionalidade de busca, considerando não apenas fluxos esperados, mas também cenários de borda e possíveis variações de entrada do usuário.

Os testes foram desenhados para validar a regra de negócio e a experiência do usuário, evitando validações frágeis baseadas apenas na estrutura da interface.

### Complemento da estratégia

Além dos testes funcionais de interface, a estratégia foi expandida para incluir:

* **Testes de API**, garantindo a consistência dos dados retornados pela busca
* **Testes de performance**, avaliando o comportamento da aplicação sob carga

---

## Abordagem técnica

Foram utilizadas duas abordagens de automação:

* **Robot Framework**: abordagem inicial, focada em validação funcional e testes de API
* **Playwright**: abordagem mais moderna, com maior controle sobre sincronização e estabilidade dos testes

A utilização do Playwright permitiu tratar comportamentos dinâmicos da interface e reduzir instabilidades observadas na automação via Selenium Library com Robot.

### Testes de API

Durante a análise, foi identificado que a funcionalidade de busca é renderizada server-side, sem chamadas XHR visíveis no frontend.

Para validar a camada de dados, foi utilizada a API REST padrão do WordPress:

```
/wp-json/wp/v2/posts?search=<termo>
```

Os testes de API validam:

* Status code da resposta
* Presença de dados no retorno
* Estrutura básica do JSON

Essa abordagem permite validar o backend de forma independente da interface.

---

## Tecnologias utilizadas

### Robot Framework

* Robot Framework
* SeleniumLibrary
* RequestsLibrary
* Python
* Google Chrome

### Playwright

* Playwright
* TypeScript
* Node.js
* Chromium / Firefox / WebKit

### Performance

* k6

---

## Estrutura do projeto

```
Teste Técnico Mirante/
│
├── playwright-tests/
│   ├── tests/
│   │   └── busca.spec.ts
│   ├── playwright.config.ts
│   ├── package.json
│   └──  ...
│
├── robot-tests/
│   ├── common/
│   ├── resources/
│   ├── share/
│   └── tests/
│       ├── api/
│       └── ui/
│
├── performance-test.js
└── README.md
```

---

## Pré-requisitos

### Para Robot Framework

* Python instalado
* Pip instalado
* Google Chrome instalado

### Para Playwright

* Node.js instalado

### Para Performance

* k6 instalado

---

## Como executar os testes

### Robot Framework

1. Instalar dependências:

```
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-requests
```

2. Executar:

```
robot robot-tests/tests
```

---

### Playwright

1. Acessar a pasta:

```
cd playwright-tests
```

2. Instalar dependências:

```
npm install
npx playwright install
```

3. Executar testes:

```
npx playwright test
```

---

### Teste de Performance (k6)

Executar:

```
k6 run performance-test.js
```

---

## Testes de Performance

Foi implementado um teste de carga utilizando k6 para simular múltiplos usuários acessando a API de busca.

**Configuração:**

* 10 usuários simultâneos
* Duração de 10 segundos
* Endpoint testado: `/wp-json/wp/v2/posts?search=mercado`

**Resultados:**

* Taxa de sucesso: 100%
* Tempo médio: ~401ms
* Mediana: ~43ms
* Percentil 95 (p95): ~2.7s
* Nenhuma falha nas requisições

**Conclusão:**

A API apresentou estabilidade sob carga, com respostas rápidas na maior parte das requisições. Foram observados alguns picos de latência, comportamento esperado em cenários reais, sem impacto na disponibilidade do serviço.

---

## Evidências

### Robot Framework

Após a execução, são gerados automaticamente:

* `log.html`
* `report.html`
* `output.xml`

### Playwright

* Relatório HTML interativo (`playwright-report/`)
* Execução com trace disponível para debug

---

## Observações

Durante a automação, foram identificados alguns comportamentos relevantes da aplicação:

* A busca vazia não é bloqueada pelo sistema
* O sistema retorna resultados padrão nesse cenário
* A abertura do campo de busca depende de comportamento dinâmico da interface

Além disso, foram observados comportamentos **flaky**, principalmente relacionados à interação com o componente de busca.

Em alguns cenários, o menu principal é exibido automaticamente em modo overlay (tela azul), bloqueando a interação com a página. Esse comportamento parece estar relacionado ao estado do navegador (cache, cookies e localStorage), podendo impactar diretamente a execução dos testes.

Para mitigar essas situações, foram adotadas estratégias como:

* Limpeza de cookies e estado do navegador antes da execução
* Interações adicionais (como tecla ESC e clique fora do menu)
* Uso de waits para sincronização
* Retry controlado na abertura da busca (Playwright)
* Validações baseadas no comportamento final da aplicação

Mesmo com essas abordagens, a aplicação pode apresentar comportamento não determinístico em alguns cenários, o que pode impactar a estabilidade dos testes automatizados.


---

## Integração contínua

A execução em pipeline (CI) foi considerada, porém:

* A interface apresenta comportamento dinâmico e dependente de animações
* Isso pode gerar instabilidade em ambientes headless

Por esse motivo, optou-se por manter a execução local neste momento.

A integração pode ser adicionada futuramente com:

* Melhorias na sincronização
* Estratégias mais robustas de espera
* Execução via URL com query parameter

---

## Possíveis melhorias

* Implementação de Page Object Model (Playwright)
* Execução em modo headless estável
* Integração com CI/CD (GitHub Actions)
* Parametrização de dados de teste
* Execução cross-browser mais robusta
* Ampliação da cobertura com cenários de edge case
* Testes de API mais avançados (validação de schema)
* Testes de performance com cenários mais robustos

---

## Autor

Matheus Ywata
