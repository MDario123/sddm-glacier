import QtGraphicalEffects 1.0
import QtQuick 2.11
import QtQuick.Controls 2.4

ComboBox {
    id: selectSession

    property var selectedSession: selectSession.currentIndex

    height: root.font.pointSize * 3
    width: root.font.pointSize * 3
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    hoverEnabled: true
    indicator.visible: false
    model: sessionModel
    currentIndex: model.lastIndex

    ColorOverlay {
        id: displayedItemColored

        anchors.fill: displayedItem
        source: displayedItem
        color: down ? root.backgroundColor : root.accentColor
        rotation: down ? 360 : 0

        Behavior on color {
            ColorAnimation {
                duration: (600) / config.AnimationSpeedMultiplier
                easing.type: Easing.OutQuad
            }

        }

        Behavior on rotation {
            RotationAnimation {
                duration: (1500) / config.AnimationSpeedMultiplier
                easing.type: Easing.OutQuad
            }

        }

    }

    delegate: ItemDelegate {
        id: session

        highlighted: selectSession.highlightedIndex === index
        anchors.left: parent.left
        width: 150
        height: 30
        opacity: 0
        anchors.leftMargin: -150
        scale: highlighted ? 1.05 : 1
        states: [
            State {
                name: "VISIBLE"
                when: popupHandler.visible
            },
            State {
                name: "NOTVISIBLE"
                when: !popupHandler.visible

                PropertyChanges {
                    target: session
                    anchors.leftMargin: -width
                    opacity: 0
                }

            }
        ]
        transitions: [
            Transition {
                to: "VISIBLE"

                SequentialAnimation {
                    // This acts as a delay
                    PropertyAnimation {
                        properties: ""
                        duration: (150 * (sessionModel.count - index - 1)) / config.AnimationSpeedMultiplier
                    }

                    ParallelAnimation {
                        NumberAnimation {
                            target: session
                            properties: "opacity"
                            to: 1
                            duration: (200) / config.AnimationSpeedMultiplier
                            easing.type: Easing.InQuad
                        }

                        NumberAnimation {
                            target: session
                            properties: "anchors.leftMargin"
                            to: 0
                            duration: (500) / config.AnimationSpeedMultiplier
                            easing.type: Easing.OutBack
                        }

                    }

                }

            },
            Transition {
                from: "VISIBLE"
            }
        ]

        Behavior on scale {
            NumberAnimation {
                easing.type: Easing.OutQuad
                duration: (300) / config.AnimationSpeedMultiplier
            }

        }

        contentItem: Text {
            id: content

            height: parent.height
            width: parent.width
            text: name
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: highlighted ? root.backgroundColor : root.textColor

            Behavior on color {
                ColorAnimation {
                    duration: (300) / config.AnimationSpeedMultiplier
                }

            }

        }

        background: Rectangle {
            id: itemBackground

            border.color: root.accentColor
            border.width: config.BorderSize
            radius: 6000
            color: highlighted ? root.accentColor : root.backgroundColor

            Behavior on color {
                ColorAnimation {
                    duration: (300) / config.AnimationSpeedMultiplier
                }

            }

        }

    }

    contentItem: Image {
        id: displayedItem

        anchors.margins: 5
        anchors.fill: parent
        source: "../Assets/gear.svg"
        asynchronous: true
        sourceSize: Qt.size(width, height)
        visible: false
    }

    background: Rectangle {
        id: background

        color: down ? root.accentColor : root.backgroundColor
        border.color: root.accentColor
        border.width: config.BorderSize
        radius: 6000
        scale: parent.hovered && !parent.pressed ? 1.1 : 1

        Behavior on scale {
            PropertyAnimation {
                duration: (300) / config.AnimationSpeedMultiplier
                easing.type: Easing.OutQuad
            }

        }

        Behavior on color {
            ColorAnimation {
                duration: (600) / config.AnimationSpeedMultiplier
                easing.type: Easing.OutQuad
            }

        }

    }

    popup: Popup {
        id: popupHandler

        x: -10
        y: selectSession.height
        width: 150
        implicitHeight: contentItem.implicitHeight
        padding: 10

        background: Rectangle {
            color: "transparent"
        }

        contentItem: ListView {
            implicitHeight: contentHeight + 20
            model: selectSession.delegateModel
            currentIndex: selectSession.highlightedIndex
            spacing: 10
        }

    }

}
