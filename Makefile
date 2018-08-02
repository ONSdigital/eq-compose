REPOS="eq-survey-runner" "go-launch-a-survey" "eq-census-schemas" "eq-deploy" "eq-docker-dynamodb" "eq-publisher" "eq-schema-validator" "eq-smoke-tests" "eq-survey-register" "eq-terraform" "eq-terraform-dynamodb" "eq-translations"


NO_COLOR=\033[0m
YELLOW=\033[33;22m

all: full check-env update pull start

full:
	@ printf "\n[${YELLOW} Running full build. Please be patient this may take awhile! ${NO_COLOR}]\n"

check-env:
ifndef EQ_HOME
	$(error EQ_HOME environment variable is not set.)
endif
	@ printf "\n[${YELLOW} EQ_HOME set to ${EQ_HOME} ${NO_COLOR}]\n"

update: check-env
	@ printf "\n[${YELLOW} Updating/Cloning repos in ${EQ_HOME} ${NO_COLOR}]\n"
	@ for r in ${REPOS}; do \
		echo "(${PREFIX}$${r})"; \
		if [ ! -e ${EQ_HOME}/${PREFIX}$${r} ]; then \
			git clone git@github.com:ONSdigital/${PREFIX}$${r}.git ${EQ_HOME}/${PREFIX}$${r}; \
		else \
			cd ${EQ_HOME}/${PREFIX}$${r}; \
			echo "On branch [`git symbolic-ref --short HEAD`], updating repo..."; \
			git pull; \
			cd; \
		fi; \
		echo ""; \
	done

pull:
	@ printf "\n[ ${YELLOW}Pulling eq docker images ${NO_COLOR}]\n"
	docker-compose -f eq.yml pull

start:
	@ printf "\n[ ${YELLOW}Starting docker images ${NO_COLOR}]\n"
	docker-compose -f eq.yml up

down:
	@ printf "\n[ ${YELLOW}Removing eq docker images ${NO_COLOR}]\n"
	docker-compose -f eq.yml down
