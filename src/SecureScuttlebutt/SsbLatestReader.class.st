"
I am a SsbLatestReader.
I am a specialised NeoJSONReader.

I can read a top level list of JSON forms separated by whitespace from a stream, and return them as an Array.
"
Class {
	#name : #SsbLatestReader,
	#superclass : #NeoJSONReader,
	#category : #SecureScuttlebutt
}

{ #category : #convenience }
SsbLatestReader class >> fromString: string [
	^ (self on: string readStream) nextTopList 
]

{ #category : #parsing }
SsbLatestReader >> nextTopList [
	"Initial interface to parse a list of  '{..}' JSON values.
	Return either primitives, a listClass or a mapClass instance.
	Based on NeoJSONReader>>next"
	
	^ self 
		consumeWhitespace; 
		parseListBare
]

{ #category : #parsing }
SsbLatestReader >> parseListBare [
	"parse a list of bare JSON '{..}', separated by whitespace only, into a list.
	Based on NeoJSONReader>>parseList"
	^ self listClass 
		streamContents: [ :stream |
			self parseListElementsBareDo: [ :each |
				stream nextPut: each ] ]


]

{ #category : #parsing }
SsbLatestReader >> parseListBareDo: block [
	"parse a list of bare JSON '{..}', separated by whitespace only, into a list.
	Based on NeoJSONReader>>parseListDo:
	"
	"self expectChar: $[."
	"(self matchChar: $]) 
		ifTrue: [ ^ self ]."
	[ readStream atEnd ] 
		whileFalse: [ block value. ].
   "For some reason, the required value is on the top of the stack (according to the debugger), but does not get returned."
	^ self
	
]

{ #category : #parsing }
SsbLatestReader >> parseListElementsBareDo: block [
  "based on NeoJSONReader>>parseListElementsDo"
	self parseListBareDo: [ 
		block value: self parseValue ]

]
