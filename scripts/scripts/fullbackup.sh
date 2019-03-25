#!/bin/bash
rsync -av --delete /data/media/* /run/media/auroden/media
rsync -av --delete /data/dotfiles /data/cloud/* /data/sauvegardes /run/media/auroden/backup

