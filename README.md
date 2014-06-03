# github-backup-sh

*Simple shell script to backup all GitHub repos for specified organization*

Archives an organization's repositories. Runs "git clone --mirror" on all repos of an organization and tarballs in to one file.
You must [generate an oauth token](https://github.com/settings/applications#personal-access-tokens)

## Instructions to archive

```sh
export GITHUB_AUTH_TOKEN=enter_oauth_token_here
github-backup.sh <organization_name>
```

Generates tgz archive of all GitHub repos.

### Use it without any installation

```sh
export GITHUB_AUTH_TOKEN=enter_oauth_token_here
curl "https://raw.github.com/andyet/github-backup-sh/master/github-backup.sh" | sh -s <username>
```

## Restoring

After unarchiving, clone a given repository and change the remote if desired:

```sh
git clone /path/to/project.git
cd project
git remote set-url origin https://new-remote.com/project.git
git push origin master --tags
```
