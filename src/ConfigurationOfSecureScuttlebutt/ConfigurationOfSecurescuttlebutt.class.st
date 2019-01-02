"
I am ConfigurationOfSecureScuttlebutt, a Metacello configuration to load Securescuttlebutt.

"
Class {
	#name : #ConfigurationOfSecurescuttlebutt,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfSecurescuttlebutt'
}

{ #category : #'development support' }
ConfigurationOfSecurescuttlebutt class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfSecurescuttlebutt class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfSecurescuttlebutt class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ 'Started January 2019'
]

{ #category : #catalog }
ConfigurationOfSecurescuttlebutt class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'Written and maintained by Alan Zimmerman.'
]

{ #category : #catalog }
ConfigurationOfSecurescuttlebutt class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'The Securescuttlebutt project ...'
]

{ #category : #catalog }
ConfigurationOfSecurescuttlebutt class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ 'The core classes are ...'
]

{ #category : #catalog }
ConfigurationOfSecurescuttlebutt class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(ssb scuttlebutt ui)
]

{ #category : #private }
ConfigurationOfSecurescuttlebutt class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfSecurescuttlebutt class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader |
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfSecurescuttlebutt class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfSecurescuttlebutt class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfSecurescuttlebutt class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfSecurescuttlebutt class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfSecurescuttlebutt class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfSecurescuttlebutt class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfSecurescuttlebutt >> baseline1: spec [
	<version: '1-baseline'>
	spec
		for: #common
		do: [ spec
				blessing: #baseline;
				"package: 'SecureScuttlebutt' with: [ spec requires: 'NeoJSON' ];"
				"package: 'SecureScuttlebutt' with: [ spec requires: 'OSSubprocess' ];"
				group: 'default' with: #('SecureScuttlebutt' 'SecureScuttlebutt-DataModel') ]
]

{ #category : #'symbolic versions' }
ConfigurationOfSecurescuttlebutt >> bleedingEdge: spec [
	<symbolicVersion: #'bleedingEdge'>
	

]

{ #category : #'symbolic versions' }
ConfigurationOfSecurescuttlebutt >> development: spec [
	<symbolicVersion: #'development'>
	

]

{ #category : #accessing }
ConfigurationOfSecurescuttlebutt >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfSecurescuttlebutt >> stable: spec [
	<symbolicVersion: #'stable'>
	
	spec for: #common version: '10'.
]

{ #category : #versions }
ConfigurationOfSecurescuttlebutt >> version10: spec [
	<version: '10' imports: #('1-baseline')>
	spec for: #common do: [ spec blessing: #release
		 ]
]
