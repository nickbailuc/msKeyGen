#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later
VERSION=0.60

license()
{ printf "${CB}$0 (Version $VERSION)${CN}
Copyright (C) 2020 Nick Bailuc, <nick.bailuc@gmail.com>

This program uses the \$RANDOM variable built into Bash in a sequence until it finds
appropriate license keys for various deprecated Microsoft products from the 1990s.
The same algorithms may also be used to check the validity of a licence key.
See $0 --help for more information.

	\"GNU General Public License version 3 or later\"\n
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.\n\n"
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
	KEY="$D$Y-OEM-0$a$b$c$d$e$f-$r1$r2$r3$r4$r5"
}


oem_debug()
{
	printf "${CB}Initialization complete!\n\n"
	# 3-digit day of year:
	printf "Determining 3-digit day of year:${CN}\n"
	D=$(( RANDOM % 366 + 1))
	printf "\tWorking with fragmentary 3-digit day of year $D\n\n${CN}"
	if (( D < 10))
	then
		printf "\tDay of year confirmed to be single-digit. Adding two zero's\n"
		D=00$D
	elif (( D < 100 ))
	then
		printf "\tDay of year confirmed to be double-digit. Adding one zero\n"
		D=0$D
	fi
	printf "${CB}\t3-digit day of year determined to be $D!\n\n"

	# 2-digit year:
	Y=$RANDOM
	printf "Determining 2-digit year:${CN}\n"
	while (( Y > 3 && Y < 95)) || (( Y > 99 ))
	do
		Y=$(( RANDOM % 100 ))
		printf "\tTrying $Y\n"
	done
	if (( Y < 4 ))
	then Y=0$Y
	fi
	printf "${CB}\t2-digit year determined to be $Y!\n\n"

	# 7-digit "divisible by 7" segment:
	printf "Initiating divisible by 7 segment:${CN}\n"
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
	printf "${CB}\n\t$((100000*a + 10000*b + 1000*c + 100*d + 10*e + f)) is divisible by 7!\n\n"

	# 5-digit "random" segment:
	printf "Determining 5-digit segment:${CN}\n"
	r1=$(( RANDOM % 10 ))
	r2=$(( RANDOM % 10 ))
	r3=$(( RANDOM % 10 ))
	r4=$(( RANDOM % 10 ))
	r5=$(( RANDOM % 10 ))
	printf "\tr1 = $r1\n\tr2 = $r2\n\tr3 = $r3\n\tr4 = $r4\n\tr5 = $r5\n"
	printf "${CB}\t5-digit segment determined to be $r1$r2$r3$r4$r5!\n\n"

	# Export Product Key:
	printf "${CB}Parsing variables and exporting to stdout:${CN}\n\n"
	printf "\033[4mWindows 95 / NT 4.0 Product ID:\t"
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
	a=0; b=0; c=0; d=0; e=0; f=0; g=1
	while (( (1000000*a + 100000*b + 10000*c + 1000*d + 100*e + 10*f + g) % 7 != 0 ))
	do
		a=$(( RANDOM % 10 ))
		b=$(( RANDOM % 10 ))
		c=$(( RANDOM % 10 ))
		d=$(( RANDOM % 10 ))
		e=$(( RANDOM % 10 ))
		f=$(( RANDOM % 10 ))
		g=$(( RANDOM % 7 + 1 ))
	done

	# Export CD Key:
	KEY="$S-$a$b$c$d$e$f$g"
}


cd_debug()
{
	printf "${CB}Initialization complete!\n\n"
	# 3-digit day of year:
	printf "Determining 3-digit segment:${CN}\n"
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
	printf "\t${CB}Fragmentary 3-digit segment is $S!\n${CN}"
	if (( S < 10))
	then
		printf "\t3-digit segment confirmed to be single-digit. Adding two zero's\n"
		S=00$S
	elif (( S < 100 ))
	then
		printf "\t3-digit segment confirmed to be double-digit. Adding one zero\n"
		S=0$S
	fi
	printf "${CB}\t3-digit segment determined to be $S!\n\n"

	# 7-digit "divisible by 7" segment:
	printf "Initiating divisible by 7 segment:${CN}\n"
	a=0; b=0; c=0; d=0; e=0; f=0; g=1
	while (( (1000000*a + 100000*b + 10000*c + 1000*d + 100*e + 10*f + g) % 7 != 0 ))
	do
		a=$(( RANDOM % 10 ))
		b=$(( RANDOM % 10 ))
		c=$(( RANDOM % 10 ))
		d=$(( RANDOM % 10 ))
		e=$(( RANDOM % 10 ))
		f=$(( RANDOM % 10 ))
		g=$(( RANDOM % 7 + 1 ))
		printf "\ta = $a\n\tb = $b\n\tc = $c\n\td = $d\n\te = $e\n\tf = $f\n"
		printf "\tLinear combination equals "
		printf "$(( 100000*$a + 10000*$b + 1000*$c + 100*$d + 10*$e + $f ))"
		if (( (1000000*a + 100000*b + 10000*c + 1000*d + 100*e + 10*f + g) % 7 != 0 ))
		then printf " which is not divisible by 7!\n\n"
		fi
	done
	printf "${CB}\n\t$((100000*a + 10000*b + 1000*c + 100*d + 10*e + f)) is divisible by 7!\n\n"


	# Export CD Key:
	printf "${CB}Parsing variables and exporting to stdout:${CN}\n\n"
	printf "\033[4mWindows 95 / NT 4.0 / Office 95 CD Key:\t"
	printf "$S-$a$b$c$d$e$f$g\033[0m\n\n"
}


validate_oem()
{
	echo TODO
}


check_oem()
{
	echo TODO
}


validate_cd()
{
	# Initialization:
	S1=1${ARG2:0:3}
	S1=$(( S1 % 1000 ))
	S2=1${ARG2:4:7}
	S2=$(( S2 % 10000000 ))
	g=$(( S2 % 10 ))

	# Format validation:
	if [[ $(expr length $ARG2) != 11 || ${ARG2:3:1} != "-" ]] ||
		! [ "$S1" -eq "$S1" ] || ! [ "$S2" -eq "$S2" ] 2> /dev/null
	then
		printf "Incorrect format!\n" >&2
		exit 4
	fi

	# Mathematical validation:
	if (( S1 == 333 || S1 == 444 || S1 == 555 || S1 == 666 || S1 == 777 || S1 == 888 || S1 == 999 ))
	then exitcode=1
	fi
	if (( S2 % 7 != 0 || g == 0 || g == 8 || g == 9 ))
	then exitcode=$(( exitcode + 2 ))
	fi

	# Output:
	if (( exitcode == 0 ))
	then toString
	else
		#Error handling:
		printf "This CD Key is invalid!" >&2
		if (( exitcode == 1 ))
		then
			printf " The $S1 part is not acceptable as the 3-digit segment!\n" >&2
			exit 5
		elif (( exitcode == 2 ))
		then
			printf " The $S2 part must be divisible by 7 and not end in 0, 8, or 9\n" >&2
			exit 5
		elif (( exitcode == 3 ))
		then
			printf " Both segments ($S1 and $S2) are incorrect!\n" >&2
			exit 5
		else
			printf "\n${CB}Validator: internal error! $REPORT${CN}" >&2
			exit 6
		fi
	fi
}


check_cd()
{
	# Initialization:
	S1=1${KEY:0:3}
	S1=$(( S1 % 1000 ))
	S2=1${KEY:4:7}
	S2=$(( S2 % 10000000 ))
	g=$(( S2 % 10 ))

	# Format validation:
	if [[ $(expr length $KEY) != 11 || ${KEY:3:1} != "-" ]] ||
		! [ "$S1" -eq "$S1" ] || ! [ "$S2" -eq "$S2" ] 2> /dev/null
	then
		printf "Incorrect format!\n" >&2
		echo $S1 $S2
		exit 4
	fi

	# Mathematical validation:
	if (( S1 == 333 || S1 == 444 || S1 == 555 || S1 == 666 || S1 == 777 || S1 == 888 || S1 == 999 ))
	then exitcode=1
	fi
	if (( S2 % 7 != 0 || g == 0 || g == 8 || g == 9 ))
	then exitcode=$(( exitcode + 2 ))
	fi

	# Output:
	if (( exitcode == 0 ))
	then printf "\t✓\n"
	else
		printf "\n${CB}Internal check algorithm failed! $REPORT${CN}" >&2
		exit 7
	fi
} # 	exit 7 : Internal check algorithm failed!


toString()
{
	if [[ $ARG1 == "oem" ]]
	then printf "Windows 95 / NT 4.0 OEM Product ID #$i:\t\t"
	elif [[ $ARG1 == "cd" ]]
	then printf "Windows 95 / NT 4.0 / Office 95 CD Key #$i:\t\t"
	elif [[ $ARG1 == "-v" || $ARG1 == "--validate" ]]
	then printf "This key is genuine!\n"
	fi
}


main()
{
	# Too many arguments validation:
	if [[ $ARG4 != "" ]]
	then
		printf "Too many arguments! Try:\n\t $0 --help\n" >&2
		exit 3
	# Argument 1 validation:
	elif [[ $ARG1 != "oem" && $ARG1 != "cd" && $ARG1 != "-h" && $ARG1 != "--help" &&
		$ARG1 != "-l" && $ARG1 != "--license" && $ARG1 != "-v" && $ARG1 != "--validate" ]]
	then
		usage
		exit 1
	elif [[ $ARG1 == "-h" || $ARG1 == "--help" ]]
	then
		help
		exit 0
	elif [[ $ARG1 == "-l" || $ARG1 == "--license" ]]
	then
		license
		exit 0
	elif [[ $ARG1 == "-v" || $ARG1 == "--validate" ]]
	then
		if [[ $ARG2 == *"OEM"* ]]
		then
			validate_oem
			exit 0
		else
			validate_cd
			exit 0
		fi

	# License key Generation:
	else
		# Debug mode:
		if [[ $ARG2 == "-d" || $ARG2 == "--debug" ]]
		then
			if [[ $ARG1 == "oem" ]]
			then oem_debug
			elif [[ $ARG1 == "cd" ]]
			then cd_debug
			else exit 2
			fi
			exit 0
		# Single key mode:
		elif [[ $ARG2 == "" ]]
		then
			i=1
			toString
			$ARG1
			printf "$KEY\n"
			exit 0
		elif (( ARG2 < 1 ))
		then
			printf "Invalid number-of-keys input! Try:\n\t $0 --help\n" >&2
			exit 2
		# Generate multiple keys:
		else
			if [[ $ARG3 == "-s" || $ARG3 == "--silent" ]]
			then
				i=1
				while (( i <= ARG2 ))
				do
					$ARG1
					printf "$KEY\n"
					i=$(( i + 1 ))
				done
			elif [[ $ARG3 == "-c" || $ARG3 == "--check" ]]
			then
				if [[ $ARG1 == "oem" ]]
				then
					i=1
					while (( i <= ARG2 ))
					do
						toString
						$ARG1
						printf $KEY
						check_oem
						i=$(( i + 1 ))
					done
				else
					i=1
					while (( i <= ARG2 ))
					do
						toString
						$ARG1
						printf $KEY
						check_cd
						i=$(( i + 1 ))
					done
				fi
			else
				i=1
				while (( i <= ARG2 ))
				do
					toString
					$ARG1
					printf "$KEY\n"
					i=$(( i + 1 ))
				done
			fi
			exit 0
		fi
	fi
}


help()
{
printf "\
${CB}$0 (Version $VERSION)${CN}
Copyright (C) 2020 Nick Bailuc, <nick.bailuc@gmail.com>
This is free software; see the source code for copying conditions.
There is ABSOLUTELY NO WARRANTY; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.

This program uses the \$RANDOM variable built into Bash in a sequence until it finds
appropriate license keys for various deprecated Microsoft products from the 1990s.
The same algorithms may also be used to check the validity of a licence key.


${CB}[SYNOPSIS]
	$0 ARG1 ARG2 ARG3

	Minimal Usage:
${CB}	$0 ARG1
	
	Examples:
	$0 cd${CN}
		Generate a single CD key

${CB}	$0 oem --debug
${CN}		Show the 4-algorithm step by step process of generating an OEM key

${CB}	$0 oem 2**5 --silent
${CN}		Calculate (2**5 = 32); generate 32 keys without enumeration

${CB}	$0 cd 5 --silent > keys.txt
${CN}		Generate 5 keys silently (only output the key).
		Then save the output in the file keys.txt


${CB}[ARG 1 PARAMETERS: TYPES OF KEYS]
	oem
${CN}		Generate Microsoft Windows 95 / NT 4.0 Product ID (OEM) Keys.

${CB}	cd
${CN}		Generate Microsoft Windows 95 / NT 4.0 / Office 95 CD Keys.

${CB}	-v, --validate
${CN}		Validate a CD/OEM key provided as an argument.

${CB}	-h, --help
${CN}		Show this help and exit 0.

${CB}	-l, --license
${CN}		Display license


${CB}[ARG 2 PARAMETER: NUMBER OF KEYS] (optional)
${CN}	This parameter may be omitted entirely, in which case only 1 key will be generated!

${CB}	N${CN} ∈ (1, 2**63-1)
		Enter any integer between 1 and 9223372036854775807 representing
		how many keys to be generated. A Bash integer calculation may also be entered!

${CB}	KEY${CN}
		If -v is used, you must enter an OEM or CD key to validate.

${CB}	-d, --debug
${CN}		Useful for develpers, or to learn how the program works


${CB}[ARG 3 PARAMETER: POWER TOOLS] (optional)
${CN}	This can only be used if an integer N was also given!

${CB}	-s, --silent
${CN}		Only output license keys, no enumeration

${CB}	-c, --check
${CN}		Uses internal validation algorithm to confirm the newly generated
		keys are valid. (Essentially the generate algorithms reverse-engineered).
		This process is certain to be slower, however can detect internal script errors.


${CB}[EXIT CODES]
${CN}	0 : Success
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
		reaches the end (outside of main() function) the script will exit 2
		indicating an error has occured!


Inspiration:
https://medium.com/@dgurney/so-you-want-to-generate-license-keys-for-old-microsoft-products-a355c8bf5408
https://www.youtube.com/watch?v=3DCEeASKNDk

${CB}Disclaimer: This script was written for educational purposes only, and the author does not
encourage or endorse software piracy of any sort.
${CN}"
}


usage()
{
printf "\
${CB}$0 (Version $VERSION)

SYNOPSIS:	$0 ARG1 ARG2 ARG3
Minimal Usage:${CB}	$0 ARG1

${CB}[ARG 1 PARAMETERS: TYPES OF KEYS]

	oem${CN}	Generate Microsoft Windows 95 / NT 4.0 Product ID (OEM) Keys.${CB}
	cd${CN}	Generate Microsoft Windows 95 / NT 4.0 / Office 95 CD Keys.${CB}
	-v, --validate	${CN}Validate a CD/OEM key provided as an argument.
${CB}	-h, --help	${CN}Show this help and exit 0.
${CB}	-l, --license	${CN}Display license

${CB}[ARG 2 PARAMETER: NUMBER OF KEYS] (optional)
${CN}	This parameter may be omitted entirely, in which case only 1 key will be generated!

${CB}	N${CN} ∈ (1, 2**63-1)
		Enter any integer between 1 and 9223372036854775807 representing
		how many keys to be generated. A Bash integer calculation may also be entered!

${CB}	KEY${CN}	If -v is used, you must enter an OEM or CD key to validate.

${CB}	-d, --debug${CN}	Useful for develpers, or to learn how the program works

${CB}[ARG 3 PARAMETER: POWER TOOLS] (optional)
${CN}	This can only be used if an integer N was also given!

${CB}	-s, --silent${CN}	Only output license keys, no enumeration
${CB}	-c, --check${CN}	Uses internal validation algorithm to confirm the newly generated keys are
			valid. (Essentially the algorithms reverse-engineered). This process
			is certain to be slower, however can detect internal script errors.

Try $0 --help for more information.\n"
}


REPORT="\nPlease report this to <nick.bailuc@gmail.com> along with
the version ($VERSION) and arguments ($1 $2 $3) used.\n"


# Initialization:
ARG1=$1
ARG2=$2
ARG3=$3
ARG4=$4
CN=$(tput sgr0)
CB=$(tput bold)
main

# End of script error:
printf "\nCongratulations, you have found an end-of-script error! $REPORT" >&2
exit 8
