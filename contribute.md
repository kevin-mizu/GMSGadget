---
layout: page
title: Contribute
---

## Pull request process

We welcome all contributions to this project [on GitHub](https://github.com/kevin-mizu/GMSGadget)! You can open an issue to suggest improvements or submit a pull request if you're confident in your changes.

Here are a few guidelines for pull requests:

* Ensure the gadget works on the specified version of each supported browser.
* If possible, provide the root cause of the issue along with relevant links or references.
* Use proper markup syntax, especially when presenting tags (e.g., wrap them using backticks `).

## Structure

Each gadgets for a library is defined in a file in the [`_gadgets/`] folder named as `<library name>.md`, such file consists only of a [YAML] front matter which describes the all the related gadgets.

The full syntax is the following:

```
---
description: Library description
github: author/repo
gadgets:
  Latest:
    cve: CVE-XXXX-XXXXX
    authors:
      - twitter:author
      - github:author
      - email:author
      - author
    tags:
      - TAG
    pocs:
      - description: Optional description of the example
        code: Code of the example
        preview: false (default: true)
    more-info: Optional additional information
    links:
      - URL
      - URL
---
```

Where `TAG` is one of the values described in the [`_data/tags.yml`] file.

Feel free to use any file in the [`_gadgets/`] folder as an example.

[YAML]: https://yaml.org/
[`_gadgets/`]: https://github.com/kevin-mizu/GMSGadget/tree/master/_gadgets

## Building the website

The framework uses Jekyll to generate the website and the search index. Install the required dependencies and then start Jekyll's local server:

```sh
$ bundle install
$ bundle exec jekyll serve
```