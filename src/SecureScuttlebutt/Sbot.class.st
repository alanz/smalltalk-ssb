"
I am a SecureScuttlebutt

I interact with an operating system sbot, which is the secure scuttlebutt CLI

"
Class {
	#name : #Sbot,
	#superclass : #Object,
	#category : #SecureScuttlebutt
}

{ #category : #api }
Sbot >> feedStream [
	^ self
		 runSbot: #('createFeedStream' '--reverse' '--limit=5')
	 	"with: self latestParser"
		
"
sbot createFeedStream --help
(feed) Fetch messages ordered by their claimed timestamps.

feed [--live] [--gt index] [--gte index] [--lt index] [--lte index] [--reverse]  [--keys] [--values] [--limit n]

Create a stream of the data in the database, ordered by the timestamp claimed by the author.

NOTE - the timestamp is not verified, and may be incorrect.
The range queries (gt, gte, lt, lte) filter against this claimed timestap.

-   `live` (boolean, default: `false`): Keep the stream open and emit new messages as they are received.

-   `gt` (greater than), `gte` (greater than or equal) define the lower bound of the range to be streamed.
     Only records where the key is greater than (or equal to) this option will be included in the range. When
    `reverse=true` the order will be reversed, but the records streamed will be the same.

-   `lt` (less than), `lte` (less than or equal) define the higher bound of the range to be streamed.
     Only key/value pairs where the key is less than (or equal to) this option will be included in the
     range. When `reverse=true` the order will be reversed, but the records streamed will be the same.

-   `reverse` (boolean, default: `false`): a boolean, set true and the stream output will be reversed.
    Beware that due to the way LevelDB works, a reverse seek will be slower than a forward seek.

-   `keys` (boolean, default: `true`): whether the `data` event should contain keys. If set to
    `true` and `values` set to `false` then `data` events will simply be keys, rather than objects
    with a `key` property.

-   `values` (boolean, default: `true`): whether the `data` event should contain values. If set to
    `true` and `keys` set to `false` then `data` events will  simply be values, rather than objects
    with a `value` property.

-   `limit` (number, default: `-1`): limit the number of results collected by this stream.
    This number represents a _maximum_ number of results and may not be reached if you get to the end
    of the data first. A value of `-1` means there is no limit. When `reverse=true` the highest keys
     will be returned instead of the lowest keys.

-   `fillCache` (boolean, default: `false`): wheather LevelDB's LRU-cache should be filled
     with data read.

-   `keyEncoding` / `valueEncoding` (string): the encoding applied to each read piece of data.

"
]

{ #category : #api }
Sbot >> friendsGet [
	^ self runSbot: #('friends.get')

"
$ sbot friends.get --help
Get the edge between two different feeds.

get --source {feedid} --dest {feedid} [--graph follow|flag]

-   `source` (FeedID): Edge source.
-   `dest` (FeedID): Edge destination.
-   `graph` (string, default: `follow`): Which graph to query. May be `follow` or `flag`.

"
]

{ #category : #api }
Sbot >> friendsGetForDest: anSsbId [
	^ self runSbot: {'friends.get'. '--dest'. anSsbId}

"
$ sbot friends.get --help
Get the edge between two different feeds.

get --source {feedid} --dest {feedid} [--graph follow|flag]

-   `source` (FeedID): Edge source.
-   `dest` (FeedID): Edge destination.
-   `graph` (string, default: `follow`): Which graph to query. May be `follow` or `flag`.

"
]

{ #category : #api }
Sbot >> friendsGetForSource: anSsbId [
	^ self runSbot: {'friends.get'. '--source'. anSsbId}

"
$ sbot friends.get --help
Get the edge between two different feeds.

get --source {feedid} --dest {feedid} [--graph follow|flag]

-   `source` (FeedID): Edge source.
-   `dest` (FeedID): Edge destination.
-   `graph` (string, default: `follow`): Which graph to query. May be `follow` or `flag`.

"
]

{ #category : #api }
Sbot >> latest [
   "Warning: this will probably run for a *very* long time.
   On my machine, it has to parse over 60 000 lines."
	^ self runSbot: 'latest' with: self latestParser

]

{ #category : #running }
Sbot >> latestParser [
   "Must be able to parse (malformed) JSON of the form
    {
      'id': '@ZcjYF92reFjUtEYdoJ8ulOI6N6klwAAaIkghEEHdvSE=.ed25519',
       'sequence': 5365,
       'ts': 1546366223707
    }

    {
      'id': '@/LNkIz1XWXCPS0o8Rlbmj1cjKA8N4bvBhVKnviWvG0I=.ed25519',
      'sequence': 1,
      'ts': 1527771208481
    }
   "
 	^[:str | SsbLatestReader fromString: str] 
]

{ #category : #api }
Sbot >> logStream [
	^ self
		 runSbot: #('createLogStream' '--reverse' '--limit=2')
	 	 with: self latestParser

"
$ sbot createLogStream --help
(log) Fetch messages ordered by the time received.

log [--live] [--gt index] [--gte index] [--lt index] [--lte index] [--reverse]  [--keys] [--values] [--limit n]

Creates a stream of the messages that have been written to this instance, in the order they arrived.
The objects in this stream will be of the form:

{ key: Hash, value: Message, timestamp: timestamp }

`timestamp` is the time which the message was received.
It is generated by [monotonic-timestamp](https://github.com/dominictarr/monotonic-timestamp).
The range queries (gt, gte, lt, lte) filter against this receive timestap.

-   `live` (boolean, default: `false`): Keep the stream open and emit new messages as they are
     received.

-   `gt` (greater than), `gte` (greater than or equal) define the lower bound of the range to
     be streamed. Only records where the key is greater than (or equal to) this option will be
     included in the range. When `reverse=true` the order will be reversed, but the records streamed
     will be the same.

-   `lt` (less than), `lte` (less than or equal) define the higher bound of the range to be streamed.
     Only key/value pairs where the key is less than (or equal to) this option will be included in
     the range. When `reverse=true` the order will be reversed, but the records streamed will be the same.

-   `reverse` (boolean, default: `false`): a boolean, set true and the stream output will be reversed.
     Beware that due to the way LevelDB works, a reverse seek will be slower than a forward seek.

-   `keys` (boolean, default: `true`): whether the `data` event should contain keys. If set to `true`
    and `values` set to `false` then `data` events will simply be keys, rather than objects with a
    `key` property.

-   `values` (boolean, default: `false`): whether the `data` event should contain values. If set to
    `true` and `keys` set to `false` then `data` events will simply be values, rather than objects
    with a `value` property.

-   `limit` (number, default: `-1`): limit the number of results collected by this stream. This
    number represents a _maximum_ number of results and may not be reached if you get to the end
    of the data first. A value of `-1` means there is no limit. When `reverse=true` the highest
    keys will be returned instead of the lowest keys.

-   `fillCache` (boolean, default: `false`): wheather LevelDB's LRU-cache should be filled with
    data read.

-   `keyEncoding` / `valueEncoding` (string): the encoding applied to each read piece of data.

"
]

{ #category : #running }
Sbot >> runSbot: aCommandAndArgs [
	^ self runSbot: aCommandAndArgs with: [ :str | NeoJSONReader fromString: str ]

]

{ #category : #running }
Sbot >> runSbot: aCommandAndArgs as: schema [
	^ self runSbot: aCommandAndArgs with: [ :str | NeoJSONReader fromString: str as: schema]

]

{ #category : #running }
Sbot >> runSbot: aCommandAndArgs with: aParser [
	| process |
	process := OSSUnixSubprocess new
		command: 'sbot';
		arguments: aCommandAndArgs;
		redirectStdout;
		redirectStderr .
	process runAndWait  .
	process isSuccess 
		ifTrue: [ ^ aParser value: process stdoutStream upToEndOfFile ]
		ifFalse: [
			"OSSUnixProcessExitStatus has a nice #printOn: "
			"
			Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
			Transcript show: 'Stderr contents: ', process stderrStream upToEndOfFile.
			"
			self error
		].

]

{ #category : #api }
Sbot >> status [
	"^ self runSbot: #('status')"
	^ self runSbot: #('status') as: SsbStatus 
]

{ #category : #api }
Sbot >> urlForBlob: aBlobId [

	"A blob starts with &"
	^ 'http://localhost:8989/blobs/get/' , aBlobId 
]

{ #category : #api }
Sbot >> whoami [
	^ self runSbot: #('whoami')
	"^ self runSbot: #('whoami') as: SsbStatus"
]
