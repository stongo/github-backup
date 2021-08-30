# github-backup-sh

*Simple shell script to backup all GitHub repos for specified organization*

Archives an organization's repositories. Runs "git clone --mirror" on all repos of an organization and tarballs in to one file.
You must [generate an oauth token](https://github.com/settings/applications#personal-access-tokens)

## Instructions to archive

```sh
export GITHUB_AUTH_TOKEN=enter_oauth_token_here
github-backup.sh <organization_name> <username for git clone>
```

Generates tgz archive of all GitHub repos.

### Use it without any installation

```sh
export GITHUB_AUTH_TOKEN=enter_oauth_token_here
curl "https://raw.github.com/andyet/github-backup-sh/master/github-backup.sh" | sh -s <username>
```

## Restoring

Create a new remote repository with nothing in it and then:

```sh
# extract archive to /tmp
tar -C /tmp -xf repo-2014-6-21.git.tgz

# clone project.git normally. /tmp/project.git is what gets extracted and is the output of the initial git clone --mirror
git clone /tmp/project.git

# change directory to the project
cd project

# change the remote url
git remote set-url origin https://new-remote.com/project.git

# push to new remote repository
git push origin master --tags
```
