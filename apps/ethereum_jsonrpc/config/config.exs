use Mix.Config

config :ethereum_jsonrpc, EthereumJSONRPC.RequestCoordinator,
  rolling_window_opts: [
    window_count: 12,
    duration: :timer.minutes(1),
    table: EthereumJSONRPC.RequestCoordinator.TimeoutCounter
  ],
  wait_per_timeout: :timer.seconds(20),
  max_jitter: :timer.seconds(2)

config :ethereum_jsonrpc, EthereumJSONRPC.Tracer,
  service: :ethereum_jsonrpc,
  adapter: SpandexDatadog.Adapter,
  trace_key: :blockscout

config :logger, :ethereum_jsonrpc,
  # keep synced with `config/config.exs`
  format: "$time $metadata[$level] $message\n",
  metadata: [:application, :request_id],
  metadata_filter: [application: :ethereum_jsonrpc]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
