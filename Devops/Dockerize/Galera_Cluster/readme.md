# Galera MySQL Cluster Setup using Docker on Ubuntu 14.04

Instructions:
1. If you are using Ubuntu as your host, install AppArmor utils
	Type: `apt-get install apparmor-utils`
2. Install Docker https://docs.docker.com/installation/
3. Create a Directory and download all files from this repo
4. Build the dockerimage
	`docker build -t galera_financeit1 .`
5. Run the first cluster node.
````
Example: IP of the host is 104.236.42.43

docker run -d -p 3306:3306 -p 4567:4567 -p 4444:4444 -p 4568:4568 --name nodeONE galera_financeit1:latest --wsrep-cluster-address=gcomm:// --wsrep-node-address=104.236.42.43

Notes:

To run another cluster node in a separate host (Example IP of the second node is 104.131.19.10 and the donor node is 104.236.42.43), do steps 1-4, then run:

docker run -d -p 3306:3306 -p 4567:4567 -p 4444:4444 -p 4568:4568 --name nodeTWO galera_financeit1:latest:latest --wsrep-cluster-address=gcomm://104.236.42.43 --wsrep-node-address=104.131.19.10

To run another cluster node in the same machine is nodeONE, run 
docker run --detach=true --name nodeTHREE -h nodeTHREE --link nodeONE:nodeONE galera_financeit1:latest  --wsrep-cluster-address=gcomm://nodeONE

Post Build Setup: 

On any of the hosts of the cluster nodes, go to the docker directory: 
1. cd init
2. chmod +x init.sh 
3. Edit the init.sh file and enter the db admin user password
4. run ./init.sh 
	NOTE: This will also set the root password of the cluster and will prompt you to enter the root password.
5. Check if the cluster is running: 
	#1 Login to one of the nodes : docker exec -i -t <container name> bash 
	#2 Login to MySQL as root using the password you configured in step 4. 
	#3 In the MySQL prompt, type:  Show status; (The cluster size should reflect the number of nodes in the cluster)
```