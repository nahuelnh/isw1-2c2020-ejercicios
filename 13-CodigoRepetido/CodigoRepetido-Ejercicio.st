!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 19:15:34'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCustomerName: 'John Lennon' takesLessThan: 50
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 21:16:00'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomerNamed: paulMcCartney.
	  
	self sendingMessage: #removeCustomerNamed: to: customerBook withCustomerName: paulMcCartney takesLessThan: 100 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/19/2020 12:57:59'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook emptyNameShouldNotBeAdded |

	customerBook := CustomerBook new.

	emptyNameShouldNotBeAdded := [:anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty.].
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCustomerName: '' shouldSignal: Error andVerify: emptyNameShouldNotBeAdded 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/19/2020 12:47:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon onlyOneCustomer |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	onlyOneCustomer := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #removeCustomerNamed: to: customerBook withCustomerName: 'Paul McCartney' shouldSignal: NotFound andVerify: onlyOneCustomer
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 21:17:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomer: paulMcCartney.
	
	self customerBook: customerBook shouldHaveActive: 0 suspended: 1 andTotal: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 22:04:04'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedAndRemovedCustomer: paulMcCartney.
	
	self customerBook: customerBook shouldHaveActive: 0 suspended: 0 andTotal: 0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/19/2020 12:47:38'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon onlyOneCustomer |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	onlyOneCustomer := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCustomerName:  'George Harrison' shouldSignal: CantSuspend andVerify: onlyOneCustomer! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/19/2020 12:47:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon onlyOneCustomer |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithSuspendedCustomer: johnLennon.
	onlyOneCustomer := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCustomerName: johnLennon shouldSignal: CantSuspend andVerify: onlyOneCustomer! !


!CustomerBookTest methodsFor: 'testing setup' stamp: 'NNH 9/18/2020 20:30:31'!
newCustomerBookWithCustomerNamed: aCustomerName
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'testing setup' stamp: 'AM 9/19/2020 12:37:56'!
newCustomerBookWithSuspendedAndRemovedCustomer: aCustomerNameToSuspendAndRemove
	
	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomerNameToSuspendAndRemove.
	customerBook suspendCustomerNamed: aCustomerNameToSuspendAndRemove.
	customerBook removeCustomerNamed: aCustomerNameToSuspendAndRemove.
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'testing setup' stamp: 'AM 9/19/2020 12:38:08'!
newCustomerBookWithSuspendedCustomer: aCustomerNameToSuspend
	
	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomerNameToSuspend.
	customerBook suspendCustomerNamed: aCustomerNameToSuspend.
	^customerBook.
	! !


!CustomerBookTest methodsFor: 'testing verification' stamp: 'AM 9/19/2020 12:35:44'!
checkCostumerBook: aCostumerBookToTest onlyHasCustomerNamed: aCustomerNameToSearch
	
	^ [ :anError | 
		self assert: aCostumerBookToTest numberOfCustomers = 1.
		self assert: (aCostumerBookToTest includesCustomerNamed: aCustomerNameToSearch) ].
		
! !

!CustomerBookTest methodsFor: 'testing verification' stamp: 'NNH 9/18/2020 20:00:07'!
customerBook: aCustomerBookToTestCustomers shouldHave: aNumberOfCustomers customersOfType: aMessageToObtainNumberOfCustomers

	self assert: aNumberOfCustomers equals: (aCustomerBookToTestCustomers perform: aMessageToObtainNumberOfCustomers).


	
! !

!CustomerBookTest methodsFor: 'testing verification' stamp: 'AM 9/19/2020 12:37:15'!
customerBook: aCustomerBookToTestCustomers shouldHaveActive: numberOfActiveCustomers suspended: numberOfSuspendedCustomers andTotal: totalNumberOfCustomers

	|numberOfCustomersPerType typesOfCustomer |
	
	numberOfCustomersPerType := Array with: numberOfActiveCustomers with: numberOfSuspendedCustomers with: totalNumberOfCustomers.
	typesOfCustomer := Array with: #numberOfActiveCustomers with: #numberOfSuspendedCustomers with: #numberOfCustomers.
	
	1 to: 3 do: [ :anIndex | | aTypeOfCustomer numberOfCustomersOfType |
		numberOfCustomersOfType := (numberOfCustomersPerType at: anIndex).
		aTypeOfCustomer := (typesOfCustomer at: anIndex).
		self customerBook: aCustomerBookToTestCustomers shouldHave: numberOfCustomersOfType customersOfType: aTypeOfCustomer.
		].


	
! !

!CustomerBookTest methodsFor: 'testing verification' stamp: 'NNH 9/18/2020 19:36:58'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCustomerName: aCustomerAsCollaborator shouldSignal: aSignalError andVerify: conditionsToCheckOnSignal

	[ aReceivingCustomerBook perform: aMessageToSend withArguments: (Array with: aCustomerAsCollaborator).
	self fail ]
		on: aSignalError 
		do: conditionsToCheckOnSignal ! !

!CustomerBookTest methodsFor: 'testing verification' stamp: 'NNH 9/18/2020 19:13:49'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCustomerName: customerAsCollaborator takesLessThan: maxNumberOfMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aReceivingCustomerBook perform: aMessageToSend withArguments:  (Array with: customerAsCollaborator ).
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < (maxNumberOfMilliseconds * millisecond)! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer information' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'customer information' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'customer information' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer information' stamp: 'NNH 9/18/2020 22:11:18'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer information' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/18/2020 23:18:25'!
addCustomerNamed: aName

	self sendSignal: #signalCustomerNameCannotBeEmpty ifCondition: (aName isEmpty).
	self sendSignal: #signalCustomerAlreadyExists ifCondition: (self includesCustomerNamed: aName). 
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/19/2020 00:18:45'!
removeAndRetrieveCustomerFromList: aCustomerList ifNameEquals: aCustomerName 

    1 to: aCustomerList size do: [ :index |
	aCustomerName = (aCustomerList at: index)
            ifTrue: [
                aCustomerList removeAt: index.
                ^ aCustomerName
            	]
    	].

    ^ nil.

	! !

!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/19/2020 00:19:01'!
removeCustomerNamed: aName 
 	
	(self removeAndRetrieveCustomerFromList: active ifNameEquals: aName) ifNotNil: [^aName].
	(self removeAndRetrieveCustomerFromList: suspended ifNameEquals: aName) ifNotNil: [^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'signal control' stamp: 'AM 9/19/2020 13:06:50'!
sendSignal: aSignal ifCondition: aBooleanConditionToSendSignal

	aBooleanConditionToSendSignal ifTrue: [ self perform: aSignal ].
	
! !

!CustomerBook methodsFor: 'signal control' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal control' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
