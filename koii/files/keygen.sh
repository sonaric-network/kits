#!/usr/bin/expect -f

set seed_phrase [lindex $argv 0]

spawn koii-keygen recover --force -o /app/config/id.json
expect "seed phrase:"
send "$seed_phrase\n"

expect "enter it now. Otherwise, press ENTER to continue:"
send "\r"

expect "Continue? (y/n):"
send "y\n"

interact