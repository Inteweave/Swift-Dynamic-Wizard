# Swift-Dynamic-Wizard
Pattern used for set-by-step instructions or to follow a UX flow. Sometimes called a Wizard or Assistant.

## Concept
Inteweave has developed many self-install kits since 2004 and has used this method for all of them. It has been coded in C++, Actionscript, Swift, Kotlin, Java and Objective-C.

What we are aiming for is to have each screen independent of any other screen. The UX flow shows how the screens should be linked and the wizard code represents that directly. The order of the steps is input as a data file. The wizard definition is *Viewing screen X, on event Y, go to screen Z*

For example, we have the following steps to choose a snack:
```
- choose snack
  - icecream
    - cone
    - soft serve
      - choc dip
      - sprinkles
  - nuts
```
The UX flow is coded in JSON:
```
	"navigation": [
      { "onScreen": "select snack", "when": "button1", "navigateTo": "ice cream" },
      { "onScreen": "select snack", "when": "button2", "navigateTo": "nuts" },
      { "onScreen": "ice cream", "when": "button1", "navigateTo": "cone" },
      { "onScreen": "ice cream", "when": "button2", "navigateTo": "soft serve" },
      { "onScreen": "soft serve", "when": "button1", "navigateTo": "choc dip" },
      { "onScreen": "soft serve", "when": "button2", "navigateTo": "sprinkles" }
	]
```
