retry() {
  local retries=$1
  shift  # Remove the retry count from arguments

  i=1
  while [ $i -le $retries ]; do
    if "$@"; then
      return 0
    else
      echo "Command failed on attempt $i. Retrying..."
      sleep 1
    fi
    i=$((i + 1))
  done

  echo "Command failed after $retries attempts"
  return 1
}