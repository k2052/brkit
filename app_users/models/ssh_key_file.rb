# Borrowed from Gitorous
class SSHKeyFile
  def initialize(path=nil)
    @path = path || default_authorized_keys_path
  end
  attr_accessor :path
  
  def contents
    File.read(@path)
  end

  def add_key(key)
    File.open(@path, "a", 0600) do |file|
      file.flock(File::LOCK_EX)
      file << key
      file.flock(File::LOCK_UN)
    end
  end

  def delete_key(key)
    data = File.read(@path)
    return true unless data.include?(key)
    new_data = data.gsub(key, "")
    File.open(@path, "w") do |file|
      file.flock(File::LOCK_EX)
      file.puts new_data
      file.flock(File::LOCK_EX)
    end
  end
  
  protected
    def default_authorized_keys_path
      File.join(File.expand_path("~"), ".ssh", "authorized_keys")
    end
end