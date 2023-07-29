class Statistics
  MIN_MONTHLY_STATS_DAYS = 5
  MIN_TOTAL_RESULT_COUNT = 200

  class << self
    def daily_stats
      records = Result.where(timestamp: date_today.midnight..date_today.end_of_day).group_by(&:subject)
      records.each do |subject, results|
        calculate_stats(subject, results)
      end

      monthly_stats if third_monday?(date_today)
    end

    private

    def calculate_stats(subject, results)
      marks = results.pluck(:marks)
      stats = { daily_result_stat_date: date_today, subject: subject,
                daily_low: marks.min, daily_high: marks.max, result_count: results.count }

      DailyResultStat.create(stats)
    end

    def monthly_stats
      subjects = DailyResultStat.distinct.pluck(:subject)
      subjects.each do |subject|
        calculate_monthly_stats(subject)
      end
    end

    def calculate_monthly_stats(subject)
      go_back_in_days = MIN_MONTHLY_STATS_DAYS
      stats = []
      while stats.sum(&:result_count) < MIN_TOTAL_RESULT_COUNT
        start_date = date_today - go_back_in_days
        stats = DailyResultStat.where(daily_result_stat_date: start_date..date_today, subject: subject)
                               .order(daily_result_stat_date: :desc)
        go_back_in_days += 1
      end

      count_used = stats.sum(&:result_count)
      stats_size = stats.size
      avg_low = stats.sum(&:daily_low) / stats_size
      avg_high = stats.sum(&:daily_high) / stats_size
      month_stats = { monthly_average_date: date_today, subject: subject,
                      monthly_avg_low: avg_low, monthly_avg_high: avg_high, monthly_result_count_used: count_used }

      MonthlyAverage.create(month_stats)
    end

    def third_monday?(date)
      first_day = date.beginning_of_month
      arr = (first_day..(first_day.end_of_month)).to_a.select { |d| d.wday == 1 }
      arr.third == date
    end

    def date_today
      DateTime.current
    end
  end
end
