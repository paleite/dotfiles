IMPORTFILE="import-vscode-extensions.sh"
touch "./${IMPORTFILE}"
chmod +x "./${IMPORTFILE}"

echo "#!/usr/bin/env bash" > "./${IMPORTFILE}"
echo "" >> "./${IMPORTFILE}"

echo "echo \"Importing VSCode extensions…\"" >> "./${IMPORTFILE}"
code --list-extensions | xargs -L 1 echo code --install-extension >> "./${IMPORTFILE}"
echo "echo \"Done.\"" >> "./${IMPORTFILE}"
