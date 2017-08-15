# Introduction
This script was inspired by the Stack Exchange question, [Is there someway to get a list of all missing photos from the photo library?](https://apple.stackexchange.com/questions/259534/is-there-someway-to-get-a-list-of-all-missing-photos-from-the-photo-library)

I had the same question, and it turns out that the photo library is backed by a SQLite database under the covers.  You can find it at `<photo library root>/database/photos.db`.  There's a table called `RKMaster`, with a row for every photo, and a column called `fileIsReference` that tells you whether the photo is "external" or not.  It's relatively straightforward to script a solution from there.

# Usage
The script does not require any parameters.  You can simply run:

```bash
./find-missing-photo-references
```

If it finds any broken links, then it will produce output like the following:

```
/Users/msolnit/Pictures/beach.jpg is missing.
/Users/msolnit/Pictures/cow.jpg is missing.
/Users/msolnit/Pictures/kitten.jpg is missing.
```

If there are no broken links, then the script is silent (does not produce any output).

# Warning
The `photos.db` schema is **not** part of any public Apple documentation, so **this script may break any at any time** due to minor (or major) software updates.  No guarantees are made about its safety, etc. etc.  But it works fine for me.
