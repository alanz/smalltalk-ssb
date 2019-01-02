"
I am BaselineOfSecureScuttlebutt, a Metacello baseline to load Secure-scuttlebutt.

"
Class {
	#name : #BaselineOfSecureScuttlebutt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSecureScuttlebutt
}


{ #category : #baselines }
BaselineOfSecurescuttlebutt >> baseline: spec [
	<baseline> 
	
	spec for: #common do: [
		spec package: 'SecureScuttlebutt' ]
]
