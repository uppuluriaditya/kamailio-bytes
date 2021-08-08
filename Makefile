build:
	docker build -t kamailio:latest .

run: build
	docker run -d --name kamailio1 kamailio:latest

remove:
	docker rm $$(docker ps -a -q | awk '{print $1}' | xargs)

clean: remove
	# ./docker-clean.sh

kill:
	## docker kill kamailio1
	docker kill $$(docker ps -q | awk '{print $1}' | xargs)

interactive: run
	docker exec -it kamailio1 bash
