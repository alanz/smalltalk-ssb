Class {
	#name : #SecureScuttlebutt,
	#superclass : #Object,
	#category : #SecureScuttlebutt
}

{ #category : #printing }
SecureScuttlebutt >> printOn [
	^ 'SecureScuttlebutt'
]

{ #category : #running }
SecureScuttlebutt >> runSbot: aCommand [
	| process |
	process := OSSUnixSubprocess new
		command: 'sbot';
		arguments: #('whoami');
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
SecureScuttlebutt >> whoami [
	^ self runSbot: 'whoami'
]
