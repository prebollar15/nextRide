# NextRide

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Export environmental variables using `source ./config/.env`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

Must add .env file to the .config directory using the following export variables:

UeberAuth GitHub Client ID & Secret Key
- export GITHUB_CLIENT_ID=""
- export GITHUB_SECRET_KEY=""

Dev-Postgres Database
- export DEV_POSTGRES_USERNAME=""
- export DEV_POSTGRES_PASSWORD=""
- export DEV_POSTGRES_DATABASE=""

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

To run in prod: PORT=4001 MIX_ENV=prod mix phx.server