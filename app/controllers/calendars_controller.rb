class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek #21行目のメソッドが実行される
    @plan = Plan.new #プランモデルにデータを追加する空箱(.newメソッド)を用意している　@planを初期化するイメージ
  end

  # 予定の保存
  def create
    Plan.create(plan_params) #かっこ内のplan_paramsはストロングパラメータにこのモデルにこの列名のものを追加するけど良い？と確認している 
    redirect_to action: :index #indexアクションを実行する
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan) #paramsは送られてきたデータが格納されている
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans}
      @week_days.push(days)
    end

  end
end
