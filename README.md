# Nicholas' Personal Site

Personal website, portfolio, and blog built using the Jamstack.

Item | Badges
---|---
Social | ![Twitter Follow](https://img.shields.io/twitter/follow/engnadeau?style=social)
Build | [![Netlify Status](https://api.netlify.com/api/v1/badges/96cf62a7-5c7d-4610-b84f-de0afc34773c/deploy-status)](https://app.netlify.com/sites/competent-panini-00973b/deploys)
Activity | ![GitHub commit activity](https://img.shields.io/github/commit-activity/m/engnadeau/personal-site)
Deploy | ![Website](https://img.shields.io/website?url=https%3A%2F%2Fwww.nicholasnadeau.com%2F) ![Uptime Robot status](https://img.shields.io/uptimerobot/status/m787891867-18e3b35ff925f2041cbcdc24) ![Uptime Robot ratio (30 days)](https://img.shields.io/uptimerobot/ratio/m787891867-18e3b35ff925f2041cbcdc24) ![Security Headers](https://img.shields.io/security-headers?url=https%3A%2F%2Fnicholasnadeau.com)

## Development

### Hugo Installation

- [Install `Hugo`](https://gohugo.io/getting-started/installing/#binary-cross-platform)
  - Binary installation is easiest

```bash
# e.g., download binary from https://github.com/gohugoio/hugo/releases
dpkg -i hugo_extended_0.97.1_Linux-64bit.deb
```

### Creating Content

- See the [`Makefile`](./Makefile) for entrypoints, e.g.:

```bash
# add post
make post

# add publication
make publication

# format publications
make format-publications
```

### Updating Theme

- Use only [released versions](https://github.com/wowchemy/wowchemy-hugo-themes/releases)
- See the [Wowchemy docs](https://wowchemy.com/docs/hugo-tutorials/update/) for details
- TLDR, update the pinned versions in [go.mod](go.mod) with:

```go
module my-website

go 1.15

require (
  github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy-plugin-netlify main
  github.com/wowchemy/wowchemy-hugo-themes/modules/wowchemy/v5 main
)
```

- The build process will then change `main` to a specific pinned version (tag + hash)

### Tips

#### YouTube/Vimeo

```markdown
{{< youtube abcxyz >}}

{{< vimeo 123456 >}}
```

#### Twitter Tweet

```markdown
{{< tweet user="xxx" id="yyy" >}}
```

#### Limit Summary

```markdown
<!--more-->
```

#### Logos

Logos for experience widget are located in [`static/logos`](./static/logos)

#### Figures and Captions

- Figures can be created with captions for screen readers and accessibility

```markdown
![screen reader text](image.jpg "caption")
```

#### Custom Footer

Custom footer in site folder at layouts/partials/hooks/footer.html

#### CSV Table

[CSV Table shortcode](https://wowchemy.com/docs/content/writing-markdown-latex/#csv-table): `{{< table path="results.csv" header="true" caption="Table 1: My results" >}}`

#### Template Theme Documentation

- [Page features](https://wowchemy.com/docs/content/page-features/)
- [Page elements](https://wowchemy.com/docs/content/writing-markdown-latex/)

#### Linking Internal Pages

```markdown
{{< ref "publication/nadeau-2018-evolutionary" >}}
```

## Deployment

- The site is deployed using [Netlify](https://app.netlify.com/sites/competent-panini-00973b/overview)
