# Editing these notes in Obsidian

The site is built from `content/` by GitHub Actions on every push to `main`; nothing needs to
run on your machine.

## One-time setup (Windows)

1. Install [Git for Windows](https://git-scm.com/download/win) with the default options.
   (GitHub Desktop alone is not enough for the Obsidian Git plugin.)
2. Clone this repository, e.g. `git clone https://github.com/jabdinghoff/quartz-test.git`.
3. Run `setup.ps1` in the clone (right-click → *Run with PowerShell*). It copies the default
   Obsidian settings and plugins from `obsidian-defaults/` into `content/.obsidian/`.
4. In Obsidian, open the **`content`** folder as a vault (not the repository root) and choose
   *Trust author and enable plugins*.

The first push asks you to log in to GitHub once (Git Credential Manager).

## Your settings

`content/.obsidian/` is ignored by Git, so changing settings only affects you. `setup.ps1`
never overwrites existing files; re-running it only adds plugins that were added to the
defaults later. To change the defaults for everyone, edit `obsidian-defaults/` instead.

Defaults include the **Git** plugin (pull on startup and every 5 minutes, manual commits) and
**Dataview**. (Dataview's 0.5.70 release ships a `manifest.json` that says 0.5.68.)

## Publishing and review

- Notes marked `draft: true` are not published. `Dashboards/Needs review` is one of them: it
  lists every note with the `needs-review` property set. Use a *Checkbox* property for it.
- The *Review status* workflow flags notes that still have `needs-review: true`. It doesn't
  block publishing.
- Everything in this repository is public on GitHub, including drafts.
