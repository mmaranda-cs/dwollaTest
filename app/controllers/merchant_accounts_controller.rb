class MerchantAccountsController < ApplicationController

  require 'dwolla_v2'

  def new
    @dwolla_merchant_id = params[:format]
    @merchant_account = MerchantAccount.new
  end

  def create
    @app_token = create_app_Token

    puts(params[:merchant_account][:dwolla_merchant_id])

    customer_url = 'https://api-sandbox.dwolla.com/customers/'
    request_url = customer_url+params[:merchant_account][:dwolla_merchant_id]+'/funding-sources'

    request_body = {
        :routingNumber => params[:merchant_account][:routing_number],
        :accountNumber => params[:merchant_account][:account_number],
        :name => params[:merchant_account][:name_for_account],
        :bankAccountType => 'checking',
        # Fo more information about customer types: https://developers.dwolla.com/concepts/customer-types#customer-types
        # Not required but suggested
        # :ipAddress => '0.0.0.0'
        # :businessName => 'TEST BUSINESS'
    }

    funding_source = @app_token.post request_url, request_body
    funding_source.response_headers[:location]

    puts("###################################################")
    puts(request_url)
    puts(request_body)
    puts("###################################################")
    puts("###################################################")
    puts(funding_source.response_headers)
    puts("###################################################")
    puts(funding_source.response_headers[:location])
    puts("###################################################")
    puts("###################################################")

    # newly_minted_customer = @app_token.get customer.response_headers[:location]

    # redirect_to dwolla_merchants_path(newly_minted_customer.id)
  end

  private

  def create_app_Token
    first_endpoint = DwollaSecurity.first
    $dwolla = DwollaV2::Client.new(key: first_endpoint.key, secret: first_endpoint.secret) do |config|
      if first_endpoint.target.include? "sandbox"
        config.environment = :sandbox # optional - defaults to production
      end
    end

    # create an application token
    $dwolla.auths.client
  end

end
