# invalidates the user's cached credentials for sudo
# (the next time sudo is run a password will be required)
# if the user has not typed any command for the last 3 minutes.

export TMOUT=180

TRAPALRM() {
	sudo -K
}

