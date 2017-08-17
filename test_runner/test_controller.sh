delayed_ajax() {
  local url=$1
  local callback=$2
  local seconds=$3

  sleep $seconds
  curl -s "$url" | "$callback"
}

my_handler() {
  # Read from stdin and do something.
  # E.g. just append to a file:
  cat 1>&2 
}

for delay in 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1; do
  delayed_ajax http://localhost:3000 my_handler $delay &
done