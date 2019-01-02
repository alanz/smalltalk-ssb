Class {
	#name : #BaselineOfSecureScuttlebutt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSecureScuttlebutt
}

{ #category : #baselines }
BaselineOfSecureScuttlebutt >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec baseline: 'OSSubprocess' with: [ spec repository: 'github://marianopeck/OSSubprocess:master/repository' ].
			spec configuration: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
			spec package: #'SecureScuttlebutt' with: [ spec requires: #(#OSSubprocess #NeoJSON) ].
			spec package: #'SecureScuttlebutt-DataModel'.
			spec package: #'SecureScuttlebutt-Tests'
			 ]
]

{ #category : #baselines }
BaselineOfSecureScuttlebutt >> project [
	
	| aProject |
	
	aProject := super project.
	aProject loadType: #atomic.
	^ aProject.
]
