"
I am SsbUi.

I am responsible for presenting a user interface to the running sbot.
"
Class {
	#name : #SsbUi,
	#superclass : #ComposablePresenter,
	#instVars : [
		'menu',
		'text'
	],
	#category : #SecureScuttlebutt
}

{ #category : #specs }
SsbUi class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #menu height: self toolbarHeight;
				add: #text ];
		yourself
]

{ #category : #specs }
SsbUi class >> open [
	^ self new openWithSpec
	
]

{ #category : #initialization }
SsbUi >> addItemTo: aGroup [
	aGroup
		addItem: [ :item | 
			item
				name: 'Dynamic';
				icon: (self iconNamed: #delete);
				action: [ aGroup menuItems remove: item.
					self needRebuild: false.
					self buildWithSpec ] ].
	self needRebuild: false.
	self buildWithSpec

]

{ #category : #initialization }
SsbUi >> initializeWidgets [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Open file';
						icon: (self iconNamed: #openIcon);
						action: [ self inform: 'Open File' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save File';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self inform: 'Save File' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Print file';
						icon: (self iconNamed: #smallPrintIcon);
						action: [ self inform: 'Print file' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'sbot status';
						icon: (self iconNamed: #confirmIcon);

						action: [ self text text: Sbot new status asString ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Undo';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ self inform: 'Undo' ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Redo';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ self inform: 'Redo' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Add menu item';
						icon: (self iconNamed:  #add);
						action: [ self addItemTo: group ] ] ].
	menu applyTo: self.
	text := self newText.
	self focusOrder add: text
]

{ #category : #initialization }
SsbUi >> menu [
	^ menu
]

{ #category : #accessing }
SsbUi >> text [
	^ text
]

{ #category : #accessing }
SsbUi >> title [

	^ 'Secure Scuttlebutt'
]
