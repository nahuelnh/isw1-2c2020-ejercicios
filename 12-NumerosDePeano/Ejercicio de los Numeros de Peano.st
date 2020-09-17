!classDefinition: #I category: #'Ejercicio de los Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ejercicio de los Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'Operaciones' stamp: 'AM 9/14/2020 21:53:46'!
next
	^self createChildNamed: self name , 'I'.
	
	
	! !

!I class methodsFor: 'Operaciones' stamp: 'AM 9/17/2020 10:34:34'!
previous
	^self throwErrorDeNumerosNegativosNoSoportados 
	
	
	! !


!I class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/16/2020 18:48:49'!
* unMultiplicador
	^unMultiplicador! !

!I class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/14/2020 21:22:16'!
+ unSumando
	^unSumando next.! !

!I class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/17/2020 10:34:13'!
- unRestando
	^self throwErrorDeNumerosNegativosNoSoportados .! !

!I class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/17/2020 10:33:58'!
/ unDivisor
	^(unDivisor == self) 
		ifTrue: [ self ] 
		ifFalse: [self throwErrorDeLaDivisionNoEntera]! !


!I class methodsFor: 'Error mensajes' stamp: 'AM 9/16/2020 19:39:40'!
descripcionDeErrorDeLaDivisonNoResultaEntera
	^'El resultado de la divison no es un Numero de Peano.'! !

!I class methodsFor: 'Error mensajes' stamp: 'AM 9/16/2020 19:28:17'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados.'! !

!I class methodsFor: 'Error mensajes' stamp: 'AM 9/17/2020 10:26:31'!
throwErrorDeLaDivisionNoEntera

	^ self error: self descripcionDeErrorDeLaDivisonNoResultaEntera! !

!I class methodsFor: 'Error mensajes' stamp: 'AM 9/17/2020 10:33:25'!
throwErrorDeNumerosNegativosNoSoportados

	^ self error: 	self descripcionDeErrorDeNumerosNegativosNoSoportados! !


!I class methodsFor: 'Operaciones Aritmeticas - private' stamp: 'AM 9/16/2020 19:52:57'!
comoRestandoDe: unSustractor
	^unSustractor previous
	

	
	
	! !


!classDefinition: #II category: #'Ejercicio de los Numeros de Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ejercicio de los Numeros de Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'Operaciones' stamp: 'AM 9/16/2020 18:41:32'!
previous
	^self parent! !


!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/16/2020 19:29:10'!
* unMultiplicador
	^self previous * unMultiplicador + unMultiplicador! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/16/2020 18:41:00'!
+ unSumando
	^self previous + unSumando next! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/16/2020 19:56:02'!
- unRestando
	^unRestando comoRestandoDe: self! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/17/2020 10:32:43'!
/ unDivisor
	^(self esIgualA: unDivisor)
		ifTrue: [ I ] 
		ifFalse: [(self esMenorOIgualA: unDivisor) 
			ifTrue: [self - unDivisor / unDivisor + I] 
			ifFalse: [self throwErrorDeLaDivisionNoEntera ]]! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/17/2020 10:31:50'!
esIgualA: unDivisor

	^ self == unDivisor! !

!II class methodsFor: 'Operaciones Aritmeticas' stamp: 'AM 9/17/2020 10:32:52'!
esMenorOIgualA: unNumeroDePeano

	^ self printString beginsWith: unNumeroDePeano printString! !


!II class methodsFor: 'Operaciones Aritmeticas - private' stamp: 'AM 9/16/2020 19:51:49'!
comoRestandoDe: unSustractor
	^self previous comoRestandoDe: unSustractor previous! !


!classDefinition: #III category: #'Ejercicio de los Numeros de Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!


!classDefinition: #IIII category: #'Ejercicio de los Numeros de Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!


!classDefinition: #IIIII category: #'Ejercicio de los Numeros de Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!


!classDefinition: #NumerosDePeanoTests category: #'Ejercicio de los Numeros de Peano'!
DenotativeObject subclass: #NumerosDePeanoTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio de los Numeros de Peano'!
