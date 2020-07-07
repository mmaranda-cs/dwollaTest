class DwollaSecuritiesController < ApplicationController

  require 'dwolla_v2'

  def index
    @dwolla_endpoints = DwollaSecurity.all

    first_endpoint = DwollaSecurity.first
    app_key = first_endpoint.key
    app_secret = first_endpoint.secret

    $dwolla = DwollaV2::Client.new(key: first_endpoint.key, secret: first_endpoint.secret) do |config|
      if first_endpoint.target.include? "sandbox"
        config.environment = :sandbox # optional - defaults to production
      end
    end

    # create an application token
    app_token = $dwolla.auths.client

    cusomter_randomizer = rand(100000000000)

    # request_body = {
    #     :firstName => "Jane#{cusomter_randomizer}",
    #     :lastName => "Merchant#{cusomter_randomizer}",
    #     :email => "jmerchant#{cusomter_randomizer}@nomail.net",
    #     :type => 'receive-only',
    #     # Fo more information about customer types: https://developers.dwolla.com/concepts/customer-types#customer-types
    #     # Not required but suggested
    #     # :ipAddress => '0.0.0.0'
    #     # businessName => 'TEST BUSINESS'
    # }
    #
    # customer = app_token.post "customers", request_body
    # customer.response_headers[:location]

    customers = app_token.get "customers", limit: 10
    for customer in customers
      puts(customer)
    end

  end

  def show
    @dwolla_endpoint = DwollaSecurity.find(params[:id])
  end



end
