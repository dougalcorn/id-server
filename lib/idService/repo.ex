defmodule IdService.Repo do
  use Ecto.Repo,
    otp_app: :idService,
    adapter: Ecto.Adapters.Postgres
end
