---
title: Needs review
draft: true
---

Notes with the `needs-review` property set. `draft: true` keeps this note off the website.

```dataview
TABLE WITHOUT ID file.link AS "Note", file.mtime AS "Last changed"
WHERE row["needs-review"] = true OR row["needs-review"] = "true"
SORT file.mtime DESC
```
