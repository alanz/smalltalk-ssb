"
I am a SecureScuttlebutt

I interact with an operating system sbot, which is the secure scuttlebutt CLI

"
Class {
	#name : #SecureScuttlebutt,
	#superclass : #Object,
	#category : #SecureScuttlebutt
}

{ #category : #running }
SecureScuttlebutt >> feedStream [
	^ self
		 runSbot: #('createFeedStream' '--reverse' '--limit=5')
	 	"with: self latestParser"
]

{ #category : #running }
SecureScuttlebutt >> latest [
	^ self runSbot: 'latest' with: self latestParser

]

{ #category : #running }
SecureScuttlebutt >> latestParser [
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

{ #category : #running }
SecureScuttlebutt >> logStream [
	^ self
		 runSbot: #('createLogStream' '--reverse' '--limit=2')
	 	 with: self latestParser

]

{ #category : #printing }
SecureScuttlebutt >> printOn [
	^ 'SecureScuttlebutt'
]

{ #category : #running }
SecureScuttlebutt >> runSbot: aCommandAndArgs [
	| process |
	process := OSSUnixSubprocess new
		command: 'sbot';
		arguments: aCommandAndArgs ;
		redirectStdout;
		redirectStderr .
	process runAndWait  .
	process isSuccess 
		ifTrue: [ ^ NeoJSONReader fromString:  process stdoutStream upToEndOfFile ]
		ifFalse: [
			"OSSUnixProcessExitStatus has a nice #printOn: "
			"
			Transcript show: 'Command exit with error status: ', process exitStatusInterpreter printString; cr.
			Transcript show: 'Stderr contents: ', process stderrStream upToEndOfFile.
			"
			self error
		].

]

{ #category : #running }
SecureScuttlebutt >> runSbot: aCommandAndArgs with: aParser [
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

{ #category : #running }
SecureScuttlebutt >> whoami [
	^ self runSbot: #('whoami')
]
