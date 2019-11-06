class Platform < ApplicationRecord
  has_many :listings, inverse_of: :platform

  def self.select_options
    platform_list = []
    platform_list << ["--- All Platforms ---", ""]

    8.times do |index|
      index += 1
      platform_list << ["--- Generation #{index}", index]
      gen_platforms = Platform.where("generation = #{index}").collect {|u| [u.name, u.name]}
      platform_list.concat(gen_platforms)
    end
    return platform_list
  end
end
