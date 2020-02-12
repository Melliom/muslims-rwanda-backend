# frozen_string_literal: true

module V1::SheikhsHelper
  def language_full_name(key)
    file = Rails.root.join("app", "helpers", "lang.json")
    all_language = JSON.parse(File.read(file))
    all_language[key]["name"].split(",").first
  end
end
