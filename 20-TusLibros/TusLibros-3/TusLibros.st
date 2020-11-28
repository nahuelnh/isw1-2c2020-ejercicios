!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:53'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:59'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:04:03'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 20:23:39'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new .! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:24'!
test01UnknownUserShouldNotCreateCart
	
	| credentials interface |
	
	credentials := Dictionary new.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory .
	
	self should: [ interface createCartForUser: 'Maradona' password: 'contraseña' ]
	raise: Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface invalidUserErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:34'!
test02WrongPasswordShouldNotCreateCart
	
	| credentials interface |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	self should: [ interface createCartForUser: 'Maradona' password: 'SegurolaYNuevaYork' ]
	raise: Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface invalidPasswordErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:38'!
test03NewCartShouldBeEmpty
	
	| credentials interface aCartId |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana' .

	self assert: ( interface listCart: aCartId ) isEmpty .
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:41'!
test04
	
	| credentials interface aCartId |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana' .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore withOcurrences: 2.


	self assert: ( ( interface listCart: aCartId ) hasEqualElements: { testObjectsFactory itemSellByTheStore. 
													 testObjectsFactory itemSellByTheStore. 
													 testObjectsFactory itemSellByTheStore}).
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:44'!
test05
	
	| credentials interface fortCartId maradonaCartId |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	credentials add: 'RickyFort' -> 'Maiameee'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	maradonaCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana' .
	fortCartId := interface createCartForUser: 'RickyFort' password: 'Maiameee' .
	interface addToCart: maradonaCartId product: testObjectsFactory itemSellByTheStore .

	self deny: ( ( interface listCart: maradonaCartId ) isEmpty ).
	self assert: ( ( interface listCart: fortCartId ) isEmpty ).

	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:49'!
test06
	
	| credentials interface |
	
	credentials := Dictionary new.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	self should: [ interface listCart: 0 ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription .

	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:53'!
test07
	
	| credentials interface |
	
	credentials := Dictionary new.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	self should: [ interface addToCart: 0 product: testObjectsFactory itemSellByTheStore ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription .

	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:38:57'!
test08
	
	| credentials interface aCartId total |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	total := interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self assert: total equals: testObjectsFactory itemSellByTheStorePrice .
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:50:48'!
test09
	
	| credentials interface aCartId |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self should: [ interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today ]
	raise: Error
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription . 
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:25:38'!
test10
	
	| credentials interface aCartId total aMerchantProcessor |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	aMerchantProcessor := MerchantProcessorSimulator new.
	aMerchantProcessor debitBehavior: [:anAmount :aCreditCard | self error: 'Unhandled Exception' ].

	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: aMerchantProcessor.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.

	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	
	[ interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today. ] on: Error do: [:anError | ].

	aMerchantProcessor debitBehavior: [:anAmount :aCreditCard | ].

	total := interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self assert: total equals: testObjectsFactory itemSellByTheStorePrice .
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:38:06'!
test11
	
	| credentials interface aCartId purchases |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	purchases := interface listPurchasesOf: 'Maradona' password: 'SegurolaYHabana'.
	
	self assert: purchases total equals: 0.
	self assert: purchases products isEmpty.
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:52:20'!
test12
	
	| credentials interface aCartId purchases |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	purchases := interface listPurchasesOf: 'Maradona' password: 'SegurolaYHabana'.
	
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice .
	"self assert: ( purchases products hasEqualElements: {testObjectsFactory itemSellByTheStore } ) ."
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:57:08'!
test13
	
	| credentials interface aCartId purchases |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	2 timesRepeat: [ aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today ].
	
	purchases := interface listPurchasesOf: 'Maradona' password: 'SegurolaYHabana'.
	
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: purchases total.
	"self assert: ( purchases products hasEqualElements: {testObjectsFactory itemSellByTheStore } ) ."
	
	! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/28/2020 00:00:36'!
test14
	
	| credentials interface aCartId purchases |
	
	credentials := Dictionary new.
	credentials add: 'Maradona' -> 'SegurolaYHabana'.
	credentials add: 'RickyFort' -> 'Maiameee'.
	
	interface := TusLibrosInterface withCredentials: credentials catalog: testObjectsFactory defaultCatalog through: testObjectsFactory.
	
	aCartId := interface createCartForUser: 'Maradona' password: 'SegurolaYHabana'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	aCartId := interface createCartForUser: 'RickyFort' password: 'Maiameee'.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	purchases := interface listPurchasesOf: 'Maradona' password: 'SegurolaYHabana'.
	
	self assert: testObjectsFactory itemSellByTheStorePrice equals: purchases total.
	"self assert: ( purchases products hasEqualElements: {testObjectsFactory itemSellByTheStore } ) ."
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:35'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:40'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'NNH 11/26/2020 21:19:32'!
listCart
	
	^items copy ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:02:56'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:03:06'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'NNH 11/28/2020 00:18:32'!
createSale

	^ Sale of: total products: OrderedCollection new ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:21:06'!
debit: anAmount from: aCreditCard
	
	debitBehavior value: anAmount value: aCreditCard .! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:22:48'!
debitBehavior: aDebitBehaviorBlock
	
	debitBehavior := aDebitBehaviorBlock! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 23:21:51'!
initialize
	
	debitBehavior := [:anAmount :aCreditCard | ]! !


!classDefinition: #Purchase category: 'TusLibros'!
Object subclass: #Purchase
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'accessing' stamp: 'NNH 11/27/2020 23:55:02'!
initialize
	
	total := 0.! !

!Purchase methodsFor: 'accessing' stamp: 'NNH 11/27/2020 23:41:12'!
products

	^ OrderedCollection new.! !

!Purchase methodsFor: 'accessing' stamp: 'NNH 11/27/2020 23:54:47'!
total
	
	^ total! !


!Purchase methodsFor: 'sadsdasdasd' stamp: 'NNH 11/27/2020 23:54:30'!
addSale: aSale 
	
	total := aSale total + total.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'NNH 11/28/2020 00:18:11'!
initializeTotal: aTotal products: aCollectionOfProducts   

	total := aTotal ! !


!Sale methodsFor: 'accessing' stamp: 'NNH 11/28/2020 00:04:18'!
clientId
	
	^ clientId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'NNH 11/28/2020 00:18:32'!
of: aTotal products: aCollectionOfProducts   

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal products: aCollectionOfProducts ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'NNH 11/27/2020 22:36:33'!
debit: anAmount from: aCreditCard
! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'credentials catalog carts nextCartId merchantProcessor salesBookByClient clientByCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'initialization' stamp: 'NNH 11/28/2020 00:21:37'!
initializeWithCredentials: aCollectionOfCredentials catalog: aCatalog through: aMerchantProcessor 

	credentials := aCollectionOfCredentials .
	catalog := aCatalog .
	carts := Dictionary new.
	nextCartId := 0.
	merchantProcessor := aMerchantProcessor .
	salesBookByClient := Dictionary new.
	clientByCart := Dictionary new.
! !


!TusLibrosInterface methodsFor: 'falopa' stamp: 'NNH 11/28/2020 00:28:31'!
createCartForUser: anUser password: aPassword 
	
	| newCartId |
	
	( credentials includesKey: anUser ) ifFalse: [ self error: self class invalidUserErrorDescription ] .
	
	(credentials at: anUser) = aPassword ifFalse: [ self error: self class invalidPasswordErrorDescription ] .
	
	newCartId := self newCartId.
	
	carts add: newCartId -> ( Cart acceptingItemsOf: catalog ) .
	clientByCart add: newCartId -> anUser .
	salesBookByClient at: anUser ifAbsentPut: OrderedCollection new.
	
	^ newCartId. ! !

!TusLibrosInterface methodsFor: 'falopa' stamp: 'NNH 11/27/2020 20:43:56'!
newCartId
	
	nextCartId := nextCartId + 1.
	^ nextCartId.! !


!TusLibrosInterface methodsFor: 'accessing' stamp: 'NNH 11/27/2020 20:56:17'!
listCart: aCartId 
			
	^ ( self cartAt: aCartId ) listCart.! !


!TusLibrosInterface methodsFor: 'fsdssasd' stamp: 'NNH 11/27/2020 21:09:57'!
addToCart: aCartId product: aProduct 
	
	( self cartAt: aCartId ) add: aProduct! !

!TusLibrosInterface methodsFor: 'fsdssasd' stamp: 'NNH 11/27/2020 20:55:35'!
cartAt: aCartId

	^ carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorDescription ]! !


!TusLibrosInterface methodsFor: 'morphic' stamp: 'NNH 11/28/2020 00:24:09'!
addToCart: aCartId product: aProduct withOcurrences: aNumberOfOccurrences 
	
	( self cartAt: aCartId ) add: aNumberOfOccurrences of: aProduct! !


!TusLibrosInterface methodsFor: 'sdfsdf' stamp: 'NNH 11/28/2020 00:32:05'!
checkOut: aCartId with: aCreditCard on: aDate 
	
	| cashier total |
	
	cashier := Cashier toCheckout: (self cartAt: aCartId) 
		charging: aCreditCard 
		throught: merchantProcessor 
		on: aDate 
		registeringOn: ( salesBookByClient at: ( self clientUsingCart: aCartId ) ).
		
	total := cashier checkOut.	
	
	carts removeKey: aCartId .
	clientByCart removeKey: aCartId .
	
	^ total.
! !

!TusLibrosInterface methodsFor: 'sdfsdf' stamp: 'NNH 11/28/2020 00:21:16'!
clientUsingCart: aCartId

	^ clientByCart at: aCartId! !


!TusLibrosInterface methodsFor: 'sdasdasd' stamp: 'NNH 11/28/2020 00:33:48'!
listPurchasesOf: aClientId password: aPassword 
	 
	| purchase |
	
	purchase := Purchase new.
	
	( salesBookByClient at: aClientId ifAbsent: [ ^ purchase ] ) do: [ :aSale | purchase addSale: aSale ].
	
	^ purchase.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'NNH 11/27/2020 22:31:41'!
withCredentials: aCollectionOfCredentials catalog: aCatalog through: aMerchantProcessor   

	^ self new initializeWithCredentials: aCollectionOfCredentials catalog: aCatalog through: aMerchantProcessor! !


!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/27/2020 20:50:51'!
invalidCartIdErrorDescription
	
	^ 'Invalid cart id'! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/26/2020 21:10:40'!
invalidPasswordErrorDescription
	
	^ 'Invalid Password'! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/26/2020 21:06:24'!
invalidUserErrorDescription
	
	^ 'Invalid user'! !
