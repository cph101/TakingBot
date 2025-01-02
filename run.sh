while IFS='=' read -r key value; do
    # Ensure the line is not empty and does not start with a #
    if [ -n "$key" ] && [ "$(echo "$key" | cut -c1)" != "#" ]; then
        export "$key=$value"
    fi
done < .env

swift build -c $TARGET --static-swift-stdlib; $(swift build -c $TARGET --show-bin-path)/TakingBot