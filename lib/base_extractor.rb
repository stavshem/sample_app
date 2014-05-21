class BaseExtractor

  def initialize(content)
    @content = content
    @type_to_prefix = {
      :reply => /@((\w|-)+)/,
      :message => /ddd((\w|-)+)/,
    }
  end
  
  def user_string
    @type_to_prefix.each do |content_type, type_re|
      ans = @content.match(type_re)
      if not ans.nil?
        return ans[1]
      end
    end
    return nil
  end

  def user_db_name
    user_string ? user_string.sub("-", " ").titleize : nil
  end

  def user_id
    user_obj = User.find_by_name(user_db_name)
    user_obj ? user_obj.id : nil
  end

  def content_type
    @type_to_prefix.each do |content_type, type_re|
      ans = @content.match(type_re)
      if not ans.nil?
        return content_type
      end
    end
    return nil
  end

  def self.db_name_to_formatted_name(raw_name)
    return raw_name.downcase.sub(" ", "-") 
  end
end
