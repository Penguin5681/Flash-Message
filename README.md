
# [Flash Message](https://pub.dev/packages/flash_message)

A lightweight Flash Message (toast/notification) package for Flutter. Simple to use, highly customizable.

<table>
  <tr>
    <td><img src="https://i.postimg.cc/ry3sgZjD/flash-1.gif" width="300"/></td>
    <td><img src="https://i.postimg.cc/HnDxWVVQ/flash-2.gif" width="300"/></td>
  </tr>
  <tr>
    <td><img src="https://i.postimg.cc/MTcMKCt8/flash-3.gif" width="300"/></td>
    <td><img src="https://i.postimg.cc/nr2J8z7V/flash-4.gif" width="300"/></td>
  </tr>
</table>

## Features

- 🎯 Easy to use
- 🎨 4 built-in styles
  - Success (green)
  - Error (red)
  - Info (blue)
  - Warning (orange)
- 📍 3 positions
  - Top
  - Center
  - Bottom
- ⚡ Smooth animations
- 🔄 Auto-dismiss
- 👆 Tap actions


## Quick Start

1. Wrap your app with `FlashMessageOverlay`:
```dart
MaterialApp(
  home: FlashMessageOverlay(
    child: MyApp(),
  ),
)
```

2. Show a message from anywhere:
```dart
FlashMessageService().showMessage(
  message: 'Hello World!',
  description: 'This is a flash message',
  type: FlashMessageType.success,
);
```

### Custom Position
```dart
FlashMessageOverlay(
  position: FlashMessagePosition.bottom,
  child: MyApp(),
)
```

## Customization

```dart
FlashMessageService().showMessage(
  message: 'Custom Style',
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  duration: Duration(seconds: 5),
  icon: Icons.star,
);
```

## Message Types

- `FlashMessageType.success`
- `FlashMessageType.error`
- `FlashMessageType.info`
- `FlashMessageType.warning`

## Positions

- `FlashMessagePosition.top`
- `FlashMessagePosition.center`
- `FlashMessagePosition.bottom`

## Properties

| Property        | Type             | Default   | Description        |
|-----------------|------------------|-----------|--------------------|
| message         | String           | required  | Main message       |
| description     | String?          | null      | Additional details |
| type            | FlashMessageType | info      | Message style      |
| duration        | Duration         | 3 seconds | Show duration      |
| backgroundColor | Color?           | null      | Custom background  |
| textColor       | Color?           | null      | Custom text color  |
| icon            | IconData?        | null      | Custom icon        |
| onTap           | Function?        | null      | Tap callback       |

## Full Demo:
[![flash-full-demo.gif](https://i.postimg.cc/BvZCmz6W/flash-full-demo.gif)](https://postimg.cc/FYqcRD3G)
