import QtQuick 2.11
import QtQuick.Controls 2.4

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
    states: [
        State {
            name: "DOWN"
            when: down
        }
    ]
    transitions: [
        Transition {
            to: "DOWN"
            animations: [
                ColorAnimation {
                    target: background
                    properties: "color"
                    to: root.accentColor
                    duration: 300
                },
                ColorAnimation {
                    target: displayedItem
                    properties: "color"
                    to: root.background1Color
                    duration: 300
                }
            ]
        },
        Transition {
            from: "DOWN"
            animations: [
                ColorAnimation {
                    target: background
                    properties: "color"
                    to: root.background1Color
                    duration: 300
                },
                ColorAnimation {
                    target: displayedItem
                    properties: "color"
                    to: root.textColor
                    duration: 300
                }
            ]
        }
    ]

    delegate: ItemDelegate {
        width: selectSession.width
        anchors.horizontalCenter: parent.horizontalCenter
        highlighted: selectSession.highlightedIndex === index
        states: [
            State {
                name: "HIGHLIGHTED"
                when: highlighted
            }
        ]
        transitions: [
            Transition {
                to: "HIGHLIGHTED"
                animations: [
                    ColorAnimation {
                        target: itemBackground
                        properties: "color"
                        to: root.accentColor
                        duration: 300
                    },
                    ColorAnimation {
                        target: content
                        properties: "color"
                        to: root.background1Color
                        duration: 300
                    }
                ]
            },
            Transition {
                from: "HIGHLIGHTED"
                animations: [
                    ColorAnimation {
                        target: itemBackground
                        properties: "color"
                        to: root.background1Color
                        duration: 300
                    },
                    ColorAnimation {
                        target: content
                        properties: "color"
                        to: root.textColor
                        duration: 300
                    }
                ]
            }
        ]

        contentItem: Text {
            id: content

            height: 30
            width: parent.width
            text: name
            color: root.textColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        background: Rectangle {
            id: itemBackground

            color: root.background1Color
            border.color: root.accentColor
            border.width: config.BorderSize
            radius: 10000
        }

    }

    contentItem: Text {
        id: displayedItem

        text: selectSession.currentText
        color: root.textColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
        id: background

        color: root.background1Color
        border.color: root.accentColor
        border.width: config.BorderSize
        radius: 10000
    }

    popup: Popup {
        id: popupHandler

        y: parent.height
        width: parent.width
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
