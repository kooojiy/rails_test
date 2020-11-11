env :PATH, ENV['PATH'] # 絶対パスから相対パス指定
set :output, 'log/cron.log' # ログの出力先ファイルを設定
set :environment, :development # 環境を設定

# 一日おきに実行
every 1.day, :at => '7:00 am' do 
    runner "EventScraping.scrapeFirst"
    runner "EventScraping.scrapeSecond"
end
