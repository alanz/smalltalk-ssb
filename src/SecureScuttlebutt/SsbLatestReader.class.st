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
	Return either primitives, a listClass or a mapClass instance."
	
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
SsbLatestReader >> parseListBare: block [
	"parse a list of bare JSON '{..}', separated by whitespace only, into a list.
	Based on NeoJSONReader>>parseListDo:
	"
	"self expectChar: $[."
	"(self matchChar: $]) 
		ifTrue: [ ^ self ]."
	[ readStream atEnd ] 
		whileFalse: [
			block value.
          ].
	^ self
	
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
		whileFalse: [
			block value.
          ].
	^ self
	
]

{ #category : #parsing }
SsbLatestReader >> parseListElementsBareDo: block [
  "based on NeoJSONReader>>parseListElementsDo"
	self parseListBare: [ 
		block value: self parseValue ]

]
