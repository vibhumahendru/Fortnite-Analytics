class Player < ApplicationRecord
  has_many :followed_relationships, foreign_key: "followed_id", class_name: "Relationship"
  has_many :follower_relationships, foreign_key: "follower_id", class_name: "Relationship"

  has_many :followers, through: :followed_relationships, source: :follower
  has_many :following, through: :follower_relationships, source: :followed
  has_many :stats

  def player_api_hash

    if self.console_type == "psn"
      userId = "psn(#{self.username})"
    elsif self.console_type == "xbox"
      userId = "xbl(#{self.username})"
    elsif self.console_type == "pc"
      userId = self.username
    else nil

    end

    if self.username.include?(" ")
      userId = self.username.gsub(/\s/,'%20')
    end

    response_string = RestClient.get("https://api.fortnitetracker.com/v1/profile/#{self.console_type}/#{userId}", headers={"TRN-Api-Key": ENV['VM_FT_KEY']})
    response_hash = JSON.parse(response_string)

  end

  def lifeTimeStats
    player_api_hash["lifeTimeStats"]
  end

  def total_wins
    lifeTimeStats[8]["value"].to_i #[8] is the 8th element in lifeTimeStats array which contains total wins.
  end

  def total_matches
    lifeTimeStats[7]["value"].to_i #[7] is the 7th element in lifeTimeStats array which contains total matches.
  end

  def total_kills
    lifeTimeStats[10]["value"].to_i #[10] is the 10th element in lifeTimeStats array which contains total kills.
  end

  def kd_ratio
    lifeTimeStats[11]["value"].to_f #[11] is the 11th element in lifeTimeStats array which contains Kill/Death ratio.
  end

  def rank
    player_api_hash["stats"]["p2"]["trnRating"]["rank"]
  end

  def display_stats
    puts "Total Wins: #{total_wins}"
    puts "Total Matches: #{total_matches}"
    puts "Total Kills: #{total_kills}"
    puts "Kill/Death Ratio: #{kd_ratio}"
    puts "Rank: #{rank}"
  end


  def chartAr
    Time.zone = 'Eastern Time (US & Canada)'
    newAr = []
    self.stats.each do |stat|
      tempAr = []
      tempAr << stat.current_time.inspect
      tempAr << stat.total_matches
      newAr << tempAr
    end
    newAr
  end

  def mail_my_stats
    Mailjet.configure do |config|
      config.api_key = ENV['EMAIL']

      config.secret_key = ENV['EMAIL_SECRET_KEY']

      config.api_version = "v3.1"
    end

  # platform = platForm
  # userId = userId
    wins = "Total Wins: #{self.total_wins}"
    tot_matches =  "Total Matches: #{self.total_matches}"
    tot_kills =  "Total Kills: #{self.total_kills}"
    kd =  "Kill/Death Ratio: #{self.kd_ratio}"
    myRank =  "Rank: #{self.rank}"



  variable = Mailjet::Send.create(messages: [{
      'From'=> {
          'Email'=> "vibhu.mahendru@flatironschool.com",
          'Name'=> 'My Fortnite Stats'
      },
      'To'=> [
          {
              'Email'=> self.email,
              'Name'=> "#{self.username}"
          }
      ],
      'Subject'=> 'stats',
      'TextPart'=> "LifeTime Stats for #{self.username}:

      #{wins}
      #{tot_matches}
      #{tot_kills}
      #{kd}
      #{myRank}
      "

  }]
  )
  p variable.attributes['Messages']
  end

end








#check
