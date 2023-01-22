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


def new(kind: str, notebook: bool = False, branch: bool = False):
    # get title
    title = get_title()
    slug = sanitize_fname(title)

    # set path
    hugo_path = f"{kind}/{slug}"
    index_path = "content" / Path(hugo_path) / "index.md"

    # create md document
    cmd = ["hugo", "new", hugo_path]
    logging.info(f"Hugo command: {' '.join(cmd)}")
    subprocess.run(cmd)

    # create notebook if needed
    if notebook:
        create_notebook(path=index_path)

    # create branch if needed
    if branch:
        # checkout master
        cmd = ["git", "checkout", "master"]
        logging.info(f"Git command: {' '.join(cmd)}")
        subprocess.run(cmd)

        # create branch
        cmd = ["git", "checkout", "-b", slug]
        logging.info(f"Git command: {' '.join(cmd)}")
        subprocess.run(cmd)

        # push branch
        cmd = ["git", "push", "-u", "origin", slug]
        logging.info(f"Git command: {' '.join(cmd)}")
        subprocess.run(cmd)

        # commit document to branch
        cmd = ["git", "add", str(index_path)]
        logging.info(f"Git command: {' '.join(cmd)}")
        subprocess.run(cmd)

        cmd = ["git", "commit", "-m", f"feat: added {kind}"]
        logging.info(f"Git command: {' '.join(cmd)}")
        subprocess.run(cmd)

        # use gh cli to open pr with title and empty body
        cmd = ["gh", "pr", "create", "--title", f'"feat: {title}"', "--body", '""']
        logging.info(f"GitHub command: {' '.join(cmd)}")
        subprocess.run(cmd)

    # open document
    cmd = ["code", str(index_path)]
    logging.info(f"VSCode command: {' '.join(cmd)}")
    subprocess.run(cmd)


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
