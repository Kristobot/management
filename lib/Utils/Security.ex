defmodule Utils.Security do
  alias Bcrypt

  def encrypt_password(password) do
    Bcrypt.hash_pwd_salt(password)
  end

  def verify_password(password, hash) do
    Bcrypt.verify_pass(password, hash)
  end

end
