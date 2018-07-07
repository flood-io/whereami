# whereami

This is a simple Slack [slash command bot](https://api.slack.com/slash-commands), which when called from slack with `/whereami`, will attempt to locate you based on [users.info](https://api.slack.com/methods/users.info) and the [geocoder](https://github.com/alexreisner/geocoder#basic-search) gem.

It will also attempt to set your [users.profile](https://api.slack.com/methods/users.profile.set) with something like this:

```json
{
  "status_text": "Australian Eastern Standard Time",
  "status_emoji": ":flag-au:"
}
```

You can run this on heroku for free and make sure you set the app's oauth token which you will get from Slack.

```
heroku create
heroku config:set TOKEN=<Your OAuth Access Token>
```

You will also need to select the following permission scopes:

- `users:read`
- `users:profile:write`
