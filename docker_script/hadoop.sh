#!/bin/sh
echo "Script is runing..."
echo "Script: service docker start"
sudo service docker start
echo "Script: network building..."
sudo docker network create --driver=bridge hadoopNetwork
sudo docker network ls | grep hadoopNetwork
echo "Script: docker image pulling..."
docker pull registry.cn-hangzhou.aliyuncs.com/personalhub/hadoop:v0.1
sudo docker images | grep ba416c95f965
echo "Script: Containers building..."
sudo docker run -itd --network hadoopNetwork -h "h01" --name "h01" -p 9870:9870 -p 8088:8088   ba416c95f965
sudo docker run -itd --network hadoopNetwork -h "h02" --name "h02"                                                ba416c95f965
sudo docker run -itd --network hadoopNetwork -h "h03" --name "h03"                                                ba416c95f965
sudo docker run -itd --network hadoopNetwork -h "h04" --name "h04"                                                ba416c95f965
sudo docker run -itd --network hadoopNetwork -h "h05" --name "h05"                                                ba416c95f965
sudo docker exec -it h01 /bin/bash -c "
    cd /usr/local/hadoop/bin
    ./hadoop namenode -format
    cd /usr/local/hadoop/sbin/
    echo \"Script: Hadoop runing...\"
    ./start-all.sh
    cd /usr/local/hadoop/bin
    ./hadoop dfsadmin -report
    read -s -n1 -p \"push anykey to continue... \"
    exit
"
echo " "
echo "Script:"
echo "
        Nerd
              Help Homework
"
echo "Script: Script end"

