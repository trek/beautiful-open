# [Beautiful Open](http://beautifulopen.com)

A list of handsome sites for open source software.

## Submissions
We don't accept all submissions.  All submissions must follow the instructions
on the *How to submit* section below. We reserve the right to reject any
submission. Submissions with inappropriate content will not be accepted.

### How to submit
To submit a site suggestions, [open an issue](https://github.com/trek/beautiful-open/issues/new)
or create a pull request. Pull requests will be given higher priority since they are easier to include.

Make sure the screenshot is **1000x800** and please double check that
everything looks good before submitting. It's also a good idea to run the
screenshot through an image optimizer like
[ImageOptim](https://imageoptim.com/) or [TinyPNG](https://tinypng.com/)
before including it. This will help keep the website fast and the repository
small as possible.

Please exclude the date from your submission. Name your markdown file
`xxxx-xx-xx-<somename>.md`, where `<somename>` is the name of the site, e.g.
`xxxx-xx-xx-emberjs.md`. I'll supply the date when accepting your pull request.

### Running the site locally
```
$ gem install jekyll
$ git clone https://github.com/trek/beautiful-open.git
$ cd beautiful-open
$ jekyll serve --watch
```

### Taking screenshots
```
npm install phantomjs async
phantomjs snap.js http://somesite.com aSiteName
```

The screenshot may not always look great, but it can work in a pinch!
