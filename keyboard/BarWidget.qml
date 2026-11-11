import QtQuick
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy-accessibility.keyboard"
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "⌨"
    tooltipText: "Show / close on-screen keyboard"
    horizontalMargin: 7.5
    onPressed: function() {
      if (root.bar) root.bar.run("bash ~/.config/omarchy/plugins/omarchy-accessibility.keyboard/keyboard/toggle.sh")
    }
  }
}
