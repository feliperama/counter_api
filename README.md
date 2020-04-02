### Date
Thursday, April 2 of 2020
### Location of deployed application
https://cherry-sundae-20794.herokuapp.com/

### Source code
https://github.com/feliperama/counter_api

### Time spent
I expended 7 hours approximately.

### Assumptions made
The main assumption is that the current_int is a Global Counter. This means that any user of the api which makes changes at this counter will be perceived by any other user.

### Shortcuts/Compromises made
On the API side, on the session controller, I made a simple signin where the consumers (frontend, curl commands) send a plain text email and password in a json payload for authentication. This was made to not overcomplicate the client, but is NOT product ready. For me, the best way to do this would be using something like a digest authentication, or at least a basic http authentication. 

### Stretch goals attempted
I tried all the stretched goals, as also added a new one that I think is important:
1. _"Build a UI for the service, especially the account creation functionality."_
    * I made this integrated in the same rails application, so I could reuse the authentication functionalities in both API and UI.
    * When you open the app link, you will be requested to sign_up or sign_in.
    * When you are sign_in, it will be prompeted a page showing your email, the Token to be used in your API requests and also the curl commands to facilitate your tests.
2. _"Allow sign up using OAuth"_
    * I used devise and omniauth-facebook gems to make it possible.
    * This feature is enabled at the UI at "Sign in with facebook"
3. _"Deploy your API and include the link in your README so we can try it out without having to run it."_
     * I deployed at Heroku. You just need to open the link on the beginning of the readme
     * I also created a docker configuration in the case you want to try it locally or make changes with a script to run it locally.
4. _"Additional: Redundancy and a additional Docker deployment"_
     * I created a docker setup (Dockerfile/docker-compose.yml) to build and start locally a setup with redudancy, composed of: 1) one Nginx web server made the load balance between 2) Two counter_api servers and 3) one postgres instance shared between the two api servers.
     * although I created this to show some necessary redundancy on production in the case you goes to deploy it on other PAAS like AWS or GCP, you can use this to build and run locally!

TIP when facebook/devise/heroku errors: 2h of the 7h of this task was trying to make facebook login works with heroku for devise and omniauth-facebook, so here is a tip which can saved any other brave soul :)
* In your developers.facebook.com/apps, inside your login app go on “facebook login” in the left side. Than, at “Valid OAuth Redirects Urls” you should put the EXACTLY callback route configured for your devise with omniauth. Just the domain of your page it will not work!
* [REF1](https://wp-native-articles.com/blog/news/how-to-fix-facebook-apps-error-cant-load-url-domain-url-isnt-included-apps-domains/) [REF2](https://www.youtube.com/watch?v=mdhubrzV5y8)

### Instructions to run assignment locally
The application is deployed at heroku, but if you want to run it locally you just need to:
##DOCKER (recommended)
1. Have Docker and Docker Compose installed.
   * I recommend download and install this https://hub.docker.com/editions/community/docker-ce-desktop-mac
3. Clone the repository and enter in the project directory:
   * git clone https://github.com/feliperama/counter_api.git
   * cd counter_api
2. Just run the command below (make sure you have docker-compose installed using _docker-compose --version_ at terminal first)
   * docker-compose up --build
3. DONE! you already have a setup with nginx, two api servers and a postgres database running on your machine! It's on your localhost:80 Just open your browser and type:
   * http://localhost
### What did you not include in your solution that you want us to know about?
More than the shortcuts, I would like to make a React.js frontend for this, but I run out of the time after configuring the facebook omniauth and docker redundancy. I know it was not mandatory but I would like to have a better separation between frontend and backend. Probably I will try it later.

### Other information about your submission that you feel it's important that we know if applicable.
Just some highlights on things that are interesting from the technical point of view:
* I configured nginx to use a hash distribution by IP address. **So if you start the request to one server it will stay in the same server**. This was not mandatory, I tested without this and everything worked, but it's a good configuration in the case if you have any kind of state that is not shared by your database.  By the way, never do this if you want a scale your application, share your state using some database/caching outside of your application.
* The secret keys for facebook was configured in environment variables and away from the code. I set different keys for production and development.

### Your feedback on this technical challenge
I really enjoy this technical challenge, honestly I prefer this over any typical leetcode challenge. It was simple but involves many components and real work. I made a little extension to use docker/nginx because I just felt that it is important to be worried about redundancy when you are doing an application to be production ready. However, I don't think it's necessary to include something like this in the stretched goals.

