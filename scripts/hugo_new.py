import logging
import subprocess
from pathlib import Path
from string import ascii_lowercase, digits, whitespace

import fire


def sanitize_fname(s: str):
    # lowercase, remove invalid chars, remove whitespace,
    # replace whitespace with -
    valid_chars = ascii_lowercase + digits + whitespace
    s = s.lower()
    s = filter(lambda x: x in valid_chars, s)
    s = "".join(s)
    s = s.split()
    s = "-".join(s)
    return s


def new(kind: str, is_post_archetype: bool = False):
    # get title
    title = input(">>> Note title: ")
    logging.info(f"Title: {title}")
    slug = sanitize_fname(title)
    logging.info(f"Slug: {slug}")

    # set path
    hugo_path = f"{kind}/{slug}"
    index_path = "content" / Path(hugo_path) / "index.md"

    extra_args = []
    if is_post_archetype:
        logging.info("Using post archetype")
        extra_args.extend(["--kind", "post"])
    logging.info(f"Extra args: {extra_args}")

    # define commands
    commands = [
        # create md document
        ["hugo", "new", hugo_path] + extra_args,
        # checkout master
        ["git", "checkout", "master"],
        # create branch
        ["git", "checkout", "-b", slug],
        # push branch
        ["git", "push", "-u", "origin", slug],
        # commit document to branch
        ["git", "add", str(index_path)],
        ["git", "commit", "-m", f"feat: added {kind}"],
        # use gh cli to open pr with title and empty body
        ["gh", "pr", "create", "--title", f'"feat: {title}"', "--body", '""'],
        # open document
        ["code", str(index_path.parent)],
    ]

    for cmd in commands:
        logging.info(f"Running command: {' '.join(cmd)}")
        subprocess.run(cmd)


if __name__ == "__main__":
    # set logging
    logging.basicConfig(level=logging.INFO)

    # run cli
    fire.Fire(new)
