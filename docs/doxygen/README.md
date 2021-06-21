# Generating Doxygen

## Re-generating HTML

Navigate to the root of the project and execute the following commands:

```
rm -rf ./docs/doxygen/html
mkdir -p ./docs/doxygen/html
doxygen ./docs/doxygen/doxyfile_options
```

To see the output locally, open `./docs/index.html`, e.g.:

```
firefox ./docs/index.html
```

This file redirects to `./docs/doxygen/html/index.html`.

## Re-generating HTML and updating the documentation hosted online

The project's Doxygen documentation is available online via the [GitHub Pages].

To publish a new version of the Doxygen files, update the `./docs/doxygen/html` directory in the `docs-doxygen_html` remote branch.
You can do that following the step-by-step guide below:

1. Navigate to the root of the project and checkout the latest `main` branch. Note that _git_ will warn you that you are working on a _'detached HEAD'_ state. This is expected.

    ```
    git fetch origin
    git checkout origin/main
    ```

1. Remove all Doxygen artifacts and re-generate them.

    ```
    rm -rf ./docs/doxygen/html
    mkdir -p ./docs/doxygen/html
    doxygen ./docs/doxygen/doxyfile_options
    ```

1. Create a _git_ commit with updated artifacts. The commit message will reference the latest commit from [`origin/main`][GitHub repo main branch].

    ```
    git add ./docs/doxygen/html
    MAIN_SHA=$(git rev-parse --short HEAD)
    git commit -m "Doxy: Generate HTML @ $MAIN_SHA"
    ```

1. Before pushing changes upstream, copy the new artifacts to the `docs-doxygen_html` branch. The easiest method is to git cherry-pick the newly created commit.

    ```
    git checkout origin/docs-doxygen_html
    git cherry-pick --strategy=recursive --strategy-option=theirs HEAD@{1}
    ```

    An alternative to include the new artifacts to the `docs-doxygen_html` branch is to copy them to the branch and create a new commit. _Note that this is just an alternative to the git cherry-pick method mentioned above; if it worked fine, go to the next step._

    ```
    git checkout origin/docs-doxygen_html
    git rm -r ./docs/doxygen/html/
    git checkout HEAD@{1} ./docs/doxygen/html/
    git commit -m "Doxy: Generate HTML @ $MAIN_SHA"
    ```

1. Push the updated artifacts on the upstream server.

    ```
    git push origin HEAD:docs-doxygen_html
    ```

1. Open [GitHub Pages] and see the updated docs!

[GitHub Pages]: https://mcu-driver-hal.github.io/MCU-Driver-HAL/
[GitHub repo main branch]: https://github.com/mcu-driver-hal/MCU-Driver-HAL/tree/main/
