#!/bin/bash

tempo_coleta=5



# variaveis serao atualizadas automaticamente
data_hora=''
data_atual=''
hora_atual=''

# obtem o tempo no formato AAAA-MM-DD HH:MM:SS 
function get_data_hora()
{
    data_hora=`date --rfc-3339=seconds`
}

# separa a data
function get_data_atual()
{
    data_atual=`echo $data_hora | cut -d\  -f1`
}

# separa a hora
function get_hora_atual()
{
    hora_atual=`echo $data_hora | cut -d\  -f2 | awk 'BEGIN{FS="-"}{print $1}'`
}

function update_data_hora()
{
    get_data_hora
    get_data_atual
    get_hora_atual
}

function coleta_metricas()
{
    update_data_hora
    # coleta informacoes gerais de memoria
    mem=`free`
    mem_used=`echo -e "$mem" | grep Mem | awk '{print $3}'`
    mem_free=`echo -e "$mem" | grep Mem | awk '{print $4}'`
    reservado_cache_buffer=`echo -e "$mem" | grep Mem | awk '{print $6}'`
    mem_avaliable=`echo -e "$mem" | grep Mem | awk '{print $7}'`
    swap_used=`echo -e "$mem" | grep Swap | awk '{print $3}'`
    cached=`cat /proc/meminfo | grep -i Cached | sed -n '1p' | awk '{print $2}'`
    buffer=`cat /proc/meminfo | grep -i Buffers | awk '{print $2}'`

    # obtem o pid do processo do navegador
    pid=`ps -e | grep [f]irefox-esr | awk '{print $1}'` 

    dados=`pidstat -p $pid -d -h -u | grep firefox`

    cpu_percent=`echo -e $dados | awk '{print $8}'`
    cpu_em_uso=`echo -e $dados | awk '{print $9}'`

    kB_wr_s=`echo -e $dados | awk '{print $11}'`

    echo "$data_atual;$hora_atual;$cpu_em_uso;$cpu_percent;$kB_wr_s;$mem_used;$mem_free;$mem_avaliable;$swap_used;$reservado_cache_buffer;$cached;$buffer" >> log_dados.csv

}


echo "data;hora;cpu_em_uso;cpu_percent;kb_wr_s;mem_used;mem_free;mem_avaliable;swap_used;reservado_cache_buffer;cached;buffer" > log_dados.csv
count=0

while [ $count -lt 1080 ]
do
    coleta_metricas
    count=$(($count+1))
    sleep $tempo_coleta
done