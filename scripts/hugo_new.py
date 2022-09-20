import logging
import subprocess
from pathlib import Path
from string import ascii_lowercase, digits, whitespace

import fire
import nbformat as nbf


def sanitize_fname(s: str):
    valid = ascii_lowercase + digits + whitespace
    s = s.lower()
    s = filter(lambda x: x in valid, s)
    s = "".join(s)
    s = s.split()
    s = "-".join(s)
    return s


def get_title():
    title = input(">>> Note title: ")
    logging.info(f"Title: {title}")
    return title


def new(kind: str, notebook: bool = False):
    # get title
    title = get_title()
    title = sanitize_fname(title)

    # set path
    path = f"{kind}/{title}"

    # create
    cmd = ["hugo", "new", path]
    logging.info(f"Hugo command: {' '.join(cmd)}")
    subprocess.run(cmd)

    # create notebook if needed
    if notebook:
        path = "content" / Path(path) / "index.md"
        create_notebook(path=path)


def create_notebook(path: Path):
    # get metadata and text
    with open(path) as f:
        metadata = f.read()
    text = "\n"

    # write notebook content
    nb = nbf.v4.new_notebook()
    nb["cells"] = [nbf.v4.new_raw_cell(metadata), nbf.v4.new_markdown_cell(text)]
    path = path.with_suffix(".ipynb")
    logging.info(f"Writing notebook: {path}")
    nbf.write(nb, path)


if __name__ == "__main__":
    # set logging
    logging.basicConfig(level=logging.INFO)

    # run cli
    fire.Fire(new)
