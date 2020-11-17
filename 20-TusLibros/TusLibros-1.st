!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 21:28:58'!
test01NewCartIsEmpty

	| anEmptyCart availableBooks |
	
	availableBooks := OrderedCollection new.
	
	anEmptyCart := Cart withCatalogue: availableBooks.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 21:29:04'!
test02ABookAddedToCartIsSuccessfullyAdded

	| aCart availableBooks |
	
	availableBooks := OrderedCollection with: 1.
	
	aCart := Cart withCatalogue: availableBooks.
	
	aCart addToCart: 1 withOcurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {1} )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 21:29:07'!
test03ManyBooksAddedOnceEachToCartAreSuccessfullyAdded

	| aCart availableBooks |
	
	availableBooks := OrderedCollection with: 1 with: 2 with: 3.
	
	aCart := Cart withCatalogue: availableBooks.
	
	aCart addToCart: 1 withOcurrences: 1. 
	aCart addToCart: 2 withOcurrences: 1.
	aCart addToCart: 3 withOcurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {1. 2. 3} )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 21:29:10'!
test04AddingABookThatIsNotForSaleShouldSignalError

	| aCart validBooks |
	
	validBooks := OrderedCollection with: 1.
	
	aCart := Cart withCatalogue: validBooks.
	
	self should: [ aCart addToCart: 2 withOcurrences: 1 ]
		raise: Error
		withMessageText: Cart bookIsNotForSaleErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AM 11/16/2020 19:06:33'!
listCart
	
	^ books! !



!Cart methodsFor: 'initialization' stamp: 'AM 11/16/2020 21:28:23'!
initializeWithCatalogue: aCatalogue
	
	catalogue := aCatalogue.
	books := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'AM 11/16/2020 19:06:48'!
isEmpty
	
	^ books isEmpty! !


!Cart methodsFor: 'book adding' stamp: 'AM 11/16/2020 21:28:10'!
addToCart: aBook withOcurrences: aNumberOfOccurences

	(catalogue includes: aBook) 
		ifFalse: [ ^ self error: self class bookIsNotForSaleErrorDescription ].
		
	books add: aBook withOccurrences: aNumberOfOccurences
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/16/2020 21:28:41'!
withCatalogue: aCatalogue

	^self new initializeWithCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/16/2020 19:17:14'!
bookIsNotForSaleErrorDescription
	
	^ 'Book is not for sale'.! !
