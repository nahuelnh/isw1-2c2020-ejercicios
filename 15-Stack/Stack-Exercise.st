!classDefinition: #OOStackTest category: #'Stack-Exercise'!
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


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'rabbit winter wonder capitalWint stackWinter stackWinterWonder emptyStack emptyFinder finderWinter finderWinterWonder collectionWinter w collectionWinterWonder wint helloWorld emptyString collectionRabbitRabbit stackRabbitRabbit finderRabbitRabbit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'NNH 10/7/2020 18:49:07'!
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
	stackRabbitRabbit := OOStack new push: rabbit; push: rabbit.
	
	emptyFinder := SentenceFinderByPrefix with: emptyStack.
	finderWinter := SentenceFinderByPrefix with: stackWinter.
	finderWinterWonder := SentenceFinderByPrefix with: stackWinterWonder.
	finderRabbitRabbit := SentenceFinderByPrefix with: stackRabbitRabbit.
	
	collectionWinter := OrderedCollection with: winter.
	collectionWinterWonder := OrderedCollection with: winter with: wonder.
	collectionRabbitRabbit := OrderedCollection with: rabbit with: rabbit.
	
	

	
	! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:11:32'!
test01EmptyFinderShouldReturnEmptyCollection
	
	self assert: (emptyFinder find: winter) isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 21:47:10'!
test02OneStringFinderShouldReturnEmptyCollection
	
	self assert: (finderWinter find: wonder) isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:43:42'!
test03OneStringFinderShouldReturnOneElementCollection
	
	self assert: (finderWinter find: winter) = collectionWinter .
	self assert: (finderWinter find: wint) = collectionWinter.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/6/2020 22:02:53'!
test04TwoStringFinderShouldReturnEmptyCollection
		
	self assert: (finderWinterWonder find: rabbit) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:43:42'!
test05TwoStringFinderShouldReturnOneElementCollection
	
	self assert: (finderWinterWonder find: winter) = collectionWinter .
	self assert: (finderWinterWonder find: wint) = collectionWinter.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:44:00'!
test06TwoStringFinderShouldReturnTwoElementCollection
	
	self assert: (finderWinterWonder find: w) = collectionWinterWonder.! !

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

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:50:02'!
test10FinderShouldReturnTwiceASentenceIfBelongsTwiceToStack
	
	self assert: (finderRabbitRabbit find: rabbit) = collectionRabbitRabbit .


	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:53:08'!
test11StackIsPreservedFindingOnEmptyFinder
	
	| emptySentenceFinder emptyStackToPreserve |
		
	emptyStackToPreserve := OOStack new.
	emptySentenceFinder := SentenceFinderByPrefix with: emptyStackToPreserve.
	emptySentenceFinder find: winter.
	
	self assert: emptyStackToPreserve isEmpty.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:53:24'!
test12StackIsPreservedFindingOnOneStringFinder
	
	| oneSentenceFinder oneElementStackToPreserve |
		
	oneElementStackToPreserve := OOStack new push: winter.
	oneSentenceFinder := SentenceFinderByPrefix with: oneElementStackToPreserve.
	oneSentenceFinder find: wonder.
	
	self assert: oneElementStackToPreserve size = 1.
	self assert: oneElementStackToPreserve top = winter.

	
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'NNH 10/7/2020 18:53:34'!
test13StackIsPreservedFindingOnTwoStringFinder
	
	| twoSentenceFinder twoElementStackToPreserve |
	
	twoElementStackToPreserve := OOStack new push: winter; push: wonder.
	twoSentenceFinder := SentenceFinderByPrefix with: twoElementStackToPreserve.
	
	twoSentenceFinder find: wonder.
	
	self assert: twoElementStackToPreserve size = 2.
	self assert: twoElementStackToPreserve pop = wonder.
	self assert: twoElementStackToPreserve pop = winter.

	
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'NNH 10/2/2020 19:54:24'!
isEmpty
	^ 0 = size.! !


!OOStack methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:10:49'!
initialize 
	size := 0.
	top := OONotValidStackElement in: self.! !


!OOStack methodsFor: 'operations' stamp: 'NNH 10/2/2020 20:19:03'!
pop
	| oldTop |
		
	oldTop := self top.
	
	top := top next.
	size := size - 1.
	
	^ oldTop.! !

!OOStack methodsFor: 'operations' stamp: 'NNH 10/7/2020 19:13:14'!
push: anElementToPush 

	top := self newStackElement: anElementToPush.
	size := size + 1.! !


!OOStack methodsFor: 'accessing' stamp: 'NNH 10/2/2020 19:53:51'!
size
	^size .! !

!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:57'!
top
	^top value.! !


!OOStack methodsFor: 'operations - private' stamp: 'NNH 10/7/2020 19:13:14'!
newStackElement: anElement

	^ OOValidStackElement with: anElement in: self next: top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
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


!classDefinition: #OONotValidStackElement category: #'Stack-Exercise'!
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


!OONotValidStackElement methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:09:36'!
initializeIn: aStackContainingElement
	stack := aStackContainingElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotValidStackElement class' category: #'Stack-Exercise'!
OONotValidStackElement class
	instanceVariableNames: ''!

!OONotValidStackElement class methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:10:01'!
in: aStackContainingElement
	^ self new initializeIn: aStackContainingElement! !


!classDefinition: #OOValidStackElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOValidStackElement
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOValidStackElement methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:06:48'!
initializeWith: anElementValue in: aStackContainingElement next: nextElementInStack
	
	value := anElementValue.
	stack := aStackContainingElement.
	next := nextElementInStack.! !


!OOValidStackElement methodsFor: 'accessing' stamp: 'NNH 10/2/2020 19:38:31'!
next
	^next.! !

!OOValidStackElement methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:47'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOValidStackElement class' category: #'Stack-Exercise'!
OOValidStackElement class
	instanceVariableNames: ''!

!OOValidStackElement class methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:08:59'!
with: anElementValue in: aStackContainingElement next: nextElementInStack
	^self new initializeWith: anElementValue in: aStackContainingElement next: nextElementInStack.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/7/2020 19:17:07'!
isValidPrefix: aPrefix

	self prefixShouldNotBeEmpty: aPrefix.
	self prefixShouldNotContainWhitespace: aPrefix.
! !

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/7/2020 19:17:07'!
prefixShouldNotBeEmpty: aPrefixToValidate

	aPrefixToValidate = '' ifTrue: [self error: self class errorDescriptionPrefixIsEmptyString].
! !

!SentenceFinderByPrefix methodsFor: 'testing - private' stamp: 'NNH 10/7/2020 19:16:34'!
prefixShouldNotContainWhitespace: aPrefixToValidate

	(aPrefixToValidate includesSubString: ' ') ifTrue: [self error: self class errorDescriptionPrefixContainsWhiteSpaces ]! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'NNH 10/7/2020 19:19:07'!
find: aPrefixToFind
	
	self isValidPrefix: aPrefixToFind.
	^self sentencesInStack select: [:aSentence | aSentence beginsWith: aPrefixToFind].
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

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'NNH 10/7/2020 19:19:07'!
sentencesInStack
	
	| sentences |
	
	sentences := self destroyStackRetrievingItsElements.
	self restoreStackWith: sentences.
	
	^sentences.! !


!SentenceFinderByPrefix methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:19:35'!
initializeWith: aStackOfSentences

	stack := aStackOfSentences.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'AM 10/5/2020 22:10:24'!
errorDescriptionPrefixContainsWhiteSpaces
	^'Prefix contains whitespaces'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'AM 10/5/2020 22:10:08'!
errorDescriptionPrefixIsEmptyString
	^'Prefix is empty string'! !


!SentenceFinderByPrefix class methodsFor: 'initializing' stamp: 'NNH 10/7/2020 19:15:13'!
with: aStackOfSentences
	^self new initializeWith: aStackOfSentences.! !
