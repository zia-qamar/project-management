# Project Conversation Management!

This is a web application for managing projects and their associated comments. The application allows users to create new projects, view project details, and update the status of a project. Users can also create comments for a project and view all comments associated with a project.


Please setup your environment following the `Getting Started`.

## Getting Started

1. Clone repository

2. Install Ruby version

```sh
$ rvm install 2.7.3
```

3. Install PostgreSQL >9.4 and start it

```sh
$ brew install postgresql
```

4. Navigate to project directory and run following

```sh
bundle install
rails db:create
rails db:migrate
```
5. Run specs

```sh
$ rspec
```

6. Start the server

```sh
$ rails server
```

7. Open your browser

[http://localhost:3000](http://localhost:3000/)

### Demo Video
[Here](https://drive.google.com/file/d/1kBvG6GyafYKlX5NX8--SGcAN292-pnRM/view?usp=sharing)

### Future Improvements
There are several improvements that could be made to the application, including:

* Adding the ability to assign projects to specific users or teams
* Allow to remove or update project comments
* Adding user authorization for accessing projects and comments
* Adding more robust error handling and error messages

