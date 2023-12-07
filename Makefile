TARGET_PATH?=${HOME}

all:
	stow --restow --target=${TARGET_PATH} home --ignore='config'
	mkdir -p ${TARGET_PATH}/.config
	stow --restow --target=${TARGET_PATH}/.config --dir home config

clean:
	stow --delete --target=${TARGET_PATH}/ home
	stow --delete --target=${TARGET_PATH}/.config --dir home config
