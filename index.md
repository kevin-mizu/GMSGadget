---
layout: page
title: GMSGadget 🚀
---

![logo](/assets/logo.png){:.logo}

*This project is inspired by the work of <a target="_blank" href="https://x.com/slekies">slekies</a>, <a target="_blank" href="https://x.com/kkotowicz">kkotowicz</a>, and <a target="_blank" href="https://x.com/sirdarckcat">sirdarckcat</a> in their <a target="_blank" href="https://www.blackhat.com/us-17/">Black Hat USA 2017</a> talk, "Breaking XSS Mitigations via Script Gadgets" (<a target="_blank" href="https://acmccs.github.io/papers/p1709-lekiesA.pdf">paper</a>, <a target="_blank" href="https://www.blackhat.com/docs/us-17/thursday/us-17-Lekies-Dont-Trust-The-DOM-Bypassing-XSS-Mitigations-Via-Script-Gadgets.pdf">slides</a>, <a target="_blank" href="https://www.youtube.com/watch?v=i6Ug8O23DMU">video</a>, <a target="_blank" href="https://github.com/google/security-research-pocs/tree/master/script-gadgets">github</a>).*

<h4 class="no-link">➵ What is this project about?</h4>

*GMSGadget (Give Me a Script Gadget)* is a collection of JavaScript gadgets that can be used to bypass XSS mitigations such as <a target="_blank" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP">Content Security Policy</a> (CSP) and HTML sanitizers like <a target="_blank" href="https://github.com/cure53/DOMPurify">DOMPurify</a>.

It's important to note that this is **not** a list of exploits. The gadgets listed here are either **patched** vulnerabilities or **intended** JavaScript behaviors that can be leveraged to bypass HTML restrictions.

<h4 class="no-link">➵ Want to contribute?</h4>

Your contributions are welcome! Whether it's submitting new gadgets, improving documentation, or reporting issues, feel free to get involved. Check out the [contribution guidelines](contribute) to get started.

<h4 class="no-link">➵ Acknowledgements</h4>

Maybe you? 👀

*This project uses the <a target="_blank" href="https://gtfobins.github.io/">GTFOBins</a> website template as a base. Big thanks to its creators for the clean and effective design!*

{% include gadgets_table.html %}
