#!/bin/bash

# REQUIRED_FLAGS=(BUCKET_PREFIX: NODES: SIZE: THREADS: DURATION_MIN:)

# echo "${REQUIRED_FLAGS[*]}"

# Parse arguments with getopt (long options only)
# TEMP=$(getopt --longoptions "BUCKET_PREFIX:,NODES:" -- "$@")

TEMP=$(getopt -o '' --long NODES:,SIZE:,THREADS:,DURATION_MIN:,BUCKET_PREFIX:,SCRIPT:  -- "$@")

echo $TEMP

eval set -- "$TEMP"

# echo $@

# # Check if all required flags are present
# for flag in "${REQUIRED_FLAGS[@]}"; do
#     if ! [[ " $@ " =~ " --$flag " ]]; then
#         echo "Error: --$flag is required."
#         exit 1
#     fi
# done

# Extract values for each flag
while true; do
    case "$1" in
        # Long flags (notice the colons for required arguments)
        --BUCKET_PREFIX)
            IFS=, read -ra BUCKET_PREFIX_VALUES <<< "$2"
            # BUCKET_PREFIX_VALUES=("${2//,/ }")
            shift 2
            ;;
        --NODES)
            IFS=, read -ra NODES_VALUES <<< "$2"
            # NODES_VALUES=("${2//,/ }")
            shift 2
            ;;
        --SIZE)
            IFS=, read -ra SIZE_VALUES <<< "$2"
            #SIZE_VALUES=("${2//,/ }")
            shift 2
            ;;
        --THREADS)
            IFS=, read -ra THREADS_VALUES <<< "$2"
            # THREADS_VALUES=("${2//,/ }")
            shift 2
            ;;
        --DURATION_MIN)
            IFS=, read -ra DURATION_MIN_VALUES <<< "$2"
            # DURATION_MIN_VALUES=("${2//,/ }")
            shift 2
            ;;
        --SCRIPT)
            IFS=, read -ra SCRIPT_VALUES <<< "$2"
            # SCRIPT_VALUES=("${2//,/ }")
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Error: Invalid option: $1"
            exit 1
            ;;
    esac
done

echo "BUCKET_PREFIX values: ${BUCKET_PREFIX_VALUES[@]}"
echo "DURATION_MIN values: ${DURATION_MIN_VALUES[@]}"
echo "NODES values: ${NODES_VALUES[@]}"
echo "SIZE values: ${SIZE_VALUES[@]}"
echo "THREADS values: ${THREADS_VALUES[@]}"
echo "SCRIPT values: ${SCRIPT_VALUES[@]}"

for BUCKET_PREFIX_ in "${BUCKET_PREFIX_VALUES[@]}"; do
    export BUCKET_PREFIX="${BUCKET_PREFIX_}"
    for DURATION_MIN_ in "${DURATION_MIN_VALUES[@]}"; do
        export DURATION_MIN="${DURATION_MIN_}"
        for NODES_ in "${NODES_VALUES[@]}"; do
            export NODES="${NODES_}"
            for SIZE_ in "${SIZE_VALUES[@]}"; do
                export SIZE="${SIZE_}"
                for THREADS_ in "${THREADS_VALUES[@]}"; do
                    export THREADS="${THREADS_}"
                    for SCRIPT_ in "${SCRIPT_VALUES[@]}"; do
                        export SCRIPT="${SCRIPT_}"
                        # echo "$NODES,$SIZE,$THREADS,$DURATION_MIN,$BUCKET_PREFIX,$SCRIPT"
                        ./run_single_benchmark.sh $SCRIPT
                        sleep $((DURATION_MIN * 60 + 10*60))
                    done
                done
            done
        done
    done
done



