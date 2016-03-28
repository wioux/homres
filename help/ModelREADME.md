#Installation
needs ruby-processing
`gem install ruby-processing`
which needs Processing which can be found [here](https://processing.org/download/).
then you need add a config file for the rp5 executable, this can be accomplished by running the code found [here](https://gist.github.com/monkstone/7438749), or just pasting the relevant path information to ~/.rp5rc

#Running the sim

Right now all of the parameters are hard coded and a bit spread out. So if you want to fuck with them, you have to look through the code yourself, but to run the existing setup it is just:

`rp5 run braindraw.rb`

