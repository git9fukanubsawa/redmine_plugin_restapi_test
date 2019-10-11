require 'base64'
require 'uri'
require 'json'

class RestapisController < ApplicationController
    def index
    end

    def result
        url = params[:url]
        user = params[:user]
        password = params[:password]
        data_name = params[:data_name]
        data_body = params[:data_body]
        http_method = params[:http_method]
        if http_method == "get"
            @result = get_restapi_info(url, user, password)
        elsif http_method == "post"
            @result = post_restapi_info(url, user, password, data_name, data_body)
        else
            redirect_to action: 'index'
        end
        
    end

    def get_restapi_info(target_uri, user, password)
        #HTTP REST API GET用メソッド
        uri = URI.parse(target_uri)
        http = Net::HTTP.new(uri.hostname, uri.port)
        req = Net::HTTP::Get.new(uri.request_uri)
        req['authorization'] = get_basic64_str(user, password)
        req['Content-Type'] = 'application/json'
        response = http.request(req)
        data = JSON.parse(response.body)
    end

    def post_restapi_info(target_uri, user, password, data_name, data_body)
        #HTTP REST API POST用メソッド
        uri = URI.parse(target_uri)
        http = Net::HTTP.new(uri.hostname, uri.port)
        req = Net::HTTP::Post.new(uri.request_uri)
        req['authorization'] = get_basic64_str(user, password)
        req['Content-Type'] = 'application/json'
        #外部変数としてAWXへ渡すデータをjsonデータに変換する。
        data = {}
        if data_name != "" and data_body != ""
            contents = {}
            contents[data_name.to_s] = data_body.to_s
            data['extra_vars'] = contents
        end
        data_json = JSON.generate(data)
        # bodyに添付する
        req.body = data_json
        response = http.request(req)
        data = JSON.parse(response.body)

    end

    def get_basic64_str(user, password)
        #ユーザー、パスワードをbase64でエンコード
        basicauth = "Basic " + Base64.encode64(user.to_s + ":" + password.to_s).chop
    end

end