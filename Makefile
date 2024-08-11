NAME=cloud1

all: $(NAME)

$(NAME):
	echo "$(NAME)"

clean:
	echo "clean"

fclean: clean
	rm -rf tmp

re: fclean all

ubuntu-docker-container:
	mkdir -p ${PWD}/tmp
	docker run -it -v ${PWD}:/home/cloud1 -it -v ${PWD}/tmp:/tmp ubuntu:oracular bash -c "bash /home/cloud1/deployment/scripts/setup.sh && exec bash"
