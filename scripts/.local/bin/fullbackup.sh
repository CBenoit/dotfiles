#!/bin/bash

function _rsync() {
	rsync -av --delete --stats --progress --modify-window=1 --delete-excluded $@
}

_rsync /data/media/* /run/media/auroden/BACKUP/media/
_rsync /data/dotfiles /data/cloud/* /data/sauvegardes /run/media/auroden/BACKUP/backup/

# _rsync /data/media/* /run/media/auroden/media
# _rsync /data/dotfiles /data/cloud/* /data/sauvegardes /run/media/auroden/backup

