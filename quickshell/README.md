# Quickshell Widget Development Guide

This directory contains the Quickshell configuration for desktop widgets and bars.

## Quick Start

### Enter the dev environment
```bash
nix develop
```

### Run the shell
```bash
# From within nix develop
quickshell --path .

# Or directly without entering shell
nix run . -- shell.qml
```

### Hot-reload workflow
1. Start quickshell: `quickshell --path .`
2. Edit any QML file
3. Save the file
4. Quickshell automatically reloads the changes (instant feedback!)

## Directory Structure

```
├── shell.qml              # Root entry point - defines PanelWindow and components
├── flake.nix              # Nix flake for dev environment and build
├── .qmlls.ini             # QML Language Server config (auto-managed - gitignore)
├── widgets/               # Reusable widget components
│   ├── Clock.qml          # Clock widget example
│   └── ...                # Add more widgets here
├── services/              # Data services and integrations
│   ├── DateService.qml    # Date/time service
│   └── ...                # Add more services here
└── theme/                 # Styling and design system
    ├── colors.qml         # Color palette
    └── fonts.qml          # Font definitions
```

## Creating New Widgets

### Simple approach (component in shell.qml)
For quick prototyping, define components directly in `shell.qml`:

```qml
component MyWidget: Rectangle {
  width: 100
  height: 50
  color: colors.background
  
  Text {
    text: "My Widget"
  }
}
```

Then use it in the Row:
```qml
MyWidget {
  anchors.verticalCenter: parent.verticalCenter
}
```

### Modular approach (separate files)
For more complex widgets, create reusable modules:

**widgets/MyWidget.qml:**
```qml
import QtQuick

Rectangle {
  width: 100
  height: 50
  
  required property color bgColor
  
  Text {
    text: "My Widget"
  }
}
```

**shell.qml:**
```qml
import "widgets/MyWidget.qml" as MyWidgetModule

// In the Row:
MyWidgetModule.MyWidget {
  bgColor: colors.background
  anchors.verticalCenter: parent.verticalCenter
}
```

## Working with Services

Services encapsulate logic for data retrieval, process execution, and state management.

### Example: DateService
Executes `date` command and updates on a timer:

```qml
Process {
  command: ["date", "+%H:%M:%S"]
  running: true
  stdout: StdioCollector {
    onStreamFinished: {
      // Use the output: this.text
    }
  }
}

Timer {
  interval: 1000  // milliseconds
  running: true
  repeat: true
  onTriggered: dateProc.running = true
}
```

### Creating a new service
**services/MyService.qml:**
```qml
import Quickshell.Io
import QtQuick

QtObject {
  id: myService
  
  signal dataChanged(string data)
  
  property string data: ""
  
  readonly property Process process: Process {
    command: ["your-command"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        myService.data = this.text.trim()
        myService.dataChanged(myService.data)
      }
    }
  }
  
  function updateData() {
    process.running = true
  }
}
```

## Color System

Define colors in `theme/colors.qml` for consistency:

```qml
QtObject {
  readonly property color background: "#1e1e2e"
  readonly property color accent: "#89b4fa"
}
```

Access via the colors object in shell.qml:
```qml
Rectangle {
  color: colors.background
  border.color: colors.accent
}
```

## QML Language Basics

### Anchors (positioning)
```qml
Text {
  anchors.centerIn: parent        // Center in parent
  anchors.left: parent.left       // Align to left
  anchors.top: parent.top         // Align to top
  anchors.fill: parent            // Fill entire parent
}
```

### Properties
```qml
property string myText: "default"
readonly property int count: 42
property bool enabled: true
```

### Signals
```qml
signal clicked()
signal dataUpdated(string newData)

onClicked: console.log("Clicked!")
```

### Timers
```qml
Timer {
  interval: 1000
  running: true
  repeat: true
  onTriggered: updateData()
}
```

### Models and Lists
```qml
ListModel {
  ListElement { name: "Item 1" }
  ListElement { name: "Item 2" }
}

ListView {
  model: myModel
  delegate: Text { text: name }
}
```

## Debugging

### Check logs
Quickshell saves logs to:
```
/run/user/1000/quickshell/by-id/*/log.qslog
```

View recent logs:
```bash
cat /run/user/1000/quickshell/by-id/*/log.qslog | tail -50
```

### Use console.log
```qml
Component.onCompleted: {
  console.log("Widget loaded!")
}
```

### Enable LSP for better DX
1. `.qmlls.ini` is auto-generated on first run
2. Configure your editor to use `qmlls` (QML Language Server)
3. You'll get completions, error checking, and documentation

## Useful Resources

- [Quickshell Documentation](https://quickshell.org/)
- [QML Language Reference](https://doc.qt.io/qt-6/qmlapplications.html)
- [QtQuick Types](https://doc.qt.io/qt-6/qtquick-index.html)
- [Process Integration](https://quickshell.org/docs/v0.3.0/types/Quickshell.Io/Process)

## Tips & Tricks

1. **Live reload is your friend** - Save often and watch changes instantly
2. **Keep components small** - Break large widgets into smaller pieces
3. **Use services for state** - Centralize data fetching in service modules
4. **Theme colors first** - Define a color palette early, use it consistently
5. **Test incrementally** - Build one widget at a time and verify each step

## Common Issues

### "Type X is not available"
- Check import statements
- Ensure file paths are correct
- Verify QML file syntax (braces must be balanced)

### Quickshell won't start
- Check `/run/user/1000/quickshell/*/log.qslog` for errors
- Verify all imports in shell.qml
- Ensure all referenced files exist

### Hot-reload doesn't work
- Check if quickshell is still running
- Try restarting quickshell
- Verify the QML file has valid syntax

---

Happy widget building! 🚀
