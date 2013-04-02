# [Grok Podcast Website](http://grokpodcast.com)

Right now we are using a forked version of Jekyll since the current published version (0.12.1) doesn't have a filter to generate RFC-822 compliant dates, which are used on RSS feeds. [I created a pull request to add the feature on the main branch](https://github.com/mojombo/jekyll/pull/892#issuecomment-15593610), but it looks like they are undergoing a major overhaul to release version 1.0, I don't have any idea of when and if they are going to merge it.

## Install:
Assuming you're running on, at least, Ruby 1.9.3, clone the repo, then:
```
bundle install
```

You can also use binstubs:
```
bundle install --binstubs
```
Just remember to always call `bin/<comand>`, like `bin/jekyll`, `bin/rake` when using binstubs.

Given the fact that we are using a forked version of Jekyll, I would recommend to use binstubs, or project specific gemsets if you're using RVM, .rvmrc is already on .gitignore.

## Generate the static site

```
rake site:generate
```

## Publish website to GitHub pages:

[The publishing mechanism was "inspired" by this post](http://ixti.net/software/2013/01/28/using-jekyll-plugins-on-github-pages.html). Just call:
```
rake site:publish
```
We are updating the publish method to use S3 instead of GH Pages

## Acknowledgments

* *Thanks to our faithful audience, valeu galera :)*
* Thanks to our [sponsors](http://grokpodcast.com/apoios), you make our life easier
* Design and implementation by [HE:Labs](http://helabs.com), thanks for the awesome design
* Developed with [Ruby](http://www.ruby-lang.org/en/) and Jekyll(http://jekyllrb.com/), thanks to our wonderful community
* Source code hosted on [GitHub](http://github.com/), thanks for this wonderful service
* S3 synchonization provided by the awesome [s3cmd](http://s3tools.org/s3cmd), thanks for making our life easier

## License

See LICENSE.md
