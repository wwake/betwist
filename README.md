# betwist
A word game

You're presented with a grid of letters. Your goal is to select adjacent letters (in any direction) to form words.

The twist is that you can twist the board - wrap any edge "around the corner". In other words, the edges of the board wrap around to the other side.

 
## Representing the Trie
We use a trie to search our dictionary.

A trie has a set of letter matchers. A letter matcher has:

* The character it matches
* A flag telling whether this letter terminates a word
* A trie for all possible remaining letters in a word

We represent the whole trie in a large array, holding 4 bytes for each matcher.

* Slot 0 (bytes 0-3) is an empty trie, used to terminate each trie.
* Slot 1 (bytes 4-7) is the root of the trie.
* The address of a trie is its (quadbyte) index in the array.

The set of matchers is placed sequentially. There's an added failure matcher at the end of the list. To see if a word is extended, you walk through the list looking for a matching character. If you don't find one, you hit the failure matcher and the prefix is rejected.

A matcher has 4 bytes:

* The high byte for the letter, where isWord is true if the letter is lowercased.

	0x41-0x57 is A-Z (isWord false)
	
	0x61-0x7a is a-z (isWord true)
  
* Three bytes for the byte index of the matcher's trie.

	This will be extended with a fourth upper byte of 0 to get that address.
	
	A 0 for the address will get to slot 0, the "leaf" trie. [Do we need that?]

## Creating the Trie
* Set the project to BetwistMaker
* Copy words.list from the resources folder to the downloads directory
* Run "main" (cmd-R)
* Copy trie.dat from the downloads directory to the resources folder

