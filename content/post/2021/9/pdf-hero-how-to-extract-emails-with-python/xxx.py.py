import PyPDF2

def parse_pdf(path: Path) -> dict:
  LOGGER.info(f"Parsing {path.relative_to(ROOT_DIR)}")

  # prepare data to be returned
  data = {
      "person": path.parent.name,
      "category": str(path.relative_to(ROOT_DIR).parts[0]),
      "file": path.name,
      "path": str(path.relative_to(ROOT_DIR)),

  }

  # get email separately due to possible errors
  try:
      data["email"] = extract_email(path)
  except PyPDF2.utils.PdfReadError as e:
      # typically due to PDF being encrypted/locked
      logger.error(f"Failed to open {path.name}: {e}")
  except Exception as e:
      # don't want misc errors crashing the entire script
      # better to have a few blank emails
      logger.error(f"Failed to parse {path.name}: {e}")

  return data
