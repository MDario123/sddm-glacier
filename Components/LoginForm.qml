import QtQuick 2.11
import QtQuick.Layouts 1.11

ColumnLayout {
    // User {
    //     id: userProfile
    //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    //     Layout.preferredHeight: root.height / 4
    // }

    id: loginFormContainer

    InputPassword {
        id: inputPassword

        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    }

}
