import "Components"
import QtMultimedia 5.15
import QtQuick 2.11
import QtQuick.Controls 2.4
import SddmComponents 2.0 as SDDM

Pane {
    id: root

    property color textColor: config.TextColor
    property color textPreviewColor: config.TextPreviewColor
    property color accentColor: config.AccentColor
    property color backgroundColor: config.BackgroundColor

    height: config.ScreenHeight
    width: config.ScreenWidth
    padding: 0
    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    SDDM.TextConstants {
        id: textConstants
    }

    Image {
        id: placeholder

        anchors.fill: parent
        source: config.Background
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
        clip: true
        mipmap: true
        visible: !videoBackground.isPlaying
    }

    LoginForm {
        id: loginform

        height: parent.height / 10
        width: parent.width / 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.leftMargin: 30
        z: 1
    }

    SessionPicker {
        id: sessionPicker

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.leftMargin: 30
        z: 1
    }

    Video {
        id: videoBackground

        onPlaying: placeholder.visible = false
        source: config.AnimatedBackground !== "" ? "gst-pipeline: filesrc location=" + config.AnimatedBackground + " ! qtdemux ! avdec_h264 ! videoconvert ! autovideosink" : null
        autoPlay: true
        loops: 1e+06
        anchors.fill: parent
        z: -1
    }

    background: Rectangle {
        id: lowestLayerBackground

        anchors.fill: parent
        color: root.backgroundColor
    }

}
