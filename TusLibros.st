!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'harryPotter lordOfTheRings ageOfEmpires'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'AM 11/17/2020 22:26:59'!
setUp

	harryPotter := #HarryPotter.
	lordOfTheRings := #LordOfTheRings.
	ageOfEmpires := #AgeOfEmpires
	! !


!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:26'!
test01NewCartIsEmpty

	| anEmptyCart catalogue |
	
	catalogue := OrderedCollection new.
	
	anEmptyCart := Cart withCatalogue: catalogue.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:35'!
test02ABookAddedToCartIsSuccessfullyAdded

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:59:37'!
test03ManyBooksAddedToCartAreSuccessfullyAdded

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter 
									with: lordOfTheRings 
									with: ageOfEmpires .
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 1. 
	aCart addToCart: lordOfTheRings withOccurrences: 1.
	aCart addToCart: ageOfEmpires withOccurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter. lordOfTheRings. ageOfEmpires} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:48'!
test05ABookAddedMoreThanOnceIsSuccessfullyAddedMoreThanOnce

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 2. 
	
	self assert: ( aCart listCart hasEqualElements: {harryPotter. harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/18/2020 18:35:53'!
test08ExternallyAddingBookToCartListShouldNotModifyCart

	| anEmptyCart catalogue emptyCartList |
	
	catalogue := OrderedCollection with: harryPotter.
	
	anEmptyCart := Cart withCatalogue: catalogue.
	emptyCartList := anEmptyCart listCart.
	emptyCartList add: harryPotter.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !


!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/19/2020 19:32:35'!
test04ABookShouldNotBeAddedWhenNotForSale

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: lordOfTheRings withOccurrences: 1 ]
		raise: Error
		withMessageText: Cart bookIsNotForSaleErrorDescription.
		
	self assert: aCart isEmpty. ! !

!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/19/2020 19:32:50'!
test06ABookShouldNotBeAddedWithNonIntegerQuantity

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0.5 ]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.
		
	self assert: aCart isEmpty. ! !

!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/19/2020 19:32:57'!
test07ABookShouldNotBeAddedWithNonPositiveQuantity

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0 ]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.
		
	self assert: aCart isEmpty. ! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:40:43'!
test01CashierShouldNotDispatchEmptyCart
	
	| aCart aCashier aCreditCard aMerchantProcessorDouble |
	
	aMerchantProcessorDouble := MerchantProcessorDouble new.
	aCashier := Cashier with: aMerchantProcessorDouble.

	aCart := Cart withCatalogue: OrderedCollection new.	
	aCreditCard := CreditCard withNumber: 4444444444444444 expirationDate: January, 2021 owner: 'Hernán'.  
	
	self should: [ aCashier checkOut: aCart with: aCreditCard ]
	raise: Error
	withMessageText: Cashier canNotCheckOutAnEmptyCartErrorDescription .
	
	self deny: aMerchantProcessorDouble wasCalled.
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:41:24'!
test02CashierShouldNotDispatchExpiredCreditCard
	
	| aCart aCashier aCreditCard aMerchantProcessorDouble |
	
	aMerchantProcessorDouble := MerchantProcessorDouble new.
	aCashier := Cashier with: aMerchantProcessorDouble.
	aCart := Cart withCatalogue: OrderedCollection new.
	aCreditCard := CreditCard withNumber: 4444444444444444 expirationDate: October, 2020 owner: 'Hernán'.  
	
	self should: [ aCashier checkOut: aCart with: aCreditCard ]
	raise: Error
	withMessageText: Cashier declinedCreditCardErrorDescription.

	self deny: aMerchantProcessorDouble wasCalled.
! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:10:08'!
test01ValidCardPropertiesAreCorrect

	| aCardId aCreditCard aMonthInCalendar aPerson |
	
	aCardId := 4444444444444444.
	aMonthInCalendar := January, 2021.
	aPerson := 'Hernán'.
	
	aCreditCard := CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson.
	
	self assert: aCreditCard number equals: aCardId.
	self assert: aCreditCard expirationDate equals: aMonthInCalendar.
	self assert: aCreditCard owner equals: aPerson.

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:10:51'!
test02CardNumberShouldNotHaveLessThan16Digits

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 10 ^ 15 - 1.
	aMonthInCalendar := January, 2021.
	aPerson := 'Hernán'.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:11:30'!
test03CardExpirationDateShouldBeAMonthOfAnYear

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 4444444444444444.
	aMonthInCalendar := January/01/2021.
	aPerson := 'Hernán'.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidExpirationDateErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:11:50'!
test04CardNumberShouldBeAnInteger

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 0.5 .
	aMonthInCalendar := January, 2021.
	aPerson := 'Hernán'.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:12:10'!
test05CardNumberShouldNotHaveMoreThan16Digits

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 10 ^ 16.
	aMonthInCalendar := January, 2021.
	aPerson := 'Hernán'.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:18:12'!
test06OwnerNameShouldNotBeEmpty

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 4444444444444444.
	aMonthInCalendar := January, 2021.
	aPerson := ''.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:18:20'!
test07OwnerNameShouldNotBeBlank

	| aCardId aMonthInCalendar aPerson |
	
	aCardId := 4444444444444444.
	aMonthInCalendar := January, 2021.
	aPerson := '          '.
	
	self should: [ CreditCard withNumber: aCardId expirationDate: aMonthInCalendar owner: aPerson ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AM 11/18/2020 18:32:39'!
listCart
	
	^ books copy! !


!Cart methodsFor: 'adding books' stamp: 'AM 11/17/2020 22:54:35'!
addToCart: aBook withOccurrences: aNumberOfOccurences

	self assertThatCanBeAdded: aBook 
		withOccurences: aNumberOfOccurences.
		
	books add: aBook 
		withOccurrences: aNumberOfOccurences 
	
	! !


!Cart methodsFor: 'assertions' stamp: 'AM 11/17/2020 22:53:44'!
assertThatCanBeAdded: aBook withOccurences: aNumberOfOccurrences

	(catalogue includes: aBook ) 
		ifFalse: [ self signalBookIsNotForSale ].
		
	(aNumberOfOccurrences isInteger and: [ aNumberOfOccurrences > 0 ]) 
		ifFalse: [ self signalBookCanNotBeAddedANonNaturalNumberOfTimes ].! !


!Cart methodsFor: 'error signaling' stamp: 'AM 11/17/2020 22:52:59'!
signalBookCanNotBeAddedANonNaturalNumberOfTimes

	^ self error: self class bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription! !

!Cart methodsFor: 'error signaling' stamp: 'AM 11/17/2020 22:52:32'!
signalBookIsNotForSale

	^ self error: self class bookIsNotForSaleErrorDescription! !


!Cart methodsFor: 'initialization' stamp: 'AM 11/16/2020 21:28:23'!
initializeWithCatalogue: aCatalogue
	
	catalogue := aCatalogue.
	books := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'AM 11/16/2020 19:06:48'!
isEmpty
	
	^ books isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/16/2020 21:28:41'!
withCatalogue: aCatalogue

	^self new initializeWithCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/17/2020 22:41:12'!
bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription
	
	^ 'Books can not be added with a non natural number of occurrences'! !

!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/16/2020 19:17:14'!
bookIsNotForSaleErrorDescription
	
	^ 'Book is not for sale'.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 20:29:37'!
checkOut: aCart with: aCreditCard
	
	(aCreditCard expirationDate < FixedGregorianDate today) ifTrue: [ self error: self class declinedCreditCardErrorDescription ] .
	
	self error: self class canNotCheckOutAnEmptyCartErrorDescription .! !


!Cashier methodsFor: 'initialization' stamp: 'NNH 11/19/2020 21:31:49'!
initializeWith: aMerchantProcessor 
	
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:01:23'!
canNotCheckOutAnEmptyCartErrorDescription
	^ 'A cashier can not check out an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:55:22'!
declinedCreditCardErrorDescription
	
	^ 'Credit card is declined'! !


!Cashier class methodsFor: 'instance creation' stamp: 'NNH 11/19/2020 21:31:25'!
with: aMerchantProcessor 
	
	^ self new initializeWith: aMerchantProcessor! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'NNH 11/19/2020 19:34:56'!
initializeWithNumber: aNumber expirationDate: aMonthOfYear owner: aPerson 
	
	number := aNumber.
	expirationDate := aMonthOfYear.
	owner := aPerson.! !


!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:39'!
expirationDate

	^ expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:26'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:51'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'NNH 11/19/2020 21:21:38'!
withNumber: aNumber expirationDate: aMonthOfYear owner: aPerson 
	
	( aNumber isInteger and: [ aNumber between: 10 ^ 15 and: 10 ^ 16 - 1 ] ) ifFalse: [ self error: self invalidCardNumberErrorDescription ] .
	( aMonthOfYear isKindOf: GregorianMonthOfYear ) ifFalse: [ self error: self invalidExpirationDateErrorDescription ] .
	aPerson withoutTrailingBlanks isEmpty ifTrue: [ self error: self invalidOwnerNameErrorDescription ] .
	
	^ self new initializeWithNumber: aNumber expirationDate: aMonthOfYear owner: aPerson . ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:29:51'!
invalidCardNumberErrorDescription
	
	^ 'Credit card number must be a positive integer' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:37:40'!
invalidExpirationDateErrorDescription
	
	^ 'Expiration date must be a moth of year' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 21:14:32'!
invalidOwnerNameErrorDescription
	
	^ 'Credit card should not have an invalid owner name'! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'wasCalled'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'testing' stamp: 'NNH 11/19/2020 21:35:47'!
initialize
	
	wasCalled := false.! !

!MerchantProcessorDouble methodsFor: 'testing' stamp: 'NNH 11/19/2020 21:32:20'!
wasCalled

	^ wasCalled.! !


!MerchantProcessorDouble methodsFor: 'as yet unclassified' stamp: 'NNH 11/19/2020 21:35:38'!
doesNotUnderstand: aMessage
	
	wasCalled := true.! !
