import requests
import sys
import json
import os

# Persor AI Terminal Agent Client (Python)

DEFAULT_URL = "https://persorai.com"

def main():
    api_url = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_URL
    chat_endpoint = f"{api_url}/api/chat"
    
    # Colors
    GREEN = '\033[92m'
    BLUE = '\033[94m'
    RED = '\033[91m'
    RESET = '\033[0m'

    print(f"{GREEN}")
    print(r"""
 ____                               _    ___ 
|  _ \ ___ _ __ ___  ___  _ __     / \  |_ _|
| |_) / _ \ '__/ __|/ _ \| '__|   / _ \  | | 
|  __/  __/ |  \__ \ (_) | |     / ___ \ | | 
|_|   \___|_|  |___/\___/|_|    /_/   \_\___|
    """)
    print(f"{RESET}")
    print(f"{BLUE}Connecting to Persor AI Node at {api_url}...{RESET}")
    print("Type 'exit' to quit.\n")

    while True:
        try:
            user_input = input(f"{GREEN}root@persor:~$ {RESET}").strip()
            
            if user_input.lower() == 'exit':
                print("Disconnecting...")
                break
            
            if not user_input:
                continue
                
            response = requests.post(chat_endpoint, json={"message": user_input})
            
            if response.status_code == 200:
                data = response.json()
                reply = data.get("reply")
                if reply:
                    print(f"> {reply}")
                else:
                    print(f"{RED}Unknown response format.{RESET}")
            else:
                 print(f"{RED}Server Error: {response.status_code}{RESET}")
                 
        except KeyboardInterrupt:
            print("\nDisconnecting...")
            break
        except Exception as e:
            print(f"{RED}Error: {e}{RESET}")

if __name__ == "__main__":
    main()
