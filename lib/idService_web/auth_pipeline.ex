defmodule IdService.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :idService,
    module: IdService.Guardian,
    error_handler: IdService.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
