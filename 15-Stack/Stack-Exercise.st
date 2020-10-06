!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/5/2020 21:51:07'!
test01EmptyFinderShouldReturnEmptyCollection
	
	| emptySentenceFinder wint |
	
	emptySentenceFinder := SentenceFinderByPrefix with: OOStack new.
	
	wint := 'wint'.
	
	self assert: (emptySentenceFinder find: wint) isEmpty.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/5/2020 21:53:47'!
test02OneStringFinderJustFindsPrefixesOfThatElement

	| oneSentenceFinder wa wi wint oneElementStack wintArray |
	
	wint := 'wint'.
	wi := 'wi'.
	wa := 'wa'.
	
	oneElementStack := OOStack new push: wint.
	oneSentenceFinder := SentenceFinderByPrefix with: oneElementStack.
	
	wintArray := Set with: wint.
	
	self assert: (oneSentenceFinder find: wi   ) = wintArray.
	self assert: (oneSentenceFinder find: wint) = wintArray.
	self assert: (oneSentenceFinder find: wa  ) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/5/2020 22:01:09'!
test03TwoStringElementSharingPrefixReturnBothOnCommonPrefix

	| twoElementStack twoSentenceFinder wi wine wineWintSet wint |
	
	wint := 'wint'.
	wine := 'wine'.
	wi := 'wi'.
	
	twoElementStack := OOStack new push: wint; push: wine.
	twoSentenceFinder := SentenceFinderByPrefix with: twoElementStack.
	
	wineWintSet := Set with: wint with: wine.
	
	self assert: (twoSentenceFinder find: wi) = wineWintSet.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/5/2020 22:11:49'!
test04EmptyStringShouldRaiseError

	| emptySentenceFinder emptyStack emptyString |
	
	emptyStack := OOStack new.
	emptySentenceFinder := SentenceFinderByPrefix with: emptyStack.
	emptyString := ''.
	
	self should: [ emptySentenceFinder find: emptyString]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorDescriptionPrefixIsEmptyString ].
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/5/2020 22:13:11'!
test05StringWithWhitespacesShouldRaiseError

	| emptySentenceFinder emptyStack holaMundo |
	
	emptyStack := OOStack new.
	emptySentenceFinder := SentenceFinderByPrefix with: emptyStack.
	holaMundo := 'hola mundo'.
	
	self should: [ emptySentenceFinder find: holaMundo]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorDescriptionPrefixContainsWhiteSpaces ].
		! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'NNH 10/2/2020 19:54:24'!
isEmpty
	^ 0 = size.! !


!OOStack methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:27:29'!
initialize 
	size := 0.
	top := OONotValidStackElement belongsTo: self.! !


!OOStack methodsFor: 'operations' stamp: 'NNH 10/2/2020 20:19:03'!
pop
	| oldTop |
		
	oldTop := self top.
	
	top := top next.
	size := size - 1.
	
	^ oldTop.! !

!OOStack methodsFor: 'operations' stamp: 'AM 10/5/2020 17:27:18'!
push: anElementToPush 

	top := OOValidStackElement belongsTo: self with: anElementToPush next: top.
	size := size + 1.! !


!OOStack methodsFor: 'accessing' stamp: 'NNH 10/2/2020 19:53:51'!
size
	^size .! !

!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:57'!
top
	^top value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 19:13:35'!
next
	self subclassResponsibility.! !

!OOStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 19:13:50'!
value
	self subclassResponsibility.! !


!classDefinition: #OONotValidStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #OONotValidStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotValidStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:30:42'!
next
	stack error: OOStack stackEmptyErrorDescription.! !

!OONotValidStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:28:44'!
value
	stack error: OOStack stackEmptyErrorDescription.! !


!OONotValidStackElement methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:29:42'!
initializeBelongsTo: aStack
	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotValidStackElement class' category: 'Stack-Exercise'!
OONotValidStackElement class
	instanceVariableNames: ''!

!OONotValidStackElement class methodsFor: 'as yet unclassified' stamp: 'AM 10/5/2020 17:24:26'!
belongsTo: aStack
	^ self new initializeBelongsTo: aStack! !


!classDefinition: #OOValidStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOValidStackElement
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOValidStackElement methodsFor: 'accessing' stamp: 'NNH 10/2/2020 19:38:31'!
next
	^next.! !

!OOValidStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:47'!
value
	^value.! !


!OOValidStackElement methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:26:14'!
initializeBelongsTo: aStack with: aValue next: nextElement
	stack := aStack.
	value := aValue.
	next := nextElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOValidStackElement class' category: 'Stack-Exercise'!
OOValidStackElement class
	instanceVariableNames: ''!

!OOValidStackElement class methodsFor: 'as yet unclassified' stamp: 'AM 10/5/2020 17:25:30'!
belongsTo: aStack with: aValue next: nextElement
	^self new initializeBelongsTo: aStack with: aValue next: nextElement.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'AM 10/5/2020 22:13:45'!
isValidPrefix: aPrefix

	aPrefix = '' ifTrue: [self error: self class errorDescriptionPrefixIsEmptyString].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class errorDescriptionPrefixContainsWhiteSpaces ]! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AM 10/5/2020 22:00:02'!
find: aPrefix 
	
	self isValidPrefix: aPrefix.		
	^self sentences select: [:aSentence | aSentence beginsWith: aPrefix].
! !


!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'AM 10/5/2020 21:50:08'!
destroyStackRetrievingItsElements
	
	| elements sizeOfStack |
	
	sizeOfStack := stack size.
	elements := OrderedCollection new.
	
	sizeOfStack timesRepeat: [ elements addFirst: stack pop].
	
	^elements.! !

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'AM 10/5/2020 21:33:38'!
restoreStackWith: elementsOfStackAsCollection

	elementsOfStackAsCollection do: [:anElement | stack push: anElement].! !

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'AM 10/5/2020 21:50:08'!
sentences
	
	| sentences |
	
	sentences := self destroyStackRetrievingItsElements.
	self restoreStackWith: sentences.
	
	^sentences asSet.! !


!SentenceFinderByPrefix methodsFor: 'initializing' stamp: 'AM 10/5/2020 18:00:41'!
initializeWith: aStack

	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'AM 10/5/2020 22:10:24'!
errorDescriptionPrefixContainsWhiteSpaces
	^'Prefix contains whitespaces'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'AM 10/5/2020 22:10:08'!
errorDescriptionPrefixIsEmptyString
	^'Prefix is empty string'! !


!SentenceFinderByPrefix class methodsFor: 'initializing' stamp: 'AM 10/5/2020 18:00:16'!
with: aStack
	^self new initializeWith: aStack.! !
