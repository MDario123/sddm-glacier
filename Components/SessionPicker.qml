import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import SddmComponents 2.0 as SDDM

ComboBox {
  id: selectSession

  property var selectedSession: selectSession.currentIndex

  height: root.font.pointSize * 3
  width: root.font.pointSize * 15
  anchors.left: parent.left
  anchors.bottom: parent.bottom

  hoverEnabled: true
  indicator.visible: false

  model: sessionModel
  currentIndex: model.lastIndex
  textRole: "name"

  delegate: ItemDelegate {
    width: selectSession.width
    anchors.horizontalCenter: parent.horizontalCenter
    highlighted: selectSession.highlightedIndex === index

    contentItem: Text {
      height: 30
      width: parent.width

      text: name

      color: parent.highlighted ? root.background1Color : root.textColor
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
      color: highlighted ? root.accentColor : root.background1Color
      border.color: root.accentColor
      border.width: config.BorderSize
      radius: 10000
    }
  }

  contentItem: Text {
    id: displayedItem
    text: selectSession.currentText
    color: parent.down ? root.background1Color : root.textColor
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
  }

  background: Rectangle {
    color: down ? root.accentColor : root.background1Color
    border.color: root.accentColor
    border.width: config.BorderSize
    radius: 10000
  }

  popup: Menu {
    id: popupHandler

    y: parent.height
    width: parent.width
    implicitHeight: contentItem.implicitHeight
    padding: 10

    background: Rectangle { color: "transparent" }

    contentItem: ListView {
      implicitHeight: contentHeight + 20
      model: selectSession.delegateModel
      currentIndex: selectSession.highlightedIndex
      spacing: 10
    }
  }
}
