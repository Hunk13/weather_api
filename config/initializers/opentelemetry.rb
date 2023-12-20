require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/rack'
require 'opentelemetry/instrumentation/rails'
require 'opentelemetry/instrumentation/active_record'

OTEL_EXPORTER = OpenTelemetry::Exporter::OTLP::Exporter.new(
  endpoint: ENV["OTEL_EXPORTER_OTLP_ENDPOINT"],
  headers: { "X-Scope-OrgID" => "WeatherAPI" },
)

processor = OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(OTEL_EXPORTER)

OpenTelemetry::SDK.configure do |c|
  c.resource = OpenTelemetry::SDK::Resources::Resource.create({
    OpenTelemetry::SemanticConventions::Resource::SERVICE_NAMESPACE => "weather-api",
    OpenTelemetry::SemanticConventions::Resource::SERVICE_NAME => ENV["PROGRAM_NAME"].to_s || "weather-api",
    OpenTelemetry::SemanticConventions::Resource::SERVICE_INSTANCE_ID => Socket.gethostname(),
    OpenTelemetry::SemanticConventions::Resource::SERVICE_VERSION => ENV["PROGRAM_VERSION"] || "0.0.1",
  })

  # enables all instrumentation!
  # c.use_all()

  # Or, if you prefer to filter specific instrumentation,
  # you can pick some of them like this https://scoutapm.com/blog/configuring-opentelemetry-in-ruby
  ##### Instruments
  c.use 'OpenTelemetry::Instrumentation::ActionPack'
  c.use 'OpenTelemetry::Instrumentation::ActionView'
  c.use 'OpenTelemetry::Instrumentation::Faraday'
  c.use 'OpenTelemetry::Instrumentation::Rack'
  c.use 'OpenTelemetry::Instrumentation::Rails'
  c.use 'OpenTelemetry::Instrumentation::ActiveRecord'
  c.use 'OpenTelemetry::Instrumentation::PG', {
  #   # By default, this instrumentation includes the executed SQL as the `db.statement`
  #   # semantic attribute. Optionally, you may disable the inclusion of this attribute entirely by
  #   # setting this option to :omit or sanitize the attribute by setting to :obfuscate
    db_statement: :obfuscate,
  }
  # c.use 'OpenTelemetry::Instrumentation::ActiveJob'
  # c.use 'OpenTelemetry::Instrumentation::ConcurrentRuby'
  # c.use 'OpenTelemetry::Instrumentation::HttpClient'
  # c.use 'OpenTelemetry::Instrumentation::Net::HTTP'
  # c.use 'OpenTelemetry::Instrumentation::Redis'
  # c.use 'OpenTelemetry::Instrumentation::RestClient'
  # c.use 'OpenTelemetry::Instrumentation::RubyKafka'
  # c.use 'OpenTelemetry::Instrumentation::Sidekiq'

  # Set OpenTelemetry library logger
  c.logger = Logger.new(STDOUT)

  # Exporter and Processor configuration
  c.add_span_processor(processor)
end
