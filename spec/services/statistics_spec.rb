# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Statistics do
  describe '.daily_stats' do
    subject { described_class.daily_stats }

    context 'when results are not submitted in a day' do
      let(:previous_timestamp) { 2.days.ago }

      before do
        create(:result, timestamp: previous_timestamp, subject: 'Science', marks: 100.5)
        create(:result, timestamp: previous_timestamp, subject: 'Science', marks: 80.0)
        create(:result, timestamp: previous_timestamp, subject: 'Science', marks: 120.5)
      end

      it 'does not calculate daily result stats' do
        expect { subject }.not_to change(DailyResultStat, :count)
      end
    end

    context 'when results are submitted in a day' do
      let(:timestamp) { Time.zone.now }
      let(:science_stats) { DailyResultStat.find_by(subject: 'Science') }
      let(:maths_stats) { DailyResultStat.find_by(subject: 'Maths') }

      before do
        create(:result, timestamp: timestamp, subject: 'Science', marks: 100.5)
        create(:result, timestamp: timestamp, subject: 'Science', marks: 80.0)
        create(:result, timestamp: timestamp, subject: 'Science', marks: 120.5)
        create(:result, timestamp: timestamp, subject: 'Maths', marks: 90.5)
        create(:result, timestamp: timestamp, subject: 'Maths', marks: 110.5)
      end

      it 'calculates daily result stats and store in db' do
        expect { subject }.to change(DailyResultStat, :count).by(2)

        expect(science_stats.result_count).to eq(3)
        expect(science_stats.daily_low).to eq(80.0)
        expect(science_stats.daily_high).to eq(120.5)

        expect(maths_stats.result_count).to eq(2)
        expect(maths_stats.daily_low).to eq(90.5)
        expect(maths_stats.daily_high).to eq(110.5)

        expect(science_stats.daily_result_stat_date).to eq(timestamp.to_date)
        expect(maths_stats.daily_result_stat_date).to eq(timestamp.to_date)
      end
    end

    context 'when today is third Monday' do
      let(:third_monday) { Date.parse('2023-07-17') }
      let(:third_monday_timestamp) { third_monday.to_time(:utc) }

      before do
        allow(DateTime).to receive(:current).and_return(third_monday)

        (11..15).each do |i|
          create(:daily_result_stat, daily_result_stat_date: (third_monday_timestamp - i.days),
                                     subject: 'Maths', daily_low: 70.5, daily_high: 150.0, result_count: 50)
        end

        (11..15).each do |i|
          create(:daily_result_stat, daily_result_stat_date: (third_monday_timestamp - i.days),
                                     subject: 'Science', daily_low: 80.5, daily_high: 140.0, result_count: 65)
        end
      end

      context 'when results are not submitted in a day' do
        let(:science_stats) { MonthlyAverage.find_by(subject: 'Science') }
        let(:maths_stats) { MonthlyAverage.find_by(subject: 'Maths') }

        it 'does not calculate daily result stats' do
          expect { subject }.not_to change(DailyResultStat, :count)
        end

        it 'calculates monthly average and store in db' do
          expect { subject }.to change(MonthlyAverage, :count).by(2)

          expect(science_stats.monthly_result_count_used).to eq(260)
          expect(science_stats.monthly_avg_low).to eq(80.5)
          expect(science_stats.monthly_avg_high).to eq(140.0)

          expect(maths_stats.monthly_result_count_used).to eq(200)
          expect(maths_stats.monthly_avg_low).to eq(70.5)
          expect(maths_stats.monthly_avg_high).to eq(150.0)

          expect(science_stats.monthly_average_date).to eq(third_monday)
          expect(maths_stats.monthly_average_date).to eq(third_monday)
        end
      end

      context 'when results are submitted in a day' do
        before do
          (0..4).each do |i|
            create(:result, timestamp: third_monday_timestamp, subject: 'Maths', marks: 100.5)
          end
        end

        it 'calculates both daily result stats and monthly average and store in db' do
          expect { subject }.to change(DailyResultStat, :count).by(1).and change(MonthlyAverage, :count).by(2)
        end
      end
    end

    context 'when today is not a third Monday' do
      let(:not_a_third_monday) { Date.parse('2023-07-10') }
      let(:not_a_third_monday_timestamp) { not_a_third_monday.to_time(:utc) }

      before do
        allow(DateTime).to receive(:current).and_return(not_a_third_monday)

        (0..5).each do |i|
          create(:daily_result_stat, daily_result_stat_date: (not_a_third_monday_timestamp - i.days),
                                     subject: 'Maths', daily_low: 70.5, daily_high: 150.0, result_count: 50)
        end
      end

      it 'does not calculate monthly average' do
        expect { subject }.not_to change(MonthlyAverage, :count)
      end
    end
  end
end
