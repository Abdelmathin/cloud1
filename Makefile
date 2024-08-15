include deployment/.env

NAME=cloud1

all: $(NAME)

$(NAME): ubuntu-container

clean:
	@echo "clean"

fclean: clean
	rm -rf tmp
	rm -rf deployment/.terraform
	rm -rf deployment/terraform.*
	rm -rf deployment/.terraform.*
	rm -rf deployment/.DS_Store
	rm -rf deployment/.vagrant

re: fclean all

vagrant:
	cd deployment && vagrant up

ubuntu-container:
	mkdir -p ${PWD}/tmp
	${sudo} docker run -it -v ${PWD}:/home/cloud1 -v ${PWD}/tmp:/tmp --env-file deployment/.env ubuntu:oracular bash -c "bash /home/cloud1/deployment/scripts/setup-ubuntu.sh && cd /home/cloud1/deployment && terraform init && terraform apply -auto-approve && exec bash"

.PHONY: clean