!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:02:08'!
test01BalanceOfEmptyPortfolioIsZero

	| portfolio |

	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:02:22'!
test02BalanceOfPortfolioWithOneAccountIsBalanceOfThatAccount

	| portfolio account |

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: 100 equals: portfolio balance.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:02:57'!
test03BalanceOfPortfolioWithMoreThanOneAccountIsSumOfBalances

	| portfolio anAccount anotherAccount |

	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	portfolio add: anotherAccount.

	self assert: 100 equals: portfolio balance.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:06:42'!
test04EmptyPortfolioHasRegisteredNoTransactions

	| portfolio account aTransaction |

	account := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: account.
	
	portfolio := Portfolio new.

	self deny: (portfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:03:53'!
test05PortfolioWithOneAccountRegistersATransactionOfThatAccount

	| portfolio account aTransaction |

	account := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.

	self assert: (portfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:05:39'!
test06APortfolioWithMoreThanOneAccountRegistersATransactionThatIsNotFromTheFirstAccount

	| portfolio anAccount anotherAccount aTransaction |

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: anotherAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	portfolio add: anotherAccount.

	self assert: (portfolio hasRegistered: aTransaction).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:07:10'!
test07EmptyPortfolioHasNoTransactions

	| portfolio account |

	account := ReceptiveAccount new.
	
	portfolio := Portfolio new.

	self assert: portfolio transactions isEmpty.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:08:28'!
test08PortfolioWithOneAccountHasTheTransactionsOfThatAccount

	| portfolio account aTransaction |

	account := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.

	self assert: 1 equals: portfolio transactions size.
	self assert: portfolio transactions includes: aTransaction.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:09:10'!
test09APortfolioWithMoreThanOneAccountHasTheTransactionsOfItsAccounts

	| portfolio anAccount anotherAccount aTransaction |

	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: anotherAccount.
	
	portfolio := Portfolio new.
	portfolio add: anAccount.
	portfolio add: anotherAccount.

	self assert: 1 equals: portfolio transactions size.
	self assert: portfolio transactions includes: aTransaction.
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:13:55'!
test10
	
	| portfolio |
	
	portfolio := Portfolio new.

	self should: [portfolio add: portfolio]
	raise: Error
	withMessageText: Portfolio cannotIncludeItselfErrorDescription.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 21:23:57'!
test11
	
	| aPortfolio anotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: aPortfolio.

	self should: [aPortfolio add: anotherPortfolio]
	raise: Error
	withMessageText: Portfolio cannotIncludeItselfErrorDescription.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:35:23'!
addToBalance: aBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:05'!
addToBalance: aBalance
	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:55'!
addToBalance: aBalance 
	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'xxx' stamp: 'NNH 11/2/2020 20:17:42'!
balance
	^ accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'xxx' stamp: 'NNH 11/2/2020 20:45:46'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'xxx' stamp: 'NNH 11/2/2020 20:11:33'!
initialize
	
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'yyy' stamp: 'NNH 11/2/2020 21:27:03'!
add: anAccountOrPortfolio 
	
	accounts add: anAccountOrPortfolio.
	((anAccountOrPortfolio isKindOf: Portfolio) 
	and: [anAccountOrPortfolio containsPortfolio: anAccountOrPortfolio])
	ifTrue: [self error: self class cannotIncludeItselfErrorDescription].! !


!Portfolio methodsFor: 'sdasdasd' stamp: 'NNH 11/2/2020 20:55:18'!
transactions
	
	^ accounts inject: OrderedCollection new into: [:aCollectionOfTransactions :anAccount | aCollectionOfTransactions union: anAccount transactions].! !


!Portfolio methodsFor: 'dsdasd' stamp: 'NNH 11/2/2020 21:40:58'!
containsPortfolio: aPortfolio 
	
	(accounts anySatisfy: [:anAccountOrPortfolio | anAccountOrPortfolio == aPortfolio]) ifTrue: [^true].
	accounts do: [:anAccountOrPortfolio | 
		((anAccountOrPortfolio isKindOf: Portfolio) 
		and: [anAccountOrPortfolio containsPortfolio: aPortfolio]) 
		ifTrue: [^true]
		].
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 20:16:15'!
new
	
	^ self basicNew initialize.! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/2/2020 21:15:01'!
cannotIncludeItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:34:42'!
balance

	^ transactions inject: 0 into: [:balance :aTransaction | aTransaction addToBalance: balance].

! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
