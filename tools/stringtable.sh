
where="$1"
module="$2"
doColor="always"
arma3root="/cygdrive/e/Program Files/games/Steam/steamapps/common/Arma 3"
cba3root="/cygdrive/e/Program Files/games/Steam/steamapps/workshop/content/107410/450814997"

if [[ -z "$where" ]]; then
	echo "Error: missing 1st positional argument \"where\" (Possible values: \"local\", \"external\")!"
	exit 1
fi
if [[ -z "$module" ]]; then
	echo "Error: missing 2nd positional argument "where" (Possible values: \"find\")!"
	exit 1
fi

function search {
	root="$1"
	file="$2"
	query="$3"
	options="$4"
	if [[ -z "$query" ]]; then
		echo "Error: missing 3rd positional argument \"query\"!"
		exit 1
	fi
	eval "find \"$root\" $options -type f -name \"$file\" -exec grep -Pai -B24 --color=$doColor \">$query<\" {} +"
}

case $where in
	local)
		
		case $module in
			find)
				search "../.." "language*.pbo" "$3" ""
				# find ../.. -type f -name "language*.pbo" -exec grep -Pa -B24 --color=$doColor ">$query<" {} +
			;;
			*)
				echo "Error: invalid value for 2nd positional argument \"where\" (Possible values: \"find\")!"
				exit 1
			;;
		esac
		;;
	external)
		case $module in
			find)
				search "$arma3root" "language*.pbo" "$3" "-type d \( -name \"@*\" -o -name \"Dta\" \) -prune -o"				
				search "$cba3root" "*.pbo" "$3" ""				
				# find "$arma3root" -type d \( -name "@*" -o -name "Dta" \) -prune -o -type f -name "language*.pbo" -exec grep -Pa -B24 --color=$doColor ">$query<" {} +
				# find "$cba3root" -type f -name "*.pbo" -exec grep -Pa -B24 --color=$doColor ">$query<" {} +
			;;
			*)
				echo "Error: invalid value for 2nd positional argument \"where\" (Possible values: \"find\")!"
				exit 1
			;;
		esac
		;;
	*)
		echo "Error: invalid value for 1st positional argument \"where\" (Possible values: \"local\", \"external\")!"
		;;
esac

