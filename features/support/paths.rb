# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    # === CUSTOMER ===
    # CUSTOMER MAIN PAGE
    when /^(.*)'s customer main page$/i
      customerinfo_path(Customerinfo.find_by(name: $1))

    # CUSTOMER DELETE MEAL PAGE
    when /^(.*)'s customer delete meal page$/i
      choose_customerinfo_entry_path(Customerinfo.find_by(name: $1))

    # CUSTOMER EDIT MEAL PAGE
    when /^(.*)'s customer edit meal page$/i
      edit_customerinfo_path(Customerinfo.find_by(name: $1))


    # === CHEF ===
    # CHEF MAIN PAGE
    when /^(.*)'s chef main page$/i
      chefinfo_path(Chefinfo.find_by(name: $1))

    # CHEF DELETE MEAL PAGE
    when /^(.*)'s chef delete meal page$/i
      choose_chefinfo_entry_path(Chefinfo.find_by(name: $1))

    # CHEF EDIT MEAL PAGE
    when /^(.*)'s chef edit meal page$/i
      edit_chefinfo_path(Chefinfo.find_by(name: $1))

    
    # === AUTHENTICATION ===
    # SIGNUP - CHEF
    when /^chef signup page/i
      signup_chef_path

    # SIGNUP - CUSTOMER
    when /^customer signup page$/i
      signup_customer_path

    # LOGIN
    when /^login page$/i
      commons_path

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
