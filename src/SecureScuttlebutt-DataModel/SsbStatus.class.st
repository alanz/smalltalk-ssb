"
I am a SsbStatus.

I am a container for the result of calling 'sbot status'.
"
Class {
	#name : #SsbStatus,
	#superclass : #Object,
	#instVars : [
		'progress',
		'sync',
		'gossip'
	],
	#category : #'SecureScuttlebutt-DataModel'
}

{ #category : #accessing }
SsbStatus class >> neoJsonMapping: mapper [
	"For inheritance mapping to work, the schema/classname must be self,
	but the instance variables have to be enumerated manually per class"

	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(progress sync gossip) ] 
]

{ #category : #comparing }
SsbStatus >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ gossip = anObject gossip
		and: [
			progress = anObject progress
				and: [
					sync = anObject sync]]

]

{ #category : #converting }
SsbStatus >> asDictionary [
	^ Dictionary new
		at: #gossip put: gossip;
		at: #progress put: progress;
		at: #ync put: sync;
		yourself

]

{ #category : #accessing }
SsbStatus >> gossip [
	^ gossip
]

{ #category : #accessing }
SsbStatus >> gossip: anObject [
	gossip := anObject
]

{ #category : #comparing }
SsbStatus >> hash [ 
  ^ gossip hash bitXor: (progress hash bitXor: (sync hash))
]

{ #category : #accessing }
SsbStatus >> progress [
  ^ progress
]

{ #category : #accessing }
SsbStatus >> progress: anObject [
  progress := anObject
]

{ #category : #accessing }
SsbStatus >> sync [
	^ sync
]

{ #category : #accessing }
SsbStatus >> sync: anObject [
	sync := anObject
]
