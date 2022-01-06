# Jekyll configuration

whitelist:

- jekyll-redirect-from
- jekyll-github-metadata

plugins:

- jekyll-redirect-from
- jekyll-github-metadata

exclude:

- .babelrc
- .cache
- CNAME
- CONTRIBUTING.md
- cssnano.config.js
- docker_compose.yml
- Dockerfile
- Gemfile
- Gemfile.lock
- Makefile
- node_modules
- package.json
- package-lock.json
- postcss.config.js
- README.md
- vendor
- webpack.config.js
- yarn-error.log
- yarn.lock

# Markdown

highlighter: false
markdown: kramdown
kramdown:
input: GFM
hard_wrap: false
parse_block_html: true
syntax_highlighter_opts:
disable: true

# Defaults

defaults:

- scope:
  path: ""
  type: pages
  values:
  layout: "default"
  og_type: article
  type: article
  category: "Others"
  excerpt_separator: "<!--more-->"
  prism_languages: []

# Site info

url: https://devhints.io
title: Devhints.io cheatsheets

# GitHub metadata

# https://help.github.com/articles/repository-metadata-on-github-pages/

repository: rstacruz/cheatsheets
