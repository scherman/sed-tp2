EXP_NAME=$1
shift
cookiecutter . --no-input -f "$@" nombre="$EXP_NAME"
cd $EXP_NAME/ && ../../src/bin/cd++ -m top.ma -l logs -t 00:10:00:000:0