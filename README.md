# TakingBot

## Running and building

### Docker
`docker-compose up --build`

### Manual (requires Swift install)
`swift build -c release --static-swift-stdlib; $(swift build -c release --show-bin-path)/TakingBot`

<details>
<summary>Installing Swift</summary>
<code>curl -L https://swiftlang.github.io/swiftly/swiftly-install.sh | bash</code>
</details>