install:
	@mkdir -p build bin
	@make build-select-word
	@make build-remove-word
	@make build-select-line
	@make build-remove-line
	@rm -rf build

build-select-word:
	@echo 'building select word...'
	@stack ghc -- -o build/sw -odir build -hidir build SelectWord/SelectWord.hs
	@mv build/sw bin/sw
	@echo 'sw built'

build-remove-word:
	@echo 'building remove word...'
	@stack ghc -- -o build/rw -odir build -hidir build RemoveWord/RemoveWord.hs
	@mv build/rw bin/rw
	@echo 'rw built'

build-select-line:
	@echo 'building select line...'
	@stack ghc -- -o build/sl -odir build -hidir build SelectLine/SelectLine.hs
	@mv build/sl bin/sl
	@echo 'sl built'

build-remove-line:
	@echo 'building remove line...'
	@stack ghc -- -o build/rl -odir build -hidir build RemoveLine/RemoveLine.hs
	@mv build/rl bin/rl
	@echo 'rl built'
