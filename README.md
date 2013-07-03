# [Grok Podcast Website](http://grokpodcast.com)

## Install:
Assuming you're running on, at least, Ruby 1.9.3, clone the repo, then:
```
bundle install
```

You can also use binstubs:
```
bundle install --path=_vendor --binstubs
```
Just remember to always call `bin/<comand>`, like `bin/jekyll`, `bin/rake` when using binstubs.

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

* Thanks to our faithful audience, valeu galera :)*
* Thanks to our [sponsors](http://grokpodcast.com/apoios), you make our life easier
* Design and implementation by [HE:Labs](http://helabs.com), thanks for the awesome design
* Developed with [Ruby](http://www.ruby-lang.org/en/) and Jekyll(http://jekyllrb.com/), thanks to our wonderful community
* Source code hosted on [GitHub](http://github.com/), thanks for this wonderful service
* S3 synchonization provided by the awesome [s3cmd](http://s3tools.org/s3cmd), thanks for making our life easier

## License

See [LICENSE](https://github.com/grokpodcast/site/blob/master/LICENSE.md)
