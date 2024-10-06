import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

ColumnLayout {
    id: loginFormContainer

    // User {
    //     id: userProfile
    //     Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    //     Layout.preferredHeight: root.height / 4
    // }

    InputPassword {
        id: inputPassword
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
    }
}
