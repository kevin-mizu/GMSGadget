---
layout: page
title: Preview
---

<script>
    document.addEventListener("keydown", e => {
      if (e.key === "Escape") history.back();
    });
</script>

<style>
  textarea {
    width: 100%;
    height: 200px;
    font-family: monospace;
    padding: 8px;
    margin-bottom: 10px;
  }
  h3 {
    margin-bottom: 10px;
  }
  .controls {
    margin-bottom: 20px;
  }
  .csp-options {
    margin-bottom: 10px;
  }
  .csp-options label {
    margin-right: 15px;
  }
  button {
    padding: 8px 16px;
    background-color: #bf0707;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-top: 10px;
  }
  button:hover {
    background-color: #bf0707;
  }
  #preview-container {
    margin-top: 20px;
  }
</style>
<div class="controls">
  <h3>HTML Content</h3>
  <textarea id="html-input" placeholder="Enter HTML content to render"></textarea>
  
  <h3>Content Security Policy</h3>
  <div class="csp-options">
    <label><input type="checkbox" id="csp-self"> 'self'</label>
    <label><input type="checkbox" id="csp-strict-dynamic"> 'strict-dynamic'</label>
    <label><input type="checkbox" id="csp-unsafe-eval"> 'unsafe-eval'</label>
  </div>
  
  <button id="render-btn">Render Content</button>
</div>

<div id="preview-container"></div>

<script>
    function renderPreview() {
        const htmlContent = document.getElementById("html-input").value;
        const previewContainer = document.getElementById("preview-container");

        let cspOptions = [];
        if (document.getElementById("csp-self").checked) cspOptions.push("self");
        if (document.getElementById("csp-strict-dynamic").checked) cspOptions.push("strict-dynamic");
        if (document.getElementById("csp-unsafe-eval").checked) cspOptions.push("unsafe-eval");

        let inline_csp = "";
        if (cspOptions.length > 0) {
            inline_csp = `<meta http-equiv="Content-Security-Policy" content="script-src 'nonce-secret'${cspOptions.map(directive => ` '${directive}'`).join("")}">`;
        }

        previewContainer.innerHTML = "";

        if (htmlContent) {
            const ifr = document.createElement("iframe");
            ifr.srcdoc = `<html>
            <head>
                ${inline_csp}
            </head>
            <body>${htmlContent}</body>
            </html>`;
            ifr.width = "100%";
            ifr.height = "1000px";
            ifr.frameBorder = "0";
            previewContainer.appendChild(ifr);
        }
    }

    window.addEventListener("load", function() {
        const params = new URLSearchParams(location.search);
        const html = params.get("html") || "";
        const csp = params.get("csp") || "";

        // set html input
        document.getElementById("html-input").value = decodeURIComponent(html);

        // set csp options
        const cspValues = csp.split(",");
        if (cspValues.includes("self")) document.getElementById("csp-self").checked = true;
        if (cspValues.includes("strict-dynamic")) document.getElementById("csp-strict-dynamic").checked = true;
        if (cspValues.includes("unsafe-eval")) document.getElementById("csp-unsafe-eval").checked = true;

        // render preview
        renderPreview();
        document.getElementById("render-btn").addEventListener("click", renderPreview);
    });
</script>