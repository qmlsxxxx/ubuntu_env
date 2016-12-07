if [ ! $1 ]; then
    echo "\$1 is null"
    exit 0
fi
    CUR_PATH=`readlink -f $1 | sed 's/\/home\/realtek/Z:/' | sed 's/\//\\\\/g'`
echo $CUR_PATH
