defmodule SimpleOAuth.SGM.Client do
  defguardp is_2xx(term) when is_integer(term) and term >= 200 and term <= 299

  def user_info(params) do
    client()
    |> Req.get(url: "/oauthweb/user/userinfo" <> "?" <> URI.encode_query(params, :rfc3986))
    |> case do
      {:ok, %Req.Response{status: status, body: body}} when is_2xx(status) -> {:ok, body}
      _ -> :error
    end
  end

  def token(params) do
    client()
    |> Req.get(url: "/oauthweb/oauth/token" <> "?" <> URI.encode_query(params, :rfc3986))
    |> case do
      {:ok, %Req.Response{status: status, body: body}} when is_2xx(status) -> {:ok, body}
      _ -> :error
    end
  end

  defp client() do
    Req.new(base_url: "http://idp.saic-gm.com", retry: false)
  end
end
