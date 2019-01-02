Class {
	#name : #BaselineOfSecureScuttlebutt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSecureScuttlebutt
}

{ #category : #baselines }
BaselineOfSecureScuttlebutt >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec
			package: 'SecureScuttlebutt' with: [
                        spec requires: 'NeoJSON';
                             requires: 'OSSubprocess' ];
			package: 'SecureScuttlebutt-DataModel';
			package: 'SecureScuttlebutt-Tests' with: [
				spec requires: 'SecureScuttlebutt' ] ].
]
