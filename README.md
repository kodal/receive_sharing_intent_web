# receive_sharing_intent_web

A receive_sharing_intent implementation on web platform

## Limits

Currently receive only text on Android Chrome PWA App with getInitialMedia.

## Usage

To use this plugin, add `receive_sharing_intent_web` along with `receive_sharing_intent` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  receive_sharing_intent: ^1.6.7
  receive_sharing_intent_web: ^0.0.1
```

### Web

Add to `web/manifest.json`:
```json
{
  ...
  "share_target": {
    "action": "/",
    "method": "GET",
    "params": {
      "title": "title",
      "text": "text",
      "url": "url"
    }
  }
}
```