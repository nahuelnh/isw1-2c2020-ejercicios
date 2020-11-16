!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 19:20:32'!
test01NewCartIsEmpty

	| anEmptyCart availableBooks |
	
	availableBooks := OrderedCollection new.
	
	anEmptyCart := Cart withAvailableBooks: availableBooks.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 19:20:13'!
test02ABookAddedToCartIsSuccessfullyAdded

	| aCart availableBooks |
	
	availableBooks := OrderedCollection with: 1.
	
	aCart := Cart withAvailableBooks: availableBooks.
	
	aCart addToCart: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {1} )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 19:20:03'!
test03ManyBooksAddedToCartAreSuccessfullyAdded

	| aCart availableBooks |
	
	availableBooks := OrderedCollection with: 1 with: 2.
	
	aCart := Cart withAvailableBooks: availableBooks.
	
	aCart addToCart: 1.
	aCart addToCart: 2.
	aCart addToCart: 2.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {1. 2. 2} )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'AM 11/16/2020 19:21:19'!
test04AddingABookThatIsNotForSaleShouldSignalError

	| aCart validBooks |
	
	validBooks := OrderedCollection with: 1.
	
	aCart := Cart withAvailableBooks: validBooks.
	
	self should: [ aCart addToCart: 2 ]
		raise: Error
		withMessageText: Cart bookIsNotForSaleErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books collectionOfBooksForSale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AM 11/16/2020 19:06:33'!
listCart
	
	^ books! !


!Cart methodsFor: 'adding books' stamp: 'AM 11/16/2020 19:18:44'!
addToCart: aBook 

	(collectionOfBooksForSale includes: aBook) 
		ifFalse: [ ^ self error: self class bookIsNotForSaleErrorDescription ].
		
	books add: aBook! !


!Cart methodsFor: 'initialization' stamp: 'AM 11/16/2020 19:05:53'!
initialize

	books := OrderedCollection new! !

!Cart methodsFor: 'initialization' stamp: 'AM 11/16/2020 19:16:53'!
initializeWithAvailableBooks: aCollectionOfBooksForSale
	
	collectionOfBooksForSale := aCollectionOfBooksForSale.
	books := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'AM 11/16/2020 19:06:48'!
isEmpty
	
	^ books isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/16/2020 19:16:30'!
withAvailableBooks: aCollectionOfBooksForSale

	^self new initializeWithAvailableBooks: aCollectionOfBooksForSale ! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/16/2020 19:17:14'!
bookIsNotForSaleErrorDescription
	
	^ 'Book is not for sale'.! !
