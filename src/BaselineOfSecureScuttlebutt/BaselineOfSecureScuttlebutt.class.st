Class {
	#name : #BaselineOfSecureScuttlebutt,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #BaselineOfSecureScuttlebutt
}

{ #category : #'development support' }
BaselineOfSecureScuttlebutt class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
BaselineOfSecureScuttlebutt class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #private }
BaselineOfSecureScuttlebutt class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
BaselineOfSecureScuttlebutt class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
BaselineOfSecureScuttlebutt class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
BaselineOfSecureScuttlebutt class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
BaselineOfSecureScuttlebutt class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
BaselineOfSecureScuttlebutt class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
BaselineOfSecureScuttlebutt class >> project [

	^self new project
]

{ #category : #'development support' }
BaselineOfSecureScuttlebutt class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) inspect
]

{ #category : #baselines }
BaselineOfSecureScuttlebutt >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.squeaksource.com/ProfStef'.
		spec configuration: 'OSSubprocess' with: [
                                    spec
                                        versionString: #stable;
                                        repository: 'github://marianopeck/OSSubprocess:master/repository' ].
		spec package: 'SecureScuttlebutt' with: [
				spec requires: #('OSSubprocess' ). ].
		spec group: 'default' with: #('SecureScuttlebutt' ). ].

]

{ #category : #accessing }
BaselineOfSecureScuttlebutt >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #accessing }
BaselineOfSecureScuttlebutt >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #versions }
BaselineOfSecureScuttlebutt >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'initial version'.
		spec author: 'AlanZimmerman'.
		spec timestamp: '1/1/2019 18:42'.
		spec configuration: 'OSSubprocess' with: 'OSSubprocess'.
		spec package: 'SecureScuttlebutt' with: 'SecureScuttlebutt-AlanZimmerman.1'. ].

]
