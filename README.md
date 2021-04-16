<br />
<p align="center">
<a href="https://github.com/nnadeau/nicholasnadeau-me">
<img src="https://raw.githubusercontent.com/nnadeau/nicholasnadeau-me/master/assets/images/logo.png" alt="Logo" width="80" height="80">
</a>

<h3 align="center">Nicholas Nadeau</h3>

<p align="center">
Personal website, portfolio, and blog built using the Jamstack
</p>
</p>


[![Netlify Status](https://api.netlify.com/api/v1/badges/96cf62a7-5c7d-4610-b84f-de0afc34773c/deploy-status)](https://app.netlify.com/sites/competent-panini-00973b/deploys)

[![Release](https://github.com/nnadeau/nicholasnadeau-me/workflows/Release/badge.svg)](https://github.com/nnadeau/nicholasnadeau-me/actions)

[![GitHub issues](https://img.shields.io/github/issues/nnadeau/nicholasnadeau-me)](https://github.com/nnadeau/nicholasnadeau-me/issues)
[![GitHub forks](https://img.shields.io/github/forks/nnadeau/nicholasnadeau-me)](https://github.com/nnadeau/nicholasnadeau-me/network)
[![GitHub stars](https://img.shields.io/github/stars/nnadeau/nicholasnadeau-me)](https://github.com/nnadeau/nicholasnadeau-me/stargazers)
[![GitHub license](https://img.shields.io/github/license/nnadeau/nicholasnadeau-me)](https://github.com/nnadeau/nicholasnadeau-me/blob/master/LICENSE)

[![Twitter](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Fnnadeau%2Fnicholasnadeau-me)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fnnadeau%2Fnicholasnadeau-me)

## Usage

### New Content

```bash
# new post
make post

# new project
make project

# new notebook
make notebook

# new talk
make talk

# auto-fetch unsplash photo for featured image
make featured-image
```

### Build and Serve Site

```bash
# build site
make build

# build, serve, and watch site with web server
make serve
```

### New Publication

- Add bib entry to [`publications.bib`](publications.bib)
- Run `make publications`

## Tips

- YouTube Hugo shortcode: `{{< youtube XXXXXXXXX >}}`
- Use `<!--more-->` in posts to limit summary
