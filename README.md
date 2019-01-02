## An Experimental Playground for Secure Scuttlbutt, in smalltalk.

### Requirements

- [Pharo 7.0](https://pharo.org)

### Installation

From Catalog, install `NeoJSONReader` stable. Ignore warning about
Pharo 7 not being supported.


Install `OSssubProcess`:

```
Metacello new
 	configuration: 'OSSubprocess';
 	repository: 'github://marianopeck/OSSubprocess:master/repository';
	version: #stable;
	load.
```

Use `Iceberg` to clone https://github.com/alanz/ssb-smalltalk.

Right-click on the repo in Iceberg, and select Packages. Install them
all, one by one.

[PRs gladly accepted on establishing a proper baseline for this]

You should now be able to print

```smalltalk
Sbot new whoami.
```
