EXP_NAME=$1
shift
cookiecutter . --no-input -f "$@" nombre="$EXP_NAME"
cd $EXP_NAME/ && ../../bin/cd++ -m top.ma -l logs -t 00:00:48:000:0