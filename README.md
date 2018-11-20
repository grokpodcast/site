# [Grok Podcast Website](http://grokpodcast.com.br)

## Setup with Vagrant

Assuming you have [Vagrant](https://www.vagrantup.com/) installed on your machine:

```
git clone git@github.com:grokpodcast/site.git grok_site
cd grok_site
vagrant up
vagrant reload
vagrant ssh

git config user.name "<YOUR NAME>"
git config user.email "<YOUR E_MAIL ON GITHUB>"

gem install bundler

cd /vagrant
gem install --path=vendor --binstubs
```

## Generate the static site

```
bin/jekyll build
bin/jekyll serve
```

## Acknowledgments

* Thanks to our faithful audience, valeu galera :)*
* Thanks to our [sponsors](http://grokpodcast.com.br/apoios), you make our life easier
* Design and implementation by [HE:Labs](http://helabs.com), thanks for the awesome design
* Developed with [Ruby](http://www.ruby-lang.org/en/) and Jekyll(http://jekyllrb.com/), thanks to our wonderful community
* Source code hosted on [GitHub](http://github.com/), thanks for this wonderful service
* S3 synchonization provided by the awesome [s3cmd](http://s3tools.org/s3cmd), thanks for making our life easier

## License

See [LICENSE](https://github.com/grokpodcast/site/blob/master/LICENSE.md)
