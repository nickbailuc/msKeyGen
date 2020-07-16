# ProductKeyGenerator
Assignment 5: A unique set of algorithms to generate CD and OEM product keys with the help of
BASH and its $RANDOM variable.


## License: GNU GPL3+
Copyright (C) 2020 Nick Bailuc, nick.bailuc@gmail.com

This program uses the $RANDOM variable built into Bash in a sequence until it
generates appropriate software license keys based on a unique alogrithm.
It may be used in part or entirely by an organization as a method of DRM to
verify a legal purchase of their software. The same algorithms may also be used
to check the validity of a licence key.

	GNU General Public License version 3 or later
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.


# Manual:

## [SYNOPSIS]

./keygen.sh ARG1 ARG2 ARG3

Minimal Usage:
./keygen.sh ARG1

Examples:
./keygen.sh cd
Generate a single CD key

./keygen.sh oem --debug
Show the 4-algorithm step by step process of generating an OEM key

./keygen.sh oem 2**5 --silent
Calculate (2**5 = 32); generate 32 keys without enumeration

./keygen.sh cd 5 --silent > keys.txt
Generate 5 keys silently (only output the key).
Then save the output in the file keys.txt


## [ARG 1 PARAMETERS: TYPES OF KEYS]
oem
Generate Product ID (OEM) Keys.

cd
Generate CD Keys.

-v, --validate
Validate a CD/OEM key provided as an argument.

-h, --help
Show this help and exit 0.

-l, --license
Display license


## [ARG 2 PARAMETER: NUMBER OF KEYS] (optional)
This parameter may be omitted entirely, in which case only 1 key will be generated!

N ∈ (1, 2**63-1)
Enter any integer between 1 and 9223372036854775807 representing
how many keys to be generated. A Bash integer calculation may also be entered!

KEY
If -v is used, you must enter an OEM or CD key to validate.

-d, --debug
Useful for develpers, or to learn how the program works


## [ARG 3 PARAMETER: POWER TOOLS] (optional)
This can only be used if an integer N was also given!

```-s, --silent```
Only output license keys, no enumeration

-c, --check
Uses internal validation algorithm to confirm the newly generated
keys are valid. (Essentially the generate algorithms reverse-engineered).
This process is certain to be slower, however can detect internal script errors.

## [EXIT CODES]
	0 : Success

	Argument Errors:
	1 : Argument 1 invalid: product type / help / version
	2 : Argument 2 invalid: N number of keys / debug
	3 : Too many arguments given
	4 : Validator: invalid format
	5 : Validator: invalid Key

	Internal Errors (please report these):
	6 : Validator: internal error!
	7 : Internal check algorithm failed!
	8 : End of script!
		The script is set to exit 0 after completion of generation. If the script
		reaches the end (outside of main() function) the script will exit 8
		indicating an error has occured!
