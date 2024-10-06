#!/bin/bash

# Check if the keypair argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path-to-private-key>"
    exit 1
fi

# Set variables
KEYPAIR=$1
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcUMLAc5acRsJ/TpzYdeXA3l/cQALdqFF6MyXDrvlaPRnk1059pZbRhg9n+XNCNxhKy+qYRjDgJ7eQzrAb3jSTyKAQKh691FIbJ7WTDezUTa4OyVQf6DHzyehlMqtPMxcrK7pIerwhsLUPRxRZtXGvjjvv/ocO+IO4d+REf/WMDfA7Y99gHsSBIS+Jv+SkTf3f1GeSNQ2Ts69u/4O69CcKckxYgUYkdbiPCXdR10az3A54QNDwdpybGJ6QagmoAMY8D8WvGPimepuQXegChLisqkYsQvqIuJOA5/o57czdnkN3jrs28Fc2S9Du4PTO30lcEu6mhCDtMissduJF/Hr3w9OB4CXiYru81CKwsPaY7Zbcr1NTm9BOLkzgn9aEMYYrIBfF5atR85GBGsEbjR4xHmANYQDtZe0GTmPS0WYdqGsrxDj5gGMOLjMDi2pBdoBFn9oePeOXCNrkrPmZQYdq7aLfjRo7PqnbIr6K0WSTf3GRuO8rw/bIRXntAH8hM+CEYK3gxUPPwvpQwQY8NsB7tAFrN48QRVlUvFF5KivADNMg9ymCJrGWCjDEZ6Dcu55NURfLRMOHsmAlhJMnymeXLrh3OOKXxAg+NZGU6iCRg6WVo33fsimUkr1YXNRy4oKVINnL7fnzGfNN6S3jS/WmJxQgTUfjNpR0xpPpmCHlOw== ubuntu@ip-172-31-3-30"

# Array of public IPs
declare -a IP_ADDRESSES=(
    "35.181.171.167"
    "35.181.168.171"
    "35.181.160.197"
    "35.180.136.121"
    "35.180.23.235"
    "15.237.196.246"
    "13.37.222.66"
)

# Loop over each IP and copy the public key
for ip in "${IP_ADDRESSES[@]}"; do
    echo "Copying public key to $ip..."
    ssh -i "$KEYPAIR" -o StrictHostKeyChecking=no  ubuntu@$ip "mkdir -p ~/.ssh && echo \"$PUBLIC_KEY\" >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

    if [ $? -eq 0 ]; then
        echo "Public key successfully copied to $ip."
    else
        echo "Failed to copy public key to $ip."
    fi
done

echo "SSH key copy process complete."
