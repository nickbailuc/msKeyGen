#!/bin/bash
#SPDX-License-Identifier: GPL-3.0-or-later
VERSION=0.45
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
	then D=00$D
	elif (( D < 100 ))
	then D=0$D
	fi

	# 2-digit year:
	Y=$(( RANDOM % 9 ))
	if (( Y < 4 ))
	then Y=0$Y
	else Y=$(( Y + 91 ))
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


oem_debug()
{
	printf "${c2}Initialization complete!\n\n"
	# 3-digit day of year:
	printf "Determining 3-digit day of year:${c1}\n"
	D=$(( RANDOM % 366 + 1))
	printf "\tWorking with fragmentary 3-digit day of year $D\n\n${c1}"
	if (( D < 10))
	then
		printf "\tDay of year confirmed to be single-digit. Adding two zero's\n"
		D=00$D
	elif (( D < 100 ))
	then
		printf "\tDay of year confirmed to be double-digit. Adding one zero\n"
		D=0$D
	fi
	printf "${c2}\t3-digit day of year determined to be $D!\n\n"

	# 2-digit year:
	Y=$RANDOM
	printf "Determining 2-digit year:${c1}\n"
	while (( Y > 3 && Y < 95)) || (( Y > 99 ))
	do
		Y=$(( RANDOM % 100 ))
		printf "\tTrying $Y\n"
	done
	if (( Y < 4 ))
	then Y=0$Y
	fi
	printf "${c2}\t2-digit year determined to be $Y!\n\n"

	# 7-digit "divisible by 7" segment:
	printf "Initiating divisible by 7 segment:${c1}\n"
	a=0; b=0; c=0; d=0; e=0; f=1
	while (( (100000*a + 10000*b + 1000*c + 100*d + 10*e + f) % 7 != 0 ))
	do
		a=$(( RANDOM % 10 ))
		b=$(( RANDOM % 10 ))
		c=$(( RANDOM % 10 ))
		d=$(( RANDOM % 10 ))
		e=$(( RANDOM % 10 ))
		f=$(( RANDOM % 7 + 1 ))
		printf "\ta = $a\n\tb = $b\n\tc = $c\n\td = $d\n\te = $e\n\tf = $f\n"
		printf "\tLinear combination equals "
		printf "$(( 100000*$a + 10000*$b + 1000*$c + 100*$d + 10*$e + $f ))"
		if (( (100000*a + 10000*b + 1000*c + 100*d + 10*e + f) % 7 != 0 ))
		then printf " which is not divisible by 7!\n\n"
		fi
	done
	printf "${c2}\n\t$((100000*a + 10000*b + 1000*c + 100*d + 10*e + f)) is divisible by 7!\n\n"

	# 5-digit "random" segment:
	printf "Determining 5-digit segment:${c1}\n"
	r1=$(( RANDOM % 10 ))
	r2=$(( RANDOM % 10 ))
	r3=$(( RANDOM % 10 ))
	r4=$(( RANDOM % 10 ))
	r5=$(( RANDOM % 10 ))
	printf "\tr1 = $r1\n\tr2 = $r2\n\tr3 = $r3\n\tr4 = $r4\n\tr5 = $r5\n"
	printf "${c2}\t5-digit segment determined to be $r1$r2$r3$r4$r5!\n\n"

	# Export Product Key:
	printf "${c2}Parsing variables and exporting to stdout:${c1}\n\n"
	printf "\033[4mWindows 95 / NT 4.0 Product ID #$i:\t"
	printf "$D$Y-OEM-0$a$b$c$d$e$f-$r1$r2$r3$r4$r5\033[0m\n\n"
}



cd()
{
	# 3-digit segment:
	S=$(( RANDOM % 1000 ))
	while (( S == 333 || S == 444 || S == 555 || S == 666 || S == 777 || S == 888 || S == 999 ))
	do S=$(( RANDOM % 1000 ))
	done
	if (( S < 10))
	then S=00$S
	elif (( S < 100 ))
	then S=0$S
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

	# Export CD Key:
	printf "$S-$a$b$c$d$e$f\n"
}


cd_debug()
{
	printf "${c2}Initialization complete!\n\n"
	# 3-digit day of year:
	printf "Determining 3-digit segment:${c1}\n"
	# 3-digit segment:
	S=$(( RANDOM % 1000 ))
	printf "\tTrying $S\n"
	while (( S == 333 || S == 444 || S == 555 || S == 666 || S == 777 || S == 888 || S == 999 ))
	do
		S=$(( RANDOM % 1000 ))
		printf "\tTrying $S: "
		if (( S == 333 || S == 444 || S == 555 || S == 666 || S == 777 || S == 888 || S == 999 ))
		then printf "Combinations of the set {333, 444, ..., 999} cannot be used!\n"
		fi
	done
	printf "\t${c2}Fragmentary 3-digit segment is $S!\n${c1}"
	if (( S < 10))
	then
		printf "\t3-digit segment confirmed to be single-digit. Adding two zero's\n"
		S=00$S
	elif (( S < 100 ))
	then
		printf "\t3-digit segment confirmed to be double-digit. Adding one zero\n"
		S=0$S
	fi
	printf "${c2}\t3-digit segment determined to be $S!\n\n"

	# 7-digit "divisible by 7" segment:
	printf "Initiating divisible by 7 segment:${c1}\n"
	a=0; b=0; c=0; d=0; e=0; f=1
	while (( (100000*a + 10000*b + 1000*c + 100*d + 10*e + f) % 7 != 0 ))
	do
		a=$(( RANDOM % 10 ))
		b=$(( RANDOM % 10 ))
		c=$(( RANDOM % 10 ))
		d=$(( RANDOM % 10 ))
		e=$(( RANDOM % 10 ))
		f=$(( RANDOM % 7 + 1 ))
		printf "\ta = $a\n\tb = $b\n\tc = $c\n\td = $d\n\te = $e\n\tf = $f\n"
		printf "\tLinear combination equals "
		printf "$(( 100000*$a + 10000*$b + 1000*$c + 100*$d + 10*$e + $f ))"
		if (( (100000*a + 10000*b + 1000*c + 100*d + 10*e + f) % 7 != 0 ))
		then printf " which is not divisible by 7!\n\n"
		fi
	done
	printf "${c2}\n\t$((100000*a + 10000*b + 1000*c + 100*d + 10*e + f)) is divisible by 7!\n\n"


	# Export CD Key:
	printf "${c2}Parsing variables and exporting to stdout:${c1}\n\n"
	printf "\033[4mWindows 95 / NT 4.0 / Office 95 CD Key #$i:\t"
	printf "$S-$a$b$c$d$e$f\033[0m\n\n"
}


toString()
{
	if [[ $ARG1 == "oem" ]]
	then printf "Windows 95 / NT 4.0 OEM Product ID #$i:\t\t"
	elif [[ $ARG1 == "cd" ]]
	then printf "Windows 95 / NT 4.0 / Office 95 CD Key #$i:\t\t"
	fi
}


main()
{
	# Argument Validation:
	if [[ $ARG4 != "" ]]
	then
		printf "Too many arguments! Try:\n\t $0 --help\n" >&2
		exit 3
	elif [[ $ARG1 != "oem" && $ARG1 != "cd" && $ARG1 != "-h" && $ARG1 != "--help" ]]
	then
		printf "Please enter a product type to generate keys for. Try:\n\t $0 --help\n" >&2
		exit 1
	elif [[ $ARG1 == "-h" ]] || [[ $ARG1 == "--help" ]]
	then
		help
		exit 0
	elif [[ $ARG1 == "-l" ]] || [[ $ARG1 == "--license" ]]
	then
		license
		exit 0

	# License Key Generation:
	else
		# Generate 1 key:
		if [[ $ARG2 == "-d" || $ARG2 == "--debug" ]]
		then
			if [[ $ARG1 == "oem" ]]
			then oem_debug
			elif [[ $ARG1 == "cd" ]]
			then cd_debug
			else exit 2
			fi
			exit 0
		# ARG2 Handling:
		elif [[ $ARG2 == "" ]]
		then
			i=1
			if [[ $ARG3 != "-s" ]] && [[ $ARG3 != "--silent" ]]
			then toString
			fi
			$ARG1
			exit 0
		elif (( ARG2 < 1 ))
		then
			printf "Invalid number-of-keys input! Try:\n\t $0 --help\n" >&2
			exit 2
		# Generate multiple keys:
		else
			i=1
			while (( i <= ARG2 ))
			do
				if [[ $ARG3 != "-s" ]] && [[ $ARG3 != "--silent" ]]
				then toString
				fi
				$ARG1
				i=$(( i + 1 ))
			done
			exit 0
		fi
	fi
}


help()
{
printf "\
${c2}$0 (Version 0.45)${c1}
Copyright (C) 2020 Nick Bailuc, <nick.bailuc@gmail.com>
This is free software; see the source code for copying conditions.
There is ABSOLUTELY NO WARRANTY; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

This program uses the \$RANDOM variable built into Bash in a sequence until it finds
appropriate license keys for various deprecated Microsoft products from the 1990s.


${c2}[SYNOPSIS]
	$0 ARG1 ARG2 ARG3

	Minimal Usage:
${c2}	$0 ARG1
	
	Examples:
	$0 cd${c1}
		Generate a single CD key

${c2}	$0 oem --debug
${c1}		Show the 4-algorithm step by step process of generating an OEM key

${c2}	$0 oem 2**5 --silent
${c1}		Calculate (2**5 = 32); generate 32 keys without enumeration

${c2}	$0 cd 5 --silent > keys.txt
${c1}		Generate 5 keys silently (only output the key).
		Then save the output in the file keys.txt


${c2}[ARG 1 PARAMETERS: TYPES OF KEYS]
	oem
${c1}		Generate Microsoft Windows 95 / NT 4.0 Product ID (OEM) Keys.

${c2}	cd
${c1}		Generate Microsoft Windows 95 / NT 4.0 / Office 95 CD Keys.

${c2}	-h, --help
${c1}		Show this help and exit 0.

${c2}	-l, --license
${c1}		Display license


${c2}[ARG 2 PARAMETER: NUMBER OF KEYS] (optional)
${c1}	This parameter may be omitted entirely, in which case only 1 key will be generated!

${c2}	N${c1} ∈ (1, 2**63-1)
		Enter any integer between 1 and 9223372036854775807 representing
		how many keys to be generated. A Bash integer calculation may also be entered!

${c2}	-d, --debug
${c1}		Useful for develpers, or to learn how the program works


${c2}[ARG 3 PARAMETER: OUTPUT LEVEL OF DETAIL] (optional)
${c1}	This can only be used if an integer N was also given!

${c2}	-s, --silent
${c1}		Only output license keys, no enumeration


${c2}[EXIT CODES]
${c1}	0 : Success
	1 : Argument 1 invalid: product type / help / version
	2 : Argument 2 invalid: N number of keys / debug
	3 : Too many arguments given
	4 : End of script!
		The script is set to exit 0 after completion of generation. If the script
		reaches the end (outside of main() function) the script will exit 2
		indicating an error has occured!


Inspiration:
https://medium.com/@dgurney/so-you-want-to-generate-license-keys-for-old-microsoft-products-a355c8bf5408
https://www.youtube.com/watch?v=3DCEeASKNDk

${c2}Disclaimer: This script was written for educational purposes only, and the author does not
encourage or endorse software piracy of any sort.
${c1}"
}


# Initialization:
ARG1=$1
ARG2=$2
ARG3=$3
ARG4=$4
c1=$(tput sgr0)
c2=$(tput bold)
main
printf "\nCongratulations, you have found an end-of-script error! Please report this to
<nick.bailuc@gmail.com> along with the version number, and the exact argument you used.\n" >&2
exit 3

#TODO: add validator
