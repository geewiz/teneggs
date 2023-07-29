# Teneggs

To work with local development gem:

```bash
bundle config set local.twitch-bot ../twitch-bot
```

Get authentication ID from

```plain
https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=<your client id>&redirect_uri=http://localhost:3000&scope=chat%3Aread+chat%3Aedit
```

(replace client ID in URL)

