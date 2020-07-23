class FundTransfersController < ApplicationController
  require 'dwolla_v2'

  def new
    puts"#{params[:format]}"

    @account_id = params[:format]
    @fund_transfer = FundTransfer.new

    @app_token = create_app_Token

    root = @app_token.get "/"
    account_url = root._links.account.href
    funding_sources = @app_token.get "#{account_url}/funding-sources"
    @sandbox_accounts = funding_sources._embedded['funding-sources']
    origin_account_url = funding_sources._embedded['funding-sources'][0]
    puts("ACCOUNT ROOT URL="+origin_account_url.id)
    @funding_source_account = origin_account_url.id

  end

  def create

    @app_token = create_app_Token

    puts(params[:format])

    source_id = params[:fund_transfer][:source_account_id]
    target_id = params[:fund_transfer][:target_account_id]
    transfer_total = params[:fund_transfer][:transfer_total]

    transfer_request = {
        :_links => {
            :source => {
                :href => "https://api-sandbox.dwolla.com/funding-sources/#{source_id}"
            },
            :destination => {
                :href => "https://api-sandbox.dwolla.com/funding-sources/#{target_id}"
            }
        },
        :amount => {
            :currency => "USD",
            :value => transfer_total
        }
    }

    transfer = @app_token.post "transfers", transfer_request
    transfer.response_headers[:location]


    target_account = @app_token.get "https://api-sandbox.dwolla.com/funding-sources/#{target_id}"
    target_customer = @app_token.get target_account._links.customer.href
    @target = target_customer.id

    redirect_to dwolla_merchant_path(@target)
  end

  # def show
  #   # create an application token
  #   @app_token = create_app_Token
  #
  #   customer_url = 'https://api-sandbox.dwolla.com/funding-sources/'
  #   request_url = customer_url+params[:id]
  #
  #   @customer = @app_token.get "#{request_url}"
  #
  #   @customer_funding_sources = funding_sources._embedded['funding-sources']
  #
  # end

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
