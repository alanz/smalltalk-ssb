Class {
	#name : #BaselineOfSecureScuttlebutt,
	#superclass : #BaselineOf,
	#category : #BaselineOfSecureScuttlebutt
}

{ #category : #baselines }
BaselineOfSecureScuttlebutt >> baseline: spec [
	<baseline>

	| repository |
	
	repository := self packageRepositoryURL.
	
	spec for: #common do: [

		baseline: 'NeoJSON' with: [spec repository:  'http://mc.stfx.eu/Neo'];
		baseline: 'OSSsubprocess' with: [spec repository:  'github://marianopeck/OSSubprocess:master/repository'];
		spec
			package: 'SecureScuttlebutt' with: [
                        spec requires: 'NeoJSON';
                             requires: 'OSSubprocess' ];
			package: 'SecureScuttlebutt-DataModel';
			package: 'SecureScuttlebutt-Tests' with: [
				spec requires: 'SecureScuttlebutt' ] ].
]
