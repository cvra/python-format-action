# Black format Github action

This project can be used to run [Black](https://github.com/psf/black) on every push using Github actions.

## Usage

For a more detailed installation guide look [there](https://github.com/MarvinJWendt/run-node-formatter/wiki)

Create a `formatter.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
on: push
name: Black Python Formatter
jobs:
  lint:
    name: Black Python Formatter
    runs-on: ubuntu-latest
    steps:
    - name: Black Python Formatter
      uses: antoinealb/black-formatter-action@clang9
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
