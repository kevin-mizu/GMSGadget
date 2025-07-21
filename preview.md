---
layout: page
title: Preview
---

<script>
	(() => {
		const params = new URLSearchParams(location.search);
		const html = params.get("html");
		const csp = params.get("csp") || "";
		let inline_csp = "";

		if (csp && csp.length > 0) {
			const validDirectives = [ "self", "strict-dynamic", "unsafe-eval" ];
			inline_csp = `<meta http-equiv="Content-Security-Policy" content="script-src 'nonce-secret'${csp.split(",")
				.filter(directive => validDirectives.includes(directive))
				.map(directive => ` '${directive}'`)
				.join("")}">`;
		}

		if (!html) return;

		const ifr = document.createElement("iframe");
		ifr.srcdoc = `<html>
		<head>
			${inline_csp}
		</head>
		<body>${html}</body>
		</html>`;
		ifr.width = "100%";
		ifr.height = "1000px";
		ifr.frameBorder = "0";
		document.body.appendChild(ifr);
	}) ()
</script>