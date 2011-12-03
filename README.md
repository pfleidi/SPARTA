# SPARTA - System Performance Analysis Ready To Advance

Sparta is a load-testing tool running your favorite test-tools from the cloud.

* scriptable load-tests using a simple DSL
* fully automated setup of cloud instances at providers of your choice 
* easy integration of load-testing tools you already use
* graphical presentation of testing results

Install dependencies with [bundler](https://github.com/carlhuda/bundler/):
	bundle install


## Getting Started
To get started you will need an account at one of the supported cloud computing providers:

* AmazonEC2
* Rackspace
* tbd.

Adding the API credentials you received from the provider of your choice to the local configuration `config/credentials.yaml` or `~/.netrc` will make your scripts cleaner and more portable. Nevertheless, credentials can also be included in scripts where needed to override default credentials in both files above.

### Warriors
### Squads

## Contributors
In no specific order:

* Sven Pfleiderer ([pfleidi](https://github.com/pfleidi))
* Moritz Haarmann ([moritzh](https://github.com/moritzh))
* Dominik Huebner ([yeahiii](https://github.com/yeahiii))


We are building SPARTA using a fine selection of great ingredients:

* cucumber
* rcov
* test-unit
* mocha
* net-netrc
