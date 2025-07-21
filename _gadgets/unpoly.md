---
description: <a href="https://unpoly.com/">Unpoly</a> enhances your HTML with attributes to build dynamic UI on the server. Unpoly works with any language or framework. It plays nice with existing code, and gracefully degrades without JavaScript.
github: unpoly/unpoly
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - before-lib-load
    pocs:
      - description: |
          The [unpoly](https://unpoly.com/) library allows to perform **Same Origin** HTTP requests and update the DOM using attributes. The following ones can be used:
          - [up-target](https://unpoly.com/up-defer#up-target)
          - [up-submit](https://unpoly.com/up-submit)
          - [up-follow](https://unpoly.com/up-follow)
          - ...

          *The full list of attributes can be found [here](https://unpoly.com/attributes-and-options).*

          While this is limited to **Same Origin** HTTP requests, as it `fetch`, `write`, `replaceHistory` (update the URL), it will render the response as HTML no matter the response `Content-Type`. Because of this, it is possible to XSS using a simple PNG file.

          *Unfortunately, the preview isn't possible as the lib triggers an error in `srcdoc` iframe.*
        code: |
          <!DOCTYPE html> <!-- idk why quirks mode is required -->
          <script src="https://unpkg.com/unpoly@3.7.1/unpoly.min.js"></script>

          <!-- user input -->
          <a href="/endpoint-with-user-data" up-target="main">Click Me</a>
          <main></main>
        preview: false
    links:
      - https://unpoly.com/attributes-and-options
  Latest (2):
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - unsafe-eval-csp
      - custom-attr
      - before-lib-load
---
