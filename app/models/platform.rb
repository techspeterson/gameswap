class Platform < ApplicationRecord
  # platforms are ordered alphabetically before select options are generated
  default_scope { order(name: :asc) }

  # model relations
  has_many :listings, inverse_of: :platform

  # select options in listing crud forms (return the platform id)
  def self.select_options
    platform_list = []

    # for each console generation, add heading, then add the consoles
    8.times do |index|
      index += 1
      platform_list << ["--- Generation #{index}", ""]
      gen_platforms = Platform.where("generation = #{index}").collect {|u| [u.name, u.id]}
      platform_list.concat(gen_platforms)
    end

    platform_list << ["--- Other", ""]
    other_platforms = Platform.where("generation = 0").collect {|u| [u.name, u.id]}
    platform_list.concat(other_platforms)

    return platform_list
  end

  # select options in search forms (return the platform name)
  def self.search_select_options
    platform_list = []
    platform_list << ["--- All Platforms ---", ""]

    # for each console generation, add heading, then add the consoles
    8.times do |index|
      index += 1
      platform_list << ["--- Generation #{index}", index]
      gen_platforms = Platform.where("generation = #{index}").collect {|u| [u.name, u.name]}
      platform_list.concat(gen_platforms)
    end

    platform_list << ["--- Other", 0]
    other_platforms = Platform.where("generation = 0").collect {|u| [u.name, u.name]}
    platform_list.concat(other_platforms)

    return platform_list
  end
end
