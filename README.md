## An Experimental Playground for Secure Scuttlbutt, in smalltalk.

### Requirements

- [Pharo 7.0](https://pharo.org)

### Installation

```smalltalk
Metacello new
  baseline: 'SecureScuttlebutt';
  repository: 'github://alanz/smalltalk-ssb:master';
  load.
```

You should now be able to print

```smalltalk
Sbot new whoami.
```

And at some point

```smalltalk
SbotUi open.
```

will do something useful.
