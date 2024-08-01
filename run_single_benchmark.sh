

if [ $# -ne 1 ]; then
    echo "Usage: $0 <yaml file>"
    exit 1                       
fi

# Define the list of mandatory environment variables


REDACTED_VARS=(WARP_ACCESS_KEY WARP_SECRET_KEY)
LOGGABLE_VARS=(BUCKET_PREFIX NODES SIZE THREADS DURATION_MIN)

REQUIRED_VARS=("${REDACTED_VARS[@]}" "${LOGGABLE_VARS[@]}") 

# Check each variable
for VAR in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!VAR}" ]; then
        echo "Error: Environment variable '$VAR' is not set or empty." >&2
        missing_vars=true
    fi
done

# Fail the script if any variables were missing
if [ "$missing_vars" = true ]; then
    echo "Exiting due to missing environment variables." >&2
    exit 1
fi

echo "Will run the benchmark described in $1"

# Log the env variables
for var_name in "${LOGGABLE_VARS[@]}"; do
    var_value="${!var_name}"  # Indirect variable expansion to get the value
    echo "${var_name}=${var_value}"
done

envsubst '$WARP_ACCESS_KEY $WARP_SECRET_KEY $BUCKET_PREFIX $NODES $SIZE $THREADS $DURATION_MIN' < k8s/warp-get-ranged.yaml \
    | kubectl delete -f -; \
envsubst '$WARP_ACCESS_KEY $WARP_SECRET_KEY $BUCKET_PREFIX $NODES $SIZE $THREADS $DURATION_MIN' < k8s/warp-get-ranged.yaml \
    | kubectl apply -f -
