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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/4/2020 23:51:09'!
test10PortfolioShouldNotAddItself
	
	| portfolio |
	
	portfolio := Portfolio new.

	self should: [portfolio add: portfolio] raise: Error.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/4/2020 23:51:53'!
test11PortfolioShouldNotAddParentPortfolio
	
	| aPortfolio anotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: aPortfolio.

	self should: [aPortfolio add: anotherPortfolio] raise: Error.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/4/2020 23:52:53'!
test12PortfolioShouldNotAddAccountIfTheyBothBelongToAnotherPortfolio
	
	| p1 p2 p3 |
	
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.

	p1 add: p2.
	p1 add: p3.

	self should: [p3 add: p2]
	raise: Error
	withMessageText: Portfolio canNotBelongToACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/4/2020 23:58:20'!
test13PortfolioShouldNotAddAnotherPortfolioWhenTheyShareAnAccount
	
	| p1 p2 p3 |
	
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.

	p1 add: p3.
	p2 add: p3.

	self should: [p1 add: p2]
	raise: Error
	withMessageText: Portfolio canNotHaveAnAccountInCommonErrorDescription.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 00:00:30'!
test14Rombo
	
	| p1 p2 p3 p4 |
	
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.
	p4 := Portfolio new.

	p1 add: p2.
	p1 add: p3.
	p3 add: p4.

	self should: [p2 add: p4]
	raise: Error
	withMessageText: Portfolio canNotBelongToACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'NNH 11/4/2020 22:48:17'!
test15
	
	| p1 p2 p3 p4 |
	
	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.
	p4 := Portfolio new.

	p1 add: p3.
	p1 add: p4.
	p2 add: p3.

	self shouldnt: [p2 add: p4] raise: Error.
! !


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


!classDefinition: #FinancialProduct category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialProduct
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialProduct methodsFor: 'inserting - private' stamp: 'NNH 11/5/2020 23:10:08'!
addParent: aPortfolio 
	
	parents add: aPortfolio.! !


!FinancialProduct methodsFor: 'balance' stamp: 'NNH 11/5/2020 23:11:23'!
balance
	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'testing' stamp: 'NNH 11/5/2020 23:11:39'!
hasRegistered: aTransaction
	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'transactions' stamp: 'NNH 11/5/2020 23:11:30'!
transactions
	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/5/2020 23:17:00'!
accountsInPortfolio
	
	| accountsInPortfolio |
	accountsInPortfolio := OrderedCollection new.
	self addAccountsInPortfolioTo: accountsInPortfolio.
	^ accountsInPortfolio.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/5/2020 23:17:37'!
addAccountsInPortfolioTo: aCollectionOfAccounts
		
	self subclassResponsibility.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/5/2020 23:19:01'!
includes: anAccountToSearch
	
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/5/2020 23:21:11'!
assertFinancialProductCanBeAdded: anAccountOrPortfolio

	(self isInAPortfolioWith: anAccountOrPortfolio) ifTrue: [self error: self class canNotBelongToACommonPortfolioErrorDescription ].
	(self hasAccountsInCommonWith: anAccountOrPortfolio)	 ifTrue: [self error: self class canNotHaveAnAccountInCommonErrorDescription ].! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/4/2020 23:47:23'!
hasAccountsInCommonWith: anAccountOrPortfolio

	^ (self accountsInPortfolio intersection: anAccountOrPortfolio accountsInPortfolio) isEmpty not! !


!Portfolio methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:17:42'!
balance
	^ accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initializing' stamp: 'NNH 11/4/2020 20:22:24'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !



!Portfolio methodsFor: 'inserting' stamp: 'NNH 11/5/2020 23:21:11'!
add: anAccountOrPortfolio 
	
	self assertFinancialProductCanBeAdded: anAccountOrPortfolio.
	
	anAccountOrPortfolio addParent: self.	
	accounts add: anAccountOrPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'NNH 11/2/2020 20:45:46'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:39:40'!
accountsInPortfolio
	
	| accountsInPortfolio |
	accountsInPortfolio := OrderedCollection new.
	self addAccountsInPortfolioTo: accountsInPortfolio.
	^ accountsInPortfolio.
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:42:08'!
addAccountsInPortfolioTo: aCollectionOfAccounts
		
	aCollectionOfAccounts add: self.
	accounts do: [:anAccount | anAccount addAccountsInPortfolioTo: aCollectionOfAccounts].
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:22:27'!
includes: anAccountToSearch
	
	
	^ (anAccountToSearch == self) or: [
		accounts anySatisfy: [:anAccount | anAccount includes: anAccountToSearch]
		].
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:20:44'!
isInAPortfolioWith: anAccount
	
	^ (parents anySatisfy: [:aParent | aParent isInAPortfolioWith: anAccount ]) or: [
		self includes: anAccount
		].
	
	
! !


!Portfolio methodsFor: 'transactions' stamp: 'NNH 11/4/2020 19:09:03'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'NNH 11/4/2020 20:13:45'!
addTransactionsTo: aCollectionOfTransactions
	
	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 20:16:15'!
new
	
	^ self basicNew initialize.! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:54:30'!
canNotBelongToACommonPortfolioErrorDescription
	^ 'There is a portfolio containing both portfolios'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:58:51'!
canNotHaveAnAccountInCommonErrorDescription
	^ 'Portfolios should not share an account'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/2/2020 21:15:01'!
cannotIncludeItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/5/2020 23:21:11'!
assertFinancialProductCanBeAdded: anAccountOrPortfolio

	(self isInAPortfolioWith: anAccountOrPortfolio) ifTrue: [self error: self class canNotBelongToACommonPortfolioErrorDescription ].
	(self hasAccountsInCommonWith: anAccountOrPortfolio)	 ifTrue: [self error: self class canNotHaveAnAccountInCommonErrorDescription ].! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/4/2020 23:47:23'!
hasAccountsInCommonWith: anAccountOrPortfolio

	^ (self accountsInPortfolio intersection: anAccountOrPortfolio accountsInPortfolio) isEmpty not! !


!Portfolio methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:17:42'!
balance
	^ accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initializing' stamp: 'NNH 11/4/2020 20:22:24'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !



!Portfolio methodsFor: 'inserting' stamp: 'NNH 11/5/2020 23:21:11'!
add: anAccountOrPortfolio 
	
	self assertFinancialProductCanBeAdded: anAccountOrPortfolio.
	
	anAccountOrPortfolio addParent: self.	
	accounts add: anAccountOrPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'NNH 11/2/2020 20:45:46'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:39:40'!
accountsInPortfolio
	
	| accountsInPortfolio |
	accountsInPortfolio := OrderedCollection new.
	self addAccountsInPortfolioTo: accountsInPortfolio.
	^ accountsInPortfolio.
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:42:08'!
addAccountsInPortfolioTo: aCollectionOfAccounts
		
	aCollectionOfAccounts add: self.
	accounts do: [:anAccount | anAccount addAccountsInPortfolioTo: aCollectionOfAccounts].
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:22:27'!
includes: anAccountToSearch
	
	
	^ (anAccountToSearch == self) or: [
		accounts anySatisfy: [:anAccount | anAccount includes: anAccountToSearch]
		].
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:20:44'!
isInAPortfolioWith: anAccount
	
	^ (parents anySatisfy: [:aParent | aParent isInAPortfolioWith: anAccount ]) or: [
		self includes: anAccount
		].
	
	
! !


!Portfolio methodsFor: 'transactions' stamp: 'NNH 11/4/2020 19:09:03'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'NNH 11/4/2020 20:13:45'!
addTransactionsTo: aCollectionOfTransactions
	
	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 20:16:15'!
new
	
	^ self basicNew initialize.! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:54:30'!
canNotBelongToACommonPortfolioErrorDescription
	^ 'There is a portfolio containing both portfolios'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:58:51'!
canNotHaveAnAccountInCommonErrorDescription
	^ 'Portfolios should not share an account'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/2/2020 21:15:01'!
cannotIncludeItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !


!classDefinition: #PortfolioTipoDeNodo category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioTipoDeNodo
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:37:52'!
accountsInPortfolio
	
	| accountsInPortfolio |
	accountsInPortfolio := OrderedCollection new.
	self addAccountsInPortfolioTo: accountsInPortfolio.
	^ accountsInPortfolio.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:38:06'!
addAccountsInPortfolioTo: aCollectionOfAccounts
		
	self subclassResponsibility.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:38:29'!
addParent: aPortfolio 
	
	parents add: aPortfolio.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:39:13'!
balance
	
	self subclassResponsibility.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:39:32'!
hasRegistered: aTransaction
	
	self subclassResponsibility.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:37:32'!
includes: anAccountToSearch
	
	self subclassResponsibility.! !

!PortfolioTipoDeNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:39:19'!
transactions
	
	self subclassResponsibility.! !


!classDefinition: #PortfolioHoja category: 'Portfolio-Ejercicio'!
PortfolioTipoDeNodo subclass: #PortfolioHoja
	instanceVariableNames: 'receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioHoja methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:48:37'!
addTransactionsTo: aCollectionOfTransactions
	
	aCollectionOfTransactions addAllLast: self transactions.! !

!PortfolioHoja methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:47:14'!
balance
	
	^ receptiveAccount balance.! !

!PortfolioHoja methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:47:39'!
hasRegistered: aTransaction
	
	^ receptiveAccount hasRegistered: aTransaction.! !

!PortfolioHoja methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:48:16'!
includes: anAccountToSearch
	
	^ anAccountToSearch == self.! !

!PortfolioHoja methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:47:22'!
transactions
	
	^ receptiveAccount transactions.! !


!classDefinition: #PortfolioNodo category: 'Portfolio-Ejercicio'!
PortfolioTipoDeNodo subclass: #PortfolioNodo
	instanceVariableNames: 'financialProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:54:01'!
add: anAccountOrPortfolio 
	
	self assertFinancialProductCanBeAdded: anAccountOrPortfolio.
	
	anAccountOrPortfolio addParent: self.	
	financialProducts add: anAccountOrPortfolio.
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:52:46'!
addTransactionsTo: aCollectionOfTransactions
	
	financialProducts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ].
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:54:24'!
assertFinancialProductCanBeAdded: anAccountOrPortfolio

	(self isInAPortfolioWith: anAccountOrPortfolio) ifTrue: [self error: self class canNotBelongToACommonPortfolioErrorDescription ].
	(self hasAccountsInCommonWith: anAccountOrPortfolio)	 ifTrue: [self error: self class canNotHaveAnAccountInCommonErrorDescription ].
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:50:23'!
balance
	^ financialProducts sum: [:anAccount | anAccount balance] ifEmpty: [0].
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:50:44'!
hasRegistered: aTransaction
	^ financialProducts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:52:29'!
includes: anAccountToSearch
	
	
	^ (anAccountToSearch == self) or: [
		financialProducts anySatisfy: [:anAccount | anAccount includes: anAccountToSearch]
		].
	
	! !

!PortfolioNodo methodsFor: 'as yet unclassified' stamp: 'NNH 11/5/2020 23:51:14'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.
	
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:34:42'!
balance

	^ transactions inject: 0 into: [:balance :aTransaction | aTransaction addToBalance: balance].

! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/4/2020 20:24:19'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'inserting - private' stamp: 'NNH 11/4/2020 20:23:55'!
addParent: aPortfolio 
	parents add: aPortfolio.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:42:32'!
addAccountsInPortfolioTo: aCollectionOfAccounts
		
	aCollectionOfAccounts add: self.! !

!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/4/2020 23:23:47'!
includes: anAccountToSearch
	
	^ anAccountToSearch == self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'NNH 11/5/2020 23:14:22'!
addTransactionsTo: aCollectionOfTransactions
	
	aCollectionOfTransactions addAllLast: self transactions.! !
