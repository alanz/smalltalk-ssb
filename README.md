## An Experimental Playground for Secure Scuttlbutt, in smalltalk.

### Requirements

- [Pharo 7.0](https://pharo.org)

### Installation

```
Metacello new
 	configuration: 'SecureScuttlebutt';
 	repository: 'github://alanz/smalltalk-ssb:master/repository';
	version: #stable;
	load.
