import logging
from pathlib import Path
import yaml

# Specify the root directory path
ROOT_PATH = Path(__file__).parent.parent

# Specify the ignore patterns
IGNORE_PATTERNS = ["authors", "post", "README.md"]

# Specify the output file path
OUTPUT_FNAME = "output.txt"

def drop_yaml_keys(content, keys):
    yaml_delimiter = b"---\n"  # Convert delimiter to bytes
    yaml_end = content.find(yaml_delimiter, 3)  # Find the end of YAML front matter
    if yaml_end != -1:
        yaml_data = content[:yaml_end].decode("utf-8")  # Extract YAML front matter
        try:
            yaml_dict = yaml.safe_load(yaml_data)  # Parse YAML front matter
            for key in keys:
                yaml_dict.pop(key, None)  # Remove specified keys from the dictionary
            yaml_data = yaml.dump(yaml_dict)  # Convert modified dictionary back to YAML
        except yaml.YAMLError as e:
            logging.error(f"Error parsing YAML in file {file_path}: {e}")
            return content  # Return original content if parsing fails
        content = yaml_data.encode("utf-8") + content[yaml_end:]  # Reconstruct the content
    return content


def dump_files(path, ignore_patterns, output_file):
    with open(output_file, "w") as f:
        for file_path in Path(path).rglob("*.md"):
            if (
                all(pattern not in str(file_path) for pattern in ignore_patterns)
                and "index" not in file_path.name
            ):
                logging.info(f"Processing file: {file_path}")
                with open(file_path, "rb") as file:
                    content = file.read()
                    modified_content = drop_yaml_keys(content, ["design"])
                    f.write(f"Path: {file_path}\n")
                    f.write(f"Content:\n{modified_content.decode('utf-8')}\n\n")



if __name__ == "__main__":
    # Configure logging
    logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

    # Call the function to dump the files
    dump_files(ROOT_PATH, IGNORE_PATTERNS, OUTPUT_FNAME)
