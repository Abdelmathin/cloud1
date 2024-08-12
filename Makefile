include deployment/.env

NAME=cloud1

all: $(NAME)

$(NAME): docker

clean:
	@echo "clean"

fclean: clean
	rm -rf tmp
	rm -rf deployment/.terraform
	rm -rf deployment/.terraform.*
	rm -rf deployment/terraform.*

re: fclean all

docker:
	mkdir -p ${PWD}/tmp
	docker run -it -v ${PWD}:/home/cloud1 -v ${PWD}/tmp:/tmp --env-file deployment/.env ubuntu:oracular bash -c "bash /home/cloud1/deployment/scripts/setup.sh && cd /home/cloud1 && cd deployment && terraform init && terraform apply && exec bash"

push-ahabachi:
	git add .
	git commit -m "auto-commit"
	git push origin ahabachi
