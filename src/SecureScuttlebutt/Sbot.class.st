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

]

{ #category : #printing }
Sbot >> printOn [
	^ 'SecureScuttlebutt'
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
Sbot >> whoami [
	^ self runSbot: #('whoami')
	"^ self runSbot: #('whoami') as: SsbStatus"
]
