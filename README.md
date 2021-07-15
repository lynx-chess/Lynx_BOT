# Lynx_BOT 🤖 

<p align="center">
  <a href="https://lichess.org/?user=lynx_bot#friend">👉 <b>Play me on Lichess </b>👈</a>
</p>


This repo sets up [**Lynx**](https://github.com/lynx-chess/Lynx) chess engine to play in lichess.org using the 'official lichess bot client' ([ShailChoksi/lichess-bot](https://github.com/ShailChoksi/lichess-bot)).

Although it can be used to play from any account, **the official Lynx account is [Lynx_BOT](https://lichess.org/@/Lynx_BOT)**.

## Instructions

### Requirements

- Owning a Lichess Bot account. You must **not** attempt this with a regular Lichess account. Learn [here](https://lichess.org/api#operation/botAccountUpgrade) how to upgrade an account to a Bot one.

- [Docker](https://docs.docker.com/get-docker/).

- [Docker Compose](https://docs.docker.com/compose/install/).

### Steps

- Download [the latest release artifact](https://github.com/lynx-chess/Lynx_BOT/releases/latest) to an empty directory.

- In that directory, create an .env file with your Lichess TOKEN.

  ```bash
  echo LICHESS_API_TOKEN="<YOUR_API_TOKEN>" > .env
  ```

- Adjust any parameters you desire in `lynx_bot.config.yml`.

- Run `docker compose`.

  ```bash
  docker compose up
  ```

## Licenses

[Lynx](https://github.com/lynx-chess/Lynx) chess engine has a more permissive MIT license, but since this repository makes use of [lichess-bot](https://github.com/ShailChoksi/lichess-bot) as well, it's also licensed under AGPL-3.0.

| Project | License | Relationship |
| ------- | ------- | ------------ |
| [Lynx](https://github.com/lynx-chess/Lynx) | MIT | Dependency |
| [lichess-bot](https://github.com/ShailChoksi/lichess-bot) | AGPL-3.0 | Dependency |
| [lc0-docker](https://github.com/vochicong/lc0-docker) | - | Inspiration |
| [**Lynx_BOT**](https://github.com/lynx-chess/Lynx_BOT) | **AGPL-3.0** | This project
