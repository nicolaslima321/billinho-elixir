# Billinho on Elixir

### Overview

Billinho is a project that are supposed to simulate an API for management of payments for students from a university/institution that are currently studying.

### Setup

* To configure and initialize the project, you must have **docker** and **docker-compose** installed on your O.S. But, you also can configure locally.

### Dockerized Environment (Recommended)

* Run `docker-compose up` on your terminal, it will build the containers, and initialize then, the project will be available at [`localhost:4000`](http://localhost:4000) from your browser.
* To setup the database, on project's folder, run `docker-compose exec billinho bash`, and inside of billinho's container, run `mix ecto.setup`

### Locally

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Tips

* The project has 4 principals Entities, that are **Students**, **Institutions**, **Enrolments** and **Invoices**, you have endpoints for creation, update, delete, list, show specific, for everyone of then, with the exception of invoices, that are only created through enrolment creation.

  #### Principal Endpoints:
  * Creation of Students - ***/students*** **[POST]**
  * Creation of Institutions - ***/institutions*** **[POST]**
  * Creation of Enrolments- ***/enrolments*** **[POST]**
.
  * List of Students - ***/students*** **[GET]**
  * List of Institutions - ***/institutions*** **[GET]**
  * List of Enrolments- ***/enrolments*** **[GET]**
  * List of Invoices- ***/invoices*** **[GET]**
.
  * Show Student - ***/students/:id*** **[GET]**
  * Show Institution - ***/institutions/:id*** **[GET]**
  * Show Enrolment- ***/enrolments/:id*** **[GET]**
  * Show Invoice - ***/invoices/:id*** **[GET]**