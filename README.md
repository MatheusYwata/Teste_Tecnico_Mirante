#  Automação - Blog do Agi

##  Objetivo

Validar a confiabilidade e o comportamento da funcionalidade de busca do blog do Agi, considerando diferentes tipos de entrada e possíveis variações de uso do usuário.

---

##  Sistema testado

https://blogdoagi.com.br/

---

##  Cenários automatizados

###  Busca com termo válido

Valida que o sistema retorna artigos relacionados ao termo pesquisado.

###  Busca com termo inexistente

Valida que o sistema exibe mensagem apropriada quando não há resultados para o termo pesquisado.

###  Busca sem digitar nada

Valida o comportamento da aplicação ao realizar uma busca vazia, onde o sistema retorna uma listagem padrão de conteúdos.

### Busca com caracteres especiais

Valida que o sistema exibe mensagem apropriada quando não há resultados para o termo pesquisado com caracteres especiais.

### Busca digitando espaço vazio

Valida o comportamento da aplicação ao realizar uma busca digitando apenas espaços vazios, onde o sistema retorna uma listagem padrão de conteúdos.

---

##  Estratégia de testes

Os cenários foram definidos com base na criticidade da funcionalidade de busca, cobrindo:

* Fluxo positivo (retorno esperado de resultados)
* Fluxo negativo (ausência de resultados)
* Comportamento alternativo (busca sem entrada)

A estratégia de testes foi baseada na análise de comportamento da funcionalidade de busca, considerando não apenas fluxos esperados, mas também cenários de borda e possíveis variações de entrada do usuário.

Os testes foram desenhados para validar a regra de negócio e a experiência do usuário, evitando validações frágeis baseadas apenas na estrutura da interface.

---
## Abordagem técnica

Foram utilizadas duas abordagens de automação:

- **Robot Framework**: abordagem inicial, focada em validação funcional
- **Playwright**: abordagem mais moderna, com maior controle sobre sincronização e estabilidade dos testes

A utilização do Playwright permitiu tratar comportamentos dinâmicos da interface e reduzir instabilidades observadas na automação via Selenium Library com Robot.

---

##  Tecnologias utilizadas

###  Robot Framework

* Robot Framework
* SeleniumLibrary
* Python
* Google Chrome

###  Playwright

* Playwright
* TypeScript
* Node.js
* Chromium / Firefox / WebKit

---

##  Estrutura do projeto

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
│
└── README.md
```

---

##  Pré-requisitos

### Para Robot Framework

* Python instalado
* Pip instalado
* Google Chrome instalado

### Para Playwright

* Node.js instalado

---

##  Como executar os testes

###  Robot Framework

1. Instalar dependências:

```
pip install robotframework
pip install robotframework-seleniumlibrary
```

2. Executar:

```
robot tests/
```

---

###  Playwright

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

4. Executar em modo visual:

```
npx playwright test --headed
```

5. Executar apenas no Chromium:

```
npx playwright test --project=chromium
```

---

##  Evidências

### Robot Framework

Após a execução, são gerados automaticamente:

* `log.html`
* `report.html`
* `output.xml`

### Playwright

* Relatório HTML interativo (`playwright-report/`)
* Execução com trace disponível para debug

---

##  Observações

Durante a automação, foi identificado que:

* A busca vazia não é bloqueada pelo sistema
* O sistema retorna resultados padrão nesse cenário
* A abertura do campo de busca depende de comportamento dinâmico da interface

Também foram observados comportamentos **flaky**, principalmente relacionados à interação com o componente de busca.

Para mitigar esse comportamento:

* Foi implementado retry controlado na abertura da busca (Playwright)
* As validações foram baseadas no comportamento final da aplicação

---

##  Integração contínua

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

---

##  Autor

Matheus Ywata


