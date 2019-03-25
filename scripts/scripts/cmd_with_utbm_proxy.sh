#!/bin/bash
export http_proxy=http://proxy.utbm.fr:3128
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export FTP_PROXY=$http_proxy
export RSYNC_PROXY=$http_proxy

export no_proxy="localhost, 127.0.0.0/8, ::1"
#export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
export NO_PROXY=$no_proxy

$@

