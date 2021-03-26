SCRIPT="$0"
APP_NAME="DYNAMIC-EST"
FILE_RESIN_CONF=resinDynamicEST.conf

LANG=es_VE.ISO-8859-1
export LANG

## Descomentar y colocar la ruta del java a usar
JAVA_HOME={{java_home_5}}

#
# VALIDA QUE LA VARIABLE RESIN_HOME SE ENCUENTRE DEFINIDA
#
if [ -x "$RESIN_HOME/bin/httpd.sh" ]
then
    RESIN=$RESIN_HOME/bin/httpd.sh
else
    echo "variable RESIN_HOME no definida o no existe el archivo: bin/httpd.sh dentro de la variable RESIN_HOME..."
    exit 1
fi


#
# BUSCA EL PATH DONDE SE ENCUENTRA EL DIRECTORIO - INCLUSO SI FUERA UN LINK SIMBOLICO
#
while [ -h "$SCRIPT" ] ; do
  ls=`ls -ld "$SCRIPT"`
  # Drop everything prior to ->
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    SCRIPT="$link"
  else
    SCRIPT=`dirname "$SCRIPT"`/"$link"
  fi
done

# 
# ASIGNA EL PATH-HOME DE LA APLICACION
#
EUP_HOME=`dirname "$SCRIPT"`/..
# TOMA LA RUTA ADSOLUTA
EUP_HOME=`cd "$EUP_HOME"; pwd`

#
# TOMAMOS EL ARCHIVO RESIN-CONF DE LA APLICACION
#
RESIN_CONF=$EUP_HOME/conf/$FILE_RESIN_CONF

#
# ASIGNAMOS EL PATH DEL PID
#
PID_FILE=$EUP_HOME/conf/$APP_NAME-pid.txt

#
# CONSULTA EL PID
#
getPID(){
    PID=""
    if [ -f "$PID_FILE" ]
    then
        if [ -r "$PID_FILE" ]
        then
            PID=`cat "$PID_FILE"`
#Con la siguiente linea consultamos el proceso
            PID=`ps -e |grep "$PID"`
        else
            echo "Cannot read $PID_FILE."
            exit 1
        fi
    fi
}

#
# INICIA LA APLICACION
#
start(){
    getPID

    if [ "X$PID" = "X" ]
    then
        $RESIN -conf $RESIN_CONF -pid $PID_FILE -Dinstance=$APP_NAME -J-Xmx1024m -J-Xms1024m -J-Xss512k -J-XX:+UseParNewGC -J-XX:+UseConcMarkSweepGC -J-XX:CMSInitiatingOccupancyFraction=75 -J-XX:+UseCMSInitiatingOccupancyOnly -J-XX:+HeapDumpOnOutOfMemoryError -J-server -start
    else
        echo "La aplicacion $APP_NAME esta ejecutandose con PID:$PID"   
        if [ "X$1" = "X1" ]
        then
            exit 1
        fi
    fi
}

#
# DETIENE LA APLICACION
#
stop(){
    getPID

    if [ "X$PID" = "X" ]
    then
        echo "La aplicacion $APP_NAME NO esta ejecutandose."
        if [ "X$1" = "X1" ]
        then
            exit 1
        fi
    else
        $RESIN  -pid $PID_FILE -J-server -stop
    fi
}

#
# VERIFICA Y RETORNA EL ESTATUS DE LA APLICACION
#
status(){
    getPID

    if [ "X$PID" = "X" ]
    then
        echo "La aplicacion $APP_NAME NO esta ejecutandose."       
    else
        echo "La aplicacion $APP_NAME esta ejecutandose con PID:$PID"
    fi
    if [ "X$1" = "X1" ]
    then
        exit 1
    fi
}

commandUse(){
    echo "Comandos a usar"
    echo "---------------------------------------"
    echo "start: Inicia la aplicacion"
    echo "stop: Detiene la aplicacion"
    echo "status: Da un estatus de la aplicacion"
    echo "restart: Reinica la aplicacion"
}

case "$1" in
    'start')
        echo "$APP_NAME Iniciando..."
        start "1"
    ;;
    'stop')
        echo "$APP_NAME Deteniendo..."
        stop "1"
    ;;
    'restart')
        echo "$APP_NAME Deteniendo..."
        stop "0"
        echo "$APP_NAME Iniciando..."
        start "1"
    ;;
    'status')
        status "0"
    ;;
    *)
        commandUse
    ;;
esac

exit 0 
