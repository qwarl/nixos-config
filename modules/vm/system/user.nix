{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.quan = {
    isNormalUser = true;
    description = "quan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
