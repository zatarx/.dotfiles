import os
import shutil
import sys
import yaml


LINK_CONF_POSITION = 2


def copy_files_from_paths(yaml_file):
    if not os.path.isfile(yaml_file):
        print(f"File '{yaml_file}' does not exist.")
        sys.exit(1)

    with open(yaml_file, 'r') as file:
        try:
            data = yaml.safe_load(file)
        except yaml.YAMLError as exc:
            print(f"Error parsing YAML file: {exc}")
            sys.exit(1)
    try:
        links = data[LINK_CONF_POSITION]['link']
    except (IndexError, KeyError) as exc:
        print(f"Link entry not found: {exc}")
        sys.exit(1)

    # Get the current working directory
    cwd = os.getcwd()

    # Copy each path to the current working directory
    for path in links:
        path = os.path.expanduser(path)
        if os.path.exists(path):
            dest = os.path.join(cwd, os.path.basename(os.path.normpath(path)))
            if os.path.isdir(path):
                shutil.copytree(path, dest, dirs_exist_ok=True)
                print(f"Copied directory '{path}' to '{dest}'")
            else:
                shutil.copy2(path, dest)
                print(f"Copied file '{path}' to '{dest}'")
        else:
            print(f"Warning: '{path}' does not exist.")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python copy_links.py <path-to-yaml-file>")
        sys.exit(1)

    yaml_file = sys.argv[1]
    copy_files_from_paths(yaml_file)
