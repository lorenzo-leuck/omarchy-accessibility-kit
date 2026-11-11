import QtQuick
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "lorenzo.hand-mouse"
  property bool trackingEnabled: false
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Process {
    id: statusProcess
    command: ["systemctl", "--user", "is-active", "mudra.service"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: root.trackingEnabled = text.trim() === "active"
    }
  }

  Timer {
    interval: 500
    running: true
    repeat: true
    onTriggered: if (!statusProcess.running) statusProcess.running = true
  }

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.trackingEnabled ? "✋ ON" : "✋ OFF"
    active: root.trackingEnabled
    tooltipText: root.trackingEnabled
      ? "Hand tracking ON — webcam in use. Click to stop."
      : "Hand tracking OFF — click to start webcam tracking."
    horizontalMargin: 7.5
    onPressed: function() {
      if (root.bar) root.bar.run("bash ~/.config/omarchy/plugins/lorenzo.hand-mouse/toggle.sh")
    }
  }
}
