Class {
	#name : #SecureScuttlebuttTests,
	#superclass : #TestCase,
	#category : #'SecureScuttlebutt-Tests'
}

{ #category : #'basic tests' }
SecureScuttlebuttTests >> testLatestParser [
  | json expected |
  json := 
'{
  "id": "@ZcjYF92reFjUtEYdoJ8ulOI6N6klwAAaIkghEEHdvSE=.ed25519",
  "sequence": 5365,
  "ts": 1546366223707
 }

{
  "id": "@/LNkIz1XWXCPS0o8Rlbmj1cjKA8N4bvBhVKnviWvG0I=.ed25519",
  "sequence": 1,
  "ts": 1527771208481
}'.
expected := [{'id'->'@ZcjYF92reFjUtEYdoJ8ulOI6N6klwAAaIkghEEHdvSE=.ed25519'. 'sequence'->5365. 'ts'->1546366223707}.
             {'id'->'@/LNkIz1XWXCPS0o8Rlbmj1cjKA8N4bvBhVKnviWvG0I=.ed25519'. 'sequence'->1.    'ts'->1527771208481}].
	self 
		assert: ((SecureScuttlebutt new latestParser) value: json)
		equals: expected
]
