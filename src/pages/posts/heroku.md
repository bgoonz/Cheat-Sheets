---
title: Heroku Cheat Sheet
subtitle: HEROKU TOOLBELT COMPLETE GUIDE
date: '2022-01-04'
thumb_img_alt: lorem-ipsum
content_img_alt: lorem-ipsum
excerpt: lorem-ipsum
seo:
  title: ''
  description: ''
  robots: []
  extra: []
template: post
---




# Heroku Cheat Sheet:




# Installing Heroku toolbelt using command line

# For MacOS...
brew tap heroku/brew && brew install heroku

# For Ubuntu...
sudo snap install --classic heroku

# Other installation methods are

curl https://cli-assets.heroku.com/install.sh | sh     # only for unix based systems, windows incompatible as it needs sudo

curl https://cli-assets.heroku.com/install-ubuntu.sh | sh    # Ubuntu/Debian apt-get

yay -S heroku-cli     # Arch linux, Note: This package is community maintained not by heroku

npm install -g heroku     # This installation method is required for users on ARM and BSD...


############

# Verifying your installation

heroku --version


# Let's get started with heroku

heroku login      # To login into the heroku toolbelt with your heroku account, this will open browser for you.

heroku login -i   # If you prefer to stay in the command line environment, then you can execute this command


# Now navigate to your desired directory and create a blank heroku application

cd ~/myapp
heorku create


# If you are facing login issues, try to execute the following command

mv ~/.netrc ~/.netrc.backup
heroku login


# Uninstalling the heroku CLI

# For macOS
rm -rf /usr/local/heroku /usr/local/lib/heroku /usr/local/bin/heroku ~/.local/share/heroku ~/Library/Caches/heroku

# or you can try the below command also on macOS
brew uninstall heroku
rm -rf ~/.local/share/heroku ~/Library/Caches/heroku

# For Linux (Standalone installs)
rm /usr/local/bin/heroku
rm -rf /usr/local/lib/heroku /usr/local/heroku
rm -rf ~/.local/share/heroku ~/.cache/heroku

# For Linux (Debian and Ubuntu installs)
sudo apt-get remove heroku heroku-toolbelt
sudo rm /etc/apt/sources.list.d/heroku.list


---



### Managing and deploying applications on Heroku (Using Git)     

cd myapp                           # Changing into the project directory
git init 						   # Initializing the project into a git repository
git add .                          # Adding all the contents of the project into the repository excluding .gitignore content
git commit -m "My first commit"    # Commiting the content to the repository

heroku create                      # Creating a new empty application on Heroku
git remote -v                      # verifying that the remote is set to the heroku

heroku git:remote -a thawing-inlet-61413      # For an existing heroku app, you can add remote to the application
git remote rename heroku heroku-staging       # renaming remotes

git push heroku master             # Deploying code to the heroku application
git push heroku testbranch:master  # Deploying code from a non-master branch to the heroku application

heroku create --ssh-git            # ssh git transport for the application instead of https
git config --global url.ssh://git@heroku.com/.insteadOf https://git.heroku.com/     # For using ssh always
git config --global --remove-section url.ssh://git@heroku.com/       # To remove this rewrite setting run the command





### Managing and deploying applications on Heroku (Using Docker)     ###################################


# Setting stack of your app to a Container
heroku stack:set container

heroku container:login            # Login to the container resistry
git clone https://github.com/heroku/alpinehelloworld.git       # Get sample code by cloning into the following repository
heroku create                     # Creating a blank heroku application

heroku container:push web         # Build the image and push to Container Registry
heroku container:push --recursive     # Pushing from the root directory of the project in recursive manner
heroku container:push web worker --recursive     # Building the image and pushing to container resistry in recursive manner
heroku container:release web      # Releasing the image to your application

heroku open                       # Open the application in the browser


---
---


# Docs:

## Commands:



```
USAGE
  $ heroku access

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               output in json format
```

### [heroku access:add EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-access-add-email)

add new users to your app

```
USAGE
  $ heroku access:add EMAIL

OPTIONS
  -a, --app=app                  (required) app to run command against
  -p, --permissions=permissions  list of permissions comma separated
  -r, --remote=remote            git remote of app to use

EXAMPLES
  $ heroku access:add user@email.com --app APP # add a collaborator to your app
  $ heroku access:add user@email.com --app APP --permissions
  deploy,manage,operate # permissions must be comma separated
```

### [heroku access:remove EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-access-remove-email)

remove users from a team app

```
USAGE
  $ heroku access:remove EMAIL

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLES
  $ heroku access:remove user@email.com --app APP
```

### [heroku access:update EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-access-update-email)

update existing collaborators on an team app

```
USAGE
  $ heroku access:update EMAIL

OPTIONS
  -a, --app=app                  (required) app to run command against

  -p, --permissions=permissions  comma-delimited list of permissions to update
                                 (deploy,manage,operate)

  -r, --remote=remote            git remote of app to use

EXAMPLES
  $ heroku access:update user@email.com --app APP --permissions
  deploy,manage,operate
```

### [heroku addons \[--all|--app APP\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-all-app-app)

lists your add-ons and attachments

```
USAGE
  $ heroku addons [--all|--app APP]

OPTIONS
  -A, --all            show add-ons and attachments for all accessible apps
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --json               return add-ons in json format

DESCRIPTION
  The default filter applied depends on whether you are in a Heroku app
  directory. If so, the --app flag is implied. If not, the default of --all
  is implied. Explicitly providing either flag overrides the default
  behavior.

EXAMPLES
  $ heroku addons --all
  $ heroku addons --app acme-inc-www
```

### [heroku addons:attach ADDON\_NAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-attach-addon_name)

attach an existing add-on resource to an app

```
USAGE
  $ heroku addons:attach ADDON_NAME

OPTIONS
  -a, --app=app            (required) app to run command against
  -r, --remote=remote      git remote of app to use
  --as=as                  name for add-on attachment
  --confirm=confirm        overwrite existing add-on attachment with same name
  --credential=credential  credential name for scoped access to Heroku Postgres
```

### [heroku addons:create SERVICE:PLAN](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-create-service-plan)

create a new add-on resource

```
USAGE
  $ heroku addons:create SERVICE:PLAN

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --as=as              name for the initial add-on attachment

  --confirm=confirm    overwrite existing config vars or existing add-on
                       attachments

  --name=name          name for the add-on resource

  --wait               watch add-on creation status and exit when complete
```

### [heroku addons:destroy \[ADDON\]... \[flags\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-destroy-addon-flags)

permanently destroy an add-on resource

```
USAGE
  $ heroku addons:destroy [ADDON]... [flags]

OPTIONS
  -a, --app=app          app to run command against
  -c, --confirm=confirm
  -f, --force            allow destruction even if connected to other apps
  -r, --remote=remote    git remote of app to use
```

### [heroku addons:detach ATTACHMENT\_NAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-detach-attachment_name)

detach an existing add-on resource from an app

```
USAGE
  $ heroku addons:detach ATTACHMENT_NAME

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku addons:docs ADDON](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-docs-addon)

open an add-on's Dev Center documentation in your browser

```
USAGE
  $ heroku addons:docs ADDON

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --show-url           show URL, do not open browser
```

### [heroku addons:downgrade ADDON \[PLAN\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-downgrade-addon-plan)

change add-on plan

```
USAGE
  $ heroku addons:downgrade ADDON [PLAN]

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  See available plans with `heroku addons:plans SERVICE`.

  Note that `heroku addons:upgrade` and `heroku addons:downgrade` are the same.
  Either one can be used to change an add-on plan up or down.

  https://devcenter.heroku.com/articles/managing-add-ons

EXAMPLE
  Upgrade an add-on by service name:
  $ heroku addons:upgrade heroku-redis:premium-2

  Upgrade a specific add-on:
  $ heroku addons:upgrade swimming-briskly-123 heroku-redis:premium-2
```

### [heroku addons:info ADDON](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-info-addon)

show detailed add-on resource and attachment information

```
USAGE
  $ heroku addons:info ADDON

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku addons:open ADDON](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-open-addon)

open an add-on's dashboard in your browser

```
USAGE
  $ heroku addons:open ADDON

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --show-url           show URL, do not open browser
```

### [heroku addons:plans SERVICE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-plans-service)

list all available plans for an add-on services

```
USAGE
  $ heroku addons:plans SERVICE

OPTIONS
  --json  output in json format
```

### [heroku addons:rename ADDON NEW\_NAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-rename-addon-new_name)

rename an add-on

```
USAGE
  $ heroku addons:rename ADDON NEW_NAME

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku addons:services](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-services)

list all available add-on services

```
USAGE
  $ heroku addons:services

OPTIONS
  --json  output in json format
```

### [heroku addons:upgrade ADDON \[PLAN\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-upgrade-addon-plan)

change add-on plan

```
USAGE
  $ heroku addons:upgrade ADDON [PLAN]

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  See available plans with `heroku addons:plans SERVICE`.

  Note that `heroku addons:upgrade` and `heroku addons:downgrade` are the same.
  Either one can be used to change an add-on plan up or down.

  https://devcenter.heroku.com/articles/managing-add-ons

EXAMPLE
  Upgrade an add-on by service name:
  $ heroku addons:upgrade heroku-redis:premium-2

  Upgrade a specific add-on:
  $ heroku addons:upgrade swimming-briskly-123 heroku-redis:premium-2
```

### [heroku addons:wait ADDON](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-addons-wait-addon)

show provisioning status of the add-ons on the app

```
USAGE
  $ heroku addons:wait ADDON

OPTIONS
  -a, --app=app                  app to run command against
  -r, --remote=remote            git remote of app to use
  --wait-interval=wait-interval  how frequently to poll in seconds
```

### [heroku apps](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps)

list your apps

```
USAGE
  $ heroku apps

OPTIONS
  -A, --all          include apps in all teams
  -p, --personal     list apps in personal account when a default team is set
  -s, --space=space  filter by space
  -t, --team=team    team to use
  --json             output in json format

EXAMPLES
  $ heroku apps
  === My Apps
  example
  example2

  === Collaborated Apps
  theirapp   other@owner.name
```

### [heroku apps:create \[APP\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-create-app)

creates a new app

```
USAGE
  $ heroku apps:create [APP]

ARGUMENTS
  APP  name of app to create

OPTIONS
  -b, --buildpack=buildpack  buildpack url to use for this app
  -n, --no-remote            do not create a git remote
  -r, --remote=remote        the git remote to create, default "heroku"
  -s, --stack=stack          the stack to create the app on
  -t, --team=team            team to use
  --addons=addons            comma-delimited list of addons to install
  --json                     output in json format
  --region=region            specify region for the app to run in
  --space=space              the private space to create the app in
  --ssh-git                  use SSH git protocol for local git remote

EXAMPLES
  $ heroku apps:create
  Creating app... done, stack is heroku-20
  https://floating-dragon-42.heroku.com/ |
  https://git.heroku.com/floating-dragon-42.git

  # or just
  $ heroku create

  # use a heroku.yml manifest file
  $ heroku apps:create --manifest

  # specify a buildpack
  $ heroku apps:create --buildpack https://github.com/some/buildpack.git

  # specify a name
  $ heroku apps:create example

  # create a staging app
  $ heroku apps:create example-staging --remote staging

  # create an app in the eu region
  $ heroku apps:create --region eu
```

### [heroku apps:destroy](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-destroy)

permanently destroy an app

```
USAGE
  $ heroku apps:destroy

OPTIONS
  -a, --app=app          app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use

DESCRIPTION
  This will also destroy all add-ons on the app.
```

### [heroku apps:errors](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-errors)

view app errors

```
USAGE
  $ heroku apps:errors

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --dyno               show only dyno errors
  --hours=hours        number of hours to look back (default 24)
  --json               output in json format
  --router             show only router errors
```

### [heroku apps:favorites](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-favorites)

list favorited apps

```
USAGE
  $ heroku apps:favorites

OPTIONS
  --json  output in json format
```

### [heroku apps:favorites:add](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-favorites-add)

favorites an app

```
USAGE
  $ heroku apps:favorites:add

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:favorites:remove](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-favorites-remove)

unfavorites an app

```
USAGE
  $ heroku apps:favorites:remove

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:info](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-info)

show detailed app information

```
USAGE
  $ heroku apps:info

OPTIONS
  -a, --app=app        app to run command against
  -j, --json
  -r, --remote=remote  git remote of app to use
  -s, --shell          output more shell friendly key/value pairs

DESCRIPTION
  $ heroku apps:info
  === example
  Git URL:   https://git.heroku.com/example.git
  Repo Size: 5M
  ...

  $ heroku apps:info --shell
  git_url=https://git.heroku.com/example.git
  repo_size=5000000
  ...
```

### [heroku apps:join](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-join)

add yourself to a team app

```
USAGE
  $ heroku apps:join

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:leave](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-leave)

remove yourself from a team app

```
USAGE
  $ heroku apps:leave

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:lock](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-lock)

prevent team members from joining an app

```
USAGE
  $ heroku apps:lock

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:open \[PATH\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-open-path)

open the app in a web browser

```
USAGE
  $ heroku apps:open [PATH]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLES
  $ heroku open -a myapp
  # opens https://myapp.herokuapp.com

  $ heroku open -a myapp /foo
  # opens https://myapp.herokuapp.com/foo
```

### [heroku apps:rename NEWNAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-rename-newname)

rename an app

```
USAGE
  $ heroku apps:rename NEWNAME

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --ssh-git            use ssh git protocol instead of https

DESCRIPTION
  This will locally update the git remote if it is set to the old app.

EXAMPLES
  $ heroku apps:rename --app oldname newname
  https://newname.herokuapp.com/ | https://git.heroku.com/newname.git
  Git remote heroku updated
```

### [heroku apps:stacks](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-stacks)

show the list of available stacks

```
USAGE
  $ heroku apps:stacks

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku apps:stacks:set STACK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-stacks-set-stack)

set the stack of an app

```
USAGE
  $ heroku apps:stacks:set STACK

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLES
  $ heroku stack:set heroku-20 -a myapp
  Setting stack to heroku-20... done
  You will need to redeploy myapp for the change to take effect.
  Run git push heroku main to trigger a new build on myapp.
```

### [heroku apps:transfer RECIPIENT](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-transfer-recipient)

transfer applications to another user or team

```
USAGE
  $ heroku apps:transfer RECIPIENT

ARGUMENTS
  RECIPIENT  user or team to transfer applications to

OPTIONS
  -a, --app=app        app to run command against
  -l, --locked         lock the app upon transfer
  -r, --remote=remote  git remote of app to use
  --bulk               transfer applications in bulk

EXAMPLES
  $ heroku apps:transfer collaborator@example.com
  Transferring example to collaborator@example.com... done

  $ heroku apps:transfer acme-widgets
  Transferring example to acme-widgets... done

  $ heroku apps:transfer --bulk acme-widgets
  ...
```

### [heroku apps:unlock](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-apps-unlock)

unlock an app so any team member can join

```
USAGE
  $ heroku apps:unlock

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku auth:2fa](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-2fa)

check MFA status (previously known as 2FA status)

```
USAGE
  $ heroku auth:2fa

ALIASES
  $ heroku 2fa
  $ heroku twofactor
```

### [heroku auth:2fa:disable DEPRECATED](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-2fa-disable-deprecated)

disables 2fa on account - DEPRECATED. Log in to Heroku Dashboard for managing MFA (previously known as 2FA) settings.

```
USAGE
  $ heroku auth:2fa:disable

ALIASES
  $ heroku twofactor:disable
  $ heroku 2fa:disable

EXAMPLES
  $ heroku auth:2fa:disable
```

### [heroku auth:login](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-login)

login with your Heroku credentials

```
USAGE
  $ heroku auth:login

OPTIONS
  -e, --expires-in=expires-in  duration of token in seconds (default 1 year)
  -i, --interactive            login with username/password

  --browser=browser            browser to open SSO with (example: "firefox",
                               "safari")

ALIASES
  $ heroku login
```

### [heroku auth:logout](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-logout)

clears local login credentials and invalidates API session

```
USAGE
  $ heroku auth:logout

ALIASES
  $ heroku logout
```

### [heroku auth:token](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-token)

outputs current CLI authentication token.

```
USAGE
  $ heroku auth:token

OPTIONS
  -h, --help  show CLI help

DESCRIPTION
  By default, the CLI auth token is only valid for 1 year. To generate a
  long-lived token, use heroku authorizations:create
```

### [heroku auth:whoami](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-auth-whoami)

display the current logged in user

```
USAGE
  $ heroku auth:whoami

ALIASES
  $ heroku whoami
```

list OAuth authorizations

```
USAGE
  $ heroku authorizations

OPTIONS
  -j, --json  output in json format
```

### [heroku authorizations:create](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-authorizations-create)

create a new OAuth authorization

```
USAGE
  $ heroku authorizations:create

OPTIONS
  -S, --short                    only output token
  -d, --description=description  set a custom authorization description

  -e, --expires-in=expires-in    set expiration in seconds (default no
                                 expiration)

  -j, --json                     output in json format

  -s, --scope=scope              set custom OAuth scopes

DESCRIPTION
  This creates an authorization with access to your Heroku account.
```

### [heroku authorizations:info ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-authorizations-info-id)

show an existing OAuth authorization

```
USAGE
  $ heroku authorizations:info ID

OPTIONS
  -j, --json  output in json format
```

### [heroku authorizations:revoke ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-authorizations-revoke-id)

revoke OAuth authorization

```
USAGE
  $ heroku authorizations:revoke ID

ALIASES
  $ heroku authorizations:destroy
```

### [heroku authorizations:rotate ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-authorizations-rotate-id)

updates an OAuth authorization token

```
USAGE
  $ heroku authorizations:rotate ID
```

### [heroku authorizations:update ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-authorizations-update-id)

updates an OAuth authorization

```
USAGE
  $ heroku authorizations:update ID

OPTIONS
  -d, --description=description  set a custom authorization description
  --client-id=client-id          identifier of OAuth client to set
  --client-secret=client-secret  secret of OAuth client to set
```

### [heroku autocomplete \[SHELL\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-autocomplete-shell)

display autocomplete installation instructions

```
USAGE
  $ heroku autocomplete [SHELL]

ARGUMENTS
  SHELL  shell type

OPTIONS
  -r, --refresh-cache  refresh cache only (ignores displaying instructions)

EXAMPLES
  $ heroku autocomplete
  $ heroku autocomplete bash
  $ heroku autocomplete zsh
  $ heroku autocomplete --refresh-cache
```

### [heroku buildpacks](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks)

display the buildpacks for an app

```
USAGE
  $ heroku buildpacks

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku buildpacks:add BUILDPACK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-add-buildpack)

add new app buildpack, inserting into list of buildpacks if necessary

```
USAGE
  $ heroku buildpacks:add BUILDPACK

ARGUMENTS
  BUILDPACK  namespace/name of the buildpack

OPTIONS
  -a, --app=app        (required) app to run command against
  -i, --index=index    the 1-based index of the URL in the list of URLs
  -r, --remote=remote  git remote of app to use
```

### [heroku buildpacks:clear](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-clear)

clear all buildpacks set on the app

```
USAGE
  $ heroku buildpacks:clear

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku buildpacks:info BUILDPACK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-info-buildpack)

fetch info about a buildpack

```
USAGE
  $ heroku buildpacks:info BUILDPACK

ARGUMENTS
  BUILDPACK  namespace/name of the buildpack
```

### [heroku buildpacks:remove \[BUILDPACK\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-remove-buildpack)

remove a buildpack set on the app

```
USAGE
  $ heroku buildpacks:remove [BUILDPACK]

ARGUMENTS
  BUILDPACK  namespace/name of the buildpack

OPTIONS
  -a, --app=app        (required) app to run command against

  -i, --index=index    the 1-based index of the URL to remove from the list of
                       URLs

  -r, --remote=remote  git remote of app to use
```

### [heroku buildpacks:search \[TERM\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-search-term)

search for buildpacks

```
USAGE
  $ heroku buildpacks:search [TERM]

ARGUMENTS
  TERM  search term that searches across name, namespace, and description

OPTIONS
  --description=description  buildpack description to filter on

  --name=name                buildpack names to filter on using a comma
                             separated list

  --namespace=namespace      buildpack namespaces to filter on using a comma
                             separated list
```

### [heroku buildpacks:set BUILDPACK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-set-buildpack)

```
USAGE
  $ heroku buildpacks:set BUILDPACK

ARGUMENTS
  BUILDPACK  namespace/name of the buildpack

OPTIONS
  -a, --app=app        (required) app to run command against
  -i, --index=index    the 1-based index of the URL in the list of URLs
  -r, --remote=remote  git remote of app to use
```

### [heroku buildpacks:versions BUILDPACK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-buildpacks-versions-buildpack)

list versions of a buildpack

```
USAGE
  $ heroku buildpacks:versions BUILDPACK

ARGUMENTS
  BUILDPACK  namespace/name of the buildpack
```

### [heroku certs](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs)

list SSL certificates for an app

```
USAGE
  $ heroku certs

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:add CRT KEY](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-add-crt-key)

add an SSL certificate to an app

```
USAGE
  $ heroku certs:add CRT KEY

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --bypass             bypass the trust chain completion step
  --domains=domains    domains to create after certificate upload
  --type=type          type to create, either 'sni' or 'endpoint'

DESCRIPTION
  Note: certificates with PEM encoding are also valid

EXAMPLES
  $ heroku certs:add example.com.crt example.com.key

  Certificate Intermediary:
  $ heroku certs:add intermediary.crt example.com.crt example.com.key
```

### [heroku certs:auto](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-auto)

show ACM status for an app

```
USAGE
  $ heroku certs:auto

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:auto:disable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-auto-disable)

disable ACM for an app

```
USAGE
  $ heroku certs:auto:disable

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:auto:enable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-auto-enable)

enable ACM status for an app

```
USAGE
  $ heroku certs:auto:enable

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:auto:refresh](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-auto-refresh)

refresh ACM for an app

```
USAGE
  $ heroku certs:auto:refresh

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:chain](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-chain)

print an ordered & complete chain for a certificate

```
USAGE
  $ heroku certs:chain

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku certs:generate DOMAIN](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-generate-domain)

generate a key and a CSR or self-signed certificate

```
USAGE
  $ heroku certs:generate DOMAIN

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --area=area          sub-country area (state, province, etc.) of owner
  --city=city          city of owner
  --country=country    country of owner, as a two-letter ISO country code
  --keysize=keysize    RSA key size in bits (default: 2048)
  --now                do not prompt for any owner information
  --owner=owner        name of organization certificate belongs to
  --selfsigned         generate a self-signed certificate instead of a CSR
  --subject=subject    specify entire certificate subject

DESCRIPTION
  Generate a key and certificate signing request (or self-signed certificate)
  for an app. Prompts for information to put in the certificate unless --now
  is used, or at least one of the --subject, --owner, --country, --area, or
  --city options is specified.

EXAMPLES
  $ heroku certs:generate example.com
```

### [heroku certs:info](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-info)

show certificate information for an SSL certificate

```
USAGE
  $ heroku certs:info

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --endpoint=endpoint  endpoint to check info on
  --name=name          name to check info on
  --show-domains       show associated domains
```

### [heroku certs:key](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-key)

print the correct key for the given certificate

```
USAGE
  $ heroku certs:key

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  You must pass one single certificate, and one or more keys.
  The first key that signs the certificate will be printed back.

EXAMPLES
  $ heroku certs:key example.com.crt example.com.key
```

### [heroku certs:remove](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-remove)

remove an SSL certificate from an app

```
USAGE
  $ heroku certs:remove

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --endpoint=endpoint  endpoint to remove
  --name=name          name to remove
```

### [heroku certs:update CRT KEY](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-certs-update-crt-key)

update an SSL certificate on an app

```
USAGE
  $ heroku certs:update CRT KEY

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --bypass             bypass the trust chain completion step
  --endpoint=endpoint  endpoint to update
  --name=name          name to update

DESCRIPTION
  Note: certificates with PEM encoding are also valid

EXAMPLES
  $ heroku certs:update example.com.crt example.com.key

  Certificate Intermediary:
  $ heroku certs:update intermediary.crt example.com.crt example.com.key
```

### [heroku ci](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci)

display the most recent CI runs for the given pipeline

```
USAGE
  $ heroku ci

OPTIONS
  -a, --app=app            app name
  -p, --pipeline=pipeline  name of pipeline
  --json                   output in json format
  --watch                  keep running and watch for new and update tests

EXAMPLE
  $ heroku ci --app murmuring-headland-14719
```

### [heroku ci:config](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-config)

display CI config vars

```
USAGE
  $ heroku ci:config

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use
  -s, --shell              output config vars in shell format
  --json                   output config vars in json format

DESCRIPTION
  Example:

       $ heroku ci:config --app murmuring-headland-14719 --json
```

### [heroku ci:config:get KEY](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-config-get-key)

get a CI config var

```
USAGE
  $ heroku ci:config:get KEY

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use
  -s, --shell              output config var in shell format

DESCRIPTION
  Examples:

       $ heroku ci:config:get RAILS_ENV
       test
```

### [heroku ci:config:set](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-config-set)

set CI config vars

```
USAGE
  $ heroku ci:config:set

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use

DESCRIPTION
  Examples:

       $ heroku ci:config:set RAILS_ENV=test
       Setting test config vars... done

       RAILS_ENV: test
```

### [heroku ci:config:unset](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-config-unset)

unset CI config vars

```
USAGE
  $ heroku ci:config:unset

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use

DESCRIPTION
  Examples:

       $ heroku ci:config:unset RAILS_ENV
       Unsetting RAILS_ENV... done
```

### [heroku ci:debug](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-debug)

opens an interactive test debugging session with the contents of the current directory

```
USAGE
  $ heroku ci:debug

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use
  --no-cache               start test run with an empty cache
  --no-setup               start test dyno without running test-setup

DESCRIPTION
  Example:

       $ heroku ci:debug
       Preparing source... done
       Creating test run... done
       Running setup and attaching to test dyno...

  ~ $
```

### [heroku ci:info TEST-RUN](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-info-test-run)

show the status of a specific test run

```
USAGE
  $ heroku ci:info TEST-RUN

OPTIONS
  -a, --app=app            app name
  -p, --pipeline=pipeline  name of pipeline
  --node=node              the node number to show its setup and output

EXAMPLE
  $ heroku ci:info 1288 --app murmuring-headland-14719
```

### [heroku ci:last](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-last)

looks for the most recent run and returns the output of that run

```
USAGE
  $ heroku ci:last

OPTIONS
  -a, --app=app            app name
  -p, --pipeline=pipeline  name of pipeline
  --node=node              the node number to show its setup and output

EXAMPLE
  $ heroku ci:last --pipeline=my-pipeline --node 100
```

### [heroku ci:migrate-manifest](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-migrate-manifest)

app-ci.json is deprecated. Run this command to migrate to app.json with an environments key.

```
USAGE
  $ heroku ci:migrate-manifest

DESCRIPTION
  Example:

       $ heroku ci:migrate-manifest
       Writing app.json file... done
       Deleting app-ci.json file... done
       Please check the contents of your app.json before committing to your repo
       You're all set! 🎉.
```

### [heroku ci:open](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-open)

open the Dashboard version of Heroku CI

```
USAGE
  $ heroku ci:open

OPTIONS
  -a, --app=app            app to run command against
  -p, --pipeline=pipeline  pipeline
  -r, --remote=remote      git remote of app to use

DESCRIPTION
  opens a browser to view the Dashboard version of Heroku CI

       Example:

       $ heroku ci:open --app murmuring-headland-14719
```

### [heroku ci:rerun \[NUMBER\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-rerun-number)

rerun tests against current directory

```
USAGE
  $ heroku ci:rerun [NUMBER]

OPTIONS
  -a, --app=app            app name
  -p, --pipeline=pipeline  name of pipeline

EXAMPLE
  $ heroku ci:rerun 985 --app murmuring-headland-14719
```

### [heroku ci:run](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ci-run)

run tests against current directory

```
USAGE
  $ heroku ci:run

OPTIONS
  -a, --app=app            app name
  -p, --pipeline=pipeline  name of pipeline

EXAMPLE
  $ heroku ci:run --app murmuring-headland-14719
```

### [heroku clients](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients)

list your OAuth clients

```
USAGE
  $ heroku clients

OPTIONS
  -j, --json  output in json format
```

### [heroku clients:create NAME REDIRECT\_URI](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients-create-name-redirect_uri)

create a new OAuth client

```
USAGE
  $ heroku clients:create NAME REDIRECT_URI

OPTIONS
  -j, --json   output in json format
  -s, --shell  output in shell format
```

### [heroku clients:destroy ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients-destroy-id)

delete client by ID

```
USAGE
  $ heroku clients:destroy ID
```

### [heroku clients:info ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients-info-id)

show details of an oauth client

```
USAGE
  $ heroku clients:info ID

OPTIONS
  -j, --json   output in json format
  -s, --shell  output in shell format
```

### [heroku clients:rotate ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients-rotate-id)

rotate OAuth client secret

```
USAGE
  $ heroku clients:rotate ID

OPTIONS
  -j, --json   output in json format
  -s, --shell  output in shell format
```

### [heroku clients:update ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-clients-update-id)

update OAuth client

```
USAGE
  $ heroku clients:update ID

OPTIONS
  -n, --name=name  change the client name
  --url=url        change the client redirect URL
```

### [heroku commands](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-commands)

list all the commands

```
USAGE
  $ heroku commands

OPTIONS
  -h, --help              show CLI help
  -j, --json              display unfiltered api data in json format
  -x, --extended          show extra columns
  --columns=columns       only show provided columns (comma-separated)
  --csv                   output is csv format [alias: --output=csv]

  --filter=filter         filter property by partial string matching, ex:
                          name=foo

  --hidden                show hidden commands

  --no-header             hide table header from output

  --no-truncate           do not truncate output to fit screen

  --output=csv|json|yaml  output in a more machine friendly format

  --sort=sort             property to sort by (prepend '-' for descending)
```

### [heroku config](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-config)

display the config vars for an app

```
USAGE
  $ heroku config

OPTIONS
  -a, --app=app        (required) app to run command against
  -j, --json           output config vars in json format
  -r, --remote=remote  git remote of app to use
  -s, --shell          output config vars in shell format
```

### [heroku config:edit \[KEY\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-config-edit-key)

interactively edit config vars

```
USAGE
  $ heroku config:edit [KEY]

ARGUMENTS
  KEY  edit a single key

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  This command opens the app config in a text editor set by $VISUAL or $EDITOR.
  Any variables added/removed/changed will be updated on the app after saving
  and closing the file.

EXAMPLES
  # edit with vim
  $ EDITOR="vim" heroku config:edit
  # edit with emacs
  $ EDITOR="emacs" heroku config:edit
  # edit with pico
  $ EDITOR="pico" heroku config:edit
  # edit with atom editor
  $ VISUAL="atom --wait" heroku config:edit
```

### [heroku config:get KEY...](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-config-get-key)

display a single config value for an app

```
USAGE
  $ heroku config:get KEY...

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --shell          output config vars in shell format

EXAMPLES
  $ heroku config:get RAILS_ENV
  production
```

### [heroku config:set](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-config-set)

set one or more config vars

```
USAGE
  $ heroku config:set

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLES
  $ heroku config:set RAILS_ENV=staging
  Setting config vars and restarting example... done, v10
  RAILS_ENV: staging

  $ heroku config:set RAILS_ENV=staging RACK_ENV=staging
  Setting config vars and restarting example... done, v11
  RAILS_ENV: staging
  RACK_ENV:  staging
```

### [heroku config:unset](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-config-unset)

unset one or more config vars

```
USAGE
  $ heroku config:unset

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

ALIASES
  $ heroku config:remove

EXAMPLES
  $ heroku config:unset RAILS_ENV
  Unsetting RAILS_ENV and restarting example... done, v10
  $ heroku config:unset RAILS_ENV RACK_ENV
  Unsetting RAILS_ENV, RACK_ENV and restarting example... done, v10
```

### [heroku container](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container)

Use containers to build and deploy Heroku apps

```
USAGE
  $ heroku container
```

### [heroku container:login](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-login)

log in to Heroku Container Registry

```
USAGE
  $ heroku container:login

OPTIONS
  -v, --verbose

DESCRIPTION
  Usage:
           heroku container:login
```

### [heroku container:logout](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-logout)

log out from Heroku Container Registry

```
USAGE
  $ heroku container:logout

OPTIONS
  -v, --verbose
```

### [heroku container:pull](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-pull)

pulls an image from an app's process type

```
USAGE
  $ heroku container:pull

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -v, --verbose

DESCRIPTION
  Usage:
       heroku container:pull web        # Pulls the web image from the app
       heroku container:pull web worker # Pulls both the web and worker images
  from the app
       heroku container:pull web:latest # Pulls the latest tag from the web
  image
```

### [heroku container:push](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-push)

builds, then pushes Docker images to deploy your Heroku app

```
USAGE
  $ heroku container:push

OPTIONS
  -R, --recursive              pushes Dockerfile.<process> found in current and
                               subdirectories

  -a, --app=app                (required) app to run command against

  -r, --remote=remote          git remote of app to use

  -v, --verbose

  --arg=arg                    set build-time variables

  --context-path=context-path  path to use as build context (defaults to
                               Dockerfile dir)

EXAMPLES
  heroku container:push web                          # Pushes Dockerfile to web
  process type
  heroku container:push worker                       # Pushes Dockerfile to
  worker process type
  heroku container:push web worker --recursive       # Pushes Dockerfile.web and
  Dockerfile.worker
  heroku container:push --recursive                  # Pushes Dockerfile.*
  heroku container:push web --arg ENV=live,HTTPS=on  # Build-time variables
  heroku container:push --recursive --context-path . # Pushes Dockerfile.* using
  current dir as build context
```

### [heroku container:release](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-release)

Releases previously pushed Docker images to your Heroku app

```
USAGE
  $ heroku container:release

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -v, --verbose

DESCRIPTION
  Usage:
       heroku container:release web                       # Releases the
  previously pushed web process type
       heroku container:release web worker                # Releases the
  previously pushed web and worker process types
```

### [heroku container:rm](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-rm)

remove the process type from your app

```
USAGE
  $ heroku container:rm

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Usage:
       heroku container:rm web        # Destroys the web container
       heroku container:rm web worker # Destroys the web and worker containers
```

### [heroku container:run](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-container-run)

builds, then runs the docker image locally

```
USAGE
  $ heroku container:run

OPTIONS
  -a, --app=app        (required) app to run command against
  -p, --port=port      port the app will run on
  -r, --remote=remote  git remote of app to use
  -v, --verbose

DESCRIPTION
  Usage:
       heroku container:run web bash # Runs bash on the local web docker
  container
       heroku container:run worker   # Runs the container CMD on the local
  worker container
```

### [heroku domains](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains)

list domains for an app

```
USAGE
  $ heroku domains

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -j, --json           output in json format
  -r, --remote=remote  git remote of app to use
  -x, --extended       show extra columns
  --columns=columns    only show provided columns (comma-separated)
  --csv                output is csv format
  --filter=filter      filter property by partial string matching, ex: name=foo
  --no-header          hide table header from output
  --sort=sort          property to sort by (prepend '-' for descending)

EXAMPLES
  $ heroku domains
  === example Heroku Domain
  example.herokuapp.com

  === example Custom Domains
  Domain Name      DNS Record Type  DNS Target
  www.example.com  CNAME            www.example.herokudns.com

  $ heroku domains --filter 'Domain Name=www.example.com'
```

### [heroku domains:add HOSTNAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-add-hostname)

add a domain to an app

```
USAGE
  $ heroku domains:add HOSTNAME

OPTIONS
  -a, --app=app        (required) app to run command against
  -c, --cert=cert      the name of the SSL cert you want to use for this domain
  -h, --help           show CLI help
  -j, --json           output in json format
  -r, --remote=remote  git remote of app to use
  --wait

EXAMPLE
  heroku domains:add www.example.com
```

### [heroku domains:clear](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-clear)

remove all domains from an app

```
USAGE
  $ heroku domains:clear

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -r, --remote=remote  git remote of app to use

EXAMPLE
  heroku domains:clear
```

### [heroku domains:info HOSTNAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-info-hostname)

show detailed information for a domain on an app

```
USAGE
  $ heroku domains:info HOSTNAME

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku domains:info www.example.com
```

### [heroku domains:remove HOSTNAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-remove-hostname)

remove a domain from an app

```
USAGE
  $ heroku domains:remove HOSTNAME

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -r, --remote=remote  git remote of app to use

EXAMPLE
  heroku domains:remove www.example.com
```

### [heroku domains:update \[HOSTNAME\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-update-hostname)

update a domain to use a different SSL certificate on an app

```
USAGE
  $ heroku domains:update [HOSTNAME]

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -r, --remote=remote  git remote of app to use

  --cert=cert          (required) the name or id of the certificate you want to
                       use for this domain

EXAMPLE
  heroku domains:update www.example.com --cert mycert
```

### [heroku domains:wait \[HOSTNAME\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-domains-wait-hostname)

wait for domain to be active for an app

```
USAGE
  $ heroku domains:wait [HOSTNAME]

OPTIONS
  -a, --app=app        (required) app to run command against
  -h, --help           show CLI help
  -r, --remote=remote  git remote of app to use
```

### [heroku drains](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-drains)

display the log drains of an app

```
USAGE
  $ heroku drains

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               output in json format
```

### [heroku drains:add URL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-drains-add-url)

adds a log drain to an app

```
USAGE
  $ heroku drains:add URL

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku drains:remove \[URL|TOKEN\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-drains-remove-url-token)

removes a log drain from an app

```
USAGE
  $ heroku drains:remove [URL|TOKEN]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku dyno:kill DYNO](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-dyno-kill-dyno)

stop app dyno

```
USAGE
  $ heroku dyno:kill DYNO

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  stop app dyno or dyno type

EXAMPLES
  $ heroku ps:stop run.1828
  Stopping run.1828 dyno... done

  $ heroku ps:stop run
  Stopping run dynos... done
```

### [heroku dyno:resize](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-dyno-resize)

manage dyno sizes

```
USAGE
  $ heroku dyno:resize

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Called with no arguments shows the current dyno size.

  Called with one argument sets the size.
  Where SIZE is one of free|hobby|standard-1x|standard-2x|performance

  Called with 1..n TYPE=SIZE arguments sets the quantity per type.
```

### [heroku dyno:restart \[DYNO\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-dyno-restart-dyno)

restart app dynos

```
USAGE
  $ heroku dyno:restart [DYNO]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  if DYNO is not specified, restarts all dynos on app

EXAMPLES
  $ heroku ps:restart web.1
  Restarting web.1 dyno... done

  $ heroku ps:restart web
  Restarting web dynos... done

  $ heroku ps:restart
  Restarting dynos... done
```

### [heroku dyno:scale](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-dyno-scale)

scale dyno quantity up or down

```
USAGE
  $ heroku dyno:scale

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Appending a size (eg. web=2:Standard-2X) allows simultaneous scaling and
  resizing.

  Omitting any arguments will display the app's current dyno formation, in a
  format suitable for passing back into ps:scale.

EXAMPLES
  $ heroku ps:scale web=3:Standard-2X worker+1
  Scaling dynos... done, now running web at 3:Standard-2X, worker at
  1:Standard-1X.

  $ heroku ps:scale
  web=3:Standard-2X worker=1:Standard-1X
```

### [heroku dyno:stop DYNO](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-dyno-stop-dyno)

stop app dyno

```
USAGE
  $ heroku dyno:stop DYNO

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  stop app dyno or dyno type

EXAMPLES
  $ heroku ps:stop run.1828
  Stopping run.1828 dyno... done

  $ heroku ps:stop run
  Stopping run dynos... done
```

### [heroku features](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-features)

list available app features

```
USAGE
  $ heroku features

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               output in json format
```

### [heroku features:disable FEATURE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-features-disable-feature)

disables an app feature

```
USAGE
  $ heroku features:disable FEATURE

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku features:enable FEATURE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-features-enable-feature)

enables an app feature

```
USAGE
  $ heroku features:enable FEATURE

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku features:info FEATURE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-features-info-feature)

display information about a feature

```
USAGE
  $ heroku features:info FEATURE

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               output in json format
```

### [heroku git:clone \[DIRECTORY\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-git-clone-directory)

clones a heroku app to your local machine at DIRECTORY (defaults to app name)

```
USAGE
  $ heroku git:clone [DIRECTORY]

ARGUMENTS
  DIRECTORY  where to clone the app

OPTIONS
  -a, --app=app        (required) the Heroku app to use
  -r, --remote=remote  the git remote to create, default "heroku"
  --ssh-git            use SSH git protocol

EXAMPLES
  $ heroku git:clone -a example
  Cloning into 'example'...
  remote: Counting objects: 42, done.
  ...
```

### [heroku git:remote](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-git-remote)

adds a git remote to an app repo

```
USAGE
  $ heroku git:remote

OPTIONS
  -a, --app=app        the Heroku app to use
  -r, --remote=remote  the git remote to create
  --ssh-git            use SSH git protocol

DESCRIPTION
  extra arguments will be passed to git remote add

EXAMPLES
  # set git remote heroku to https://git.heroku.com/example.git
       $ heroku git:remote -a example

       # set git remote heroku-staging to https://git.heroku.com/example.git
       $ heroku git:remote --remote heroku-staging -a example
```

### [heroku help \[COMMAND\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-help-command)

display help for heroku

```
USAGE
  $ heroku help [COMMAND]

ARGUMENTS
  COMMAND  command to show help for

OPTIONS
  --all  see all commands in CLI
```

### [heroku join](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-join)

add yourself to a team app

```
USAGE
  $ heroku join

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku keys](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-keys)

display your SSH keys

```
USAGE
  $ heroku keys

OPTIONS
  -l, --long  display full SSH keys
  --json      output in json format
```

### [heroku keys:add \[KEY\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-keys-add-key)

add an SSH key for a user

```
USAGE
  $ heroku keys:add [KEY]

OPTIONS
  -y, --yes  automatically answer yes for all prompts

DESCRIPTION
  if no KEY is specified, will try to find ~/.ssh/id_rsa.pub

EXAMPLES
  $ heroku keys:add
  Could not find an existing public key.
  Would you like to generate one? [Yn] y
  Generating new SSH public key.
  Uploading SSH public key /.ssh/id_rsa.pub... done

  $ heroku keys:add /my/key.pub
  Uploading SSH public key /my/key.pub... done
```

### [heroku keys:clear](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-keys-clear)

remove all SSH keys for current user

```
USAGE
  $ heroku keys:clear
```

### [heroku keys:remove KEY](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-keys-remove-key)

remove an SSH key from the user

```
USAGE
  $ heroku keys:remove KEY

EXAMPLES
  $ heroku keys:remove email@example.com
  Removing email@example.com SSH key... done
```

### [heroku labs](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-labs)

list experimental features

```
USAGE
  $ heroku labs

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --json               display as json
```

### [heroku labs:disable \[FEATURE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-labs-disable-feature)

disables an experimental feature

```
USAGE
  $ heroku labs:disable [FEATURE]

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --confirm=confirm
```

### [heroku labs:enable FEATURE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-labs-enable-feature)

enables an experimental feature

```
USAGE
  $ heroku labs:enable FEATURE

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku labs:info FEATURE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-labs-info-feature)

show feature info

```
USAGE
  $ heroku labs:info FEATURE

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  --json               display as json
```

### [heroku leave](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-leave)

remove yourself from a team app

```
USAGE
  $ heroku leave

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku local \[PROCESSNAME\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-local-processname)

run heroku app locally

```
USAGE
  $ heroku local [PROCESSNAME]

OPTIONS
  -e, --env=env            location of env file (defaults to .env)
  -f, --procfile=procfile  use a different Procfile
  -p, --port=port          port to listen on

DESCRIPTION
  Start the application specified by a Procfile (defaults to ./Procfile)

ALIASES
  $ heroku local:start

EXAMPLE
  $ heroku local
  $ heroku local web
  $ heroku local web=2
  $ heroku local web=1,worker=2
```

### [heroku local:run](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-local-run)

run a one-off command

```
USAGE
  $ heroku local:run

OPTIONS
  -e, --env=env
  -p, --port=port

EXAMPLE
  $ heroku local:run bin/migrate
```

### [heroku local:version](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-local-version)

display node-foreman version

```
USAGE
  $ heroku local:version
```

### [heroku lock](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-lock)

prevent team members from joining an app

```
USAGE
  $ heroku lock

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku logs](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-logs)

display recent log output

```
USAGE
  $ heroku logs

OPTIONS
  -a, --app=app        (required) app to run command against

  -d, --dyno=dyno      only show output from this dyno type (such as "web" or
                       "worker")

  -n, --num=num        number of lines to display

  -r, --remote=remote  git remote of app to use

  -s, --source=source  only show output from this source (such as "app" or
                       "heroku")

  -t, --tail           continually stream logs

  --force-colors       force use of colors (even on non-tty output)

DESCRIPTION
  disable colors with --no-color, HEROKU_LOGS_COLOR=0, or HEROKU_COLOR=0

EXAMPLES
  $ heroku logs --app=my-app
  $ heroku logs --num=50
  $ heroku logs --dyno=web --app=my-app
  $ heroku logs --app=my-app --tail
```

### [heroku maintenance](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-maintenance)

display the current maintenance status of app

```
USAGE
  $ heroku maintenance

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku maintenance:off](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-maintenance-off)

take the app out of maintenance mode

```
USAGE
  $ heroku maintenance:off

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku maintenance:on](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-maintenance-on)

put the app into maintenance mode

```
USAGE
  $ heroku maintenance:on

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku members](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-members)

list members of a team

```
USAGE
  $ heroku members

OPTIONS
  -r, --role=role  filter by role
  -t, --team=team  team to use
  --json           output in json format
  --pending        filter by pending team invitations
```

### [heroku members:add EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-members-add-email)

adds a user to a team

```
USAGE
  $ heroku members:add EMAIL

OPTIONS
  -r, --role=role  (required) member role (admin, collaborator, member, owner)
  -t, --team=team  team to use
```

### [heroku members:remove EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-members-remove-email)

removes a user from a team

```
USAGE
  $ heroku members:remove EMAIL

OPTIONS
  -t, --team=team  team to use
```

### [heroku members:set EMAIL](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-members-set-email)

sets a members role in a team

```
USAGE
  $ heroku members:set EMAIL

OPTIONS
  -r, --role=role  (required) member role (admin, collaborator, member, owner)
  -t, --team=team  team to use
```

### [heroku notifications](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-notifications)

display notifications

```
USAGE
  $ heroku notifications

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

  --all                view all notifications (not just the ones for the current
                       app)

  --json               output in json format

  --read               show notifications already read
```

### [heroku orgs](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-orgs)

list the teams that you are a member of

```
USAGE
  $ heroku orgs

OPTIONS
  --enterprise  filter by enterprise teams
  --json        output in json format
```

### [heroku orgs:open](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-orgs-open)

open the team interface in a browser window

```
USAGE
  $ heroku orgs:open

OPTIONS
  -t, --team=team  team to use
```

### [heroku pg \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-database)

show database information

```
USAGE
  $ heroku pg [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups)

list database backups

```
USAGE
  $ heroku pg:backups

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:cancel \[BACKUP\_ID\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-cancel-backup_id)

cancel an in-progress backup or restore (default newest)

```
USAGE
  $ heroku pg:backups:cancel [BACKUP_ID]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:capture \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-capture-database)

capture a new backup

```
USAGE
  $ heroku pg:backups:capture [DATABASE]

OPTIONS
  -a, --app=app                  (required) app to run command against
  -r, --remote=remote            git remote of app to use
  -v, --verbose
  --wait-interval=wait-interval
```

### [heroku pg:backups:delete BACKUP\_ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-delete-backup_id)

delete a backup

```
USAGE
  $ heroku pg:backups:delete BACKUP_ID

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use
```

### [heroku pg:backups:download \[BACKUP\_ID\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-download-backup_id)

downloads database backup

```
USAGE
  $ heroku pg:backups:download [BACKUP_ID]

OPTIONS
  -a, --app=app        (required) app to run command against
  -o, --output=output  location to download to. Defaults to latest.dump
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:info \[BACKUP\_ID\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-info-backup_id)

get information about a specific backup

```
USAGE
  $ heroku pg:backups:info [BACKUP_ID]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:restore \[BACKUP\] \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-restore-backup-database)

restore a backup (default latest) to a database

```
USAGE
  $ heroku pg:backups:restore [BACKUP] [DATABASE]

OPTIONS
  -a, --app=app                  (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote            git remote of app to use
  -v, --verbose
  --wait-interval=wait-interval

DESCRIPTION
  defaults to saving the latest database to DATABASE_URL
```

### [heroku pg:backups:schedule \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-schedule-database)

schedule daily backups for given database

```
USAGE
  $ heroku pg:backups:schedule [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

  --at=at              (required) at a specific (24h) hour in the given
                       timezone. Defaults to UTC. --at '[HOUR]:00 [TIMEZONE]'
```

### [heroku pg:backups:schedules](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-schedules)

list backup schedule

```
USAGE
  $ heroku pg:backups:schedules

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:unschedule \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-unschedule-database)

stop daily backups

```
USAGE
  $ heroku pg:backups:unschedule [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:backups:url \[BACKUP\_ID\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-backups-url-backup_id)

get secret but publicly accessible URL of a backup

```
USAGE
  $ heroku pg:backups:url [BACKUP_ID]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:bloat \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-bloat-database)

show table and index bloat in your database ordered by most wasteful

```
USAGE
  $ heroku pg:bloat [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:blocking \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-blocking-database)

display queries holding locks other queries are waiting to be released

```
USAGE
  $ heroku pg:blocking [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:connection-pooling:attach \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-connection-pooling-attach-database)

add an attachment to a database using connection pooling

```
USAGE
  $ heroku pg:connection-pooling:attach [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --as=as              name for add-on attachment

DESCRIPTION
  Example:

     heroku pg:connection-pooling:attach postgresql-something-12345
```

### [heroku pg:copy SOURCE TARGET](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-copy-source-target)

copy all data from source db to target

```
USAGE
  $ heroku pg:copy SOURCE TARGET

OPTIONS
  -a, --app=app                  (required) app to run command against
  -r, --remote=remote            git remote of app to use
  --confirm=confirm
  --verbose
  --wait-interval=wait-interval

DESCRIPTION
  at least one of the databases must be a Heroku PostgreSQL DB
```

### [heroku pg:credentials \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-database)

show information on credentials in the database

```
USAGE
  $ heroku pg:credentials [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --reset              DEPRECATED
```

### [heroku pg:credentials:create \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-create-database)

create credential within database

```
USAGE
  $ heroku pg:credentials:create [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -n, --name=name      (required) name of the new credential within the database
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Example:

       heroku pg:credentials:create postgresql-something-12345 --name
  new-cred-name
```

### [heroku pg:credentials:destroy \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-destroy-database)

destroy credential within database

```
USAGE
  $ heroku pg:credentials:destroy [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -n, --name=name        (required) unique identifier for the credential
  -r, --remote=remote    git remote of app to use

DESCRIPTION
  Example:

       heroku pg:credentials:destroy postgresql-transparent-56874 --name
  cred-name -a woodstock-production
```

### [heroku pg:credentials:repair-default \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-repair-default-database)

repair the permissions of the default credential within database

```
USAGE
  $ heroku pg:credentials:repair-default [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use

DESCRIPTION
  Example:

       heroku pg:credentials:repair-default postgresql-something-12345
```

### [heroku pg:credentials:rotate \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-rotate-database)

rotate the database credentials

```
USAGE
  $ heroku pg:credentials:rotate [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm

  -n, --name=name        which credential to rotate (default credentials if not
                         specified)

  -r, --remote=remote    git remote of app to use

  --all                  rotate all credentials

  --force                forces rotating the targeted credentials
```

### [heroku pg:credentials:url \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-credentials-url-database)

show information on a database credential

```
USAGE
  $ heroku pg:credentials:url [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against

  -n, --name=name      which credential to show (default credentials if not
                       specified)

  -r, --remote=remote  git remote of app to use
```

### [heroku pg:diagnose \[DATABASE|REPORT\_ID\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-diagnose-database-report_id)

run or view diagnostics report

```
USAGE
  $ heroku pg:diagnose [DATABASE|REPORT_ID]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               format output as JSON

DESCRIPTION
  defaults to DATABASE_URL database if no DATABASE is specified
  if REPORT_ID is specified instead, a previous report is displayed
```

### [heroku pg:info \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-info-database)

show database information

```
USAGE
  $ heroku pg:info [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:kill PID \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-kill-pid-database)

kill a query

```
USAGE
  $ heroku pg:kill PID [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -f, --force
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:killall \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-killall-database)

terminates all connections for all credentials

```
USAGE
  $ heroku pg:killall [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:links \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-links-database)

lists all databases and information on link

```
USAGE
  $ heroku pg:links [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:links:create REMOTE DATABASE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-links-create-remote-database)

create a link between data stores

```
USAGE
  $ heroku pg:links:create REMOTE DATABASE

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --as=as              name of link to create

DESCRIPTION
  Example:

       heroku pg:links:create HEROKU_REDIS_RED HEROKU_POSTGRESQL_CERULEAN
```

### [heroku pg:links:destroy DATABASE LINK](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-links-destroy-database-link)

destroys a link between data stores

```
USAGE
  $ heroku pg:links:destroy DATABASE LINK

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use

DESCRIPTION
  Example:

       heroku pg:links:destroy HEROKU_POSTGRESQL_CERULEAN redis-symmetrical-100
```

### [heroku pg:locks \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-locks-database)

display queries with active locks

```
USAGE
  $ heroku pg:locks [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -t, --truncate       truncates queries to 40 charaters
```

### [heroku pg:maintenance \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-maintenance-database)

show current maintenance information

```
USAGE
  $ heroku pg:maintenance [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:maintenance:run \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-maintenance-run-database)

start maintenance

```
USAGE
  $ heroku pg:maintenance:run [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -f, --force
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:maintenance:window DATABASE WINDOW](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-maintenance-window-database-window)

set weekly maintenance window

```
USAGE
  $ heroku pg:maintenance:window DATABASE WINDOW

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  All times are in UTC.

  Example:

       heroku pg:maintenance:window postgres-slippery-100 "Sunday 06:00"
```

### [heroku pg:outliers \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-outliers-database)

show 10 queries that have longest execution time in aggregate

```
USAGE
  $ heroku pg:outliers [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -n, --num=num        the number of queries to display (default: 10)
  -r, --remote=remote  git remote of app to use
  -t, --truncate       truncate queries to 40 characters
  --reset              resets statistics gathered by pg_stat_statements
```

### [heroku pg:promote DATABASE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-promote-database)

sets DATABASE as your DATABASE\_URL

```
USAGE
  $ heroku pg:promote DATABASE

OPTIONS
  -a, --app=app        (required) app to run command against
  -f, --force
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:ps \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-ps-database)

view active queries with execution time

```
USAGE
  $ heroku pg:ps [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -v, --verbose
```

### [heroku pg:psql \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-psql-database)

open a psql shell to the database

```
USAGE
  $ heroku pg:psql [DATABASE]

OPTIONS
  -a, --app=app            (required) app to run command against
  -c, --command=command    SQL command to run
  -f, --file=file          SQL file to run
  -r, --remote=remote      git remote of app to use
  --credential=credential  credential to use
```

### [heroku pg:pull SOURCE TARGET](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-pull-source-target)

pull Heroku database into local or remote database

```
USAGE
  $ heroku pg:pull SOURCE TARGET

OPTIONS
  -a, --app=app                            (required) app to run command against
  -r, --remote=remote                      git remote of app to use

  --exclude-table-data=exclude-table-data  tables for which data should be
                                           excluded (use ';' to split multiple
                                           names)

DESCRIPTION
  Pull from SOURCE into TARGET.

  TARGET must be one of:
     * a database name (i.e. on a local PostgreSQL server)  => TARGET must not
  exist and will be created
     * a fully qualified URL to a local PostgreSQL server   => TARGET must not
  exist and will be created
     * a fully qualified URL to a remote PostgreSQL server  => TARGET must exist
  and be empty

  To delete a local database run `dropdb TARGET`
  To create an empty remote database, run `createdb` with connection
  command-line options (run `createdb --help` for details).

  Examples:

       # pull Heroku DB named postgresql-swimmingly-100 into local DB mylocaldb
  that must not exist
       $ heroku pg:pull postgresql-swimmingly-100 mylocaldb --app sushi

       # pull Heroku DB named postgresql-swimmingly-100 into empty remote DB at
  postgres://myhost/mydb
       $ heroku pg:pull postgresql-swimmingly-100 postgres://myhost/mydb --app
  sushi
```

### [heroku pg:push SOURCE TARGET](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-push-source-target)

push local or remote into Heroku database

```
USAGE
  $ heroku pg:push SOURCE TARGET

OPTIONS
  -a, --app=app                            (required) app to run command against
  -r, --remote=remote                      git remote of app to use

  --exclude-table-data=exclude-table-data  tables for which data should be
                                           excluded (use ';' to split multiple
                                           names)

DESCRIPTION
  Push from SOURCE into TARGET. TARGET must be empty.

  To empty a Heroku database for push run `heroku pg:reset`

  SOURCE must be either the name of a database existing on your localhost or the
  fully qualified URL of a remote database.

  Examples:

       # push mylocaldb into a Heroku DB named postgresql-swimmingly-100
       $ heroku pg:push mylocaldb postgresql-swimmingly-100

       # push remote DB at postgres://myhost/mydb into a Heroku DB named
  postgresql-swimmingly-100
       $ heroku pg:push postgres://myhost/mydb postgresql-swimmingly-100
```

### [heroku pg:reset \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-reset-database)

delete all data in DATABASE

```
USAGE
  $ heroku pg:reset [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use
```

### [heroku pg:settings \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-settings-database)

show your current database settings

```
USAGE
  $ heroku pg:settings [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:settings:log-lock-waits \[VALUE\] \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-settings-log-lock-waits-value-database)

Controls whether a log message is produced when a session waits longer than the deadlock\_timeout to acquire a lock. deadlock\_timeout is set to 1 second

```
USAGE
  $ heroku pg:settings:log-lock-waits [VALUE] [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Delays due to lock contention occur when multiple transactions are trying to
  access the same resource at the same time.
  Applications and their query patterns should try to avoid changes to many
  different tables within the same transaction.
```

### [heroku pg:settings:log-min-duration-statement \[VALUE\] \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-settings-log-min-duration-statement-value-database)

The duration of each completed statement will be logged if the statement completes after the time specified by VALUE.

```
USAGE
  $ heroku pg:settings:log-min-duration-statement [VALUE] [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  VALUE needs to specified as a whole number, in milliseconds.
  Setting log_min_duration_statement to zero prints all statement durations and
  -1 will disable logging statement durations.
```

### [heroku pg:settings:log-statement \[VALUE\] \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-settings-log-statement-value-database)

log\_statement controls which SQL statements are logged.

```
USAGE
  $ heroku pg:settings:log-statement [VALUE] [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Valid values for VALUE:
  none - No statements are logged
  ddl  - All data definition statements, such as CREATE, ALTER and DROP will be
  logged
  mod  - Includes all statements from ddl as well as data-modifying statements
  such as INSERT, UPDATE, DELETE, TRUNCATE, COPY
  all  - All statements are logged
```

### [heroku pg:unfollow DATABASE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-unfollow-database)

stop a replica from following and make it a writeable database

```
USAGE
  $ heroku pg:unfollow DATABASE

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use
```

### [heroku pg:upgrade \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-upgrade-database)

unfollow a database and upgrade it to the latest stable PostgreSQL version

```
USAGE
  $ heroku pg:upgrade [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use
  -v, --version=version  PostgreSQL version to upgrade to

DESCRIPTION
  to upgrade to another PostgreSQL version, use pg:copy instead
```

### [heroku pg:vacuum-stats \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-vacuum-stats-database)

show dead rows and whether an automatic vacuum is expected to be triggered

```
USAGE
  $ heroku pg:vacuum-stats [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku pg:wait \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pg-wait-database)

blocks until database is available

```
USAGE
  $ heroku pg:wait [DATABASE]

OPTIONS
  -a, --app=app                  (required) app to run command against
  -r, --remote=remote            git remote of app to use
  --no-notify                    do not show OS notification

  --wait-interval=wait-interval  how frequently to poll in seconds (to avoid
                                 rate limiting)
```

### [heroku pipelines](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines)

list pipelines you have access to

```
USAGE
  $ heroku pipelines

OPTIONS
  --json  output in json format

EXAMPLE
  $ heroku pipelines
```

### [heroku pipelines:add PIPELINE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-add-pipeline)

add this app to a pipeline

```
USAGE
  $ heroku pipelines:add PIPELINE

ARGUMENTS
  PIPELINE  name of pipeline

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --stage=stage    stage of first app in pipeline

DESCRIPTION
  The app and pipeline names must be specified.
  The stage of the app will be guessed based on its name if not specified.

EXAMPLE
  $ heroku pipelines:add my-pipeline -a my-app -s production
```

### [heroku pipelines:connect NAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-connect-name)

connect a github repo to an existing pipeline

```
USAGE
  $ heroku pipelines:connect NAME

ARGUMENTS
  NAME  name of pipeline

OPTIONS
  -r, --repo=repo  (required) the GitHub repository to connect to

EXAMPLE
  $ heroku pipelines:connect my-pipeline -r githuborg/reponame
```

### [heroku pipelines:create \[NAME\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-create-name)

create a new pipeline

```
USAGE
  $ heroku pipelines:create [NAME]

ARGUMENTS
  NAME  name of pipeline (defaults to basename of the app)

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --stage=stage    stage of first app in pipeline
  -t, --team=team      the team which will own the apps

DESCRIPTION
  An existing app must be specified as the first app in the pipeline.
     The pipeline name will be inferred from the app name if not specified.
     The stage of the app will be guessed based on its name if not specified.
     The pipeline owner will be the user creating the pipeline if not specified
  with -t for teams or -o for orgs.

EXAMPLES
  $ heroku pipelines:create -a my-app-staging
  $ heroku pipelines:create my-pipeline -a my-app-staging
```

### [heroku pipelines:destroy PIPELINE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-destroy-pipeline)

destroy a pipeline

```
USAGE
  $ heroku pipelines:destroy PIPELINE

ARGUMENTS
  PIPELINE  name of pipeline

EXAMPLE
  $ heroku pipelines:destroy my-pipeline
```

### [heroku pipelines:diff](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-diff)

compares the latest release of this app to its downstream app(s)

```
USAGE
  $ heroku pipelines:diff

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku pipelines:diff -a my-app-staging
```

### [heroku pipelines:info PIPELINE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-info-pipeline)

show list of apps in a pipeline

```
USAGE
  $ heroku pipelines:info PIPELINE

ARGUMENTS
  PIPELINE  pipeline to show list of apps for

OPTIONS
  --json  output in json format

EXAMPLE
  $ heroku pipelines:info my-pipeline
```

### [heroku pipelines:open PIPELINE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-open-pipeline)

open a pipeline in dashboard

```
USAGE
  $ heroku pipelines:open PIPELINE

ARGUMENTS
  PIPELINE  name of pipeline

EXAMPLE
  $ heroku pipelines:open my-pipeline
```

### [heroku pipelines:promote](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-promote)

promote the latest release of this app to its downstream app(s)

```
USAGE
  $ heroku pipelines:promote

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -t, --to=to          comma separated list of apps to promote to

EXAMPLE
  $ heroku pipelines:promote -a my-app-staging
```

### [heroku pipelines:remove](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-remove)

remove this app from its pipeline

```
USAGE
  $ heroku pipelines:remove

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku pipelines:remove -a my-app
```

### [heroku pipelines:rename PIPELINE NAME](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-rename-pipeline-name)

rename a pipeline

```
USAGE
  $ heroku pipelines:rename PIPELINE NAME

ARGUMENTS
  PIPELINE  current name of pipeline
  NAME      new name of pipeline

EXAMPLE
  $ heroku pipelines:rename my-pipeline new-pipeline-name
```

### [heroku pipelines:setup \[NAME\] \[REPO\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-setup-name-repo)

bootstrap a new pipeline with common settings and create a production and staging app (requires a fully formed app.json in the repo)

```
USAGE
  $ heroku pipelines:setup [NAME] [REPO]

ARGUMENTS
  NAME  name of pipeline
  REPO  a GitHub repository to connect the pipeline to

OPTIONS
  -t, --team=team  the team to assign pipeline ownership to (defaults to current
                   user)

  -y, --yes        accept all default settings without prompting

EXAMPLE
  $ heroku pipelines:setup my-pipeline githuborg/reponame -t my-team
```

### [heroku pipelines:transfer OWNER](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-transfer-owner)

transfer ownership of a pipeline

```
USAGE
  $ heroku pipelines:transfer OWNER

ARGUMENTS
  OWNER  the owner to transfer the pipeline to

OPTIONS
  -c, --confirm=confirm
  -p, --pipeline=pipeline  (required) name of pipeline

EXAMPLES
  $ heroku pipelines:transfer admin@example.com -p my-pipeline
  $ heroku pipelines:transfer admin-team -p my-pipeline
```

### [heroku pipelines:update](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-pipelines-update)

update the app's stage in a pipeline

```
USAGE
  $ heroku pipelines:update

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --stage=stage    (required) new stage of app

EXAMPLE
  $ heroku pipelines:update -s staging -a my-app
```

### [heroku plugins](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-plugins)

list installed plugins

```
USAGE
  $ heroku plugins

OPTIONS
  --core  show core plugins

EXAMPLE
  $ heroku plugins
```

### [heroku plugins:install PLUGIN...](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-plugins-install-plugin)

installs a plugin into the CLI

```
USAGE
  $ heroku plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  plugin to install

OPTIONS
  -f, --force    yarn install with force flag
  -h, --help     show CLI help
  -v, --verbose

DESCRIPTION
  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a
  user-installed plugin with a 'hello' command will override the core plugin
  implementation. This is useful if a user needs to update core plugin
  functionality in the CLI without the need to patch and update the whole CLI.

ALIASES
  $ heroku plugins:add

EXAMPLES
  $ heroku plugins:install myplugin
  $ heroku plugins:install https://github.com/someuser/someplugin
  $ heroku plugins:install someuser/someplugin
```

### [heroku plugins:link PLUGIN](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-plugins-link-plugin)

links a plugin into the CLI for development

```
USAGE
  $ heroku plugins:link PLUGIN

ARGUMENTS
  PATH  [default: .] path to plugin

OPTIONS
  -h, --help     show CLI help
  -v, --verbose

DESCRIPTION
  Installation of a linked plugin will override a user-installed or core plugin.

  e.g. If you have a user-installed or core plugin that has a 'hello' command,
  installing a linked plugin with a 'hello' command will override the
  user-installed or core plugin implementation. This is useful for development
  work.

EXAMPLE
  $ heroku plugins:link myplugin
```

### [heroku plugins:uninstall PLUGIN...](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-plugins-uninstall-plugin)

removes a plugin from the CLI

```
USAGE
  $ heroku plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

OPTIONS
  -h, --help     show CLI help
  -v, --verbose

ALIASES
  $ heroku plugins:unlink
  $ heroku plugins:remove
```

### [heroku plugins:update](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-plugins-update)

update installed plugins

```
USAGE
  $ heroku plugins:update

OPTIONS
  -h, --help     show CLI help
  -v, --verbose
```

### [heroku ps \[TYPE \[TYPE ...\]\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-type-type)

list dynos for an app

```
USAGE
  $ heroku ps [TYPE [TYPE ...]]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --json               display as json

EXAMPLES
  $ heroku ps
  === run: one-off dyno
  run.1: up for 5m: bash

  === web: bundle exec thin start -p $PORT
  web.1: created for 30s

  $ heroku ps run # specifying types
  === run: one-off dyno
  run.1: up for 5m: bash
```

### [heroku ps:autoscale:disable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-autoscale-disable)

disable web dyno autoscaling

```
USAGE
  $ heroku ps:autoscale:disable

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku ps:autoscale:enable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-autoscale-enable)

enable web dyno autoscaling

```
USAGE
  $ heroku ps:autoscale:enable

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --max=max            (required) maximum number of dynos
  --min=min            (required) minimum number of dynos

  --notifications      receive email notifications when the max dyno limit is
                       reached

  --p95=p95            desired p95 response time
```

### [heroku ps:copy FILE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-copy-file)

Copy a file from a dyno to the local filesystem

```
USAGE
  $ heroku ps:copy FILE

OPTIONS
  -a, --app=app        (required) app to run command against
  -d, --dyno=dyno      specify the dyno to connect to
  -o, --output=output  the name of the output file
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Example:

       $ heroku ps:copy FILENAME --app murmuring-headland-14719
```

### [heroku ps:exec](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-exec)

Create an SSH session to a dyno

```
USAGE
  $ heroku ps:exec

OPTIONS
  -a, --app=app        (required) app to run command against
  -d, --dyno=dyno      specify the dyno to connect to
  -r, --remote=remote  git remote of app to use
  --ssh                use native ssh
  --status             lists the status of the SSH server in the dyno

DESCRIPTION
  Example:

       $ heroku ps:exec 'node -i' --app murmuring-headland-14719
```

### [heroku ps:forward PORT](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-forward-port)

Forward traffic on a local port to a dyno

```
USAGE
  $ heroku ps:forward PORT

OPTIONS
  -a, --app=app        (required) app to run command against
  -d, --dyno=dyno      specify the dyno to connect to
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Provide a port or comma-separated list of ports to forward.

       For example, "4000,9000:9001" will forward port 4000 to port 4000 and
       port 9000 to port 9001.

       Example:

       $ heroku ps:forward 8080 --app murmuring-headland-14719
```

### [heroku ps:kill DYNO](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-kill-dyno)

stop app dyno

```
USAGE
  $ heroku ps:kill DYNO

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  stop app dyno or dyno type

EXAMPLES
  $ heroku ps:stop run.1828
  Stopping run.1828 dyno... done

  $ heroku ps:stop run
  Stopping run dynos... done
```

### [heroku ps:resize](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-resize)

manage dyno sizes

```
USAGE
  $ heroku ps:resize

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Called with no arguments shows the current dyno size.

  Called with one argument sets the size.
  Where SIZE is one of free|hobby|standard-1x|standard-2x|performance

  Called with 1..n TYPE=SIZE arguments sets the quantity per type.
```

### [heroku ps:restart \[DYNO\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-restart-dyno)

restart app dynos

```
USAGE
  $ heroku ps:restart [DYNO]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  if DYNO is not specified, restarts all dynos on app

EXAMPLES
  $ heroku ps:restart web.1
  Restarting web.1 dyno... done

  $ heroku ps:restart web
  Restarting web dynos... done

  $ heroku ps:restart
  Restarting dynos... done
```

### [heroku ps:scale](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-scale)

scale dyno quantity up or down

```
USAGE
  $ heroku ps:scale

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Appending a size (eg. web=2:Standard-2X) allows simultaneous scaling and
  resizing.

  Omitting any arguments will display the app's current dyno formation, in a
  format suitable for passing back into ps:scale.

EXAMPLES
  $ heroku ps:scale web=3:Standard-2X worker+1
  Scaling dynos... done, now running web at 3:Standard-2X, worker at
  1:Standard-1X.

  $ heroku ps:scale
  web=3:Standard-2X worker=1:Standard-1X
```

### [heroku ps:socks](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-socks)

Launch a SOCKS proxy into a dyno

```
USAGE
  $ heroku ps:socks

OPTIONS
  -a, --app=app        (required) app to run command against
  -d, --dyno=dyno      specify the dyno to connect to
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Example:

       $ heroku ps:socks --app murmuring-headland-14719
       Establishing credentials... done
       SOCKSv5 proxy server started on port 1080
       Use CTRL+C to stop the proxy
```

### [heroku ps:stop DYNO](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-stop-dyno)

stop app dyno

```
USAGE
  $ heroku ps:stop DYNO

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  stop app dyno or dyno type

EXAMPLES
  $ heroku ps:stop run.1828
  Stopping run.1828 dyno... done

  $ heroku ps:stop run
  Stopping run dynos... done
```

### [heroku ps:type](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-type)

manage dyno sizes

```
USAGE
  $ heroku ps:type

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Called with no arguments shows the current dyno size.

  Called with one argument sets the size.
  Where SIZE is one of free|hobby|standard-1x|standard-2x|performance

  Called with 1..n TYPE=SIZE arguments sets the quantity per type.
```

### [heroku ps:wait](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-ps-wait)

wait for all dynos to be running latest version after a release

```
USAGE
  $ heroku ps:wait

OPTIONS
  -R, --with-run                     whether to wait for one-off run dynos
  -a, --app=app                      (required) app to run command against
  -r, --remote=remote                git remote of app to use
  -t, --type=type                    wait for one specific dyno type

  -w, --wait-interval=wait-interval  [default: 10] how frequently to poll in
                                     seconds (to avoid hitting Heroku API rate
                                     limits)
```

### [heroku psql \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-psql-database)

open a psql shell to the database

```
USAGE
  $ heroku psql [DATABASE]

OPTIONS
  -a, --app=app            (required) app to run command against
  -c, --command=command    SQL command to run
  -f, --file=file          SQL file to run
  -r, --remote=remote      git remote of app to use
  --credential=credential  credential to use
```

### [heroku redis \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-database)

gets information about redis

```
USAGE
  $ heroku redis [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku redis:cli \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-cli-database)

opens a redis prompt

```
USAGE
  $ heroku redis:cli [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -c, --confirm=confirm
  -r, --remote=remote    git remote of app to use
```

### [heroku redis:credentials \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-credentials-database)

display credentials information

```
USAGE
  $ heroku redis:credentials [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  --reset              reset credentials
```

### [heroku redis:info \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-info-database)

gets information about redis

```
USAGE
  $ heroku redis:info [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku redis:keyspace-notifications \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-keyspace-notifications-database)

set the keyspace notifications configuration

```
USAGE
  $ heroku redis:keyspace-notifications [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -c, --config=config  (required) set keyspace notifications configuration
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Set the configuration to enable keyspace notification events:
       K     Keyspace events, published with __keyspace@<db>__ prefix.
       E     Keyevent events, published with __keyevent@<db>__ prefix.
       g     Generic commands (non-type specific) like DEL, EXPIRE, RENAME, ...
       $     String commands
       l     List commands
       s     Set commands
       h     Hash commands
       z     Sorted set commands
       t     Stream commands
       x     Expired events (events generated every time a key expires)
       e     Evicted events (events generated when a key is evicted for
  maxmemory)
       m     Key miss events (events generated when a key that doesn't exist is
  accessed)
       A     Alias for "g$lshztxe", so that the "AKE" string means all the
  events except "m".

       pass an empty string ('') to disable keyspace notifications
```

### [heroku redis:maintenance \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-maintenance-database)

manage maintenance windows

```
USAGE
  $ heroku redis:maintenance [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against

  -f, --force          start maintenance without entering application
                       maintenance mode

  -r, --remote=remote  git remote of app to use

  -w, --window=window  set weekly UTC maintenance window

  --run                start maintenance

DESCRIPTION
  Set or change the maintenance window for your Redis instance
```

### [heroku redis:maxmemory \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-maxmemory-database)

set the key eviction policy

```
USAGE
  $ heroku redis:maxmemory [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -p, --policy=policy  (required) set policy name
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  Set the key eviction policy when instance reaches its storage limit. Available
  policies for key eviction include:

       noeviction      # returns errors when memory limit is reached
       allkeys-lfu     # removes less frequently used keys first
       volatile-lfu    # removes less frequently used keys first that have an
  expiry set
       allkeys-lru     # removes less recently used keys first
       volatile-lru    # removes less recently used keys first that have an
  expiry set
       allkeys-random  # evicts random keys
       volatile-random # evicts random keys but only those that have an expiry
  set
       volatile-ttl    # only evicts keys with an expiry set and a short TTL
```

### [heroku redis:promote DATABASE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-promote-database)

sets DATABASE as your REDIS\_URL

```
USAGE
  $ heroku redis:promote DATABASE

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku redis:timeout \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-timeout-database)

set the number of seconds to wait before killing idle connections

```
USAGE
  $ heroku redis:timeout [DATABASE]

OPTIONS
  -a, --app=app          (required) app to run command against
  -r, --remote=remote    git remote of app to use
  -s, --seconds=seconds  set timeout value

DESCRIPTION
  Sets the number of seconds to wait before killing idle connections. A value of
  zero means that connections will not be closed.
```

### [heroku redis:wait \[DATABASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-redis-wait-database)

wait for Redis instance to be available

```
USAGE
  $ heroku redis:wait [DATABASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku regions](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-regions)

list available regions for deployment

```
USAGE
  $ heroku regions

OPTIONS
  --common   show regions for common runtime
  --json     output in json format
  --private  show regions for private spaces
```

### [heroku releases](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-releases)

display the releases for an app

```
USAGE
  $ heroku releases

OPTIONS
  -a, --app=app        (required) app to run command against
  -n, --num=num        number of releases to show
  -r, --remote=remote  git remote of app to use
  --json               output releases in json format

EXAMPLES
  $ heroku releases
  === example Releases
  v1 Config add FOO_BAR email@example.com 2015/11/17 17:37:41 (~ 1h ago)
  v2 Config add BAR_BAZ email@example.com 2015/11/17 17:37:41 (~ 1h ago)
  v3 Config add BAZ_QUX email@example.com 2015/11/17 17:37:41 (~ 1h ago)
```

### [heroku releases:info \[RELEASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-releases-info-release)

view detailed information for a release

```
USAGE
  $ heroku releases:info [RELEASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --shell          output in shell format
  --json               output in json format
```

### [heroku releases:output \[RELEASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-releases-output-release)

View the release command output

```
USAGE
  $ heroku releases:output [RELEASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku releases:rollback \[RELEASE\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-releases-rollback-release)

rollback to a previous release

```
USAGE
  $ heroku releases:rollback [RELEASE]

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use

DESCRIPTION
  If RELEASE is not specified, it will rollback one release
```

### [heroku reviewapps:disable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-reviewapps-disable)

disable review apps and/or settings on an existing pipeline

```
USAGE
  $ heroku reviewapps:disable

OPTIONS
  -a, --app=app            parent app used by review apps
  -p, --pipeline=pipeline  (required) name of pipeline
  -r, --remote=remote      git remote of app to use
  --no-autodeploy          disable autodeployments
  --no-autodestroy         disable automatically destroying review apps
  --no-wait-for-ci         disable wait for CI

EXAMPLE
  $ heroku reviewapps:disable -p my-pipeline -a my-app --no-autodeploy
```

### [heroku reviewapps:enable](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-reviewapps-enable)

enable review apps and/or settings on an existing pipeline

```
USAGE
  $ heroku reviewapps:enable

OPTIONS
  -a, --app=app            parent app used by review apps
  -p, --pipeline=pipeline  (required) name of pipeline
  -r, --remote=remote      git remote of app to use
  --autodeploy             autodeploy the review app
  --autodestroy            autodestroy the review app
  --wait-for-ci            wait for CI to pass before deploying

EXAMPLE
  $ heroku reviewapps:enable -p my-pipeline -a my-app --autodeploy --autodestroy
```

### [heroku run](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-run)

run a one-off process inside a heroku dyno

```
USAGE
  $ heroku run

OPTIONS
  -a, --app=app        (required) parent app used by review apps

  -e, --env=env        environment variables to set (use ';' to split multiple
                       vars)

  -r, --remote=remote  git remote of app to use

  -s, --size=size      dyno size

  -x, --exit-code      passthrough the exit code of the remote command

  --no-notify          disables notification when dyno is up (alternatively use
                       HEROKU_NOTIFICATIONS=0)

  --no-tty             force the command to not run in a tty

  --type=type          process type

DESCRIPTION
  Shows a notification if the dyno takes more than 20 seconds to start.

EXAMPLES
  $ heroku run bash
  $ heroku run -s hobby -- myscript.sh -a arg1 -s arg2
```

### [heroku run:detached](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-run-detached)

run a detached dyno, where output is sent to your logs

```
USAGE
  $ heroku run:detached

OPTIONS
  -a, --app=app        (required) app to run command against

  -e, --env=env        environment variables to set (use ';' to split multiple
                       vars)

  -r, --remote=remote  git remote of app to use

  -s, --size=size      dyno size

  -t, --tail           continually stream logs

  --type=type          process type

EXAMPLE
  $ heroku run:detached ls
```

### [heroku sessions](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-sessions)

list your OAuth sessions

```
USAGE
  $ heroku sessions

OPTIONS
  -j, --json  output in json format
```

### [heroku sessions:destroy ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-sessions-destroy-id)

delete (logout) OAuth session by ID

```
USAGE
  $ heroku sessions:destroy ID
```

### [heroku spaces](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces)

list available spaces

```
USAGE
  $ heroku spaces

OPTIONS
  -t, --team=team  team to use
  --json           output in json format
```

### [heroku spaces:create](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-create)

create a new space

```
USAGE
  $ heroku spaces:create

OPTIONS
  -s, --space=space      name of space to create
  -t, --team=team        team to use
  --cidr=cidr            RFC-1918 CIDR the space will use

  --data-cidr=data-cidr  RFC-1918 CIDR used by Heroku Data resources for the
                         space

  --region=region        region name

DESCRIPTION
  Example:

       $ heroku spaces:create --space my-space --team my-team --region oregon
       Creating space my-space in team my-team... done
       === my-space
       ID:         e7b99e37-69b3-4475-ad47-a5cc5d75fd9f
       Team:       my-team
       Region:     oregon
       CIDR:       10.0.0.0/16
       Data CIDR:  172.23.0.0/20
       State:      allocating
       Created at: 2016-01-06T03:23:13Z
```

### [heroku spaces:destroy](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-destroy)

destroy a space

```
USAGE
  $ heroku spaces:destroy

OPTIONS
  -s, --space=space  space to destroy
  --confirm=confirm  set to space name to bypass confirm prompt

DESCRIPTION
  Example:

       $ heroku spaces:destroy --space my-space
       Destroying my-space... done
```

### [heroku spaces:info](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-info)

show info about a space

```
USAGE
  $ heroku spaces:info

OPTIONS
  -s, --space=space  space to get info of
  --json             output in json format
```

### [heroku spaces:peering:info](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-peering-info)

display the information necessary to initiate a peering connection

```
USAGE
  $ heroku spaces:peering:info

OPTIONS
  -s, --space=space  space to get peering info from
  --json             output in json format

DESCRIPTION
  Example:

       $ heroku spaces:peering:info example-space
       === example-space Peering Info
       AWS Account ID:    012345678910
       AWS Region:        us-west-2
       AWS VPC ID:        vpc-baadf00d
       AWS VPC CIDR:      10.0.0.0/16
       Space CIDRs:       10.0.128.0/20, 10.0.144.0/20
       Unavailable CIDRs: 10.1.0.0/16

  You will use the information provied by this command to establish a peering
  connection request from your AWS VPC to your private space.

  To start the peering process, go into your AWS console for the VPC you would
  like peered with your Private Space,
  navigate to the VPC service, choose the "Peering Connections" option and click
  the "Create peering connection" button.

  - The AWS Account ID and VPC ID are necessary for the AWS VPC Peering
  connection wizard.
  - You will also need to configure your VPC route table to route the Dyno CIDRs
  through the peering connection.

  Once you've established the peering connection request, you can use the
  spaces:peerings:accept command to accept and
  configure the peering connection for the space.
```

### [heroku spaces:peerings](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-peerings)

list peering connections for a space

```
USAGE
  $ heroku spaces:peerings

OPTIONS
  -s, --space=space  space to get peer list from
  --json             output in json format
```

### [heroku spaces:peerings:accept](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-peerings-accept)

accepts a pending peering request for a private space

```
USAGE
  $ heroku spaces:peerings:accept

OPTIONS
  -p, --pcxid=pcxid  PCX ID of a pending peering
  -s, --space=space  space to get peering info from

DESCRIPTION
  Example:

       $ heroku spaces:peerings:accept pcx-4bd27022 --space example-space
       Accepting and configuring peering connection pcx-4bd27022
```

### [heroku spaces:peerings:destroy](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-peerings-destroy)

destroys an active peering connection in a private space

```
USAGE
  $ heroku spaces:peerings:destroy

OPTIONS
  -p, --pcxid=pcxid  PCX ID of a pending peering
  -s, --space=space  space to get peering info from
  --confirm=confirm  set to PCX ID to bypass confirm prompt

DESCRIPTION
  Example:

       $ heroku spaces:peerings:destroy pcx-4bd27022 --confirm pcx-4bd27022
  --space example-space
       Tearing down peering connection pcx-4bd27022
```

### [heroku spaces:ps](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-ps)

list dynos for a space

```
USAGE
  $ heroku spaces:ps

OPTIONS
  -s, --space=space  space to get dynos of
  --json             output in json format
```

### [heroku spaces:rename](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-rename)

renames a space

```
USAGE
  $ heroku spaces:rename

OPTIONS
  --from=from  (required) current name of space
  --to=to      (required) desired name of space

DESCRIPTION
  Example:

       $ heroku spaces:rename --from old-space-name --to new-space-name
       Renaming space old-space-name to new-space-name... done
```

### [heroku spaces:topology](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-topology)

show space topology

```
USAGE
  $ heroku spaces:topology

OPTIONS
  -s, --space=space  space to get topology of
  --json             output in json format
```

### [heroku spaces:transfer](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-transfer)

transfer a space to another team

```
USAGE
  $ heroku spaces:transfer

OPTIONS
  --space=space  (required) name of space
  --team=team    (required) desired owner of space

DESCRIPTION
  Example:

       $ heroku spaces:transfer --space=space-name --team=team-name
       Transferring space-name to team-name... done
```

### [heroku spaces:vpn:config](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-config)

display the configuration information for VPN

```
USAGE
  $ heroku spaces:vpn:config

OPTIONS
  -n, --name=name    name or id of the VPN connection to retrieve config from
  -s, --space=space  space the VPN connection belongs to
  --json             output in json format

DESCRIPTION
  Example:

       $ heroku spaces:vpn:config --space my-space vpn-connection-name
       === vpn-connection-name VPN Tunnels
       VPN Tunnel  Customer Gateway  VPN Gateway     Pre-shared Key  Routable
  Subnets  IKE Version
       ──────────  ────────────────  ──────────────  ──────────────
  ────────────────  ───────────
       Tunnel 1    104.196.121.200   35.171.237.136  abcdef12345     10.0.0.0/16
        1
       Tunnel 2    104.196.121.200   52.44.7.216     fedcba54321     10.0.0.0/16
        1

  You will use the information provided by this command to establish a Private
  Space VPN Connection.

  - You must configure your VPN Gateway to use both Tunnels provided by Heroku
  - The VPN Gateway values are the IP addresses of the Private Space Tunnels
  - The Customer Gateway value is the Public IP of your VPN Gateway
  - The VPN Gateway must use the IKE Version shown and the Pre-shared Keys as
  the authentication method
```

### [heroku spaces:vpn:connect](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-connect)

create VPN

```
USAGE
  $ heroku spaces:vpn:connect

OPTIONS
  -c, --cidrs=cidrs  a list of routable CIDRs separated by commas
  -i, --ip=ip        public IP of customer gateway
  -n, --name=name    VPN name
  -s, --space=space  space name

DESCRIPTION
  Private Spaces can be connected to another private network via an IPSec VPN
  connection allowing dynos to connect to hosts on your private networks and
  vice versa.
  The connection is established over the public Internet but all traffic is
  encrypted using IPSec.

EXAMPLES
  $ heroku spaces:vpn:connect --name office --ip 35.161.69.30 --cidrs
  172.16.0.0/16,10.0.0.0/24 --space my-space
       Creating VPN Connection in space my-space... done
       ▸    Use spaces:vpn:wait to track allocation.
```

### [heroku spaces:vpn:connections](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-connections)

list the VPN Connections for a space

```
USAGE
  $ heroku spaces:vpn:connections

OPTIONS
  -s, --space=space  space to get VPN connections from
  --json             output in json format

DESCRIPTION
  Example:

     $ heroku spaces:vpn:connections --space my-space
     === my-space VPN Connections
     Name    Status  Tunnels
     ──────  ──────  ───────
     office  active  UP/UP
```

### [heroku spaces:vpn:destroy](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-destroy)

destroys VPN in a private space

```
USAGE
  $ heroku spaces:vpn:destroy

OPTIONS
  -n, --name=name    name or id of the VPN connection to retrieve config from
  -s, --space=space  space to get peering info from
  --confirm=confirm  set to VPN connection name to bypass confirm prompt

DESCRIPTION
  Example:

       $ heroku spaces:vpn:destroy --space example-space vpn-connection-name
  --confirm vpn-connection-name
       Tearing down VPN Connection vpn-connection-name in space example-space
```

### [heroku spaces:vpn:info](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-info)

display the information for VPN

```
USAGE
  $ heroku spaces:vpn:info

OPTIONS
  -n, --name=name    name or id of the VPN connection to get info from
  -s, --space=space  space the vpn connection belongs to
  --json             output in json format

DESCRIPTION
  Example:

       $ heroku spaces:vpn:info --space my-space vpn-connection-name
       === vpn-connection-name VPN Tunnel Info
       Name:           vpn-connection-name
       ID:             123456789012
       Public IP:      35.161.69.30
       Routable CIDRs: 172.16.0.0/16
       Status:         failed
       Status Message: supplied CIDR block already in use
       === my-space Tunnel Info
       VPN Tunnel  IP Address     Status  Status Last Changed   Details
       ──────────  ─────────────  ──────  ────────────────────  ──────────────
       Tunnel 1    52.44.146.197  UP      2016-10-25T22:09:05Z  status message
       Tunnel 2    52.44.146.197  UP      2016-10-25T22:09:05Z  status message
```

### [heroku spaces:vpn:update](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-update)

update VPN

```
USAGE
  $ heroku spaces:vpn:update

OPTIONS
  -c, --cidrs=cidrs  a list of routable CIDRs separated by commas
  -n, --name=name    VPN name
  -s, --space=space  space name

DESCRIPTION
  Private Spaces can be connected to another private network via an IPSec VPN
  connection allowing dynos to connect to hosts on your private networks and
  vice versa.
  The connection is established over the public Internet but all traffic is
  encrypted using IPSec.

EXAMPLES
  $ heroku spaces:vpn:update --name office --cidrs 172.16.0.0/16,10.0.0.0/24
  --space my-space
       Updating VPN Connection in space my-space... done
```

### [heroku spaces:vpn:wait](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-vpn-wait)

wait for VPN Connection to be created

```
USAGE
  $ heroku spaces:vpn:wait

OPTIONS
  -i, --interval=interval  seconds to wait between poll intervals
  -n, --name=name          name or id of the vpn connection to wait for
  -s, --space=space        space the vpn connection belongs to
  -t, --timeout=timeout    maximum number of seconds to wait
  --json                   output in json format
```

### [heroku spaces:wait](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-spaces-wait)

wait for a space to be created

```
USAGE
  $ heroku spaces:wait

OPTIONS
  -i, --interval=interval  seconds to wait between poll intervals
  -s, --space=space        space to get info of
  -t, --timeout=timeout    maximum number of seconds to wait
  --json                   output in json format
```

### [heroku status](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-status)

display current status of the Heroku platform

```
USAGE
  $ heroku status

OPTIONS
  --json  output in json format
```

### [heroku teams](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-teams)

list the teams that you are a member of

```
USAGE
  $ heroku teams

OPTIONS
  --json  output in json format

DESCRIPTION
  Use heroku members:* to manage team members.
```

### [heroku trusted-ips](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-trusted-ips)

list trusted IP ranges for a space

```
USAGE
  $ heroku trusted-ips

OPTIONS
  -s, --space=space  space to get inbound rules from
  --json             output in json format

DESCRIPTION
  Trusted IP ranges are only available on Private Spaces.

  The space name is a required parameter. Newly created spaces will have
  0.0.0.0/0 set by default
  allowing all traffic to applications in the space. More than one CIDR block
  can be provided at
  a time to the commands listed below. For example 1.2.3.4/20 and 5.6.7.8/20 can
  be added with:
```

### [heroku trusted-ips:add SOURCE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-trusted-ips-add-source)

Add one range to the list of trusted IP ranges

```
USAGE
  $ heroku trusted-ips:add SOURCE

OPTIONS
  -s, --space=space  space to add rule to
  --confirm=confirm  set to space name to bypass confirm prompt

DESCRIPTION
  Uses CIDR notation.

  Example:

       $ heroku trusted-ips:add --space my-space 192.168.2.0/24
       Added 192.168.0.1/24 to trusted IP ranges on my-space
```

### [heroku trusted-ips:remove SOURCE](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-trusted-ips-remove-source)

Remove a range from the list of trusted IP ranges

```
USAGE
  $ heroku trusted-ips:remove SOURCE

OPTIONS
  --confirm=confirm  set to space name to bypass confirm prompt
  --space=space      (required) space to remove rule from

DESCRIPTION
  Uses CIDR notation.

  Example:

       $ heroku trusted-ips:remove --space my-space 192.168.2.0/24
       Removed 192.168.2.0/24 from trusted IP ranges on my-space
```

### [heroku unlock](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-unlock)

unlock an app so any team member can join

```
USAGE
  $ heroku unlock

OPTIONS
  -a, --app=app        (required) app to run command against
  -r, --remote=remote  git remote of app to use
```

### [heroku update \[CHANNEL\]](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-update-channel)

update the heroku CLI

```
USAGE
  $ heroku update [CHANNEL]
```

### [heroku webhooks](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks)

list webhooks on an app

```
USAGE
  $ heroku webhooks

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks
```

### [heroku webhooks:add](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-add)

add a webhook to an app

```
USAGE
  $ heroku webhooks:add

OPTIONS
  -a, --app=app                      app to run command against

  -i, --include=include              (required) comma delimited event types your
                                     server will receive

  -l, --level=level                  (required) notify does not retry, sync will
                                     retry until successful or timeout

  -r, --remote=remote                git remote of app to use

  -s, --secret=secret                value to sign delivery with in
                                     Heroku-Webhook-Hmac-SHA256 header

  -t, --authorization=authorization  authoriation header to send with webhooks

  -u, --url=url                      (required) URL for receiver

EXAMPLE
  $ heroku webhooks:add -i api:dyno -l notify -u https://example.com/hooks
```

### [heroku webhooks:deliveries](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-deliveries)

list webhook deliveries on an app

```
USAGE
  $ heroku webhooks:deliveries

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use
  -s, --status=status  filter deliveries by status

EXAMPLE
  $ heroku webhooks:deliveries
```

### [heroku webhooks:deliveries:info ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-deliveries-info-id)

info for a webhook event on an app

```
USAGE
  $ heroku webhooks:deliveries:info ID

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks:deliveries:info 99999999-9999-9999-9999-999999999999
```

### [heroku webhooks:events](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-events)

list webhook events on an app

```
USAGE
  $ heroku webhooks:events

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks:events
```

### [heroku webhooks:events:info ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-events-info-id)

info for a webhook event on an app

```
USAGE
  $ heroku webhooks:events:info ID

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks:events:info 99999999-9999-9999-9999-999999999999
```

### [heroku webhooks:info ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-info-id)

info for a webhook on an app

```
USAGE
  $ heroku webhooks:info ID

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks:info 99999999-9999-9999-9999-999999999999
```

### [heroku webhooks:remove ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-remove-id)

removes a webhook from an app

```
USAGE
  $ heroku webhooks:remove ID

ARGUMENTS
  ID  id of webhook to remove

OPTIONS
  -a, --app=app        app to run command against
  -r, --remote=remote  git remote of app to use

EXAMPLE
  $ heroku webhooks:remove 99999999-9999-9999-9999-999999999999
```

### [heroku webhooks:update ID](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-webhooks-update-id)

updates a webhook in an app

```
USAGE
  $ heroku webhooks:update ID

OPTIONS
  -a, --app=app                      app to run command against

  -i, --include=include              (required) comma delimited event types your
                                     server will receive

  -l, --level=level                  (required) notify does not retry, sync will
                                     retry until successful or timeout

  -r, --remote=remote                git remote of app to use

  -s, --secret=secret                value to sign delivery with in
                                     Heroku-Webhook-Hmac-SHA256 header

  -t, --authorization=authorization  authoriation header to send with webhooks

  -u, --url=url                      (required) URL for receiver

EXAMPLE
  $ heroku webhooks:update 99999999-9999-9999-9999-999999999999 -i dyno -l
  notify -s 09928c40bf1b191b645174a19f7053d16a180da37332e719ef0998f4c0a2 -u
  https://example.com/hooks
```

### [heroku which COMMAND](https://devcenter.heroku.com/articles/heroku-cli-commands#heroku-which-command)

show which plugin a command is in

```
USAGE
  $ heroku which COMMAND
```


### Explination:

<details>

<summary></summary>


# How Heroku Works 

> ## Excerpt
> This is a high-level, technical description of how Heroku works. It ties together many of the concepts you'll encounter while writing, configuring, deploying and running applications on the Heroku platform.

---
-   [Heroku Architecture](https://devcenter.heroku.com/categories/heroku-architecture)
-   [How Heroku Works](https://devcenter.heroku.com/articles/how-heroku-works)

Last updated June 09, 2020

This is a high-level, technical description of how Heroku works. It ties together many of the concepts you'll encounter while writing, configuring, deploying and running applications on the Heroku platform.

Performing one of the [Getting Started](https://devcenter.heroku.com/start) tutorials will make the concepts in this documentation more concrete.

Read this document sequentially: in order to tell a coherent story, it incrementally unveils and refines the concepts describing the platform.

The final section ties all the definitions together, providing a [deploy-time](https://devcenter.heroku.com/articles/how-heroku-works#deploy) and [runtime-view](https://devcenter.heroku.com/articles/how-heroku-works#runtime) of Heroku.

## [Defining an application](https://devcenter.heroku.com/articles/how-heroku-works#defining-an-application)

Heroku lets you deploy, run and manage applications written in Ruby, Node.js, Java, Python, Clojure, Scala, Go and PHP.

An application is a collection of _source code_ written in one of these languages, perhaps a framework, and some _dependency description_ that instructs a build system as to which additional dependencies are needed in order to build and run the application.

**Terminology** (Preliminary): Applications consist of your source code and a description of any dependencies.

Dependency mechanisms vary across languages: in Ruby you use a `Gemfile`, in Python a `requirements.txt`, in Node.js a `package.json`, in Java a `pom.xml` and so on.

The source code for your application, together with the dependency file, should provide enough information for the Heroku platform to build your application, to produce something that can be executed.

## [Knowing what to execute](https://devcenter.heroku.com/articles/how-heroku-works#knowing-what-to-execute)

You don't need to make many changes to an application in order to run it on Heroku. One requirement is informing the platform as to which parts of your application are runnable.

If you're using some established framework, Heroku can figure it out. For example, in Ruby on Rails, it's typically `rails server`, in Django it's `python <app>/manage.py runserver` and in Node.js it's the `main` field in `package.json`.

**Terminology**: [Procfiles](https://devcenter.heroku.com/articles/procfile) list process types - named commands that you may want executed.

For other applications, you may need to explicitly declare what can be executed. You do this in a text file that accompanies your source code - a [Procfile](https://devcenter.heroku.com/articles/procfile). Each line declares a [process type](https://devcenter.heroku.com/articles/process-model) - a named command that can be executed against your built application. For example, your Procfile may look like this:

```
web: java -jar lib/foobar.jar $PORT
queue: java -jar lib/queue-processor.jar
```

This file declares a `web` process type and provides the command that needs to be executed in order to run it (in this case, `java -jar lib/foobar.jar $PORT`). It also declares a `queue` process type, and its corresponding command.

The earlier definition of an application can now be refined to include this single additional Procfile.

**Terminology**: Applications consist of your source code, a description of any dependencies, and a Procfile.

Heroku is a polyglot platform – it lets you build, run and scale applications in a similar manner across all the languages – utilizing the dependencies and Procfile. The Procfile exposes an architectural aspect of your application (in the above example there are two entry points to the application) and this architecture lets you, for example, scale each part independently. An excellent guide to architecture principles that work well for applications running on Heroku can be found in [Architecting Applications for Heroku](https://devcenter.heroku.com/articles/architecting-apps).

## [Deploying applications](https://devcenter.heroku.com/articles/how-heroku-works#deploying-applications)

[Git](http://git-scm.com/) is a powerful, distributed version control system that many developers use to manage and version source code. The Heroku platform uses Git as the primary means for deploying applications (there are other ways to transport your source code to Heroku, including via an API).

When you create an application on Heroku, it associates a new Git remote, typically named `heroku`, with the local Git repository for your application.

As a result, deploying code is just the familiar `git push`, but to the `heroku` remote instead:

```
$ git push heroku master
```

**Terminology**: Deploying applications involves sending the application to Heroku using either Git, GitHub, or via an API.

There are many other ways of deploying applications too. For example, you can enable [GitHub integration](https://devcenter.heroku.com/articles/github-integration) so that each new pull request is associated with its own new application, which enables all sorts of continuous integration scenarios. Or you can use the [Heroku API](https://devcenter.heroku.com/articles/build-and-release-using-the-api) to build and release apps.

Deployment then, is about moving your application from your local system to Heroku - and Heroku provides several ways in which apps can be deployed.

## [Building applications](https://devcenter.heroku.com/articles/how-heroku-works#building-applications)

When the Heroku platform receives the application source, it initiates a build of the source application. The build mechanism is typically language specific, but follows the same pattern, typically retrieving the specified dependencies, and creating any necessary assets (whether as simple as processing style sheets or as complex as compiling code).

**Advanced**: [Buildpacks](https://devcenter.heroku.com/articles/buildpacks) lie behind the slug compilation process. Buildpacks take your application, its dependencies, and the language runtime, and produce slugs. They're open source - enabling you to extend Heroku to other languages and frameworks.

For example, when the build system receives a Rails application, it may fetch all the dependencies specified in the Gemfile, as well as generate files based on the asset pipeline. A Java application may fetch binary library dependencies using Maven, compile the source code together with those libraries, and produce a JAR file to execute.

The source code for your application, together with the fetched dependencies and output of the build phase such as generated assets or compiled code, as well as the language and framework, are assembled into a [slug](https://devcenter.heroku.com/articles/slug-compiler).

**Terminology**: A [slug](https://devcenter.heroku.com/articles/slug-compiler) is a bundle of your source, fetched dependencies, the language runtime, and compiled/generated output of the build system - ready for execution.

These slugs are a fundamental aspect of what happens during application execution - they contain your compiled, assembled application - ready to run - together with the instructions (the Procfile) of what you may want to execute.

## [Running applications on dynos](https://devcenter.heroku.com/articles/how-heroku-works#running-applications-on-dynos)

Heroku executes applications by running a command you specified in the Procfile, on a [dyno](https://devcenter.heroku.com/articles/dynos) that's been preloaded with your prepared slug (in fact, with your release, which extends your slug and a few items not yet defined: config vars and add-ons).

Think of a running dyno as a lightweight, secure, virtualized Unix container that contains your application slug in its file system.

**Terminology**: [Dynos](https://devcenter.heroku.com/articles/dynos) are isolated, virtualized Unix containers, that provide the environment required to run an application.

Generally, if you deploy an application for the first time, Heroku will run 1 web dyno automatically. In other words, it will boot a dyno, load it with your slug, and execute the command you've associated with the web process type in your Procfile.

You have control over how many dynos are running at any given time. Given the Procfile example earlier, you can start 5 dynos, 3 for the web and 2 for the queue process types, as follows:

```
$ heroku ps:scale web=3 queue=2
```

When you deploy a new version of an application, all of the currently executing dynos are killed, and new ones (with the new release) are started to replace them - preserving the existing dyno formation.

**Terminology**: Your application's [dyno formation](https://devcenter.heroku.com/articles/scaling#dyno-formation) is the total number of currently-executing dynos, divided between the various process types you have scaled.

To understand what's executing, you just need to know what dynos are running which process types:

```
$ heroku ps
== web: 'java lib/foobar.jar $PORT'
web.1: up 2013/02/07 18:59:17 (~ 13m ago)
web.2: up 2013/02/07 18:52:08 (~ 20m ago)
web.3: up 2013/02/07 18:31:14 (~ 41m ago)

== queue: `java lib/queue-processor.jar`
queue.1: up 2013/02/07 18:40:48 (~ 32m ago)
queue.2: up 2013/02/07 18:40:48 (~ 32m ago)
```

Dynos then, are an important means of scaling your application. In this example, the application is well architected to allow for the independent scaling of web and queue worker dynos.

## [Config vars](https://devcenter.heroku.com/articles/how-heroku-works#config-vars)

An application's configuration is everything that is likely to vary between environments (staging, production, developer environments, etc.). This includes backing services such as databases, credentials, or environment variables that provide some specific information to your application.

Heroku lets you run your application with a customizable configuration - the configuration sits outside of your application code and can be changed independently of it.

The configuration for an application is stored in [config vars](https://devcenter.heroku.com/articles/config-vars). For example, here's how to configure an encryption key for an application:

```
$ heroku config:set ENCRYPTION_KEY=my_secret_launch_codes
Adding config vars and restarting demoapp... done, v14
ENCRYPTION_KEY:     my_secret_launch_codes
```

**Terminology**: [Config vars](https://devcenter.heroku.com/articles/config-vars) contain customizable configuration data that can be changed independently of your source code. The configuration is exposed to a running application via environment variables.

At runtime, all of the config vars are exposed as environment variables - so they can be easily extracted programmatically. A Ruby application deployed with the above config var can access it by calling `ENV["ENCRYPTION_KEY"]`.

All dynos in an application will have access to the exact same set of config vars at runtime.

## [Releases](https://devcenter.heroku.com/articles/how-heroku-works#releases)

Earlier, this article stated that to run your application on a dyno, the Heroku platform loaded the dyno with your most recent slug. This needs to be refined: in fact it loads it with the slug and any config variables you have assigned to the application. The combination of slug and configuration is called a [release](https://devcenter.heroku.com/articles/releases).

**Terminology** (Preliminary): [Releases](https://devcenter.heroku.com/articles/releases) are an append-only ledger of slugs and config vars.

All releases are automatically persisted in an append-only ledger, making managing your application, and different releases, a cinch. Use the `heroku releases` command to see the audit trail of release deploys:

```
$ heroku releases
== demoapp Releases
v103 Deploy 582fc95  jon@heroku.com   2013/01/31 12:15:35
v102 Deploy 990d916  jon@heroku.com   2013/01/31 12:01:12
```

The number next to the deploy message, for example `582fc95`, corresponds to the commit hash of the repository you deployed to Heroku.

Every time you deploy a new version of an application, a new slug is created and release is generated.

As Heroku contains a store of the previous releases of your application, it's very easy to rollback and deploy a previous release:

```
$ heroku releases:rollback v102
Rolling back demoapp... done, v102
$ heroku releases
== demoapp Releases
v104 Rollback to v102 jon@heroku.com   2013/01/31 14:11:33 (~15s ago)
v103 Deploy 582fc95   jon@heroku.com   2013/01/31 12:15:35
v102 Deploy 990d916   jon@heroku.com   2013/01/31 12:01:12
```

Making a material change to your application, whether it's changing the source or configuration, results in a new release being created.

A release then, is the mechanism behind how Heroku lets you modify the configuration of your application (the config vars) independently of the application source (stored in the slug) - the release binds them together. Whenever you change a set of config vars associated with your application, a new release will be generated.

## [Dyno manager](https://devcenter.heroku.com/articles/how-heroku-works#dyno-manager)

Part of the Heroku platform, the [dyno manager](https://devcenter.heroku.com/articles/dynos), is responsible for keeping dynos running. For example, dynos are cycled at least once per day, or whenever the dyno manager detects a fault in the running application (such as out of memory exceptions) or problems with the underlying hardware that requires the dyno be moved to a new physical location.

**Terminology**: The [dyno manager](https://devcenter.heroku.com/articles/dynos) of the Heroku platform is responsible for managing dynos across all applications running on Heroku.

This dyno cycling happens transparently and automatically on a regular basis, and is logged.

**Terminology**: Applications that use the free dyno type will [sleep](https://devcenter.heroku.com/articles/free-dyno-hours). When a sleeping application receives HTTP traffic, it will be awakened - causing a delay of a few seconds. Using one of the other [dyno types](https://devcenter.heroku.com/articles/dyno-types) will avoid sleeping.

Because Heroku manages and runs applications, there's no need to manage operating systems or other internal system configuration. [One-off dynos](https://devcenter.heroku.com/articles/one-off-dynos) can be run with their input/output attached to your local terminal. These can also be used to carry out admin tasks that modify the state of shared resources, for example database configuration - perhaps periodically through a [scheduler](https://devcenter.heroku.com/articles/scheduler).

**Terminology**: [One-off Dynos](https://devcenter.heroku.com/articles/one-off-dynos) are temporary dynos that can run with their input/output attached to your local terminal. They're loaded with your latest release.

Here's the simplest way to create and attach to a one-off dyno:

```
$ heroku run bash
Running `bash` attached to terminal... up, run.8963
~ $ ls
```

This will spin up a new dyno, loaded with your release, and then run the `bash` command - which will provide you with a Unix shell (remember that dynos are effectively isolated virtualized Unix containers). Once you've terminated your session, or after a period of inactivity, the dyno will be removed.

Changes to the filesystem on one dyno are not propagated to other dynos and are not persisted across deploys and dyno restarts. A better and more scalable approach is to use a shared resource such as a database or queue.

**Terminology**: Each dyno gets its own [ephemeral filesystem](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem) - with a fresh copy of the most recent release. It can be used as temporary scratchpad, but changes to the filesystem are not reflected to other dynos.

The ephemeral nature of the file system in a dyno can be demonstrated with the above command. If you create a one-off dyno by running `heroku run bash`, the Unix shell on the dyno, and then create a file on that dyno, and then terminate your session - the change is lost. All dynos, even those in the same application, are isolated - and after the session is terminated the dyno will be killed. New dynos are always created from a slug, not from the state of other dynos.

## [Add-ons](https://devcenter.heroku.com/articles/how-heroku-works#add-ons)

Applications typically make use of [add-ons](https://devcenter.heroku.com/articles/add-ons) to provide backing services such as databases, queueing & caching systems, storage, email services and more. Add-ons are provided as services by Heroku and third parties - there's a large [marketplace](https://elements.heroku.com/addons) of add-ons you can choose from.

Heroku treats these add-ons as attached resources: provisioning an add-on is a matter of choosing one from the add-on marketplace, and attaching it to your application.

For example, here is how to add the [Heroku Redis](https://devcenter.heroku.com/articles/heroku-redis) backing store add-on to an application:

```
$ heroku addons:create heroku-redis:hobby-dev
```

Dynos do not share file state, and so add-ons that provide some kind of storage are typically used as a means of communication between dynos in an application. For example, Redis or Postgres could be used as the backing mechanism in a queue; then dynos of the web process type can push job requests onto the queue, and dynos of the queue process type can pull jobs requests from the queue.

The add-on service provider is responsible for the service - and the interface to your application is often provided through a config var. In this example, a `REDIS_URL` will be automatically added to your application when you provision the add-on. You can write code that connects to the service through the URL, for example:

```
uri = URI.parse(ENV["REDIS_URL"])
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
```

**Terminology**: [Add-ons](https://elements.heroku.com/addons/) are third party, specialized, value-added cloud services that can be easily attached to an application, extending its functionality.

Add-ons are associated with an application, much like config vars - and so the earlier definition of a release needs to be refined. A _release_ of your applications is not just your slug and config vars; it's your slug, config vars as well as the set of provisioned add-ons.

**Terminology**: [Releases](https://devcenter.heroku.com/articles/releases) are an append-only ledger of slugs, config vars and add-ons. Heroku maintains an append-only ledger of releases you make.

Much like config vars, whenever you add, remove or change an add-on, a new release is created.

## [Logging and monitoring](https://devcenter.heroku.com/articles/how-heroku-works#logging-and-monitoring)

Heroku treats logs as streams of time-stamped events, and collates the stream of logs produced from all of the processes running in all dynos, and the Heroku platform components, into the [Logplex](https://devcenter.heroku.com/articles/logplex) - a high-performance, real-time system for log delivery.

It's easy to examine the logs across all the platform components and dynos:

```
$ heroku logs
2013-02-11T15:19:10+00:00 heroku[router]: at=info method=GET path=/articles/custom-domains host=mydemoapp.heroku.com fwd=74.58.173.188 dyno=web.1 queue=0 wait=0ms connect=0ms service=1452ms status=200 bytes=5783
2013-02-11T15:19:10+00:00 app[web.2]: Started GET "/" for 1.169.38.175 at 2013-02-11 15:19:10 +0000
2013-02-11T15:19:10+00:00 app[web.1]: Started GET "/" for 2.161.132.15 at 2013-02-11 15:20:10 +0000
```

Here you see 3 timestamped log entries, the first from Heroku's router, the last two from two dynos running the web process type.

**Terminology**: [Logplex](https://devcenter.heroku.com/articles/logplex) automatically collates log entries from all the running dynos of your app, as well as other components such as the routers, providing a single source of activity.

You can also dive into the logs from just a single dyno, and keep the channel open, listening for further events:

```
$ heroku logs --ps web.1 --tail
2013-02-11T15:19:10+00:00 app[web.1]: Started GET "/" for 1.169.38.175 at 2013-02-11 15:19:10 +0000
```

Logplex keeps a limited buffer of log entries solely for performance reasons. To persist them, and action events such as email notification on exception, use a [Logging Add-on](https://elements.heroku.com/addons/#logging), which ties into log drains - an API for receiving the output from Logplex.

## [HTTP routing](https://devcenter.heroku.com/articles/how-heroku-works#http-routing)

Depending on your dyno formation, some of your dynos will be running the command associated with the `web` process type, and some will be running other commands associated with other process types.

The dynos that run process types named `web` are different in one way from all other dynos - they will receive HTTP traffic. Heroku's [HTTP routers](https://devcenter.heroku.com/articles/http-routing) distribute incoming requests for your application across your running web dynos.

So scaling an app's capacity to handle web traffic involves scaling the number of web dynos:

```
$ heroku ps:scale web+5
```

A random selection algorithm is used for HTTP request load balancing across web dynos - and this routing handles both HTTP and HTTPS traffic. It also supports multiple simultaneous connections, as well as timeout handling.

## [Tying it all together](https://devcenter.heroku.com/articles/how-heroku-works#tying-it-all-together)

The concepts explained here can be divided into two buckets: those that involve the development and deployment of an application, and those that involve the runtime operation of the Heroku platform and the application after it's deployed.

The following two sections recapitulate the main components of the platform, separating them into these two buckets.

### [Deploy](https://devcenter.heroku.com/articles/how-heroku-works#deploy)

-   Applications consist of your source code, a description of any dependencies, and a Procfile.
-   [Procfiles](https://devcenter.heroku.com/articles/procfile) list process types - named commands that you may want executed.
-   Deploying applications involves sending the application to Heroku using either Git, GitHub, or via an API.
-   [Buildpacks](https://devcenter.heroku.com/articles/buildpacks) lie behind the slug compilation process. Buildpacks take your application, its dependencies, and the language runtime, and produce slugs.
-   A [slug](https://devcenter.heroku.com/articles/slug-compiler) is a bundle of your source, fetched dependencies, the language runtime, and compiled/generated output of the build system - ready for execution.
-   [Config vars](https://devcenter.heroku.com/articles/config-vars) contain customizable configuration data that can be changed independently of your source code. The configuration is exposed to a running application via environment variables.
-   [Add-ons](https://elements.heroku.com/addons/) are third party, specialized, value-added cloud services that can be easily attached to an application, extending its functionality.
-   A [release](https://devcenter.heroku.com/articles/releases) is a combination of a slug (your application), config vars and add-ons. Heroku maintains an append-only ledger of releases you make.

### [Runtime](https://devcenter.heroku.com/articles/how-heroku-works#runtime)

-   [Dynos](https://devcenter.heroku.com/articles/dynos) are isolated, virtualized Unix containers, that provide the environment required to run an application.
-   Your application's [dyno formation](https://devcenter.heroku.com/articles/scaling#dyno-formation) is the total number of currently-executing dynos, divided between the various process types you have scaled.
-   The [dyno manager](https://devcenter.heroku.com/articles/dynos) is responsible for managing dynos across all applications running on Heroku.
-   Applications that use the free dyno type will [sleep](https://devcenter.heroku.com/articles/free-dyno-hours) after 30 minutes of inactivity. Scaling to multiple web dynos, or a different dyno type, will avoid this.
-   [One-off Dynos](https://devcenter.heroku.com/articles/one-off-dynos) are temporary dynos that run with their input/output attached to your local terminal. They're loaded with your latest release.
-   Each dyno gets its own [ephemeral filesystem](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem) - with a fresh copy of the most recent release. It can be used as temporary scratchpad, but changes to the filesystem are not reflected to other dynos.
-   [Logplex](https://devcenter.heroku.com/articles/logplex) automatically collates log entries from all the running dynos of your app, as well as other components such as the routers, providing a single source of activity.
-   [Scaling](https://devcenter.heroku.com/articles/scaling) an application involves varying the number of dynos of each process type.




# Glossary of Heroku Terminology 

> ## Excerpt
> This article provides definitions for terms that are either specific to the Heroku platform or have a specific meaning on the Heroku platform. This is not an exhaustive list of Heroku products and features.

---
-   [Heroku Architecture](https://devcenter.heroku.com/categories/heroku-architecture)
-   [Glossary of Heroku Terminology](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology)

Last updated July 23, 2019

This article provides definitions for terms that are either specific to the Heroku platform or have a specific meaning on the Heroku platform. This is not an exhaustive list of Heroku products and features.

## [Add-on](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#add-on)

A component you can attach to a Heroku app that provides a supporting service, such as data storage, monitoring, or log management. Add-ons maintained by Heroku and third-party providers are available in the [Elements Marketplace](https://elements.heroku.com/).

[Learn more about add-ons](https://devcenter.heroku.com/articles/add-ons)

## [App](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#app)

A web application on Heroku. Has a set of [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) that run the application's source code. Has a unique `.herokuapp.com` URL and [release](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release) history.

[Learn more about apps](https://devcenter.heroku.com/articles/how-heroku-works#defining-an-application)

## [Buildpack](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#buildpack)

A collection of scripts that transforms a Heroku app's code into the executable bundle (called a [slug](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#slug)) that is run by the app's [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno).

Heroku provides [official buildpacks](https://devcenter.heroku.com/articles/buildpacks#officially-supported-buildpacks) for a variety of programming languages. Third-party buildpacks for other languages and frameworks are avilable in the [Elements Marketplace](https://elements.heroku.com/).

[Learn more about buildpacks](https://devcenter.heroku.com/articles/buildpacks)

## [Config var](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#config-var)

An environment variable that is available across all of a Heroku app's [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno). Its value persists across [releases](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release) and dyno restarts.

[Learn more about config vars](https://devcenter.heroku.com/articles/config-vars)

## [Dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno)

A container that runs a Heroku app's code. When a dyno starts up, it runs a single command that is usually specified in the app's [Procfile](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#procfile). For example, dynos for basic Node.js web apps often run the command `node app.js` to start up a web server.

[Learn more about dynos](https://devcenter.heroku.com/articles/dynos)

## [Dyno formation](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno-formation)

The current set of dynos running across all of a Heroku app's [process types](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#process-type). The number of dynos running for each process type can be scaled up and down independently.

[Learn more about scaling an app's dyno formation](https://devcenter.heroku.com/articles/scaling)

## [Free dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#free-dyno)

The Free [dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) type enables you to host a basic Heroku app for free. Free dynos have several limitations, including:

-   Free web dynos “sleep” if they receive no web traffic for thirty minutes. A sleeping Free dyno will “wake up” upon receiving an HTTP request, but there is a brief delay before the app becomes active.
-   Each Heroku customer is allotted a monthly quota of Free dyno hours that is consumed across all of the customer's Heroku apps that use Free dynos. When this quota is reached for a given month, all of the customer's Free dynos sleep for the remainder of the month.

[Learn more about Free dynos](https://devcenter.heroku.com/articles/free-dyno-hours)

## [Heroku CLI](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#heroku-cli)

The command-line interface for interacting with Heroku apps.

[Learn more about the Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)

## [Heroku Dashboard](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#heroku-dashboard)

The web interface for interacting with Heroku apps. Available at [dashboard.heroku.com](https://dashboard.heroku.com/).

[Learn more about the Heroku Dashboard](https://devcenter.heroku.com/articles/heroku-dashboard)

## [Log drain](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#log-drain)

A destination (i.e., a URL) that the [Logplex](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#logplex) service routes all of a Heroku app's logs to. An app can specify multiple log drains to route its logs to multiple destinations.

[Learn more about log drains](https://devcenter.heroku.com/articles/log-drains)

## [Logplex](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#logplex)

The service that routes logs generated by Heroku apps to applicable [log drains](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#log-drain). Located in the US region.

[Learn more about Logplex](https://devcenter.heroku.com/articles/logplex)

## [Maintenance mode](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#maintenance-mode)

A mode you can enable for a Heroku app to prevent all external web traffic from reaching it. This can be useful for performing maintenance tasks such as database migrations.

[Learn more about maintenance mode](https://devcenter.heroku.com/articles/maintenance-mode)

## [One-off dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#one-off-dyno)

A [dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) you can spin up to perform a one-off operation on a Heroku app, such as a database migration.

[Learn more about one-off dynos](https://devcenter.heroku.com/articles/one-off-dynos)

## [Pipeline](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#pipeline)

A collection of Heroku apps that share the same codebase, typically to represent an app's development, staging, and production versions.

[Learn more about pipelines](https://devcenter.heroku.com/articles/pipelines)

## [Preboot](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#preboot)

If a Heroku app enables preboot, on every [release](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release), Heroku ensures that the new release's [web dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#web-dyno) are started and receiving traffic _before_ the previous release's dynos are terminated.

Preboot can help reduce app latency during a release, but there are important [caveats](https://devcenter.heroku.com/articles/preboot#caveats) to enabling it.

[Learn more about preboot](https://devcenter.heroku.com/articles/preboot)

## [Process type](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#process-type)

A Heroku app declares one or more process types to indicate which command its [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) should run on startup. Each dyno belongs to exactly one process type (such as `web`) and runs the command associated with that process type (such as `node app.js`).

The `web` process type is special, because it is the only process type that enables dynos to receive traffic from the internet.

Process types are declared in an app's [Procfile](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#procfile).

[Learn more about process types](https://devcenter.heroku.com/articles/procfile)

## [Procfile](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#procfile)

A plaintext file that declares the commands that an app's [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) run when they start up. The Procfile is always named `Procfile` _without_ a file extension and lives in an application's root directory.

A basic Procfile looks like this:

```
web: node app.js
```

This example Procfile defines a single [process type](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#process-type), named `web`. Dynos that belong to the `web` process type run the command `node app.js` when they start up.

See also: [Web dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#web-dyno), [Worker dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#worker-dyno)

[Learn more about the Procfile](https://devcenter.heroku.com/articles/procfile)

## [Region](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#region)

The approximate location of the data center that a Heroku app's [dynos](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) run in. Heroku provides two regions to non-enterprise customers: `us` and `eu`.

[Learn more about regions](https://devcenter.heroku.com/articles/regions)

## [Release](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release)

A distinct deployed version of a Heroku app. All of the following events create a new release for an app:

-   A successful app build
-   A change to the value of a [config var](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#config-var) (unless the config var is managed by an [add-on](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#add-on))
-   A [pipeline](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#pipeline) promotion
-   A [rollback](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#rollback)
-   A release via the Platform API
-   Provisioning a new add-on

[Learn more about releases](https://devcenter.heroku.com/articles/releases)

## [Release phase](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release-phase)

An optional phase that occurs just _before_ a new app [release](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release) is deployed. Useful if you have commands that should always run before new code goes live, such as database migrations.

[Learn more about release phase](https://devcenter.heroku.com/articles/release-phase)

## [Rollback](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#rollback)

The process of reverting a Heroku app to the state of a previous [release](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#release). Rolling back creates a _new_ release.

[Learn more about rollback](https://devcenter.heroku.com/articles/releases#rollback)

## [Slug](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#slug)

The executable bundle created from a Heroku app's source code by a [buildpack](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#buildpack).

[Learn more about slugs](https://devcenter.heroku.com/articles/slug-compiler)

## [Stack](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#stack)

The image of an operating system (usually a release of Ubuntu) that runs on a [dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno).

[Learn more about stacks](https://devcenter.heroku.com/articles/stack)

## [Twelve-factor app](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#twelve-factor-app)

A design methodology for the architecture of modern web applications. The conventions of the Heroku platform are largely informed by this methodology.

[Learn more about the twelve-factor app](https://12factor.net/)

## [Web dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#web-dyno)

A [dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) that can receive HTTP traffic. These dynos run the command associated with the `web` process type in an app's [Procfile](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#procfile).

## [Worker dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#worker-dyno)

A [dyno](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#dyno) that _cannot_ receive HTTP traffic. These dynos run the command associated with any process type in an app's [Procfile](https://devcenter.heroku.com/articles/glossary-of-heroku-terminology#procfile) _except_ the `web` process type.



### Heroku CLI:


The Heroku Command Line Interface (CLI) makes it easy to create and manage your Heroku apps directly from the terminal. It's an essential part of using Heroku.

## [Download and install](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)

The Heroku CLI requires **Git**, the popular version control system. If you don't already have Git installed, complete the following before installing the CLI:

-   [Git installation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
-   [First-time Git setup](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

Currently, the Windows installers may display a warning titled “Windows protected your PC”. To run the installation when this warning is shown, click “More info”, verify the publisher as “salesforce.com, inc”, then click the “Run anyway” button.

![apple logo](https://devcenter.heroku.com/images/cli-apple-logo.svg)macOS

```
$ brew tap heroku/brew && brew install heroku
```

## [Other installation methods](https://devcenter.heroku.com/articles/heroku-cli#other-installation-methods)

### [Standalone installation](https://devcenter.heroku.com/articles/heroku-cli#standalone-installation)

The standalone install is a simple tarball with a binary. It contains its own node.js binary and will autoupdate like the above install methods.

To quickly setup into `/usr/local/lib/heroku` and `/usr/local/bin/heroku`, run this script (script requires sudo and not Windows compatible):

```
$ curl https://cli-assets.heroku.com/install.sh | sh
```

Otherwise, download one of the tarballs below and extract it yourself.

#### [Tarballs](https://devcenter.heroku.com/articles/heroku-cli#tarballs)

These are available in `gz` or `xz` compression. `xz` is much smaller but `gz` is more compatible.

-   [macOS](https://cli-assets.heroku.com/heroku-darwin-x64.tar.gz)
-   [Linux (x64)](https://cli-assets.heroku.com/heroku-linux-x64.tar.gz)
-   [Linux (arm)](https://cli-assets.heroku.com/heroku-linux-arm.tar.gz)
-   [Windows (x64)](https://cli-assets.heroku.com/heroku-win32-x64.tar.gz)
-   [Windows (x86)](https://cli-assets.heroku.com/heroku-win32-x86.tar.gz)

### [Ubuntu / Debian apt-get](https://devcenter.heroku.com/articles/heroku-cli#ubuntu-debian-apt-get)

```
$ curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
```

This version does not autoupdate and must be updated manually via `apt-get`. Use the [snap](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) or [standalone installation](https://devcenter.heroku.com/articles/heroku-cli#standalone-installation) for an autoupdating version of the CLI.

### [Arch Linux](https://devcenter.heroku.com/articles/heroku-cli#arch-linux)

[This package](https://aur.archlinux.org/packages/heroku-cli) is community maintained and **not** by Heroku.

```
$ yay -S heroku-cli
```

### [npm](https://devcenter.heroku.com/articles/heroku-cli#npm)

The CLI is built with Node.js and is installable via `npm`. This is a manual install method that can be used in environments where autoupdating is not ideal or where Heroku does not offer a prebuilt Node.js binary.

It's strongly recommended to use one of the other installation methods if possible.

This installation method does not autoupdate and requires you to use your system's version of Node.js, which may be older than the version Heroku develops the CLI against. Heroku uses very current releases of Node.js and does not back-support older versions.

If you use any of the other installation methods the proper version of Node.js is already included, and it doesn't conflict with any other version on your system.

Also, this method won't use the yarn lockfile for dependencies like the others do (even if you install with yarn). This may cause issues if the CLI's dependencies become incompatible in minor or patch releases.

This method is useful if you want fine-grained control over CLI updates such as in a tested script.

This installation method is required for users on ARM and BSD. You must have `node` and `npm` installed already.

```
$ npm install -g heroku
```

## [Verifying your installation](https://devcenter.heroku.com/articles/heroku-cli#verifying-your-installation)

To verify your CLI installation, use the `heroku --version` command:

```
$ heroku --version
heroku/7.0.0 (darwin-x64) node-v8.0.0
```

You should see `heroku/x.y.z` in the output. If you don't, but you have installed the Heroku CLI, it's possible you have an old `heroku` gem on your system. Uninstall it with [these instructions](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-legacy-heroku-gem).

## [Getting started](https://devcenter.heroku.com/articles/heroku-cli#getting-started)

After you install the CLI, run the `heroku login` command. You'll be prompted to enter any key to go to your web browser to complete login. The CLI will then log you in automatically.

```
$ heroku login
heroku: Press any key to open up the browser to login or q to exit
 ›   Warning: If browser does not open, visit
 ›   https://cli-auth.heroku.com/auth/browser/***
heroku: Waiting for login...
Logging in... done
Logged in as me@example.com
```

If you'd prefer to stay in the CLI to enter your credentials, you may run `heroku login -i`

```
$ heroku login -i
heroku: Enter your login credentials
Email: me@example.com
Password: ***************
Two-factor code: ********
Logged in as me@heroku.com
```

The CLI saves your email address and an API token to `~/.netrc` for future use. For more information, see [Heroku CLI Authentication](https://devcenter.heroku.com/articles/authentication).

Now you're ready to create your first Heroku app:

```
$ cd ~/myapp
$ heroku create
Creating app... done, ⬢ sleepy-meadow-81798
https://sleepy-meadow-81798.herokuapp.com/ | https://git.heroku.com/sleepy-meadow-81798.git
```

Check out your preferred language's [getting started guide](https://devcenter.heroku.com/start) for a comprehensive introduction to deploying your first app.

## [Staying up to date](https://devcenter.heroku.com/articles/heroku-cli#staying-up-to-date)

The Heroku CLI keeps itself and its plugins (except linked plugins) up to date automatically, _unless_ you installed the Debian/Ubuntu package or used `npm install`.

When you run a `heroku` command, a background process checks for the latest available version of the CLI. If a new version is found, it's downloaded and stored in `~/.local/share/heroku/client`. This background check happens at most once every 4 hours.

The `heroku` binary checks for an up-to-date client in `~/.local/share/heroku/client` before using the originally installed client.

### [Latest release SHAs](https://devcenter.heroku.com/articles/heroku-cli#latest-release-shas)

#### [Darwin](https://devcenter.heroku.com/articles/heroku-cli#darwin)

-   [x64](https://cli-assets.heroku.com/darwin-x64)

#### [Linux](https://devcenter.heroku.com/articles/heroku-cli#latest-release-shas-linux)

-   [arm](https://cli-assets.heroku.com/linux-arm)
-   [x64](https://cli-assets.heroku.com/linux-x64)

#### [Windows](https://devcenter.heroku.com/articles/heroku-cli#latest-release-shas-windows)

-   [x64](https://cli-assets.heroku.com/win32-x64)
-   [x86](https://cli-assets.heroku.com/win32-x86)

## [Useful CLI plugins](https://devcenter.heroku.com/articles/heroku-cli#useful-cli-plugins)

CLI plugins allow you to extend your CLI installation. Install a CLI plugin with `heroku plugins:install someplugin`. See [Using CLI Plugins](https://devcenter.heroku.com/articles/using-cli-plugins) for more information on plugin management.

Here are some useful plugins you might want to try:

-   [heroku-builds](https://github.com/heroku/heroku-builds) — View builds, purge the build cache, and create builds from tarballs
-   [heroku-repo](https://github.com/heroku/heroku-repo) — Commands to manipulate an app's Heroku git repository
-   [api](https://github.com/heroku/heroku-api-plugin) — Make ad-hoc API requests (such as `heroku api GET /account`)
-   [heroku-pg-extras](https://github.com/heroku/heroku-pg-extras) — Add extra `heroku pg:*` commands
-   [heroku-slugs](https://github.com/heroku/heroku-slugs) — Downloads app slugs
-   [heroku-kafka](https://github.com/heroku/heroku-kafka-jsplugin) — Manage Heroku Kafka
-   [heroku-papertrail](https://github.com/papertrail/papertrail-heroku-plugin) — Display, tail, and search for logs with [Papertrail](https://elements.heroku.com/addons/papertrail).
-   [advanced-scheduler](https://github.com/oavanruiten/advanced-scheduler) — Create and manage your [Advanced Scheduler](https://elements.heroku.com/addons/advanced-scheduler) triggers.

## [CLI architecture](https://devcenter.heroku.com/articles/heroku-cli#cli-architecture)

The Heroku CLI is built with the Open CLI Framework ([oclif](https://oclif.io/)), developed within Heroku / Salesforce. oclif is available as a framework for any developer to build a large or a small CLI. The framework includes a CLI generator, automated documentation creation, and testing infrastructure.

The code for the Heroku CLI is also [open source](https://github.com/heroku/cli). It does _not_ require Node.js or any other dependencies to run. Unless you install the Debian/Ubuntu package or use `npm install`, the CLI contains its own Node.js binary that does not conflict with other applications.

## [Troubleshooting](https://devcenter.heroku.com/articles/heroku-cli#troubleshooting)

If you're having issues with the CLI, first ensure that you're using the [latest version](http://cli-assets.heroku.com/version). If you're not, try updating with `heroku update`.

Not all methods of installation support `heroku update`.

-   If you installed the CLI with `apt`, you need to use `sudo apt-get update && sudo apt-get upgrade heroku` instead.
-   If you installed the CLI with `npm` or `yarn`, you need to use `npm upgrade -g heroku` or `yarn global upgrade heroku` instead.

If the CLI fails to update, try uninstalling it with the [instructions below](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli), then reinstalling it. Ensure that you don't have the legacy Heroku Toolbelt or Heroku Ruby gem installed by using `which heroku` or `where heroku` (on Windows) to confirm what the `heroku` command points to. You might need to modify your `PATH` to include `/usr/local/bin/heroku` (for most installations).

If you're still encountering an issue, you can set the following debugging environment variables to help diagnose it:

Environment Variable

Description

`HEROKU_DEBUG=1`

Shows debugging information mostly related to Heroku API interactions

`HEROKU_DEBUG_HEADERS=1`

Alongside `HEROKU_DEBUG=1`, shows HTTP headers

`DEBUG=*`

Shows very verbose debugging information

You can also check the CLI's error logfile, which is stored at one of the following locations depending on your operating system:

OS

Location

macOS

`~/Library/Caches/heroku/error.log`

Windows

`%LOCALAPPDATA%\heroku\error.log`

Linux/Other

`~/.cache/heroku/error.log` (or `XDG_CACHE_HOME` if set)

If you continue to have problems and the CLI is up to date, or if updating fails for other reasons, you can reset the CLI by deleting its user directories. These directories are replaced automatically and you will not be logged out, but you _will_ lose any installed plugins.

First, run `heroku plugins` to list your installed plugins so you can make sure to reinstall them.

Then, delete the following directories:

Windows:

-   `%LOCALAPPDATA%\heroku`

macOS/Linux/Other:

-   `~/.local/share/heroku` (or `XDG_DATA_HOME` if set)
-   Either `~/Library/Caches/heroku` on macOS, or `~/.cache/heroku` on Linux/Other (or `XDG_CACHE_HOME` if set)

### [Login issues](https://devcenter.heroku.com/articles/heroku-cli#login-issues)

If you are experiencing issues with logging in, try moving your `.netrc` file. This is where the CLI stores credentials:

```
$ mv ~/.netrc ~/.netrc.backup
$ heroku login
```

On Windows, the file is named `_netrc`.

### [Homebrew-specific issues](https://devcenter.heroku.com/articles/heroku-cli#homebrew-specific-issues)

If you get legacy warnings even though you installed the latest homebrew version of heroku, this is happening because the binary `heroku` command in your `PATH` environment variable is not pointing to the version that brew installed.

First, run `which heroku` to see what binary `heroku` is pointing to. If it is not `/usr/local/bin/heroku`, you need to either delete the binary it is pointing to, or make `/usr/local/bin/` higher up in your `PATH` environment variable by modifying your `~/.bashrc` file or equivalent.

Next, run `brew link --overwrite heroku` to make sure that `/usr/local/bin/heroku` is pointing to the new CLI. If you continue to have trouble, run `brew doctor` which should point out any issues with your system.

### [Apple Silicon Issues](https://devcenter.heroku.com/articles/heroku-cli#apple-silicon-issues)

If you are getting the following error on a machine with an Apple M1 chip, this is happening because Rosetta 2 has either not been installed or was declined to be installed.

`Bad CPU type in executable`

Installing [Rosetta 2](https://support.apple.com/en-us/HT211861) will resolve this issue.

If you don't want to install Rosetta 2 on your machine, you can [install the Heroku npm package](https://devcenter.heroku.com/articles/heroku-cli#npm) globally and use your own Node binary locally (currently only v16 of Node has M1 ARM support), though this is not the recommend install method.

## [Uninstalling the Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli)

Note that this also deletes all CLI plugins.

### [macOS](https://devcenter.heroku.com/articles/heroku-cli#macos)

On macOS, you can uninstall the CLI by typing:

```
$ rm -rf /usr/local/heroku /usr/local/lib/heroku /usr/local/bin/heroku ~/.local/share/heroku ~/Library/Caches/heroku
```

#### [Homebrew](https://devcenter.heroku.com/articles/heroku-cli#homebrew)

If you installed the Heroku CLI using Homebrew, you can uninstall the CLI by typing:

```
$ brew uninstall heroku
$ rm -rf ~/.local/share/heroku ~/Library/Caches/heroku
```

### [Linux](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli-linux)

#### [Standalone installs](https://devcenter.heroku.com/articles/heroku-cli#standalone-installs)

For standalone installs, you can uninstall the CLI by typing:

```
$ rm /usr/local/bin/heroku
$ rm -rf /usr/local/lib/heroku /usr/local/heroku
$ rm -rf ~/.local/share/heroku ~/.cache/heroku
```

#### [Debian and Ubuntu installs](https://devcenter.heroku.com/articles/heroku-cli#debian-and-ubuntu-installs)

For Debian/Ubuntu, you can uninstall the CLI by typing:

```
$ sudo apt-get remove heroku heroku-toolbelt
$ sudo rm /etc/apt/sources.list.d/heroku.list
```

If you have `$XDG_DATA_HOME`, and/or `$XDG_CACHE_HOME` it will use those variables instead of `~/.local/share`, and `~/.cache`.

You can remove the release key by running these commands:

```
$ sudo apt-key list
$ sudo apt-key del KEYFROMABOVE
```

### [Windows](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-heroku-cli-windows)

On Windows, to uninstall the Heroku CLI:

1.  Click **`Start > Control Panel > Programs > Programs and Features`**.
2.  Select **`Heroku CLI`**, and then click **`Uninstall`**. (Note that the uninstaller is unsigned)

The Windows uninstaller is _not_ automatically updated alongside the CLI. If it's been a while since you first installed the CLI and you're attempting to uninstall it to fix an issue, you might first need to manually install the latest version of the CLI to obtain an up-to-date uninstaller.

If this is unsuccessful, manually delete `%LOCALAPPDATA%\heroku` along with the directory in Program Files.

### [Uninstalling the legacy heroku gem](https://devcenter.heroku.com/articles/heroku-cli#uninstalling-the-legacy-heroku-gem)

To find out where the executable is located, run `which`.

```
$ which heroku
/usr/local/heroku/bin/heroku
```

The path to the `heroku` command should not be a Ruby gem directory.

If it is, uninstall it and any other `heroku` gems:

```
$ gem uninstall heroku --all
```


#### CLI USAGE:


```
Usage: heroku COMMAND

Help topics, type heroku help TOPIC for more details:

 access          manage user access to apps
 addons          manage add-ons
 apps            manage apps
 authorizations  OAuth authorizations
 buildpacks      manage the buildpacks for an app
 certs           a topic for the ssl plugin
 ci              run an application test suite on Heroku
 clients         OAuth clients on the platform
 config          manage app config vars
 domains         manage the domains for an app
 drains          list all log drains
 features        manage optional features
 git             manage local git repository for app
 keys            manage ssh keys
 labs            experimental features
 local           run heroku app locally
 logs            display recent log output
 maintenance     manage maintenance mode for an app
 members         manage organization members
 notifications   display notifications
 orgs            manage organizations
 pg              manage postgresql databases
 pipelines       manage collections of apps in pipelines
 plugins         manage plugins
 ps              manage dynos (dynos, workers)
 redis           manage heroku redis instances
 regions         list available regions
 releases        manage app releases
 run             run a one-off process inside a Heroku dyno
 sessions        OAuth sessions
 spaces          manage heroku private spaces
 status          status of the Heroku platform
 teams           manage teams
```

The commands are divided into two types: general commands and app commands.

### [General commands](https://devcenter.heroku.com/articles/using-the-cli#general-commands)

General commands operate on your Heroku account as a whole, and are not specific to a particular app. For instance, to get a list of apps you created or are a collaborator on:

```
$ heroku apps
=== user@example.org Apps
example
example2

=== Collaborated Apps
collabapp                 owner@example.org
```

### [App commands](https://devcenter.heroku.com/articles/using-the-cli#app-commands)

App commands are typically executed from within an app's local git clone. The app name is automatically detected by scanning the git remotes for the current working copy, so you don't have to specify which app to operate on explicitly. For example, the `heroku apps:info` command can either be called with `--app` or be executed without any arguments inside the working copy:

```
$ cd example
$ heroku apps:info
=== example-app-69977
Auto Cert Mgmt: false
Dynos:
Git URL:        https://git.heroku.com/example-app-69977.git
Owner:          your@emailaddress.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          heroku-18
Web URL:        https://example-app-69977.herokuapp.com/
```

If you have multiple heroku remotes or want to execute an app command outside of a local working copy, you can specify the remote name or an explicit app name as follows:

```
$ heroku apps:info --app example
$ heroku apps:info --remote production
```

Alternatively, the app name can be specified by setting the `HEROKU_APP` environment variable.

### [Using an HTTP proxy](https://devcenter.heroku.com/articles/using-the-cli#using-an-http-proxy)

If you're behind a firewall that requires use of a proxy to connect with external HTTP/HTTPS services, you can set the `HTTP_PROXY` or `HTTPS_PROXY` environment variables in your local developer environment, before running the `heroku` command.

If you get the error `UNABLE_TO_GET_ISSUER_CERT_LOCALLY` or `ECONNREFUSED` this is likely the reason.

For example, on a Unix system you could do something like this:

```
$ export HTTP_PROXY=http://proxy.server.com:portnumber
or
$ export HTTPS_PROXY=https://proxy.server.com:portnumber
$ heroku login
```

On a Windows machine, either set it in the System Properties/Environment Variables, or do it from the terminal:

```
> set HTTP_PROXY=http://proxy.server.com:portnumber
or
> set HTTPS_PROXY=https://proxy.server.com:portnumber
> heroku login
```

This can go in your `~/.bashrc` (or equivalent) to prevent running this every time you open a new shell session.

If your company's internet requires the use of a MITM proxy, you might get a `SELF_SIGNED_CERT_IN_CHAIN` error . You'll need to set `NODE_EXTRA_CA_CERTS` to the file location of the proxy's Certificate Authority (CA) certificate in pem format. Or if issued the self-signed certificate directly, set `SSL_CERT_FILE` or `SSL_CERT_DIR` to a file/directory containing the MITM certificate.

```
$ export NODE_EXTRA_CA_CERTS=/path/to/ca_cert.pem
$ heroku whoami
```


</details>
