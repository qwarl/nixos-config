{
  # Enable Fail2ban to prevent brute-force attacks.
  services.fail2ban = {
    enable = true;
    maxretry = 2;
  };
}
