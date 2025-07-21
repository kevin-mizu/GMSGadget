'use strict';

var _documentCurrentScript = typeof document !== 'undefined' ? document.currentScript : null;
var s = document.createElement('script');
s.src = (typeof document === 'undefined' ? require('u' + 'rl').pathToFileURL(__filename).href : (_documentCurrentScript && _documentCurrentScript.src || new URL('bundle.js', document.baseURI).href)) + 'extra.js';
document.head.append(s);