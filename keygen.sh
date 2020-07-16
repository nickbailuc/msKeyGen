#!/bin/bash
#SPDX-License-Identifier: GPL-3.0-or-later
VERSION=0.42

help()
{
printf "\
$0 (Version 0.42)
Copyright (C) 2020 Nick Bailuc, <nick.bailuc@gmail.com>
This is free software; see the source code for copying conditions.
There is ABSOLUTELY NO WARRANTY; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

This program uses the \$RANDOM variable built into Bash in a sequence until it finds
appropriate license keys for various deprecated Microsoft products from the 1990s.


	[SYNOPSIS]
	$0 ARG1 ARG2 ARG3
	
	Example: $0 oem 10
		Generate 10 keys silently (stdout only keys without enumeration)

	Example: $0 cd 2**5 --silent
		Calculate 2**5 (=32) and generate that many keys.


	[ARG1 PARAMETERS]
	oem
		Generate Microsoft Windows 95 / NT 4.0 Product ID (OEM) Keys.

	cd
		Generate Microsoft Windows 95 / NT 4.0 / Office 95 CD Keys.

	-h, --help
		Show this help and exit 0.

	-l, --license
		Display license


	[ARG2 PARAMETERS]
	This parameter may be ommited entirely, in which case only 1 key will be generated

	N∈(1, 2**63-1)
		Enter any integer between 1 and 9223372036854775807 representing
		how many keys to be generated. A Bash integer calculation may also be entered!


	[EXIT CODES]
	0 : Success
	1 : Invalid argument: product type
	2 : Invalid argument: number of keys
	3 : End of script!
		The script is set to exit 0 after completion of generation. If the script
		reaches the end (outside of main() function) the script will exit 2
		indicating an error has occured!


Inspiration:
https://medium.com/@dgurney/so-you-want-to-generate-license-keys-for-old-microsoft-products-a355c8bf5408

Disclaimer: This script was written for educational purposes only, and the author does not
encourage or endorse software piracy of any sort.
"
}

license()
{
printf "\
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
"
}


oem()
{
	# 3-digit day of year:
	D=$(( RANDOM % 366 + 1))
	if (( D < 10)) 
	then
		D=00$D
	elif (( D < 100 ))
	then
		D=0$D
	fi

	# 2-digit year:
	Y=$(( RANDOM % 9 ))
	if (( Y < 4 ))
	then
		Y=0$Y
	else
		Y=$(( Y + 91 ))
	fi

	# 7-digit "divisible by 7" segment:
	a=0; b=0; c=0; d=0; e=0; f=1
	while (( (100000*a + 10000*b + 1000*c + 100*d + 10*e + f) % 7 != 0 ))
	do
		a=$(( RANDOM % 10 ))
		b=$(( RANDOM % 10 ))
		c=$(( RANDOM % 10 ))
		d=$(( RANDOM % 10 ))
		e=$(( RANDOM % 10 ))
		f=$(( RANDOM % 7 + 1 ))
	done

	# 5-digit "random" segment:
	r1=$(( RANDOM % 10 ))
	r2=$(( RANDOM % 10 ))
	r3=$(( RANDOM % 10 ))
	r4=$(( RANDOM % 10 ))
	r5=$(( RANDOM % 10 ))

	# Export Product Key:
	printf "$D$Y-OEM-0$a$b$c$d$e$f-$r1$r2$r3$r4$r5\n"
}


cd()
{
	# 3-digit segment:
	for T in {3..9}
	do
		if (( S == (T * 111)))
		then
			S=$(( RANDOM % 1000 ))
		fi
	done
}


toString()
{
	if [[ $ARG1 == "oem" ]]
	then printf "Windows 95 / NT 4.0 OEM Product ID #$i:\t"
	elif [[ $ARG1 == "cd" ]]
	then printf "Windows 95 / NT 4.0 / Office 95 CD Key #$i:\t"
	fi
}


main()
{
	# ARG1 validation:
	if [[ $ARG1 != "oem" ]] && [[ $ARG1 != "cd" ]]
	then
		printf "Please enter a product type to generate keys for. Try:\n $0 --help\n" >&2
		exit 1
	fi
	if [[ $ARG1 == "-h" ]] || [[ $ARG1 == "--help" ]]
	then
		help
		exit 0
	elif [[ $ARG1 == "-l" ]] || [[ $ARG1 == "--license" ]]
	then
		license
		exit 0

	# License Key Generation:
	else
		if [[ $ARG2 -eq "" ]]
		then
			i=1
			if [[ $ARG3 != "-s" ]] && [[ $ARG3 != "--silent" ]]
			then
				toString
			fi
			$ARG1
			exit 0
		elif (( ARG2 < 1 ))
		then
			printf "Invalid input! Please enter an integer between 1 and (2^63)-1 (inclusively)\n" >&2
			exit 2
		else
			i=1
			while (( i <= ARG2 ))
			do
				if [[ $ARG3 != "-s" ]] && [[ $ARG3 != "--silent" ]]
				then
					toString
				fi
				$ARG1
				i=$(( i + 1 ))
			done
			exit 0
		fi
	fi
}

# Initialization:
ARG1=$1
ARG2=$2
ARG3=$3
main
printf "End of script error!\n" >&2
exit 3

#TODO: add validator
