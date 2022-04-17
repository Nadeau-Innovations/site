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

## Development

- [Install `Hugo`](https://gohugo.io/getting-started/installing/#binary-cross-platform)
  - Binary installation is easiest

```bash
# e.g., download binary from https://github.com/gohugoio/hugo/releases
dpkg -i hugo_extended_0.97.1_Linux-64bit.deb
```

- See the [`Makefile`](./Makefile) for entrypoints

```bash
# add publication
make publication

# format publications
make format-publications
```

### Updating

- See the [Wowchemy docs](https://wowchemy.com/docs/hugo-tutorials/update/) for details

### Tips

- YouTube/Vimeo shortcode: `{{< youtube abcxyz >}}` / `{{< vimeo 123456 >}}`
- Twitter tweet shortcode: `{{< tweet user="xxx" id="yyy" >}}`
- Use `<!--more-->` in posts to limit summary
- Logos for experience widget are located in [`static/logos`](./static/logos)
- Figures can now be created by using the standard, portable Markdown syntax: ![screen reader text](image.jpg "caption") where the image is in the page folder, the media library, or is a remote URI.
- Custom footer in site folder at layouts/partials/hooks/footer.html
- [CSV Table shortcode](https://wowchemy.com/docs/content/writing-markdown-latex/#csv-table): `{{< table path="results.csv" header="true" caption="Table 1: My results" >}}`
- Template theme docs:
  - [Page features](https://wowchemy.com/docs/content/page-features/)
  - [Page elements](https://wowchemy.com/docs/content/writing-markdown-latex/)
