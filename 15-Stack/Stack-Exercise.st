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
	instanceVariableNames: 'rabbit winter wonder capitalWint stackWinter stackWinterWonder emptyStack emptyFinder finderWinter finderWinterWonder setWinter w setWinterWonder wint helloWorld emptyString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'NNH 10/6/2020 22:06:56'!
setUp
	
	rabbit := 'rabbit'.
	w := 'w'.
	wint := 'wint'.
	winter := 'winter'.
	wonder := 'wonder'.
	capitalWint := 'Wint'.
	helloWorld := 'Hello World'.
	emptyString := ''.
		
	emptyStack := OOStack new.
	stackWinter := OOStack new push: winter.
	stackWinterWonder := OOStack new push: winter; push: wonder.
	
	emptyFinder := SentenceFinderByPrefix with: emptyStack.
	finderWinter := SentenceFinderByPrefix with: stackWinter.
	finderWinterWonder := SentenceFinderByPrefix with: stackWinterWonder.
	
	setWinter := Set with: winter.
	setWinterWonder := Set with: winter with: wonder.
	
	

	
	! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:11:32'!
test01EmptyFinderShouldReturnEmptyCollection
	
	self assert: (emptyFinder find: winter) isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:47:10'!
test02OneStringFinderShouldReturnEmptyCollection
	
	self assert: (finderWinter find: wonder) isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:48:59'!
test03OneStringFinderShouldReturnOneElementCollection
	
	self assert: (finderWinter find: winter) = setWinter .
	self assert: (finderWinter find: wint) = setWinter.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:02:53'!
test04TwoStringFinderShouldReturnEmptyCollection
		
	self assert: (finderWinterWonder find: rabbit) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:50:15'!
test05TwoStringFinderShouldReturnOneElementCollection
	
	self assert: (finderWinterWonder find: winter) = setWinter .
	self assert: (finderWinterWonder find: wint) = setWinter.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:53:41'!
test06TwoStringFinderShouldReturnTwoElementCollection
	
	self assert: (finderWinterWonder find: w) = setWinterWonder.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:06:56'!
test07EmptyStringShouldRaiseError
	
	self should: [ emptyFinder find: emptyString]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorDescriptionPrefixIsEmptyString ].
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:06:56'!
test08StringWithWhitespacesShouldRaiseError

	self should: [emptyFinder find: helloWorld ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorDescriptionPrefixContainsWhiteSpaces ].
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:54:13'!
test09FinderIsCaseSensitive

	self assert: (finderWinterWonder find: capitalWint) isEmpty.
		! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:55:44'!
test10StackIsPreservedFindingOnEmptyFinder
	
	| emptySentenceFinder emptyStackToPreserve |
		
	emptyStackToPreserve := OOStack new.
	emptySentenceFinder := SentenceFinderByPrefix with: emptyStackToPreserve.
	emptySentenceFinder find: winter.
	
	self assert: emptyStackToPreserve isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:56:18'!
test11StackIsPreservedFindingOnOneStringFinder
	
	| oneSentenceFinder oneElementStackToPreserve |
		
	oneElementStackToPreserve := OOStack new push: winter.
	oneSentenceFinder := SentenceFinderByPrefix with: oneElementStackToPreserve.
	oneSentenceFinder find: wonder.
	
	self assert: oneElementStackToPreserve size = 1.
	self assert: oneElementStackToPreserve top = winter.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:57:09'!
test12StackIsPreservedFindingOnTwoStringFinder
	
	| twoSentenceFinder twoElementStackToPreserve |
	
	twoElementStackToPreserve := OOStack new push: winter; push: wonder.
	twoSentenceFinder := SentenceFinderByPrefix with: twoElementStackToPreserve.
	
	twoSentenceFinder find: wonder.
	
	self assert: twoElementStackToPreserve size = 2.
	self assert: twoElementStackToPreserve pop = wonder.
	self assert: twoElementStackToPreserve pop = winter.

	
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

!OONotValidStackElement methodsFor: 'accessing' stamp: 'AM 10/7/2020 10:33:26'!
next
	stack error: stack class stackEmptyErrorDescription.! !

!OONotValidStackElement methodsFor: 'accessing' stamp: 'AM 10/7/2020 10:33:33'!
value
	stack error: stack class stackEmptyErrorDescription.! !


!OONotValidStackElement methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:29:42'!
initializeBelongsTo: aStack
	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotValidStackElement class' category: 'Stack-Exercise'!
OONotValidStackElement class
	instanceVariableNames: ''!

!OONotValidStackElement class methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:24:26'!
belongsTo: aStack
	^ self new initializeBelongsTo: aStack! !


!classDefinition: #OOValidStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOValidStackElement
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOValidStackElement methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:26:14'!
initializeBelongsTo: aStack with: aValue next: nextElement
	stack := aStack.
	value := aValue.
	next := nextElement.! !


!OOValidStackElement methodsFor: 'accessing' stamp: 'NNH 10/2/2020 19:38:31'!
next
	^next.! !

!OOValidStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:47'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOValidStackElement class' category: 'Stack-Exercise'!
OOValidStackElement class
	instanceVariableNames: ''!

!OOValidStackElement class methodsFor: 'initializing' stamp: 'AM 10/5/2020 17:25:30'!
belongsTo: aStack with: aValue next: nextElement
	^self new initializeBelongsTo: aStack with: aValue next: nextElement.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/6/2020 20:48:20'!
isValidPrefix: aPrefix

	self prefixIsNotEmpty: aPrefix.
	self prefixDoesNotContainWhitespace: aPrefix.
! !

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/6/2020 20:45:37'!
prefixDoesNotContainWhitespace: aPrefix

	(aPrefix includesSubString: ' ') ifTrue: [self error: self class errorDescriptionPrefixContainsWhiteSpaces ]! !

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/6/2020 20:45:12'!
prefixIsNotEmpty: aPrefix

	aPrefix = '' ifTrue: [self error: self class errorDescriptionPrefixIsEmptyString].
! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'NNH 10/6/2020 20:47:34'!
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

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'NNH 10/6/2020 21:01:53'!
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
