import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import SddmComponents 2.0 as SDDM

TextField {
  id: password

  height: root.font.pointSize * 2.5
  implicitWidth: Math.min(Math.max(150, contentWidth + 30), 600)

  Keys.onReturnPressed: sddm.login(config.Username, password.text, sessionPicker.selectedSession)
  focus: true

  echoMode: TextInput.Password
  passwordCharacter: "*"

  placeholderText: textConstants.password
  placeholderTextColor: root.textPreviewColor
  horizontalAlignment: TextInput.AlignHCenter
  renderType: Text.QtRendering
  color: root.textColor

  background: Rectangle {
    color: root.background1Color
    border.color: root.accentColor
    border.width: config.BorderSize
    radius: 10000
  }
}
