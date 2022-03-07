# Heroku Cheat Sheet

Heroku lets you deploy, run and manage applications written in Ruby, Node.js, Java, Python, Clojure, Scala, Go and PHP. An application is a…

---

### Heroku Deploy Guides & Cheatsheet Compilation

#### Heroku lets you deploy, run and manage applications written in Ruby, Node.js, Java, Python, Clojure, Scala, Go and PHP. An application is a collection of _source code_ written in one of these languages, perhaps a framework, and some _dependency description_ that instructs a build system as to which additional dependencies are needed in order to build and run the application.

\#### This is a quick tutorial explaining how to get a static website hosted on Heroku.

![](https://cdn-images-1.medium.com/max/800/0*gAOfoFENBTwE5mqJ.gif)

> Heroku hosts apps on the internet, not static websites. To get it to run your static portfolio, personal blog, etc., you need to trick Heroku into thinking your website is a PHP app.

> Basic Assumptions You want to deploy some straight-up HTML, CSS, JS, maybe a few images. Nothing fancy here. You are in the root directory of your site (i.e. the directory that contains all subdirectories and files for the site) The root directory contains a main HTML page, e.g. index.html A Heroku app and remote are set up and ready to go Steps Add a file called composer.json to the root directory by running touch composer.json Add a file called index.php to the root directory by running touch index.php Rename the homepage (e.g. index.html) to home.html In index.php, add the following line: In composer.json, add the following line: {} Run git push heroku master Done! Visit your deployed single-page website, hosted by Heroku (as a fake PHP app ☺).

[**A list of all of my articles to link to future posts**\
\_You should probably skip this one… seriously it's just for internal use!\_bryanguner.medium.com](https://bryanguner.medium.com/a-list-of-all-of-my-articles-to-link-to-future-posts-1f6f88ebdf5b)

[**ALLOFMYOTHERARTICLES**\
\_You should probably skip this one… seriously it's just for internal use!\_bryanguner.medium.com](https://bryanguner.medium.com/a-list-of-all-of-my-articles-to-link-to-future-posts-1f6f88ebdf5b)

### Steps:

> **-heavily borrowed from this** [**free code camp article**](https://www.freecodecamp.org/news/how-to-deploy-an-application-to-heroku/) **by Stan Georgian.**

### 1.) Create the project

Starting with any basic boilerplate demo server with NodeJS.

Open a terminal and run the command `npm init -y` in order to create a new project. The dummy server will be written in [Express](https://expressjs.com), so we need to run the `npm install express` command to install this module.

Once this library is installed, we can create a new file for our project, named `app.js`.

We can start the application by running `node app.js`. Then we can try it out at the following URL `http://localhost:3000`. At this point you should see the message `Hello World` in the browser.

\### 2.) Version Control

![](https://cdn-images-1.medium.com/max/800/0*3FuViRnU9-PB5uqf.PNG)

The next step is to choose a version control system and to place our code in a development platform in a repository.

The most popular version control system is [Git](https://git-scm.com) along with [Github](https://github.com) as a development platform, so that's what we'll use here.

On GitHub, go ahead and create a new repository for your application, like this:

To upload your local code into a repository, you need to run the commands that are listed on GitHub after you click \`Create repository\` button:\*\*!\*\* Before we do this, we must ignore some files. We want to upload to the repository only the code that we write, without the dependencies (the installed modules).

![](https://cdn-images-1.medium.com/max/800/0*pyHPJP0kjAV9sij1.PNG)

![](https://cdn-images-1.medium.com/max/800/0*C7nOWV7ygqTRdqcu.PNG)

For that, we need to create a new file `.gitignore` and inside it write the file that we want to ignore.

Now, we can write the commands listed in the picture above (the one from GitHub).

![](https://cdn-images-1.medium.com/max/800/0*T-9QyGzUdWvFuA-D.PNG)

If you ran the commands correctly, then it'll be on your repository's page. If you refresh it you should see your files, except the one that you explicitly ignored, namely `node modules`.

\### Step 3 — Link the repository with Heroku

![](https://cdn-images-1.medium.com/max/800/0*_WzaY9T9A0FsvPgb.PNG)

At this step, we can link the repository from Github to our Heroku application.

First, create a new application on Heroku and follow the steps listed on the platform.

Once the application has been created, a window similar to this should appear:Now, if you look at the navigation at the top, you'll see \`Overview\`, \`Resources\`, \`Deploy\`, \`Metrics\` and so on. Be sure that \`Deploy\` is selected. Then on the second row, click on the GitHub icon.Search for the desired application, which is \`demo-deploy-app-09\` in our case. Then click \`Connect\`.Once the application is successfully connected with your Heroku account, you can click \`Deploy Branch\` to deploy your application.

![](https://cdn-images-1.medium.com/max/800/0*kAZI5kiisUiZ2Z9D.PNG)

![](https://cdn-images-1.medium.com/max/800/0*T89joca8hXRO8UsL.PNG)

![](https://cdn-images-1.medium.com/max/800/0*cowa0t6DgTqjUdjR.PNG)

![](https://cdn-images-1.medium.com/max/800/0*J9tMV455odrM00UJ.PNG)

If you want, you can also select the option `Enable Automatic Deploys` which will automatically pull the code from your Github repository every time you make a push to that repository.

Once the application has been deployed, you can click on View to open your application.

\### Step 4 — Configure Heroku to properly run the application

![](https://cdn-images-1.medium.com/max/800/0*9dBdxScA9_dIEz1Q.PNG)

If you open the application at this point, you should see something like this:

That's right, an error. That's because Heroku doesn't know how to start our application.

![](https://cdn-images-1.medium.com/max/800/0*rMZ8aneIjG3nx211.PNG)

If you remember, we ran the command `node app.js` to start the application locally.\
Heroku has no way of knowing what commands it needs to run to start the application, and that's why it threw an error.

To solve this problem, we must create a new file named `Procfile` with the following content: `web: node ./app.js`.

To update our application, all we need to do is push a new commit to GitHub. If we have enabled the `Automatic Deploys` option, then the code will be automatically pulled to Heroku. Otherwise we need to click on `Deploy Branch` again.

---
