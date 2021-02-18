# Gitea SSH Passthrough

Easily enable SSH passthrough and restrict `git` user to `git-receive-pack` and `git-upload-pack`.

## Features

- Easy to setup
- Simple Restricted Git Shell (replacement for `git-shell`)

## Setup

```
$ sudo -u git bash -c 'wget -qO- https://raw.githubusercontent.com/hadi77ir/gitea-ssh-passthrough/main/setup-gitea-sshp.sh | bash'
```

## Notes

The setup script and passthrough scripts assume a few default configurations:

- Your container must have exposed its port 22 (SSH) over host's port 2222.

```
ports:
  - "22:2222"
```

- Your container must have this bound volume:

```
volumes:
  - /home/git/.ssh/:/data/git/.ssh
```

- Your container environment contains `git` user details in these fields:

```
environment:
  - USER_UID=1000
  - USER_GID=1000
```

- More notes can be found at [here](https://docs.gitea.io/en-us/install-with-docker/#ssh-container-passthrough).

- If there were problems with pull/push regarding `git-receive-pack` and `git-upload-pack`, permissions or ..., just run these administrative tasks:
  - "Resynchronize pre-receive, update and post-receive hooks of all repositories"
  - "Update the '.ssh/authorized_keys' file with Gitea SSH keys"
  - "Update the '.ssh/authorized_principals' file with Gitea SSH principals"

## License

MIT

## Credits

Restricted shell is a derivative of [https://stackoverflow.com/a/12993743](https://stackoverflow.com/a/12993743)
