# frozen_string_literal: true

require 'prometheus/customer_auth_processor'

module Jobs
  class PrometheusCustomerAuthStats < ::BaseJob
    self.every_interval = '30s'

    def execute
      client = PrometheusExporter::Client.default
      Stats::CustomerAuthStats.last24_hour.each do |stat|
        metric = CustomerAuthProcessor.collect(
          last24h_customer_price: stat.customer_price.to_f,
          labels: {
            account_id: stat.account_id,
            account_external_id: stat.account_external_id,
            customer_auth_id: stat.customer_auth_id,
            customer_auth_external_id: stat.customer_auth_external_id,
            customer_auth_external_type: stat.customer_auth_external_type
          }
        )
        client.send_json(metric)
      end
    end
  end
end
