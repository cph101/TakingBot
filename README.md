# TakingBot

## Running and building

### Docker
`docker-compose up --build`

### Manual (requires Swift install)
`export TARGET=release` (Set to `debug` if debugging) 
`swift build -c $TARGET --static-swift-stdlib; $(swift build -c $TARGET --show-bin-path)/TakingBot`

<details>
<summary>Installing Swift</summary>
<code>curl -L https://swiftlang.github.io/swiftly/swiftly-install.sh | bash</code>
</details>